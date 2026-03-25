# 프로젝트 설계 계획

## 1. 프로젝트 목표 이해

-   두 개의 **PostgreSQL** DDL(`.sql`) 파일을 비교하여 차이점을 감지하고, 소스 DB 스키마를 타겟 DB 스키마에 동기화하는 SQL 스크립트를 생성하는 애플리케이션을 개발합니다.
    -   소스 DB(운영)의 DDL 파일과 타겟 DB(테스트)의 DDL 파일을 비교하여 차이점을 감지합니다.
    -   스키마 동기화를 위한 실행 가능한 SQL 스크립트를 자동으로 생성하여 파일로 저장합니다.

## 2. 핵심 기능 및 실행 파이프라인

전체 애플리케이션은 다음 4단계의 파이프라인으로 실행됩니다.
1. **Read & Parse (읽기 및 파싱)**: 파일 읽기 및 pglast로 파싱합니다. 파티션·상속 테이블, 뷰, 트리거 등 제외 대상은 파싱 후 노드 타입으로 필터링합니다.
2. **Map (매핑)**: 파싱된 노드를 내부 비교 로직을 위해 추상화된 Meta 객체(`TableMeta`, `ColumnMeta`, `IndexMeta`, `ConstraintMeta`, `FunctionMeta`, `SequenceMeta` 등) 트리로 변환하여 저장합니다.
3. **Compare (비교)**: 소스와 타겟의 Meta 객체를 전수 조사하여 비교하고, 동기화 명령을 담은 `SyncCommand` 객체 리스트를 생성합니다.
4. **Generate (생성)**: `SyncCommand`를 기반으로 최종 `result_log.sql` 스크립트를 작성하고 스냅샷 파일을 출력합니다.

-   **소스/타겟 DDL 스크립트 파싱 및 비교**:
    -   실행 인자로 받은 파일(`실행인자1`, `실행인자2`)을 파싱하여 스키마 정보를 추출하고 전수 조사합니다.
    -   **비교 대상**: 테이블, 컬럼, 제약 조건(`PK`, `FK`, `UK`, `Check`), 인덱스, 함수, 시퀀스 등 모든 구성 요소.
    -   **제외 대상**: 파티션 테이블(패턴 및 `PARTITION OF`), 관련 인덱스/제약조건, 뷰(View), 트리거(현재 라이브러리 한계로 한시적 제외).
-   **스키마 스냅샷 로깅**:
    -   `script/source_schema_snapshot.txt` 및 `script/target_schema_snapshot.txt` 생성 (객체 타입별로 섹션 구분: TABLES, SEQUENCES, FUNCTIONS 등). **각 섹션 제목 우측에 해당 객체 타입의 총 카운트를 표시합니다 (예: `--- TABLES (15) ---`).**
    -   타겟 DDL 스냅샷 생성 시 주석(`Comment`)은 비교에서 제외.
-   **동기화 스크립트 및 로그 생성 (`script/result_log.sql`)**:
    -   동기화 스크립트와 실행 로그, 객체 삭제 근거 등을 함께 기록.
    -   **비교 데이터 주석 처리**: 변경된 항목의 이전/이후 상태를 생성된 구문 위에 주석으로 기록.
    -   **안전 모드 (기본 동작)**: `DROP` 구문 등 데이터 손실 위험이 있는 SQL은 자동 주석 처리(`--`) 및 경고 메시지 기록.

## 3. 기술 스택 및 라이브러리

-   **언어**: `Python 3.12+`
-   **의존성 관리**: `uv` (pyproject.toml)
-   **DDL 파싱**: `pglast` (PostgreSQL 네이티브 파서 libpg_query 기반 Python 바인딩)
-   **타겟 DBMS**: `PostgreSQL`

## 4. 상세 구현 가이드 및 유의사항 (중요)

### 4.1 파싱 및 필터링 전략
-   **문장 분리 방식 및 한계**: `re.split(r';\s*(?:\r\n|\n|\r)', ddl_script)` 정규식을 사용하여 문장을 분리합니다. 단순 세미콜론 분리는 함수 내부의 세미콜론과 충돌할 위험이 있어 줄바꿈 결합 형태를 기준으로 합니다.
    -   *(주의)* 이 방식도 완벽하지 않으므로, 향후 pglast의 `parse_sql()` 전체 파싱 기능을 활용하는 방식을 우선 고려합니다.
-   **오류에 강건한 처리**: 특정 문장 파싱 실패 시 `failed_statements` 리스트에 저장하고 `result_log.sql` 하단에 주석으로 기록하여 전체 프로세스를 중단시키지 않습니다. 이때, **상세 에러 로그 대신 파싱에 실패한 객체의 유형과 이름만 간결하게 기록합니다 (예: `/* PARSING FAILED: [TABLE] my_table */`).** 파싱 실패는 `try/except pglast.Error`로 처리합니다.
- **사전 필터링 불필요**: `pglast`는 PostgreSQL 네이티브 파서를 사용하므로 `INHERITS`, `PARTITION OF`, `PARTITION BY`, `::` 타입 캐스팅 등 PostgreSQL 고유 문법을 직접 파싱합니다. 파싱 전 문자열 수준 사전 필터링이 필요하지 않습니다.
- **파티션 테이블 및 뷰 제외 로직**: 파싱 후 노드 타입으로 판별하여 제외합니다.
    -   `PARTITION OF` 테이블: `CreateStmt` 노드에 `partbound` 필드가 존재하는 경우
    -   `INHERITS` 테이블: `CreateStmt` 노드에 `inhRelations` 필드가 존재하는 경우
    -   뷰(`ViewStmt`), 트리거(`CreateTrigStmt`): 노드 태그로 무시 처리

### 4.2 동기화 스크립트 생성 규칙
-   **SQL 실행 순서 (의존성 관리)**: 스크립트 실행 시 참조 무결성 오류가 발생하지 않도록 다음 순서로 생성 구문을 정렬해야 합니다.
    -   **생성(CREATE/ADD)**: `SEQUENCE` → `TABLE` → `CONSTRAINT (PK/UK)` → `INDEX` → `FK` → `FUNCTION`
    -   **삭제(DROP)**: `FK` → `TABLE` 순서로 역순 처리 (기본적으로 주석 처리됨)
-   **제약 조건/인덱스 수정**: 기존 객체를 `DROP`(주석 처리)하고 새 객체를 `CREATE`하는 방식으로 처리합니다.
- **함수**: 정의(`Definition`) 전체를 문자열로 비교합니다. 이때 **연속된 공백 문자(공백, 탭, 줄바꿈 등 1칸 이상)를 단일 공백으로 치환(Normalization)**하여 단순 포맷팅 차이는 무시하고 실제 로직의 차이만 감지하도록 합니다. 차이가 있을 경우 전체 구문을 다시 생성합니다.
- **시퀀스 수정 (`MODIFY`)**: PostgreSQL에는 `CREATE OR REPLACE SEQUENCE`가 없으므로 `CREATE SEQUENCE`를 그대로 사용하면 이미 존재하는 시퀀스에서 오류가 발생합니다. **반드시 `ALTER SEQUENCE`를 사용해야 합니다.**
    -   비교는 정규화된 정의 문자열(`normalized_body`)로 수행하고, 변경이 감지되면 `ALTER SEQUENCE`로 동기화합니다.
    -   `ALTER SEQUENCE` 생성 시 소스의 모든 옵션을 명시적으로 지정하고, 소스에 없는 옵션은 PostgreSQL 기본값으로 리셋합니다 (예: `NO MAXVALUE`, `CACHE 1`, `NO CYCLE`).
    -   `SequenceMeta`에 `options: dict` 필드를 두어 `CreateSeqStmt.options`(DefElem 리스트)에서 파싱한 속성값을 보관합니다.
    -   **pglast 주의**: 큰 정수(예: `maxvalue 99999999999999`)는 `Integer`가 아닌 `Float` 노드로 저장되므로 `arg.fval`을 `int()`로 변환해야 합니다. `CYCLE` 옵션은 `Boolean` 노드(`arg.boolval`)로 저장됩니다.
    -   **변경 속성 명시**: `result_log.sql`의 `MODIFY` 주석에 전체 정의 대신 **변경된 속성만** `속성: 이전값 → 새값` 형식으로 기록합니다 (예: `-- Previous: Changed: maxvalue: (not set) → 99999999999999, cache: (not set) → 20`). 이를 위해 소스/타겟의 `options` 딕셔너리를 속성 단위로 비교하는 `_diff_seq_options(src_opts, tgt_opts)` 함수를 사용합니다.
-   **기타 로직**: `SET DEFAULT now` 구문이 있을 경우, `SET DEFAULT now()` 함수 호출로 수정하여 비교 및 동기화합니다.
-   **문자열 리터럴 및 이스케이프**: SQL 스크립트 생성 시 Python f-string 또는 `textwrap.dedent` 사용 시 raw string 혼용에 주의해야 합니다.

### 4.3 pglast 파싱 시 필수 준수 규칙 (엄격 적용)
AI가 구현 시 반드시 아래 pglast API 규칙을 준수하여 코드를 작성해야 합니다.

-   **파싱 진입점**: `pglast.parse_sql(ddl_script)` → `RawStmt` 노드 배열 반환
-   **노드 탐색**: `pglast.Node`로 래핑하여 `.node_tag` / 딕셔너리 키로 접근
-   **테이블 생성**: 노드 태그 `CreateStmt` → `relation.relname`으로 테이블명 추출
-   **컬럼 정의**: `tableElts` 배열, 각 항목 태그 `ColumnDef` → `colname`, `typeName`
-   **제약 조건 식별**: `Constraint` 노드의 `contype` 값으로 판별
    -   `CONSTR_PRIMARY` → PK, `CONSTR_UNIQUE` → UK, `CONSTR_FOREIGN` → FK, `CONSTR_CHECK` → Check
-   **인덱스**: 노드 태그 `IndexStmt` → `unique` boolean 필드로 UNIQUE 여부 판별
-   **함수**: 노드 태그 `CreateFunctionStmt` → `funcname` 리스트에서 이름 추출
-   **시퀀스**: 노드 태그 `CreateSeqStmt` → `sequence.relname`, `options`(DefElem 리스트)로 속성 추출
    -   DefElem 필드: `defname`(옵션명), `arg`(값 노드)
    -   소정수 → `Integer.ival`, 대정수(maxvalue 등) → `Float.fval`을 `int()`로 변환, 불리언(cycle) → `Boolean.boolval`
    -   `arg=None`이면 `NO MAXVALUE` 등 명시적 부정 옵션
-   **파티션 테이블 제외**: `CreateStmt.partbound` 존재 시(PARTITION OF), `inhRelations` 존재 시(INHERITS) → 비교 대상에서 제외
-   **뷰 제외**: 노드 태그 `ViewStmt` → 무시
-   **트리거 제외**: 노드 태그 `CreateTrigStmt` → 무시
-   **COMMENT 처리**: 노드 태그 `CommentStmt` → 타겟 스냅샷 생성 시 제외

## 5. 출력 파일 포맷 (템플릿 예시)

AI 구현 시, 로그와 출력 파일의 형태가 일관되도록 아래 포맷을 참고하여 작성합니다.

### 5.1 스냅샷 파일 포맷 예시 (`script/source_schema_snapshot.txt`)
```text
--- TABLES (2) ---
[Table] users
  - id : integer (PK)
  - name : varchar(50)
[Table] orders
  - order_id : integer (PK)
  - user_id : integer (FK)

--- SEQUENCES (1) ---
[Sequence] user_seq
```

### 5.2 동기화 스크립트 포맷 예시 (`script/result_log.sql`)
```sql
-- [MODIFY] Table: users
-- Previous: column 'age' integer
-- New: column 'age' varchar(3)
ALTER TABLE users ALTER COLUMN age TYPE varchar(3);

-- [WARNING: DROP OPERATION]
-- DROP TABLE old_logs;

-- [PARSING FAILED STATEMENTS]
-- /* PARSING FAILED: [TRIGGER] my_trigger */
```