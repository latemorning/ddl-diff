create sequence seq_ba_id
    maxvalue 99999999
    cycle;

create sequence seq_cm_id
    maxvalue 9999
    cycle;

create sequence seq_cp_id
    maxvalue 9999
    cycle;

create sequence seq_cu_id
    maxvalue 9999999
    cycle;

create sequence seq_dmms_id
    maxvalue 99999999999999
    cycle;

create sequence seq_if_id
    maxvalue 99999999
    cycle;

create sequence seq_lc_id;

create sequence seq_lg_id
    maxvalue 99999999
    cycle;

create sequence seq_mms_id
    maxvalue 99999999999999
    cache 20
    cycle;

create sequence seq_ph_id
    maxvalue 99999999
    cycle;

create sequence seq_phub_cpn_id
    maxvalue 999999999999
    cache 20
    cycle;

create sequence seq_pnt_bc_id
    maxvalue 999999999999
    cycle;

create sequence seq_pnt_bl_id
    maxvalue 999999999999
    cycle;

create sequence seq_pnt_ha_id
    maxvalue 999999999999
    cycle;

create sequence seq_pnt_kb_id
    maxvalue 999999999999
    cycle;

create sequence seq_pnt_sh_id
    maxvalue 999999999999
    cycle;

create sequence seq_pnt_ss_id
    maxvalue 999999999999
    cycle;

create sequence seq_point_tr_id
    maxvalue 999999999999
    cache 20
    cycle;

create sequence seq_pnt_prvd_tz_h;

create sequence seq_ph_info_prvd_ag_hist
    maxvalue 999999999;

create sequence seq_ph_cls_ag_hist
    maxvalue 999999999;

create table adm_accs_ctrl_d
(
    ctrl_id      varchar(12)  not null,
    ctrl_seq     integer      not null,
    ip_stat      varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    ip_desc      varchar(200),
    ip_addr_enc  varchar(400) not null
);

comment on table adm_accs_ctrl_d is 'PHUB접근제어정보D';

comment on column adm_accs_ctrl_d.ctrl_id is '제어ID';

comment on column adm_accs_ctrl_d.ctrl_seq is '제어순번';

comment on column adm_accs_ctrl_d.ip_stat is '아이피상태';

comment on column adm_accs_ctrl_d.rgst_dt is '등록일시';

comment on column adm_accs_ctrl_d.rgst_user_id is '등록자ID';

comment on column adm_accs_ctrl_d.mdfy_dt is '수정일시';

comment on column adm_accs_ctrl_d.mdfy_user_id is '수정자ID';

comment on column adm_accs_ctrl_d.ip_desc is ' IP 설명';

comment on column adm_accs_ctrl_d.ip_addr_enc is '접속가능IP암호화';

create index adm_accs_ctrl_d_01fk
    on adm_accs_ctrl_d (ctrl_id);

create unique index adm_accs_ctrl_d_pk
    on adm_accs_ctrl_d (ctrl_id, ctrl_seq);

alter table adm_accs_ctrl_d
    add primary key (ctrl_id, ctrl_seq);

create table adm_accs_ctrl_m
(
    ctrl_id       varchar(12) not null,
    rltn_corp_ind varchar(20),
    rltn_corp_id  varchar(20),
    ctrl_stat     varchar(20),
    rgst_dt       timestamp,
    rgst_user_id  varchar(20),
    mdfy_dt       timestamp,
    mdfy_user_id  varchar(20),
    athn_key      varchar(100)
);

comment on table adm_accs_ctrl_m is 'PHUB접근제어정보M';

comment on column adm_accs_ctrl_m.ctrl_id is '제어ID';

comment on column adm_accs_ctrl_m.rltn_corp_ind is '관계사구분';

comment on column adm_accs_ctrl_m.rltn_corp_id is '관계사아이디';

comment on column adm_accs_ctrl_m.ctrl_stat is '제어상태';

comment on column adm_accs_ctrl_m.rgst_dt is '등록일시';

comment on column adm_accs_ctrl_m.rgst_user_id is '등록자ID';

comment on column adm_accs_ctrl_m.mdfy_dt is '수정일시';

comment on column adm_accs_ctrl_m.mdfy_user_id is '수정자ID';

comment on column adm_accs_ctrl_m.athn_key is '인증키';

create unique index adm_accs_ctrl_m_pk
    on adm_accs_ctrl_m (ctrl_id);

alter table adm_accs_ctrl_m
    add primary key (ctrl_id);

create table adm_action_chng_hist
(
    menu_id      varchar(20)  not null,
    uri          varchar(200) not null,
    hist_seq     integer      not null,
    actn_nm      varchar(50),
    mot_id       varchar(20),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    uri_method   varchar(10),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_user_id varchar(20),
    mdfy_dt      timestamp
);

comment on table adm_action_chng_hist is 'REQUEST액션정보이력';

comment on column adm_action_chng_hist.menu_id is '메뉴아이디';

comment on column adm_action_chng_hist.uri is 'URI';

comment on column adm_action_chng_hist.hist_seq is '이력순번';

comment on column adm_action_chng_hist.actn_nm is 'ACTION명';

comment on column adm_action_chng_hist.mot_id is '전문ID';

comment on column adm_action_chng_hist.send_plc is '발신처';

comment on column adm_action_chng_hist.rcv_plc is '수신처';

comment on column adm_action_chng_hist.uri_method is 'URI_METHOD';

comment on column adm_action_chng_hist.rgst_dt is '등록일시';

comment on column adm_action_chng_hist.rgst_user_id is '등록자ID';

comment on column adm_action_chng_hist.mdfy_user_id is '수정자ID';

comment on column adm_action_chng_hist.mdfy_dt is '수정일시';

create index adm_action_chng_hist_01fk
    on adm_action_chng_hist (menu_id, uri);

create unique index adm_action_chng_hist_pk
    on adm_action_chng_hist (menu_id, uri, hist_seq);

alter table adm_action_chng_hist
    add primary key (menu_id, uri, hist_seq);

create table adm_action_info
(
    menu_id       varchar(20)  not null,
    uri           varchar(200) not null,
    actn_nm       varchar(50),
    send_plc      varchar(20),
    rcv_plc       varchar(20),
    uri_method    varchar(10),
    log_write_yn  varchar(1) default 'Y'::character varying,
    rgst_dt       timestamp,
    rgst_user_id  varchar(20),
    mdfy_dt       timestamp,
    mdfy_user_id  varchar(20),
    logcntr_if_yn varchar(1) default 'N'::character varying
);

comment on table adm_action_info is 'REQUEST액션정보';

comment on column adm_action_info.menu_id is '메뉴아이디';

comment on column adm_action_info.uri is 'URI';

comment on column adm_action_info.actn_nm is 'ACTION명';

comment on column adm_action_info.send_plc is '발신처';

comment on column adm_action_info.rcv_plc is '수신처';

comment on column adm_action_info.uri_method is 'URI_METHOD';

comment on column adm_action_info.log_write_yn is '로그기록여부';

comment on column adm_action_info.rgst_dt is '등록일시';

comment on column adm_action_info.rgst_user_id is '등록자ID';

comment on column adm_action_info.mdfy_dt is '수정일시';

comment on column adm_action_info.mdfy_user_id is '수정자ID';

comment on column adm_action_info.logcntr_if_yn is '로그센터연동여부';

create unique index adm_action_info_pk
    on adm_action_info (menu_id, uri);

alter table adm_action_info
    add primary key (menu_id, uri);

create table adm_batch_dtl
(
    log_no       varchar(20)  not null,
    seq          integer      not null,
    phub_tr_no   varchar(30),
    phub_cpn_no  varchar(20),
    tr_amt       integer,
    rslt_code    varchar(20),
    rslt_msg     varchar(200),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    cust_id_enc  varchar(400) not null,
    pin_no_enc   varchar(400) not null
);

comment on table adm_batch_dtl is '배치작업상세내역';

comment on column adm_batch_dtl.log_no is '로그번호';

comment on column adm_batch_dtl.seq is '순번';

comment on column adm_batch_dtl.phub_tr_no is '포인트허브 거래번호';

comment on column adm_batch_dtl.phub_cpn_no is '포인트허브쿠폰번호';

comment on column adm_batch_dtl.tr_amt is '거래금액';

comment on column adm_batch_dtl.rslt_code is '결과코드';

comment on column adm_batch_dtl.rslt_msg is '결과메시지';

comment on column adm_batch_dtl.rgst_dt is '등록일시';

comment on column adm_batch_dtl.rgst_user_id is '등록자ID';

comment on column adm_batch_dtl.cust_id_enc is '고객ID암호화';

comment on column adm_batch_dtl.pin_no_enc is '핀번호암호화';

alter table adm_batch_dtl
    add primary key (log_no, seq);

create table adm_batch_log_m
(
    dd_cmpr_no   varchar(12) not null,
    cmpr_dd      varchar(8),
    doc_file_nm  varchar(50),
    no_acr_cnt   integer,
    mtch_cnt     integer,
    ttl_deal_cnt integer,
    rgst_dt      timestamp,
    rslt_code    varchar(20),
    rslt_msg     varchar(200),
    strt_dt      timestamp,
    end_dt       timestamp,
    rgst_user_id varchar(20),
    wrkn_nm      varchar(100)
);

comment on table adm_batch_log_m is '배치작업로그M';

comment on column adm_batch_log_m.dd_cmpr_no is '일대사번호';

comment on column adm_batch_log_m.cmpr_dd is '대사일자';

comment on column adm_batch_log_m.doc_file_nm is '전문파일명';

comment on column adm_batch_log_m.no_acr_cnt is '불일치건수';

comment on column adm_batch_log_m.mtch_cnt is '일치건수';

comment on column adm_batch_log_m.ttl_deal_cnt is '총거래건수';

comment on column adm_batch_log_m.rgst_dt is '등록일시';

comment on column adm_batch_log_m.rslt_code is '결과코드';

comment on column adm_batch_log_m.rslt_msg is '결과메시지';

comment on column adm_batch_log_m.strt_dt is '작업시작일시';

comment on column adm_batch_log_m.end_dt is '작업종료일시';

comment on column adm_batch_log_m.rgst_user_id is '등록자ID';

comment on column adm_batch_log_m.wrkn_nm is '작업명';

alter table adm_batch_log_m
    add primary key (dd_cmpr_no);

create table adm_cmn_cd_d
(
    ind_cd       varchar(20) not null,
    dtl_cd       varchar(20) not null,
    dtl_cd_nm    varchar(20),
    use_yn       varchar(1) default 'Y'::character varying,
    dp_yn        varchar(1) default 'Y'::character varying,
    cd_val       varchar(100),
    sort_ord     integer,
    cd_desc      varchar(100),
    rmrk         varchar(100),
    prv_use_cd_1 varchar(30),
    prv_use_cd_2 varchar(30),
    prv_use_cd_3 varchar(30),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    dtl_cd_enc   varchar(400)
);

comment on table adm_cmn_cd_d is '공통코드D';

comment on column adm_cmn_cd_d.ind_cd is '구분코드';

comment on column adm_cmn_cd_d.dtl_cd is '상세코드';

comment on column adm_cmn_cd_d.dtl_cd_nm is '상세코드명';

comment on column adm_cmn_cd_d.use_yn is '사용여부';

comment on column adm_cmn_cd_d.dp_yn is '노출여부';

comment on column adm_cmn_cd_d.cd_val is '코드값';

comment on column adm_cmn_cd_d.sort_ord is '정렬순서';

comment on column adm_cmn_cd_d.cd_desc is '코드설명';

comment on column adm_cmn_cd_d.rmrk is '비고';

comment on column adm_cmn_cd_d.prv_use_cd_1 is '전용코드_1';

comment on column adm_cmn_cd_d.prv_use_cd_2 is '전용코드_2';

comment on column adm_cmn_cd_d.prv_use_cd_3 is '전용코드_3';

comment on column adm_cmn_cd_d.rgst_dt is '등록일시';

comment on column adm_cmn_cd_d.rgst_user_id is '등록자ID';

comment on column adm_cmn_cd_d.mdfy_dt is '수정일시';

comment on column adm_cmn_cd_d.mdfy_user_id is '수정자ID';

comment on column adm_cmn_cd_d.dtl_cd_enc is '암호화코드비교값';

create index adm_cmn_cd_d_01fk
    on adm_cmn_cd_d (ind_cd);

create unique index adm_cmn_cd_d_pk
    on adm_cmn_cd_d (ind_cd, dtl_cd);

alter table adm_cmn_cd_d
    add primary key (ind_cd, dtl_cd);

create table adm_cmn_cd_m
(
    ind_cd       varchar(20) not null,
    ind_cd_nm    varchar(30),
    grp_cd       varchar(10),
    use_yn       varchar(1) default 'Y'::character varying,
    cd_desc      varchar(100),
    rgst_user_id varchar(20),
    rgst_dt      timestamp,
    mdfy_user_id varchar(20),
    mdfy_dt      timestamp
);

comment on table adm_cmn_cd_m is '공통코드M';

comment on column adm_cmn_cd_m.ind_cd is '구분코드';

comment on column adm_cmn_cd_m.ind_cd_nm is '구분코드명';

comment on column adm_cmn_cd_m.grp_cd is '공통그룹코드';

comment on column adm_cmn_cd_m.use_yn is '사용여부';

comment on column adm_cmn_cd_m.cd_desc is '코드설명';

comment on column adm_cmn_cd_m.rgst_user_id is '등록자ID';

comment on column adm_cmn_cd_m.rgst_dt is '등록일시';

comment on column adm_cmn_cd_m.mdfy_user_id is '수정자ID';

comment on column adm_cmn_cd_m.mdfy_dt is '수정일시';

create unique index adm_cmn_cd_m_pk
    on adm_cmn_cd_m (ind_cd);

alter table adm_cmn_cd_m
    add primary key (ind_cd);

create table adm_logcntr_log
(
    log_no        varchar(20) not null,
    menu_nm       varchar(100),
    actn_id       varchar(20),
    uri           varchar(200),
    prmt          json,
    cust_id       varchar(20),
    inqr_rsn      varchar(100),
    sngl_mult_ind varchar(20),
    rgst_user_id  varchar(20),
    rgst_dt       timestamp,
    jnng_ip_enc   varchar(400)
);

comment on table adm_logcntr_log is '로그센터연동로그';

comment on column adm_logcntr_log.log_no is '로그번호_LC';

comment on column adm_logcntr_log.menu_nm is '메뉴명';

comment on column adm_logcntr_log.actn_id is '액션ID';

comment on column adm_logcntr_log.uri is 'URI';

comment on column adm_logcntr_log.prmt is '파라미터';

comment on column adm_logcntr_log.cust_id is '고객ID';

comment on column adm_logcntr_log.inqr_rsn is '조회사유';

comment on column adm_logcntr_log.sngl_mult_ind is '다량단건구분';

comment on column adm_logcntr_log.rgst_user_id is '등록자ID';

comment on column adm_logcntr_log.rgst_dt is '등록일시';

comment on column adm_logcntr_log.jnng_ip_enc is '접속아이피암호화';

alter table adm_logcntr_log
    add primary key (log_no);

create table adm_menu_by_auth
(
    menu_id      varchar(20) not null,
    user_grp_id  varchar(20) not null,
    rgst_yn      varchar(1) default 'Y'::character varying,
    read_yn      varchar(1) default 'Y'::character varying,
    mdfy_yn      varchar(1) default 'Y'::character varying,
    exp_yn       varchar(1) default 'Y'::character varying,
    max_exp_cnt  integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table adm_menu_by_auth is '메뉴별권한';

comment on column adm_menu_by_auth.menu_id is '메뉴아이디';

comment on column adm_menu_by_auth.user_grp_id is '사용자그룹ID';

comment on column adm_menu_by_auth.rgst_yn is '등록권한';

comment on column adm_menu_by_auth.read_yn is '보기권한';

comment on column adm_menu_by_auth.mdfy_yn is '수정권한';

comment on column adm_menu_by_auth.exp_yn is '엑스포트권한여부';

comment on column adm_menu_by_auth.max_exp_cnt is '최대엑스포트횟수';

comment on column adm_menu_by_auth.rgst_dt is '등록일시';

comment on column adm_menu_by_auth.rgst_user_id is '등록자ID';

comment on column adm_menu_by_auth.mdfy_dt is '수정일시';

comment on column adm_menu_by_auth.mdfy_user_id is '수정자ID';

create index adm_menu_by_auth_03fk
    on adm_menu_by_auth (menu_id);

create unique index adm_menu_by_auth_pk
    on adm_menu_by_auth (menu_id, user_grp_id);

alter table adm_menu_by_auth
    add primary key (menu_id, user_grp_id);

create table adm_menu_info
(
    menu_id      varchar(20) not null,
    menu_nm      varchar(100),
    menu_ind     varchar(20),
    menu_uri     varchar(200),
    menu_desc    varchar(200),
    menu_path    varchar(200),
    root_menu    varchar(20),
    upr_menu_id  varchar(20),
    menu_lvl     integer,
    use_yn       varchar(1) default 'Y'::character varying,
    dp_yn        varchar(1) default 'Y'::character varying,
    menu_ord     integer,
    auth_type    varchar(10),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table adm_menu_info is '포인트허브메뉴정보';

comment on column adm_menu_info.menu_id is '메뉴아이디';

comment on column adm_menu_info.menu_nm is '메뉴명';

comment on column adm_menu_info.menu_ind is '메뉴구분';

comment on column adm_menu_info.menu_uri is '메뉴URI';

comment on column adm_menu_info.menu_desc is '메뉴설명';

comment on column adm_menu_info.menu_path is '메뉴경로';

comment on column adm_menu_info.root_menu is 'ROOT메뉴';

comment on column adm_menu_info.upr_menu_id is '상위메뉴ID';

comment on column adm_menu_info.menu_lvl is '메뉴레벨';

comment on column adm_menu_info.use_yn is '사용여부';

comment on column adm_menu_info.dp_yn is '노출여부';

comment on column adm_menu_info.menu_ord is '메뉴순위';

comment on column adm_menu_info.auth_type is '권한유형';

comment on column adm_menu_info.rgst_dt is '등록일시';

comment on column adm_menu_info.rgst_user_id is '등록자ID';

comment on column adm_menu_info.mdfy_dt is '수정일시';

comment on column adm_menu_info.mdfy_user_id is '수정자ID';

create unique index adm_menu_info_pk
    on adm_menu_info (menu_id);

alter table adm_menu_info
    add primary key (menu_id);

create table adm_msg_info
(
    msg_id       varchar(20) not null,
    msg_cd       varchar(20),
    msg_grp      varchar(20),
    msg_nm       varchar(100),
    use_yn       varchar(1) default 'Y'::character varying,
    msg_ind      varchar(20),
    rmrk         varchar(100),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table adm_msg_info is '포인트허브메시지정보';

comment on column adm_msg_info.msg_id is '메시지ID';

comment on column adm_msg_info.msg_cd is '메시지코드';

comment on column adm_msg_info.msg_grp is '메시지그룹';

comment on column adm_msg_info.msg_nm is '메시지명';

comment on column adm_msg_info.use_yn is '사용여부';

comment on column adm_msg_info.msg_ind is '메시지구분';

comment on column adm_msg_info.rmrk is '비고';

comment on column adm_msg_info.rgst_dt is '등록일시';

comment on column adm_msg_info.rgst_user_id is '등록자ID';

comment on column adm_msg_info.mdfy_dt is '수정일시';

comment on column adm_msg_info.mdfy_user_id is '수정자ID';

create unique index adm_msg_info_pk
    on adm_msg_info (msg_id);

alter table adm_msg_info
    add primary key (msg_id);

create table adm_pnt_prvdr_msg
(
    prvdr_id     varchar(20) not null,
    msg_seq      integer     not null,
    pnt_cd       varchar(30),
    msg_id       varchar(10),
    msg          varchar(200),
    rfrn_val1    varchar(20),
    rfrn_val2    varchar(20),
    rfrn_val3    varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table adm_pnt_prvdr_msg is '포인트제공처별메시지';

comment on column adm_pnt_prvdr_msg.prvdr_id is '제공처ID';

comment on column adm_pnt_prvdr_msg.msg_seq is '메시지순번';

comment on column adm_pnt_prvdr_msg.pnt_cd is '포인트코드';

comment on column adm_pnt_prvdr_msg.msg_id is '메시지ID';

comment on column adm_pnt_prvdr_msg.msg is '메시지';

comment on column adm_pnt_prvdr_msg.rfrn_val1 is '참조값1';

comment on column adm_pnt_prvdr_msg.rfrn_val2 is '참조값2';

comment on column adm_pnt_prvdr_msg.rfrn_val3 is '참조값3';

comment on column adm_pnt_prvdr_msg.rgst_dt is '등록일시';

comment on column adm_pnt_prvdr_msg.rgst_user_id is '등록자ID';

comment on column adm_pnt_prvdr_msg.mdfy_dt is '수정일시';

comment on column adm_pnt_prvdr_msg.mdfy_user_id is '수정자ID';

alter table adm_pnt_prvdr_msg
    add primary key (prvdr_id, msg_seq);

create table adm_prmt_chng_hist
(
    prmt_cd      varchar(20) not null,
    hist_seq     integer     not null,
    prmt_grp_cd  varchar(20),
    use_ind      varchar(20),
    prmt_val     varchar(50),
    use_yn       varchar(1) default 'Y'::character varying,
    rfrn_val1    varchar(20),
    rfrn_val2    varchar(20),
    rfrn_val3    varchar(20),
    prmt_desc    varchar(100),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
);

comment on table adm_prmt_chng_hist is '파라미터변경이력';

comment on column adm_prmt_chng_hist.prmt_cd is '파라미터코드';

comment on column adm_prmt_chng_hist.hist_seq is '이력순번';

comment on column adm_prmt_chng_hist.prmt_grp_cd is '파라미터그룹코드';

comment on column adm_prmt_chng_hist.use_ind is '용도구분';

comment on column adm_prmt_chng_hist.prmt_val is '파라미터값';

comment on column adm_prmt_chng_hist.use_yn is '사용여부';

comment on column adm_prmt_chng_hist.rfrn_val1 is '참조값1';

comment on column adm_prmt_chng_hist.rfrn_val2 is '참조값2';

comment on column adm_prmt_chng_hist.rfrn_val3 is '참조값3';

comment on column adm_prmt_chng_hist.prmt_desc is '파라미터설명';

comment on column adm_prmt_chng_hist.rgst_user_id is '등록자ID';

comment on column adm_prmt_chng_hist.rgst_dt is '등록일시';

create index adm_prmt_chng_hist_01fk
    on adm_prmt_chng_hist (prmt_cd);

create unique index adm_prmt_chng_hist_pk
    on adm_prmt_chng_hist (prmt_cd, hist_seq);

alter table adm_prmt_chng_hist
    add primary key (prmt_cd, hist_seq);

create table adm_pwd_chng_hist
(
    user_id      varchar(20) not null,
    hist_seq     integer     not null,
    rgst_dd      timestamp,
    pwd          varchar(100),
    rgst_user_id varchar(20)
);

comment on table adm_pwd_chng_hist is '비밀번호변경이력';

comment on column adm_pwd_chng_hist.user_id is '사용자ID';

comment on column adm_pwd_chng_hist.hist_seq is '이력순번';

comment on column adm_pwd_chng_hist.rgst_dd is '등록일시';

comment on column adm_pwd_chng_hist.pwd is '비밀번호';

comment on column adm_pwd_chng_hist.rgst_user_id is '등록자ID';

create index adm_pwd_chng_hist_01fk
    on adm_pwd_chng_hist (user_id);

create unique index adm_pwd_chng_hist_pk
    on adm_pwd_chng_hist (user_id, hist_seq);

alter table adm_pwd_chng_hist
    add primary key (user_id, hist_seq);

create table adm_stnd_dctn
(
    word_no     integer not null,
    word_txt    varchar(100),
    word_abrv_1 varchar(200),
    word_abrv_2 varchar(200),
    word_desc   varchar(1000)
);

comment on table adm_stnd_dctn is 'PH표준사전';

comment on column adm_stnd_dctn.word_no is '단어ID';

comment on column adm_stnd_dctn.word_txt is '단어내용';

comment on column adm_stnd_dctn.word_abrv_1 is '단어약어1';

comment on column adm_stnd_dctn.word_abrv_2 is '단어약어2';

comment on column adm_stnd_dctn.word_desc is '단어설명';

create unique index adm_stnd_dctn_pk
    on adm_stnd_dctn (word_no);

alter table adm_stnd_dctn
    add primary key (word_no);

create table adm_sysprmt_info
(
    prmt_cd      varchar(30) not null,
    use_ind      varchar(10),
    prmt_grp_cd  varchar(10),
    prmt_val     varchar(100),
    use_yn       varchar(20),
    rfrn_val1    varchar(100),
    rfrn_val2    varchar(100),
    rfrn_val3    varchar(100),
    prmt_desc    varchar(100),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table adm_sysprmt_info is '시스템파라미터정보';

comment on column adm_sysprmt_info.prmt_cd is '파라미터코드';

comment on column adm_sysprmt_info.use_ind is '용도구분';

comment on column adm_sysprmt_info.prmt_grp_cd is '파라미터그룹코드';

comment on column adm_sysprmt_info.prmt_val is '파라미터값';

comment on column adm_sysprmt_info.use_yn is '사용여부';

comment on column adm_sysprmt_info.rfrn_val1 is '참조값1';

comment on column adm_sysprmt_info.rfrn_val2 is '참조값2';

comment on column adm_sysprmt_info.rfrn_val3 is '참조값3';

comment on column adm_sysprmt_info.prmt_desc is '설명';

comment on column adm_sysprmt_info.rgst_dt is '등록일시';

comment on column adm_sysprmt_info.rgst_user_id is '등록자ID';

comment on column adm_sysprmt_info.mdfy_dt is '수정일시';

comment on column adm_sysprmt_info.mdfy_user_id is '수정자ID';

create unique index adm_sysprmt_info_pk
    on adm_sysprmt_info (prmt_cd);

alter table adm_sysprmt_info
    add primary key (prmt_cd);

create table adm_user_info
(
    user_id         varchar(20)                                not null,
    stat_cd         varchar(20) default '1000'::character varying,
    efct_strt_dd    varchar(8),
    efct_end_dd     varchar(8),
    login_err_cnt   integer,
    user_grp_id     varchar(20),
    dept_cd         varchar(20),
    jnng_pwd        varchar(100),
    rcnt_jnng_dd    timestamp,
    rgst_dt         timestamp,
    rgst_user_id    varchar(20),
    mdfy_dt         timestamp,
    mdfy_user_id    varchar(20),
    login_yn        varchar(1)  default 'N'::character varying not null,
    max_inqr_cnt    integer     default 0,
    otp_auth_yn     varchar(1)  default 'Y'::character varying,
    captcha_auth_yn varchar(1)  default 'Y'::character varying,
    ldap_auth_yn    varchar(1)  default 'Y'::character varying,
    user_nm_enc     varchar(400)                               not null,
    user_nm_sch     varchar(400)[],
    cnt_plc_enc     varchar(400)                               not null,
    cnt_plc_sch     varchar(400)[],
    ip_addr2_enc    varchar(400),
    ip_addr3_enc    varchar(400),
    ip_addr_enc     varchar(400)                               not null
);

comment on table adm_user_info is '사용자정보';

comment on column adm_user_info.user_id is '사용자ID';

comment on column adm_user_info.stat_cd is '상태코드';

comment on column adm_user_info.efct_strt_dd is '유효시작일';

comment on column adm_user_info.efct_end_dd is '유효종료일';

comment on column adm_user_info.login_err_cnt is '로그인오류카운트';

comment on column adm_user_info.user_grp_id is '사용자그룹';

comment on column adm_user_info.dept_cd is '부서코드';

comment on column adm_user_info.jnng_pwd is '접속비밀번호';

comment on column adm_user_info.rcnt_jnng_dd is '최근접속일';

comment on column adm_user_info.rgst_dt is '등록일시';

comment on column adm_user_info.rgst_user_id is '등록자ID';

comment on column adm_user_info.mdfy_dt is '수정일시';

comment on column adm_user_info.mdfy_user_id is '수정자ID';

comment on column adm_user_info.login_yn is '로그인여부';

comment on column adm_user_info.max_inqr_cnt is '최대조회수';

comment on column adm_user_info.otp_auth_yn is 'OTP인증여부';

comment on column adm_user_info.captcha_auth_yn is 'CAPTCHA 인증여부';

comment on column adm_user_info.ldap_auth_yn is 'LDAP 인증여부';

comment on column adm_user_info.user_nm_enc is '사용자명암호화';

comment on column adm_user_info.user_nm_sch is '사용자명해시';

comment on column adm_user_info.cnt_plc_enc is '연락처암호화';

comment on column adm_user_info.cnt_plc_sch is '연락처해시';

comment on column adm_user_info.ip_addr2_enc is 'IP주소2암호화';

comment on column adm_user_info.ip_addr3_enc is 'IP주소3암호화';

comment on column adm_user_info.ip_addr_enc is 'IP주소암호화';

create unique index adm_user_info_pk
    on adm_user_info (user_id);

alter table adm_user_info
    add primary key (user_id);

create table adm_user_log
(
    log_no       varchar(20) not null,
    menu_nm      varchar(100),
    actn_id      varchar(20),
    uri          varchar(200),
    prmt         json,
    rgst_user_id varchar(20),
    rgst_dt      timestamp,
    jnng_ip_enc  varchar(400)
);

comment on table adm_user_log is '시스템사용로그';

comment on column adm_user_log.log_no is '로그번호_LG';

comment on column adm_user_log.menu_nm is '메뉴명';

comment on column adm_user_log.actn_id is '액션ID';

comment on column adm_user_log.uri is 'URI';

comment on column adm_user_log.prmt is '파라미터';

comment on column adm_user_log.rgst_user_id is '등록자ID';

comment on column adm_user_log.rgst_dt is '등록일시';

comment on column adm_user_log.jnng_ip_enc is '접속아이피암호화';

create index adm_user_log_idx_01
    on adm_user_log (rgst_dt, rgst_user_id);

create unique index adm_user_log_pk
    on adm_user_log (log_no);

alter table adm_user_log
    add primary key (log_no);

create table adm_user_login_hist
(
    user_id       varchar(20) not null,
    hist_seq      integer     not null,
    login_dt      timestamp,
    login_stat    varchar(20),
    login_err_cnt integer default 0,
    rgst_dt       timestamp,
    rgst_user_id  varchar(20),
    login_err_rsn varchar(200),
    login_ip_enc  varchar(400)
);

comment on table adm_user_login_hist is '로그인이력';

comment on column adm_user_login_hist.user_id is '사용자ID';

comment on column adm_user_login_hist.hist_seq is '이력순번';

comment on column adm_user_login_hist.login_dt is '로그인일시';

comment on column adm_user_login_hist.login_stat is '로그인상태';

comment on column adm_user_login_hist.login_err_cnt is '로그인오류카운트';

comment on column adm_user_login_hist.rgst_dt is '등록일시';

comment on column adm_user_login_hist.rgst_user_id is '등록자ID';

comment on column adm_user_login_hist.login_err_rsn is '로그인실패사유';

comment on column adm_user_login_hist.login_ip_enc is '로그인IP암호화';

create unique index adm_user_login_hist_pk
    on adm_user_login_hist (user_id, hist_seq);

alter table adm_user_login_hist
    add primary key (user_id, hist_seq);

create table auto_drmt_customer_hist
(
    drmt_id     varchar(40) not null,
    success_yn  varchar(2)  not null,
    user_id     varchar(20) not null,
    rgst_dt     timestamp,
    success_cnt integer,
    mdfy_dt     timestamp
);

create table cl_cmpr_info
(
    dd_cmpr_no      varchar(12) not null,
    pt_hb_date_time varchar(14),
    cmpr_dd         varchar(8),
    doc_file_nm     varchar(50),
    no_acr_cnt      integer,
    mtch_cnt        integer,
    ttl_deal_cnt    integer,
    rgst_dt         timestamp,
    rgst_user_id    varchar(20),
    mdfy_dt         timestamp,
    mdfy_user_id    varchar(20)
);

comment on table cl_cmpr_info is '클립포인트일대사결과M';

comment on column cl_cmpr_info.dd_cmpr_no is '일대사번호';

comment on column cl_cmpr_info.pt_hb_date_time is '파일생성일시';

comment on column cl_cmpr_info.cmpr_dd is '대사일자';

comment on column cl_cmpr_info.doc_file_nm is '전문파일명';

comment on column cl_cmpr_info.no_acr_cnt is '불일치건수';

comment on column cl_cmpr_info.mtch_cnt is '일치건수';

comment on column cl_cmpr_info.ttl_deal_cnt is '총거래건수';

comment on column cl_cmpr_info.rgst_dt is '등록일시';

comment on column cl_cmpr_info.rgst_user_id is '등록자ID';

comment on column cl_cmpr_info.mdfy_dt is '수정일시';

comment on column cl_cmpr_info.mdfy_user_id is '수정자ID';

alter table cl_cmpr_info
    add primary key (dd_cmpr_no);

create table cl_cmpr_point
(
    dd_cmpr_no   varchar(12) not null,
    pnt_cd       varchar(30) not null,
    cmpr_dd      varchar(8),
    ttl_deal_cnt integer,
    sucs_cnt     integer,
    ans_pnt      integer,
    fail_cnt     integer
);

comment on table cl_cmpr_point is '클립일대사결과카드별D';

comment on column cl_cmpr_point.dd_cmpr_no is '일대사번호';

comment on column cl_cmpr_point.pnt_cd is '포인트코드';

comment on column cl_cmpr_point.cmpr_dd is '대사일자';

comment on column cl_cmpr_point.ttl_deal_cnt is '총거래건수';

comment on column cl_cmpr_point.sucs_cnt is '성공건수';

comment on column cl_cmpr_point.ans_pnt is '포인트';

comment on column cl_cmpr_point.fail_cnt is '실패건수';

create index cl_cmpr_point_01fk
    on cl_cmpr_point (dd_cmpr_no);

create unique index cl_cmpr_point_pk
    on cl_cmpr_point (dd_cmpr_no, pnt_cd);

alter table cl_cmpr_point
    add primary key (dd_cmpr_no, pnt_cd);

create table drmt_customer_hist
(
    drmt_id     varchar(40) not null,
    success_yn  varchar(2)  not null,
    user_id     varchar(20) not null,
    rgst_dt     timestamp,
    success_cnt integer
);

create table ex_adm_user_info
(
    user_id         varchar(20),
    stat_cd         varchar(20),
    efct_strt_dd    varchar(8),
    efct_end_dd     varchar(8),
    login_err_cnt   integer,
    user_grp_id     varchar(20),
    dept_cd         varchar(20),
    jnng_pwd        varchar(100),
    rcnt_jnng_dd    timestamp,
    rgst_dt         timestamp,
    rgst_user_id    varchar(20),
    mdfy_dt         timestamp,
    mdfy_user_id    varchar(20),
    login_yn        varchar(1),
    max_inqr_cnt    integer,
    otp_auth_yn     varchar(1),
    captcha_auth_yn varchar(1),
    ldap_auth_yn    varchar(1),
    tran_dt         timestamp default now(),
    user_nm_enc     varchar(400),
    user_nm_sch     varchar(400)[],
    cnt_plc_enc     varchar(400),
    cnt_plc_sch     varchar(400)[],
    ip_addr2_enc    varchar(400),
    ip_addr3_enc    varchar(400),
    ip_addr_enc     varchar(400)
);

comment on column ex_adm_user_info.tran_dt is '데이터이관일시';

comment on column ex_adm_user_info.user_nm_enc is '사용자명암호화';

comment on column ex_adm_user_info.user_nm_sch is '사용자명해시';

comment on column ex_adm_user_info.cnt_plc_enc is '연락처암호화';

comment on column ex_adm_user_info.cnt_plc_sch is '연락처해시';

comment on column ex_adm_user_info.ip_addr2_enc is 'IP주소2암호화';

comment on column ex_adm_user_info.ip_addr3_enc is 'IP주소3암호화';

comment on column ex_adm_user_info.ip_addr_enc is 'IP주소암호화';

create table ex_fp_fmly_supot
(
    phub_tr_no     varchar(20),
    own_yn         varchar(1),
    end_yn         varchar(1),
    req_stat_cd    varchar(10),
    prgr_stat      varchar(10),
    phub_cpn_no    varchar(20),
    rgst_dt        timestamp,
    rgst_user_id   varchar(20),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(20),
    cust_type_cd   varchar(10),
    tran_dt        timestamp default now(),
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[],
    cust_nm_enc    varchar(400),
    cust_nm_sch    varchar(400)[],
    kt_cust_id_enc varchar(400)
);

comment on column ex_fp_fmly_supot.tran_dt is '데이터이관일시';

comment on column ex_fp_fmly_supot.cust_ctn_enc is '연락처암호화';

comment on column ex_fp_fmly_supot.cust_ctn_sch is '연락처해시';

comment on column ex_fp_fmly_supot.cust_nm_enc is '이름암호화';

comment on column ex_fp_fmly_supot.cust_nm_sch is '이름해시';

comment on column ex_fp_fmly_supot.kt_cust_id_enc is 'KT고객ID암호화';

create table ex_ph_cls_ag_info
(
    cust_id      varchar(20),
    cls_id       varchar(10),
    cls_ver      varchar(10),
    agre_yn      varchar(1),
    mand_yn      varchar(1),
    cls_titl     varchar(400),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    tran_dt      timestamp default now()
);

create table ex_ph_cpn_chng_hist
(
    phub_cpn_no        varchar(20),
    hist_seq_no        integer,
    chng_typ_cd        varchar(10),
    cpn_amt            integer,
    cpn_typ_id         varchar(20),
    phub_tr_no         varchar(20),
    cpn_stat_cd        varchar(20),
    cpn_isue_dt        timestamp,
    cpn_cncl_dt        timestamp,
    cpn_use_dt         timestamp,
    efct_strt_dd       varchar(8),
    efct_end_dd        varchar(8),
    prnt_phub_cpn_no   varchar(30),
    cust_id            varchar(20),
    use_cncl_dt        timestamp,
    cpn_cncl_ind       varchar(10),
    cncl_phub_tr_no    varchar(20),
    rgst_dt            timestamp,
    rgst_user_id       varchar(20),
    mdfy_dt            timestamp,
    mdfy_user_id       varchar(20),
    cust_type_cd       varchar(10),
    tran_dt            timestamp default now(),
    cust_ctn_enc       varchar(400),
    cust_ctn_sch       varchar(400)[],
    kt_cust_id_enc     varchar(400),
    own_kt_cust_id_enc varchar(400),
    pin_no_enc         varchar(400)
);

comment on column ex_ph_cpn_chng_hist.tran_dt is '데이터이관일시';

comment on column ex_ph_cpn_chng_hist.cust_ctn_enc is '연락처암호화';

comment on column ex_ph_cpn_chng_hist.cust_ctn_sch is '연락처해시';

comment on column ex_ph_cpn_chng_hist.kt_cust_id_enc is 'KT고객ID암호화';

comment on column ex_ph_cpn_chng_hist.own_kt_cust_id_enc is '개통자KT고객ID암호화';

comment on column ex_ph_cpn_chng_hist.pin_no_enc is '핀번호암호화';

create table ex_ph_cpn_isue_info
(
    phub_cpn_no        varchar(20),
    cpn_amt            integer,
    cpn_typ_id         varchar(20),
    phub_tr_no         varchar(20),
    cpn_isue_dt        timestamp,
    efct_strt_dd       varchar(8),
    kos_tr_no          varchar(20),
    efct_end_dd        varchar(8),
    cpn_stat_cd        varchar(20),
    cpn_use_dt         timestamp,
    prnt_phub_cpn_no   varchar(20),
    cpn_cncl_dt        timestamp,
    cust_id            varchar(20),
    use_cncl_dt        timestamp,
    cpn_cncl_ind       varchar(10),
    cncl_phub_tr_no    varchar(20),
    rgst_dt            timestamp,
    rgst_user_id       varchar(20),
    mdfy_dt            timestamp,
    mdfy_user_id       varchar(20),
    cust_type_cd       varchar(10),
    tran_dt            timestamp default now(),
    cust_ctn_enc       varchar(400),
    cust_ctn_sch       varchar(400)[],
    kt_cust_id_enc     varchar(400),
    own_kt_cust_id_enc varchar(400),
    pin_no_enc         varchar(400)
);

comment on column ex_ph_cpn_isue_info.tran_dt is '데이터이관일시';

comment on column ex_ph_cpn_isue_info.cust_ctn_enc is '연락처암호화';

comment on column ex_ph_cpn_isue_info.cust_ctn_sch is '연락처해시';

comment on column ex_ph_cpn_isue_info.kt_cust_id_enc is 'KT고객ID암호화';

comment on column ex_ph_cpn_isue_info.own_kt_cust_id_enc is '개통자KT고객ID암호화';

comment on column ex_ph_cpn_isue_info.pin_no_enc is '핀번호암호화';

create table ex_ph_deal_dtl
(
    phub_tr_no       varchar(30),
    pnt_tr_no        varchar(20),
    pnt_cd           varchar(30),
    deal_dt          varchar(14),
    ori_pnt_tr_no    varchar(20),
    deal_ind         varchar(20),
    ans_pnt          integer,
    ans_pnt_amt      integer,
    pnt_exch_rate    numeric(5, 2),
    rgst_dt          timestamp,
    rgst_user_id     varchar(20),
    cncl_yn          varchar(2),
    tran_dt          timestamp default now(),
    naver_user_key   varchar(20),
    naver_masking_id varchar(20)
);

comment on column ex_ph_deal_dtl.tran_dt is '데이터이관일시';

create table ex_ph_deal_info
(
    phub_tr_no     varchar(30),
    deal_dt        varchar(14),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    pg_send_po_id  varchar(20),
    deal_ind       varchar(20),
    cust_id        varchar(20),
    cncl_yn        varchar(1),
    pay_method     varchar(20),
    pg_deal_no     varchar(40),
    goods_nm       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    service_id     varchar(30),
    cncl_ind       varchar(10),
    inqr_pnt       integer,
    tran_dt        timestamp default now(),
    ttl_sale_amt   integer,
    cust_ci_enc    varchar(400)
);

comment on column ex_ph_deal_info.tran_dt is '데이터이관일시';

comment on column ex_ph_deal_info.ttl_sale_amt is '할인금액';

comment on column ex_ph_deal_info.cust_ci_enc is '고객CI암호화';

create index ex_ph_deal_info_idx01
    on ex_ph_deal_info (phub_tr_no, cust_id);

create table ex_ph_deal_req_dtl
(
    phub_tr_no       varchar(30),
    pnt_tr_no        varchar(20),
    pnt_cd           varchar(30),
    deal_dt          varchar(14),
    ori_pnt_tr_no    varchar(20),
    deal_ind         varchar(20),
    ans_pnt          integer,
    ans_pnt_amt      integer,
    pnt_exch_rate    numeric(5, 2),
    sucs_yn          varchar(1),
    err_cd           varchar(20),
    err_msg          varchar(1000),
    mdfy_user_id     varchar(20),
    rgst_dt          timestamp,
    rgst_user_id     varchar(20),
    mdfy_dt          timestamp,
    cncl_yn          varchar(1),
    tran_dt          timestamp default now(),
    naver_user_key   varchar(20),
    naver_masking_id varchar(20)
);

comment on column ex_ph_deal_req_dtl.tran_dt is '데이터이관일시';

create table ex_ph_deal_req_info
(
    phub_tr_no     varchar(30),
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(1000),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30),
    add_param      varchar(1000),
    inqr_pnt       integer,
    tran_dt        timestamp default now(),
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[],
    cust_ci_enc    varchar(400)
);

comment on column ex_ph_deal_req_info.tran_dt is '데이터이관일시';

comment on column ex_ph_deal_req_info.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ex_ph_deal_req_info.ttl_sale_amt is '할인금액';

comment on column ex_ph_deal_req_info.cust_ctn_enc is '연락처암호화';

comment on column ex_ph_deal_req_info.cust_ctn_sch is '연락처해시';

comment on column ex_ph_deal_req_info.cust_ci_enc is '고객CI암호화';

create index ex_ph_deal_req_info_idx01
    on ex_ph_deal_req_info (phub_tr_no, cust_id);

create table ex_ph_mms_send_hist
(
    mms_msg_no        varchar(20),
    mms_msg_id        varchar(10),
    msg_gen_dt        timestamp,
    send_dt           timestamp,
    phub_tr_no        varchar(20),
    phub_cpn_no       varchar(20),
    rsvt_send_yn      varchar(20),
    send_req_dt       timestamp,
    send_rslt_cd      varchar(20),
    send_rslt_msg     varchar(100),
    sms_call_back     varchar(100),
    prv_use_cd_1      varchar(30),
    prv_use_cd_2      varchar(30),
    prv_use_cd_3      varchar(30),
    rgst_dt           timestamp,
    rgst_user_id      varchar(20),
    mdfy_dt           timestamp,
    mdfy_user_id      varchar(20),
    tran_dt           timestamp default now(),
    send_cust_ctn_enc varchar(400),
    send_cust_ctn_sch varchar(400)[],
    send_cust_nm_enc  varchar(400),
    send_cust_nm_sch  varchar(400)[],
    recv_cust_ctn_enc varchar(400),
    recv_cust_ctn_sch varchar(400)[],
    recv_cust_nm_enc  varchar(400),
    recv_cust_nm_sch  varchar(400)[],
    msg_conts_enc     text
);

comment on column ex_ph_mms_send_hist.tran_dt is '데이터이관일시';

comment on column ex_ph_mms_send_hist.send_cust_ctn_enc is '발신번호암호화';

comment on column ex_ph_mms_send_hist.send_cust_ctn_sch is '발신번호해시';

comment on column ex_ph_mms_send_hist.send_cust_nm_enc is '발신자명암호화';

comment on column ex_ph_mms_send_hist.send_cust_nm_sch is '발신번호해시';

comment on column ex_ph_mms_send_hist.recv_cust_ctn_enc is '수신번호암호화';

comment on column ex_ph_mms_send_hist.recv_cust_ctn_sch is '수신번호해시';

comment on column ex_ph_mms_send_hist.recv_cust_nm_enc is '수신자명암호화';

comment on column ex_ph_mms_send_hist.recv_cust_nm_sch is '수신자명해시';

comment on column ex_ph_mms_send_hist.msg_conts_enc is '메시지전문암호화';

create table ex_ph_pnt_cust_ctn
(
    cust_id      varchar(20),
    telecom_ind  varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    tran_dt      timestamp default now(),
    cell_mdl_cd  varchar(50),
    cust_ctn_enc varchar(400),
    cust_ctn_sch varchar(400)[]
);

comment on column ex_ph_pnt_cust_ctn.tran_dt is '데이터이관일시';

comment on column ex_ph_pnt_cust_ctn.cell_mdl_cd is '휴대폰모델코드';

comment on column ex_ph_pnt_cust_ctn.cust_ctn_enc is '연락처암호화';

comment on column ex_ph_pnt_cust_ctn.cust_ctn_sch is '연락처해시';

create index ex_ph_pnt_cust_ctn_idx02
    on ex_ph_pnt_cust_ctn (cust_id, cust_ctn_enc);

create table ex_ph_pnt_cust_info
(
    cust_id      varchar(20) not null,
    clip_mmbr_yn varchar(1),
    clip_sbsc_dt varchar(14),
    clip_rtr_dd  varchar(8),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    pay_noti_yn  varchar(1),
    inforn_ind   varchar(10),
    clip_cust_id varchar(20),
    tran_dt      timestamp default now(),
    cust_nm_enc  varchar(400),
    cust_nm_sch  varchar(400)[],
    brdt_enc     varchar(400),
    cust_ci_enc  varchar(400),
    gender_enc   varchar(400)
);

comment on column ex_ph_pnt_cust_info.tran_dt is '데이터이관일시';

comment on column ex_ph_pnt_cust_info.cust_nm_enc is '고객명암호화';

comment on column ex_ph_pnt_cust_info.cust_nm_sch is '고객명해시';

comment on column ex_ph_pnt_cust_info.brdt_enc is '생년월일암호화';

comment on column ex_ph_pnt_cust_info.cust_ci_enc is '고객CI암호화';

comment on column ex_ph_pnt_cust_info.gender_enc is '성별암호화';

create index ex_ph_pnt_cust_info_idx02
    on ex_ph_pnt_cust_info (cust_id, cust_nm_enc);

create table fp_cpn_use_cmpr_fail
(
    mm_cmpr_no   varchar(12)  not null,
    seq          integer      not null,
    cmpr_mm      varchar(6),
    cpn_amt      integer,
    cpn_stat_cd  varchar(20),
    cpn_isue_dt  varchar(14),
    cpn_use_dt   varchar(14),
    cpn_cncl_dt  varchar(14),
    err_cd       varchar(20),
    err_msg      varchar(100),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    cust_ctn_enc varchar(400) not null,
    cust_ctn_sch varchar(400)[],
    pin_no_enc   varchar(400) not null
);

comment on table fp_cpn_use_cmpr_fail is '패밀리포인트쿠폰사용월대사결과D';

comment on column fp_cpn_use_cmpr_fail.mm_cmpr_no is '월대사번호';

comment on column fp_cpn_use_cmpr_fail.seq is '순번';

comment on column fp_cpn_use_cmpr_fail.cmpr_mm is '대사월';

comment on column fp_cpn_use_cmpr_fail.cpn_amt is '쿠폰금액';

comment on column fp_cpn_use_cmpr_fail.cpn_stat_cd is '쿠폰상태코드';

comment on column fp_cpn_use_cmpr_fail.cpn_isue_dt is '쿠폰발행일시';

comment on column fp_cpn_use_cmpr_fail.cpn_use_dt is '쿠폰사용일시';

comment on column fp_cpn_use_cmpr_fail.cpn_cncl_dt is '쿠폰취소일시';

comment on column fp_cpn_use_cmpr_fail.err_cd is '오류코드';

comment on column fp_cpn_use_cmpr_fail.err_msg is '오류메시지';

comment on column fp_cpn_use_cmpr_fail.rgst_dt is '등록일시';

comment on column fp_cpn_use_cmpr_fail.rgst_user_id is '등록자ID';

comment on column fp_cpn_use_cmpr_fail.mdfy_dt is '수정일시';

comment on column fp_cpn_use_cmpr_fail.mdfy_user_id is '수정자ID';

comment on column fp_cpn_use_cmpr_fail.cust_ctn_enc is '고객CTN암호화';

comment on column fp_cpn_use_cmpr_fail.cust_ctn_sch is '고객CTN해시';

comment on column fp_cpn_use_cmpr_fail.pin_no_enc is '핀번호암호화';

alter table fp_cpn_use_cmpr_fail
    add primary key (mm_cmpr_no, seq);

create table fp_cpn_use_cmpr_info
(
    mm_cmpr_no         varchar(12) not null,
    rds_file_nm        varchar(50),
    gifti_show_file_nm varchar(50),
    cmpr_mm            varchar(6),
    rds_ttl_deal_cnt   integer,
    rds_ttl_use_amt    integer,
    gshow_ttl_deal_cnt integer,
    gshow_ttl_use_amt  integer,
    no_acr_cnt         integer,
    no_acr_amt         integer,
    rgst_dt            timestamp,
    rgst_user_id       varchar(20),
    mdfy_dt            timestamp,
    mdfy_user_id       varchar(20)
);

comment on table fp_cpn_use_cmpr_info is '패밀리포인트쿠폰사용월대사결과M';

comment on column fp_cpn_use_cmpr_info.mm_cmpr_no is '월대사번호';

comment on column fp_cpn_use_cmpr_info.rds_file_nm is 'RDS파일명';

comment on column fp_cpn_use_cmpr_info.gifti_show_file_nm is '기프티쇼파일명';

comment on column fp_cpn_use_cmpr_info.cmpr_mm is '대사월';

comment on column fp_cpn_use_cmpr_info.rds_ttl_deal_cnt is 'KOS-RDS 총사용건수';

comment on column fp_cpn_use_cmpr_info.rds_ttl_use_amt is 'KOS-RDS 총사용금액';

comment on column fp_cpn_use_cmpr_info.gshow_ttl_deal_cnt is '기프티쇼 총사용건수';

comment on column fp_cpn_use_cmpr_info.gshow_ttl_use_amt is '기프티쇼 총사용금액';

comment on column fp_cpn_use_cmpr_info.no_acr_cnt is '불일치건수';

comment on column fp_cpn_use_cmpr_info.no_acr_amt is '불일치금액';

comment on column fp_cpn_use_cmpr_info.rgst_dt is '등록일시';

comment on column fp_cpn_use_cmpr_info.rgst_user_id is '등록자ID';

comment on column fp_cpn_use_cmpr_info.mdfy_dt is '수정일시';

comment on column fp_cpn_use_cmpr_info.mdfy_user_id is '수정자ID';

alter table fp_cpn_use_cmpr_info
    add primary key (mm_cmpr_no);

create table fp_gifti_show_cmpr_file_info
(
    mm_cmpr_no   varchar(12)  not null,
    seq          integer      not null,
    goods_nm     varchar(200),
    cpn_amt      integer,
    cpn_isue_dt  varchar(14),
    cpn_use_dt   varchar(14),
    cpn_cncl_dt  varchar(14),
    cpn_stat_cd  varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    cust_ctn_enc varchar(400) not null,
    cust_ctn_sch varchar(400)[],
    pin_no_enc   varchar(400) not null
);

comment on table fp_gifti_show_cmpr_file_info is '기프티쇼월대사파일정보';

comment on column fp_gifti_show_cmpr_file_info.mm_cmpr_no is '월대사번호';

comment on column fp_gifti_show_cmpr_file_info.seq is '순번';

comment on column fp_gifti_show_cmpr_file_info.goods_nm is '상품명';

comment on column fp_gifti_show_cmpr_file_info.cpn_amt is '쿠폰금액';

comment on column fp_gifti_show_cmpr_file_info.cpn_isue_dt is '쿠폰발행일시';

comment on column fp_gifti_show_cmpr_file_info.cpn_use_dt is '쿠폰사용일시';

comment on column fp_gifti_show_cmpr_file_info.cpn_cncl_dt is '쿠폰취소일시';

comment on column fp_gifti_show_cmpr_file_info.cpn_stat_cd is '쿠폰상태코드';

comment on column fp_gifti_show_cmpr_file_info.rgst_dt is '등록일시';

comment on column fp_gifti_show_cmpr_file_info.rgst_user_id is '등록자ID';

comment on column fp_gifti_show_cmpr_file_info.cust_ctn_enc is '고객CTN암호화';

comment on column fp_gifti_show_cmpr_file_info.cust_ctn_sch is '고객CTN해시';

comment on column fp_gifti_show_cmpr_file_info.pin_no_enc is '핀번호암호화';

alter table fp_gifti_show_cmpr_file_info
    add primary key (mm_cmpr_no, seq);

create table fp_gifti_show_goods
(
    goods_cd            varchar(30) not null,
    splcom_cd           varchar(200),
    splcom_nm           varchar(200),
    use_com_code        varchar(200),
    use_com_name        varchar(200),
    goods_nm            varchar(200),
    goods_img_250       varchar(200),
    goods_img_500       varchar(200),
    goods_img_desc      varchar(200),
    goods_img_sa        varchar(200),
    brand_icon_img      varchar(200),
    mms_brand_thum_img  varchar(200),
    mms_goods_img       varchar(200),
    goods_expl          varchar(4000),
    sell_price_amt      integer,
    cnsm_price_amt      integer,
    sell_end_dt         varchar(8),
    valid_prd_type_cd   varchar(10),
    valid_prd_day       numeric,
    valid_prd_date      varchar(8),
    goods_type_nm       varchar(50),
    goods_type_dtl_nm   varchar(50),
    supply_uniq_cd      varchar(100),
    mms_barcd_create_yn varchar(1),
    brand_cd            varchar(30),
    brand_nm            varchar(200),
    sell_discnt_cost    numeric,
    mms_content         varchar(4000),
    b2b_goods_yn        varchar(1),
    cancel_posbl_yn     varchar(1),
    extd_posbl_yn       varchar(1),
    refund_posbl_yn     varchar(1),
    search_text         varchar(4000),
    stad_terms_apply_yn varchar(1),
    rgst_dt             timestamp default now(),
    rgst_user_id        varchar(20),
    mdfy_dt             timestamp default now(),
    mdfy_user_id        varchar(20)
);

comment on column fp_gifti_show_goods.goods_cd is '상품아이디';

comment on column fp_gifti_show_goods.splcom_cd is '상품공급사아이디';

comment on column fp_gifti_show_goods.splcom_nm is '상품공급사명';

comment on column fp_gifti_show_goods.use_com_code is '교환처코드';

comment on column fp_gifti_show_goods.use_com_name is '교환처명';

comment on column fp_gifti_show_goods.goods_nm is '상품명';

comment on column fp_gifti_show_goods.goods_img_250 is '250X250사이즈이미지';

comment on column fp_gifti_show_goods.goods_img_500 is '500X500사이즈이미지';

comment on column fp_gifti_show_goods.goods_img_desc is '상품설명이미지';

comment on column fp_gifti_show_goods.goods_img_sa is '간편인증이미지';

comment on column fp_gifti_show_goods.brand_icon_img is '브랜드아이콘이미지';

comment on column fp_gifti_show_goods.mms_brand_thum_img is '브랜드MMS썸네일이미지';

comment on column fp_gifti_show_goods.mms_goods_img is '상품MMS이미지';

comment on column fp_gifti_show_goods.goods_expl is '상품설명';

comment on column fp_gifti_show_goods.sell_price_amt is '실판매단가';

comment on column fp_gifti_show_goods.cnsm_price_amt is '정상판매단가(액면가)';

comment on column fp_gifti_show_goods.sell_end_dt is '판매종료일자';

comment on column fp_gifti_show_goods.valid_prd_type_cd is '유효기간유형(01-일수//02-일자)';

comment on column fp_gifti_show_goods.valid_prd_day is '유효기간(일자)';

comment on column fp_gifti_show_goods.valid_prd_date is '유효기간(일수)';

comment on column fp_gifti_show_goods.goods_type_nm is '상품유형명';

comment on column fp_gifti_show_goods.goods_type_dtl_nm is '상세상품유형명';

comment on column fp_gifti_show_goods.supply_uniq_cd is '상품공급업체코드';

comment on column fp_gifti_show_goods.mms_barcd_create_yn is '공급사MMS바코드생성여부';

comment on column fp_gifti_show_goods.brand_cd is '브랜드코드';

comment on column fp_gifti_show_goods.brand_nm is '브랜드명';

comment on column fp_gifti_show_goods.sell_discnt_cost is '판매할인비용';

comment on column fp_gifti_show_goods.mms_content is 'MMS추가문구';

comment on column fp_gifti_show_goods.b2b_goods_yn is 'B2B상품여부';

comment on column fp_gifti_show_goods.cancel_posbl_yn is '취소가능여부';

comment on column fp_gifti_show_goods.extd_posbl_yn is '연장가능여부';

comment on column fp_gifti_show_goods.refund_posbl_yn is '환불가능여부';

comment on column fp_gifti_show_goods.search_text is '상품검색어';

comment on column fp_gifti_show_goods.stad_terms_apply_yn is '표준약관여부';

comment on column fp_gifti_show_goods.rgst_dt is '등록일시';

comment on column fp_gifti_show_goods.rgst_user_id is '등록자ID';

comment on column fp_gifti_show_goods.mdfy_dt is '수정일시';

comment on column fp_gifti_show_goods.mdfy_user_id is '수정자ID';

create unique index fp_gifti_show_goods_tmp_pk
    on fp_gifti_show_goods (goods_cd);

create unique index fp_gs_goods_tmp_amt_uk
    on fp_gifti_show_goods (cnsm_price_amt);

alter table fp_gifti_show_goods
    add constraint fp_gifti_show_goods_tmp_pkey
        primary key (goods_cd);

create table fp_gifti_show_goods_tmp
(
    goods_cd            varchar(30) not null,
    splcom_cd           varchar(200),
    splcom_nm           varchar(200),
    use_com_code        varchar(200),
    use_com_name        varchar(200),
    goods_nm            varchar(200),
    goods_img_250       varchar(200),
    goods_img_500       varchar(200),
    goods_img_desc      varchar(200),
    goods_img_sa        varchar(200),
    brand_icon_img      varchar(200),
    mms_brand_thum_img  varchar(200),
    mms_goods_img       varchar(200),
    goods_expl          varchar(4000),
    sell_price_amt      integer,
    cnsm_price_amt      integer,
    sell_end_dt         varchar(8),
    valid_prd_type_cd   varchar(10),
    valid_prd_day       numeric(28, 6),
    valid_prd_date      varchar(8),
    goods_type_nm       varchar(50),
    goods_type_dtl_nm   varchar(50),
    supply_uniq_cd      varchar(100),
    mms_barcd_create_yn varchar(1),
    brand_cd            varchar(30),
    brand_nm            varchar(200),
    sell_discnt_cost    numeric(28, 6),
    mms_content         varchar(4000),
    b2b_goods_yn        varchar(1),
    cancel_posbl_yn     varchar(1),
    extd_posbl_yn       varchar(1),
    refund_posbl_yn     varchar(1),
    search_text         varchar(4000),
    stad_terms_apply_yn varchar(1),
    rgst_dt             timestamp default now(),
    rgst_user_id        varchar(20),
    mdfy_dt             timestamp,
    mdfy_user_id        varchar(20)
);

comment on table fp_gifti_show_goods_tmp is '기프티쇼상품정보';

comment on column fp_gifti_show_goods_tmp.goods_cd is '상품ID';

comment on column fp_gifti_show_goods_tmp.splcom_cd is '상품공급사ID';

comment on column fp_gifti_show_goods_tmp.splcom_nm is '상품공급사명';

comment on column fp_gifti_show_goods_tmp.use_com_code is '교환처코드';

comment on column fp_gifti_show_goods_tmp.use_com_name is '교환처명';

comment on column fp_gifti_show_goods_tmp.goods_nm is '상품명';

comment on column fp_gifti_show_goods_tmp.goods_img_250 is '이미지250';

comment on column fp_gifti_show_goods_tmp.goods_img_500 is '이미지500';

comment on column fp_gifti_show_goods_tmp.goods_img_desc is '상품설명이미지';

comment on column fp_gifti_show_goods_tmp.goods_img_sa is '간편인증이미지';

comment on column fp_gifti_show_goods_tmp.brand_icon_img is '브랜드아이콘';

comment on column fp_gifti_show_goods_tmp.mms_brand_thum_img is '브랜드썸네일이미지';

comment on column fp_gifti_show_goods_tmp.mms_goods_img is '상품이미지';

comment on column fp_gifti_show_goods_tmp.goods_expl is '상품설명';

comment on column fp_gifti_show_goods_tmp.sell_price_amt is '실판매단가';

comment on column fp_gifti_show_goods_tmp.cnsm_price_amt is '정상판매단가';

comment on column fp_gifti_show_goods_tmp.sell_end_dt is '판매종료일자';

comment on column fp_gifti_show_goods_tmp.valid_prd_type_cd is '유효기간유형0102';

comment on column fp_gifti_show_goods_tmp.valid_prd_day is '유효기간_일수';

comment on column fp_gifti_show_goods_tmp.valid_prd_date is '유효기간_일자';

comment on column fp_gifti_show_goods_tmp.goods_type_nm is '상품유형명';

comment on column fp_gifti_show_goods_tmp.goods_type_dtl_nm is '상세상품유형명';

comment on column fp_gifti_show_goods_tmp.supply_uniq_cd is '공급업체코드';

comment on column fp_gifti_show_goods_tmp.mms_barcd_create_yn is 'mms바코드생성여부';

comment on column fp_gifti_show_goods_tmp.brand_cd is '브랜드코드';

comment on column fp_gifti_show_goods_tmp.brand_nm is '브랜드명';

comment on column fp_gifti_show_goods_tmp.sell_discnt_cost is '판매할인비용';

comment on column fp_gifti_show_goods_tmp.mms_content is 'mms추가문구';

comment on column fp_gifti_show_goods_tmp.b2b_goods_yn is 'B2B상품여부';

comment on column fp_gifti_show_goods_tmp.cancel_posbl_yn is '취소가능여부';

comment on column fp_gifti_show_goods_tmp.extd_posbl_yn is '연장가능여부';

comment on column fp_gifti_show_goods_tmp.refund_posbl_yn is '환불가능여부';

comment on column fp_gifti_show_goods_tmp.search_text is '상품검색어';

comment on column fp_gifti_show_goods_tmp.stad_terms_apply_yn is '표준약관여부';

comment on column fp_gifti_show_goods_tmp.rgst_dt is '등록일시';

comment on column fp_gifti_show_goods_tmp.rgst_user_id is '등록자ID';

comment on column fp_gifti_show_goods_tmp.mdfy_dt is '수정일시';

comment on column fp_gifti_show_goods_tmp.mdfy_user_id is '수정자ID';

create unique index fp_gifti_show_goods_pk
    on fp_gifti_show_goods_tmp (goods_cd);

create unique index fp_gs_goods_amt_uk
    on fp_gifti_show_goods_tmp (cnsm_price_amt);

alter table fp_gifti_show_goods_tmp
    add constraint fp_gifti_show_goods_pkey
        primary key (goods_cd);

create table fp_gifti_show_info
(
    phub_cpn_no  varchar(20) not null,
    ctr_id       varchar(30),
    goods_id     varchar(30),
    phub_tr_no   varchar(20),
    pay_no       varchar(30),
    prv_use_cd_1 varchar(30),
    prv_use_cd_2 varchar(30),
    prv_use_cd_3 varchar(30),
    rgst_dt      timestamp default now(),
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table fp_gifti_show_info is '기프티쇼쿠폰정보';

comment on column fp_gifti_show_info.phub_cpn_no is '포인트허브쿠폰번호';

comment on column fp_gifti_show_info.ctr_id is '기프티쇼거래ID';

comment on column fp_gifti_show_info.goods_id is '상품ID';

comment on column fp_gifti_show_info.phub_tr_no is '포인트허브거래번호';

comment on column fp_gifti_show_info.pay_no is '결제번호';

comment on column fp_gifti_show_info.prv_use_cd_1 is '전용코드_1';

comment on column fp_gifti_show_info.prv_use_cd_2 is '전용코드_2';

comment on column fp_gifti_show_info.prv_use_cd_3 is '전용코드_3';

comment on column fp_gifti_show_info.rgst_dt is '등록일시';

comment on column fp_gifti_show_info.rgst_user_id is '등록자ID';

comment on column fp_gifti_show_info.mdfy_dt is '수정일시';

comment on column fp_gifti_show_info.mdfy_user_id is '수정자ID';

create unique index fp_gifti_show_info_pk
    on fp_gifti_show_info (phub_cpn_no);

alter table fp_gifti_show_info
    add primary key (phub_cpn_no);

create table fp_rds_cmpr_file_info
(
    mm_cmpr_no   varchar(12)  not null,
    seq          integer      not null,
    hdqr_nm      varchar(100),
    chrg_nm      varchar(100),
    trtm_orgn_nm varchar(30),
    pmnt_dd      varchar(14),
    pmnt_item    varchar(30),
    pmnt_rsn     varchar(30),
    use_amt      integer,
    cpn_stat_cd  varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    cust_ctn_enc varchar(400) not null,
    cust_ctn_sch varchar(400)[],
    pin_no_enc   varchar(400) not null
);

comment on table fp_rds_cmpr_file_info is 'KOS-RDS월대사파일정보';

comment on column fp_rds_cmpr_file_info.mm_cmpr_no is '월대사번호';

comment on column fp_rds_cmpr_file_info.seq is '순번';

comment on column fp_rds_cmpr_file_info.hdqr_nm is '본부명';

comment on column fp_rds_cmpr_file_info.chrg_nm is '담당명';

comment on column fp_rds_cmpr_file_info.trtm_orgn_nm is '처리조직명';

comment on column fp_rds_cmpr_file_info.pmnt_dd is '수납일자';

comment on column fp_rds_cmpr_file_info.pmnt_item is '수납항목';

comment on column fp_rds_cmpr_file_info.pmnt_rsn is '수납사유';

comment on column fp_rds_cmpr_file_info.use_amt is '사용금액';

comment on column fp_rds_cmpr_file_info.cpn_stat_cd is '쿠폰상태코드';

comment on column fp_rds_cmpr_file_info.rgst_dt is '등록일시';

comment on column fp_rds_cmpr_file_info.rgst_user_id is '등록자ID';

comment on column fp_rds_cmpr_file_info.cust_ctn_enc is '고객CTN암호화';

comment on column fp_rds_cmpr_file_info.cust_ctn_sch is '고객CTN해시';

comment on column fp_rds_cmpr_file_info.pin_no_enc is '핀번호암호화';

alter table fp_rds_cmpr_file_info
    add primary key (mm_cmpr_no, seq);

create table kcoin_auto_pay_info
(
    cust_id          varchar(20) not null,
    bill_user_key    varchar(30) not null,
    bill_titl        varchar(100),
    auto_pay_amt     integer,
    auto_pay_dd      integer,
    auto_pay_stat_cd varchar(10),
    auto_pay_trmn_dd varchar(8),
    auto_pay_rslt_cd varchar(20),
    rgst_dt          timestamp,
    rgst_user_id     varchar(20),
    mdfy_dt          timestamp,
    mdfy_user_id     varchar(20)
);

comment on table kcoin_auto_pay_info is 'K코인자동납부정보';

comment on column kcoin_auto_pay_info.cust_id is '고객ID';

comment on column kcoin_auto_pay_info.bill_user_key is '청구사용자키';

comment on column kcoin_auto_pay_info.bill_titl is '청구제목';

comment on column kcoin_auto_pay_info.auto_pay_amt is '자동납부금액';

comment on column kcoin_auto_pay_info.auto_pay_dd is '자동납부일';

comment on column kcoin_auto_pay_info.auto_pay_stat_cd is '자동납부상태';

comment on column kcoin_auto_pay_info.auto_pay_trmn_dd is '자동납부해지일자';

comment on column kcoin_auto_pay_info.auto_pay_rslt_cd is '당월자동납부결과';

comment on column kcoin_auto_pay_info.rgst_dt is '등록일시';

comment on column kcoin_auto_pay_info.rgst_user_id is '등록자ID';

comment on column kcoin_auto_pay_info.mdfy_dt is '수정일시';

comment on column kcoin_auto_pay_info.mdfy_user_id is '수정자ID';

create unique index kcoin_auto_pay_info_pk
    on kcoin_auto_pay_info (cust_id, bill_user_key);

alter table kcoin_auto_pay_info
    add primary key (cust_id, bill_user_key);

create table monthly_del_cust_id
(
    cust_id varchar(20) not null
);

alter table monthly_del_cust_id
    add constraint monthly_del_cust_id_pk
        primary key (cust_id);

create table monthly_del_phub_tr_no
(
    phub_tr_no varchar(30) not null
);

alter table monthly_del_phub_tr_no
    add constraint monthly_del_phub_tr_no_pk
        primary key (phub_tr_no);

create table pg_cmpr_info_m
(
    dd_cmpr_no   varchar(12) not null,
    pg_cmpn_id   varchar(40),
    cmpr_dd      varchar(8),
    cmpr_ttl_cnt integer,
    cmpr_ttl_amt integer,
    file_path    varchar(100),
    file_nm      varchar(30),
    ttl_cncl_cnt integer default 0,
    ttl_cncl_amt integer default 0,
    trtm_rslt_cd varchar(20),
    rslt_msg     varchar(100),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table pg_cmpr_info_m is 'PG일대사M';

comment on column pg_cmpr_info_m.dd_cmpr_no is '일대사번호';

comment on column pg_cmpr_info_m.pg_cmpn_id is 'PG사ID';

comment on column pg_cmpr_info_m.cmpr_dd is '대사일자';

comment on column pg_cmpr_info_m.cmpr_ttl_cnt is '대사총건수';

comment on column pg_cmpr_info_m.cmpr_ttl_amt is '대사총금액';

comment on column pg_cmpr_info_m.file_path is '파일경로';

comment on column pg_cmpr_info_m.file_nm is '파일명';

comment on column pg_cmpr_info_m.ttl_cncl_cnt is '총취소건수';

comment on column pg_cmpr_info_m.ttl_cncl_amt is '총취소금액';

comment on column pg_cmpr_info_m.trtm_rslt_cd is '처리결과코드';

comment on column pg_cmpr_info_m.rslt_msg is '결과메시지';

comment on column pg_cmpr_info_m.rgst_dt is '등록일시';

comment on column pg_cmpr_info_m.rgst_user_id is '등록자ID';

comment on column pg_cmpr_info_m.mdfy_dt is '수정일시';

comment on column pg_cmpr_info_m.mdfy_user_id is '수정자ID';

create unique index pg_cmpr_info_m_pk
    on pg_cmpr_info_m (dd_cmpr_no);

alter table pg_cmpr_info_m
    add primary key (dd_cmpr_no);

create table ph_api_auth_info_s
(
    phub_tr_no           varchar(30) not null,
    sbank_deal_vo        text,
    attr1                text,
    attr2                text,
    attr3                text,
    attr4                text,
    attr5                text,
    rgst_dt              timestamp(6) default now(),
    mdfy_dt              timestamp(6) default now(),
    certification_vo_enc text
);

comment on column ph_api_auth_info_s.certification_vo_enc is '송신데이터암호화';

alter table ph_api_auth_info_s
    add primary key (phub_tr_no);

create table ph_cls_ag_info
(
    cust_id      varchar(20) not null,
    cls_id       varchar(10) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    mand_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    rgst_dt      timestamp   not null,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table ph_cls_ag_info is '약관동의정보';

comment on column ph_cls_ag_info.cust_id is '고객ID';

comment on column ph_cls_ag_info.cls_id is '약관ID';

comment on column ph_cls_ag_info.cls_ver is '약관버전';

comment on column ph_cls_ag_info.agre_yn is '동의여부';

comment on column ph_cls_ag_info.mand_yn is '필수여부';

comment on column ph_cls_ag_info.cls_titl is '약관타이틀';

comment on column ph_cls_ag_info.rgst_dt is '등록일시';

comment on column ph_cls_ag_info.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_info.mdfy_dt is '수정일시';

comment on column ph_cls_ag_info.mdfy_user_id is '수정자ID';

create index ph_cls_ag_info_idx_01
    on ph_cls_ag_info (cust_id, rgst_dt);

alter table ph_cls_ag_info
    add primary key (cust_id, cls_id);

create table ph_cls_info
(
    cls_id       varchar(10) not null,
    cls_ver      varchar(10) not null,
    aply_strt_dd varchar(8),
    aply_end_dd  varchar(8),
    cls_titl     varchar(200),
    cls_sub_titl varchar(200),
    use_yn       varchar(1)  default 'Y'::character varying,
    sort_ord     integer,
    mand_yn      varchar(1)  default 'Y'::character varying,
    cls_url      varchar(200),
    rmrk         varchar(100),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    service_id   varchar(30) default 'SVC_BASE'::character varying,
    pg_cmpn_id   varchar(40),
    cls_grp_id   varchar(20),
    cls_flag     varchar(20)
);

comment on table ph_cls_info is '약관정보';

comment on column ph_cls_info.cls_id is '약관ID';

comment on column ph_cls_info.cls_ver is '약관버전';

comment on column ph_cls_info.aply_strt_dd is '적용시작일자';

comment on column ph_cls_info.aply_end_dd is '적용종료일자';

comment on column ph_cls_info.cls_titl is '약관타이틀';

comment on column ph_cls_info.cls_sub_titl is '서브타이틀';

comment on column ph_cls_info.use_yn is '사용여부';

comment on column ph_cls_info.sort_ord is '정렬순서';

comment on column ph_cls_info.mand_yn is '필수여부';

comment on column ph_cls_info.cls_url is '약관상세팝업주소';

comment on column ph_cls_info.rmrk is '비고';

comment on column ph_cls_info.rgst_dt is '등록일시';

comment on column ph_cls_info.rgst_user_id is '등록자ID';

comment on column ph_cls_info.mdfy_dt is '수정일시';

comment on column ph_cls_info.mdfy_user_id is '수정자ID';

comment on column ph_cls_info.service_id is '서비스아이디';

comment on column ph_cls_info.pg_cmpn_id is 'PG사ID';

comment on column ph_cls_info.cls_grp_id is '약관그룹ID';

comment on column ph_cls_info.cls_flag is '약관flag';

create unique index ph_cls_info_pk
    on ph_cls_info (cls_id, cls_ver);

alter table ph_cls_info
    add primary key (cls_id, cls_ver);

create table ph_info_prvd_item
(
    cls_id       varchar(10) not null,
    prvdr_id     varchar(20) not null,
    cls_ver      varchar(10) not null,
    prvdr_nm     varchar(50),
    rcvr_id      varchar(10),
    rcvr_nm      varchar(20),
    prps         varchar(50),
    item         varchar(200),
    hold_prd     varchar(200),
    agre_yn      varchar(1) default 'Y'::character varying,
    sort_ord     integer,
    prv_use_cd_1 varchar(30),
    prv_use_cd_2 varchar(30),
    prv_use_cd_3 varchar(30),
    rmrk         varchar(100),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table ph_info_prvd_item is '정보제공사항정보';

comment on column ph_info_prvd_item.cls_id is '약관ID';

comment on column ph_info_prvd_item.prvdr_id is '제공처ID';

comment on column ph_info_prvd_item.cls_ver is '약관버전';

comment on column ph_info_prvd_item.prvdr_nm is '제공처이름';

comment on column ph_info_prvd_item.rcvr_id is '제공받는자';

comment on column ph_info_prvd_item.rcvr_nm is '제공받는자명';

comment on column ph_info_prvd_item.prps is '목적';

comment on column ph_info_prvd_item.item is '항목';

comment on column ph_info_prvd_item.hold_prd is '보유기간';

comment on column ph_info_prvd_item.agre_yn is '동의여부';

comment on column ph_info_prvd_item.sort_ord is '정렬순서';

comment on column ph_info_prvd_item.prv_use_cd_1 is '전용코드_1';

comment on column ph_info_prvd_item.prv_use_cd_2 is '전용코드_2';

comment on column ph_info_prvd_item.prv_use_cd_3 is '전용코드_3';

comment on column ph_info_prvd_item.rmrk is '비고';

comment on column ph_info_prvd_item.rgst_dt is '등록일시';

comment on column ph_info_prvd_item.rgst_user_id is '등록자ID';

comment on column ph_info_prvd_item.mdfy_dt is '수정일시';

comment on column ph_info_prvd_item.mdfy_user_id is '수정자ID';

create index ph_info_prvd_item_01fk
    on ph_info_prvd_item (cls_id, cls_ver);

create unique index ph_info_prvd_item_pk
    on ph_info_prvd_item (cls_id, prvdr_id, cls_ver);

alter table ph_info_prvd_item
    add primary key (cls_id, prvdr_id, cls_ver);

create table ph_mms_form_info
(
    mms_msg_id   varchar(10) not null,
    msg_ind      varchar(20),
    msg_titl     varchar(100),
    msg_body     varchar(1000),
    msg_type     varchar(10),
    clbc_ctn     varchar(20),
    use_yn       varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp  default now(),
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    msg_desc     varchar(200),
    oth_clbc_ctn varchar(20)
);

comment on table ph_mms_form_info is 'MMS메시지양식M';

comment on column ph_mms_form_info.mms_msg_id is '메시지ID';

comment on column ph_mms_form_info.msg_ind is '메시지구분';

comment on column ph_mms_form_info.msg_titl is '메시지제목';

comment on column ph_mms_form_info.msg_body is '메시지본문';

comment on column ph_mms_form_info.msg_type is '메시지유형';

comment on column ph_mms_form_info.clbc_ctn is '콜백번호';

comment on column ph_mms_form_info.use_yn is '사용여부';

comment on column ph_mms_form_info.rgst_dt is '등록일시';

comment on column ph_mms_form_info.rgst_user_id is '등록자ID';

comment on column ph_mms_form_info.mdfy_dt is '수정일시';

comment on column ph_mms_form_info.mdfy_user_id is '수정자ID';

comment on column ph_mms_form_info.msg_desc is '메시지설명';

comment on column ph_mms_form_info.oth_clbc_ctn is '타사가입자콜백번호';

create unique index ph_mms_form_info_pk
    on ph_mms_form_info (mms_msg_id);

alter table ph_mms_form_info
    add primary key (mms_msg_id);

create table ph_mon_sttl_d
(
    sttl_no      varchar(20) not null,
    seq          integer     not null,
    pay_amt      integer,
    sttl_amt     integer,
    pnt_id       varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
);

comment on table ph_mon_sttl_d is 'PG월정산D';

comment on column ph_mon_sttl_d.sttl_no is '정산번호';

comment on column ph_mon_sttl_d.seq is '순번';

comment on column ph_mon_sttl_d.pay_amt is '결제금액';

comment on column ph_mon_sttl_d.sttl_amt is '정산금액';

comment on column ph_mon_sttl_d.pnt_id is '포인트ID';

comment on column ph_mon_sttl_d.rgst_dt is '등록일시';

comment on column ph_mon_sttl_d.rgst_user_id is '등록자ID';

create index ph_mon_sttl_d_01fk
    on ph_mon_sttl_d (sttl_no);

create unique index ph_mon_sttl_d_pk
    on ph_mon_sttl_d (sttl_no, seq);

alter table ph_mon_sttl_d
    add primary key (sttl_no, seq);

create table ph_mon_sttl_m
(
    sttl_no      varchar(20) not null,
    pg_cmpn_id   varchar(40),
    sttl_mm      varchar(6),
    ttl_cnt      integer,
    ttl_pay_amt  integer,
    ttl_sttl_amt integer,
    trtm_rslt_cd varchar(20),
    rslt_msg     varchar(100),
    trtm_strt_dt timestamp,
    trtm_end_dt  timestamp,
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table ph_mon_sttl_m is 'PG월정산M';

comment on column ph_mon_sttl_m.sttl_no is '정산번호';

comment on column ph_mon_sttl_m.pg_cmpn_id is 'PG사ID';

comment on column ph_mon_sttl_m.sttl_mm is '정산월';

comment on column ph_mon_sttl_m.ttl_cnt is '총건수';

comment on column ph_mon_sttl_m.ttl_pay_amt is '총결제금액';

comment on column ph_mon_sttl_m.ttl_sttl_amt is '총정산금액';

comment on column ph_mon_sttl_m.trtm_rslt_cd is '처리결과코드';

comment on column ph_mon_sttl_m.rslt_msg is '결과메시지';

comment on column ph_mon_sttl_m.trtm_strt_dt is '처리시작일시';

comment on column ph_mon_sttl_m.trtm_end_dt is '처리종료일시';

comment on column ph_mon_sttl_m.rgst_dt is '등록일시';

comment on column ph_mon_sttl_m.rgst_user_id is '등록자ID';

comment on column ph_mon_sttl_m.mdfy_dt is '수정일시';

comment on column ph_mon_sttl_m.mdfy_user_id is '수정자ID';

create unique index ph_mon_sttl_m_pk
    on ph_mon_sttl_m (sttl_no);

alter table ph_mon_sttl_m
    add primary key (sttl_no);

create table ph_pg_cmpn_info
(
    pg_cmpn_id       varchar(40)  not null,
    pg_cmpn_nm       varchar(50),
    pnt_aply_strt_dd varchar(8),
    pnt_aply_end_dd  varchar(8),
    athn_key         varchar(100),
    rgst_dt          timestamp,
    rgst_user_id     varchar(20),
    mdfy_dt          timestamp,
    mdfy_user_id     varchar(20),
    chrgr_nm_enc     varchar(400) not null,
    chrgr_nm_sch     varchar(400)[],
    chrgr_tel_enc    varchar(400) not null,
    chrgr_tel_sch    varchar(400)[]
);

comment on table ph_pg_cmpn_info is 'PG사정보';

comment on column ph_pg_cmpn_info.pg_cmpn_id is 'PG사ID';

comment on column ph_pg_cmpn_info.pg_cmpn_nm is 'PG사이름';

comment on column ph_pg_cmpn_info.pnt_aply_strt_dd is '포인트적용시작일';

comment on column ph_pg_cmpn_info.pnt_aply_end_dd is '포인트적용종료일';

comment on column ph_pg_cmpn_info.athn_key is '인증키';

comment on column ph_pg_cmpn_info.rgst_dt is '등록일시';

comment on column ph_pg_cmpn_info.rgst_user_id is '등록자ID';

comment on column ph_pg_cmpn_info.mdfy_dt is '수정일시';

comment on column ph_pg_cmpn_info.mdfy_user_id is '수정자ID';

comment on column ph_pg_cmpn_info.chrgr_nm_enc is '담당자명암호화';

comment on column ph_pg_cmpn_info.chrgr_nm_sch is '담당자명해시';

comment on column ph_pg_cmpn_info.chrgr_tel_enc is '담당자연락처암호화';

comment on column ph_pg_cmpn_info.chrgr_tel_sch is '담당자연락처해시';

create unique index ph_pg_cmpn_info_pk
    on ph_pg_cmpn_info (pg_cmpn_id);

alter table ph_pg_cmpn_info
    add primary key (pg_cmpn_id);

create table ph_pg_cprt
(
    pg_cmpn_id    varchar(40) not null,
    cprt_cmpn_id  varchar(30) not null,
    pg_send_po_id varchar(20),
    rgst_dt       timestamp,
    rgst_user_id  varchar(20),
    mdfy_dt       timestamp,
    mdfy_user_id  varchar(20)
);

comment on table ph_pg_cprt is 'PG사제휴';

comment on column ph_pg_cprt.pg_cmpn_id is 'PG사ID';

comment on column ph_pg_cprt.cprt_cmpn_id is '사용처ID';

comment on column ph_pg_cprt.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_pg_cprt.rgst_dt is '등록일시';

comment on column ph_pg_cprt.rgst_user_id is '등록자ID';

comment on column ph_pg_cprt.mdfy_dt is '수정일시';

comment on column ph_pg_cprt.mdfy_user_id is '수정자ID';

create index ph_pg_cprt_01fk
    on ph_pg_cprt (pg_cmpn_id);

create index ph_pg_cprt_02fk
    on ph_pg_cprt (cprt_cmpn_id);

create unique index ph_pg_cprt_pk
    on ph_pg_cprt (pg_cmpn_id, cprt_cmpn_id);

alter table ph_pg_cprt
    add primary key (pg_cmpn_id, cprt_cmpn_id);

create table ph_pg_cprt_attr
(
    cprt_cmpn_id  varchar(40) not null,
    pay_method    varchar(10) not null,
    identi_url    varchar(100),
    point_url     varchar(100),
    alert_msg     varchar(100),
    identi_img_pc text,
    point_img_pc  text,
    identi_img_mb text,
    point_img_mb  text,
    rate_show_yn  varchar(1)   default 'N'::character varying,
    init_yn       varchar(1)   default 'N'::character varying,
    rgst_dt       timestamp(0) default now(),
    rgst_user_id  varchar(20),
    mdfy_dt       timestamp(0) default now(),
    mdfy_user_id  varchar(20)
);

create index ph_pg_cprt_attr_cprt_cmpn_id_idx
    on ph_pg_cprt_attr (cprt_cmpn_id);

create index ph_pg_cprt_attr_pay_method_idx
    on ph_pg_cprt_attr (pay_method);

alter table ph_pg_cprt_attr
    add constraint ph_pg_cprt_attr_pk
        primary key (cprt_cmpn_id, pay_method);

create table ph_pg_cprt_cmsn_rate
(
    pg_cmpn_id        varchar(40) not null,
    cprt_cmpn_id      varchar(30) not null,
    rate_aply_strt_dd varchar(8)  not null,
    rate_aply_end_dd  varchar(8),
    kt_cmsn_rate      numeric(5, 2),
    pg_cmsn_rate      numeric(5, 2),
    rgst_dt           timestamp,
    rgst_user_id      varchar(20),
    mdfy_dt           timestamp,
    mdfy_user_id      varchar(20)
);

comment on table ph_pg_cprt_cmsn_rate is 'PG_사용처별수수료';

comment on column ph_pg_cprt_cmsn_rate.pg_cmpn_id is 'PG사ID';

comment on column ph_pg_cprt_cmsn_rate.cprt_cmpn_id is '사용처ID';

comment on column ph_pg_cprt_cmsn_rate.rate_aply_strt_dd is '적용시작일';

comment on column ph_pg_cprt_cmsn_rate.rate_aply_end_dd is '적용종료일자';

comment on column ph_pg_cprt_cmsn_rate.kt_cmsn_rate is 'KT수수료율';

comment on column ph_pg_cprt_cmsn_rate.pg_cmsn_rate is 'PG수수료율';

comment on column ph_pg_cprt_cmsn_rate.rgst_dt is '등록일시';

comment on column ph_pg_cprt_cmsn_rate.rgst_user_id is '등록자ID';

comment on column ph_pg_cprt_cmsn_rate.mdfy_dt is '수정일시';

comment on column ph_pg_cprt_cmsn_rate.mdfy_user_id is '수정자ID';

create index ph_pg_cprt_cmsn_rate_01fk
    on ph_pg_cprt_cmsn_rate (pg_cmpn_id, cprt_cmpn_id);

create unique index ph_pg_cprt_cmsn_rate_pk
    on ph_pg_cprt_cmsn_rate (pg_cmpn_id, cprt_cmpn_id, rate_aply_strt_dd);

alter table ph_pg_cprt_cmsn_rate
    add primary key (pg_cmpn_id, cprt_cmpn_id, rate_aply_strt_dd);

create table ph_pg_cprt_limit_hist
(
    pg_cmpn_id     varchar(40) not null,
    cprt_cmpn_id   varchar(30) not null,
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(8)  not null,
    cprt_cmpn_seq  integer,
    ori_phub_tr_no varchar(30),
    deal_ind       varchar(20),
    ttl_pnt_amt    integer,
    rgst_dt        timestamp default now()
);

create index ph_pg_cprt_limit_hist_01
    on ph_pg_cprt_limit_hist (pg_cmpn_id);

create index ph_pg_cprt_limit_hist_02
    on ph_pg_cprt_limit_hist (cprt_cmpn_id);

create index ph_pg_cprt_limit_hist_03
    on ph_pg_cprt_limit_hist (deal_dt);

alter table ph_pg_cprt_limit_hist
    add primary key (pg_cmpn_id, cprt_cmpn_id, phub_tr_no, deal_dt);

create table ph_pg_cprt_limit_info
(
    pg_cmpn_id    varchar(40) not null,
    cprt_cmpn_id  varchar(30) not null,
    cprt_cmpn_seq integer     not null,
    limit_amount  integer,
    rmrk          varchar(100),
    limit_yn      varchar(1) default 'N'::character varying,
    rgst_dt       timestamp  default now(),
    rgst_user_id  varchar(20)
);

alter table ph_pg_cprt_limit_info
    add primary key (pg_cmpn_id, cprt_cmpn_id, cprt_cmpn_seq);

create table ph_pg_cprt_policy
(
    policy_id           varchar(10)  not null,
    policy_nm           varchar(100) not null,
    deal_unit           integer,
    min_per_deal        integer,
    max_per_deal        integer,
    prvdr_pnt_exch_rate numeric,
    cprt_pnt_exch_rate  numeric,
    max_dscnt_rate      numeric(5, 2),
    cprt_cmsn_rate      numeric(5, 2),
    dp_unit             varchar(20),
    rmrk                varchar(1000),
    rgst_dt             timestamp,
    rgst_user_id        varchar(30),
    mdfy_dt             timestamp,
    mdfy_user_id        varchar(30)
);

comment on table ph_pg_cprt_policy is '사용처정책';

comment on column ph_pg_cprt_policy.policy_id is '정책ID';

comment on column ph_pg_cprt_policy.policy_nm is '정책명';

comment on column ph_pg_cprt_policy.deal_unit is '거래단위';

comment on column ph_pg_cprt_policy.min_per_deal is '최소거래금액';

comment on column ph_pg_cprt_policy.max_per_deal is '최대거래금액';

comment on column ph_pg_cprt_policy.prvdr_pnt_exch_rate is '제공처(카드사)포인트 전환율';

comment on column ph_pg_cprt_policy.cprt_pnt_exch_rate is '사용처(가맹점)포인트 전환율';

comment on column ph_pg_cprt_policy.max_dscnt_rate is '최대할인율';

comment on column ph_pg_cprt_policy.cprt_cmsn_rate is '사용처수수료율';

comment on column ph_pg_cprt_policy.dp_unit is '화면표시단위';

comment on column ph_pg_cprt_policy.rmrk is '비고';

comment on column ph_pg_cprt_policy.rgst_dt is '등록일시';

comment on column ph_pg_cprt_policy.rgst_user_id is '등록자ID';

comment on column ph_pg_cprt_policy.mdfy_dt is '수정일시';

comment on column ph_pg_cprt_policy.mdfy_user_id is '수정자ID';

create unique index ph_pg_cprt_policy_pk
    on ph_pg_cprt_policy (policy_id);

alter table ph_pg_cprt_policy
    add primary key (policy_id);

create table ph_pg_cprt_prvdr
(
    pg_cmpn_id   varchar(40) not null,
    cprt_cmpn_id varchar(30) not null,
    prvdr_id     varchar(20) not null,
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    imag_link    varchar(100),
    sort_ord     integer,
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table ph_pg_cprt_prvdr is '포인트사용처별제공처';

comment on column ph_pg_cprt_prvdr.pg_cmpn_id is 'PG사ID';

comment on column ph_pg_cprt_prvdr.cprt_cmpn_id is '사용처ID';

comment on column ph_pg_cprt_prvdr.prvdr_id is '제공처ID';

comment on column ph_pg_cprt_prvdr.rgst_dt is '등록일시';

comment on column ph_pg_cprt_prvdr.rgst_user_id is '등록자ID';

comment on column ph_pg_cprt_prvdr.imag_link is '이미지링크';

comment on column ph_pg_cprt_prvdr.sort_ord is '정렬순서';

comment on column ph_pg_cprt_prvdr.mdfy_dt is '수정일시';

comment on column ph_pg_cprt_prvdr.mdfy_user_id is '수정자ID';

create index ph_pg_cprt_prvdr_02fk
    on ph_pg_cprt_prvdr (prvdr_id);

create unique index ph_pg_cprt_prvdr_pk
    on ph_pg_cprt_prvdr (pg_cmpn_id, cprt_cmpn_id, prvdr_id);

alter table ph_pg_cprt_prvdr
    add primary key (pg_cmpn_id, cprt_cmpn_id, prvdr_id);

create table ph_pg_cprt_prvdr_policy
(
    policy_id     varchar(10) not null,
    prvdr_id      varchar(20) not null,
    deal_unit     integer,
    min_avl_pnt   integer,
    max_per_pnt   integer,
    pnt_exch_rate numeric,
    pnt_rule      varchar(1000),
    dp_unit       varchar(20),
    rmrk          varchar(1000),
    rgst_dt       timestamp,
    rgst_user_id  varchar(30),
    mdfy_dt       timestamp,
    mdfy_user_id  varchar(30)
);

comment on table ph_pg_cprt_prvdr_policy is '사용처별카드사정책';

comment on column ph_pg_cprt_prvdr_policy.policy_id is '정책ID';

comment on column ph_pg_cprt_prvdr_policy.prvdr_id is '제공처ID';

comment on column ph_pg_cprt_prvdr_policy.deal_unit is '거래단위';

comment on column ph_pg_cprt_prvdr_policy.min_avl_pnt is '최소사용포인트';

comment on column ph_pg_cprt_prvdr_policy.max_per_pnt is '최대거래포인트';

comment on column ph_pg_cprt_prvdr_policy.pnt_exch_rate is '포인트전환율';

comment on column ph_pg_cprt_prvdr_policy.pnt_rule is '포인트rule';

comment on column ph_pg_cprt_prvdr_policy.dp_unit is '화면표시단위';

comment on column ph_pg_cprt_prvdr_policy.rmrk is '비고';

comment on column ph_pg_cprt_prvdr_policy.rgst_dt is '등록일시';

comment on column ph_pg_cprt_prvdr_policy.rgst_user_id is '등록자ID';

comment on column ph_pg_cprt_prvdr_policy.mdfy_dt is '수정일시';

comment on column ph_pg_cprt_prvdr_policy.mdfy_user_id is '수정자ID';

create unique index ph_pg_cprt_prvdr_policy_pk
    on ph_pg_cprt_prvdr_policy (policy_id, prvdr_id);

alter table ph_pg_cprt_prvdr_policy
    add primary key (policy_id, prvdr_id);

create table ph_pg_cprt_scr_info_d
(
    scr_id       varchar(10)  not null,
    elmt_id      varchar(50)  not null,
    elmt_txt     varchar(100) not null,
    elmt_typ     varchar(20),
    cond_val1    varchar(20),
    cond_val2    varchar(20),
    cond_val3    varchar(20),
    rmrk         varchar(1000),
    rgst_dt      timestamp,
    rgst_user_id varchar(30),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(30)
);

comment on table ph_pg_cprt_scr_info_d is '가맹점화면정보D';

comment on column ph_pg_cprt_scr_info_d.scr_id is '화면정보ID';

comment on column ph_pg_cprt_scr_info_d.elmt_id is '화면요소ID';

comment on column ph_pg_cprt_scr_info_d.elmt_txt is '화면요소명';

comment on column ph_pg_cprt_scr_info_d.elmt_typ is '요소구분(TEXT : text문구, HTML : html문구, MSG : 노출메시지, SRC : 소스경로)';

comment on column ph_pg_cprt_scr_info_d.rmrk is '설명';

comment on column ph_pg_cprt_scr_info_d.rgst_dt is '등록일시';

comment on column ph_pg_cprt_scr_info_d.rgst_user_id is '등록자ID';

comment on column ph_pg_cprt_scr_info_d.mdfy_dt is '수정일시';

comment on column ph_pg_cprt_scr_info_d.mdfy_user_id is '수정자ID';

alter table ph_pg_cprt_scr_info_d
    add primary key (scr_id, elmt_id);

create table ph_pg_cprt_scr_info_m
(
    scr_id       varchar(10)  not null,
    scr_nm       varchar(100) not null,
    pay_method   varchar(20),
    rmrk         varchar(1000),
    rgst_dt      timestamp,
    rgst_user_id varchar(30),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(30)
);

comment on table ph_pg_cprt_scr_info_m is '가맹점화면정보M';

comment on column ph_pg_cprt_scr_info_m.scr_id is '화면정보ID';

comment on column ph_pg_cprt_scr_info_m.scr_nm is '화면정보명';

comment on column ph_pg_cprt_scr_info_m.pay_method is '결제구분(SI : 권종형 단일 결제, CO : 복합 결제, CU : 소진형 결제)';

comment on column ph_pg_cprt_scr_info_m.rmrk is '설명';

comment on column ph_pg_cprt_scr_info_m.rgst_dt is '등록일시';

comment on column ph_pg_cprt_scr_info_m.rgst_user_id is '등록자ID';

comment on column ph_pg_cprt_scr_info_m.mdfy_dt is '수정일시';

comment on column ph_pg_cprt_scr_info_m.mdfy_user_id is '수정자ID';

alter table ph_pg_cprt_scr_info_m
    add primary key (scr_id);

create table ph_pnt_acml_use
(
    cust_id      varchar(20) not null,
    pnt_cd       varchar(30) not null,
    use_dd       varchar(8),
    dd_acml_pnt  integer,
    mm_acml_pnt  integer,
    dd_acml_cnt  integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table ph_pnt_acml_use is '포인트기간별누적사용';

comment on column ph_pnt_acml_use.cust_id is '고객ID';

comment on column ph_pnt_acml_use.pnt_cd is '포인트코드';

comment on column ph_pnt_acml_use.use_dd is '사용일자';

comment on column ph_pnt_acml_use.dd_acml_pnt is '일일누적포인트';

comment on column ph_pnt_acml_use.mm_acml_pnt is '월누적포인트';

comment on column ph_pnt_acml_use.dd_acml_cnt is '일일누적거래횟수';

comment on column ph_pnt_acml_use.rgst_dt is '등록일시';

comment on column ph_pnt_acml_use.rgst_user_id is '등록자ID';

comment on column ph_pnt_acml_use.mdfy_dt is '수정일시';

comment on column ph_pnt_acml_use.mdfy_user_id is '수정자ID';

create index ph_pnt_acml_use_01fk
    on ph_pnt_acml_use (cust_id);

create unique index ph_pnt_acml_use_pk
    on ph_pnt_acml_use (cust_id, pnt_cd);

alter table ph_pnt_acml_use
    add primary key (cust_id, pnt_cd);

create table ph_pnt_cmpn_info
(
    cprt_cmpn_id  varchar(30)                                not null,
    cprt_cmpn_nm  varchar(50),
    biz_no        varchar(20),
    rchr_pay_ind  varchar(20),
    rgst_dt       timestamp,
    rgst_user_id  varchar(20),
    mdfy_dt       timestamp,
    mdfy_user_id  varchar(20),
    lotte_aflt_no varchar(10),
    kmc_url_id    varchar(20),
    policy_id     varchar(10),
    dsp_titl      varchar(100),
    cls_grp_id    varchar(20),
    scr_id        varchar(20),
    cmpn_if_type  varchar(5) default 'UI'::character varying not null
);

comment on table ph_pnt_cmpn_info is '포인트사용처정보';

comment on column ph_pnt_cmpn_info.cprt_cmpn_id is '사용처ID';

comment on column ph_pnt_cmpn_info.cprt_cmpn_nm is '사용처명';

comment on column ph_pnt_cmpn_info.biz_no is '사업자번호';

comment on column ph_pnt_cmpn_info.rchr_pay_ind is '충전결제구분';

comment on column ph_pnt_cmpn_info.rgst_dt is '등록일시';

comment on column ph_pnt_cmpn_info.rgst_user_id is '등록자ID';

comment on column ph_pnt_cmpn_info.mdfy_dt is '수정일시';

comment on column ph_pnt_cmpn_info.mdfy_user_id is '수정자ID';

comment on column ph_pnt_cmpn_info.lotte_aflt_no is '롯데멤버스가맹점번호';

comment on column ph_pnt_cmpn_info.kmc_url_id is 'KMC 본인인증 팝업 호출 URL ID';

comment on column ph_pnt_cmpn_info.policy_id is '사용처정책ID';

comment on column ph_pnt_cmpn_info.dsp_titl is '화면출력 가맹점명';

comment on column ph_pnt_cmpn_info.cls_grp_id is '약관그룹ID';

comment on column ph_pnt_cmpn_info.scr_id is '화면정보ID';

create unique index ph_pnt_cmpn_info_pk
    on ph_pnt_cmpn_info (cprt_cmpn_id);

alter table ph_pnt_cmpn_info
    add primary key (cprt_cmpn_id);

create table ph_pnt_cmpn_mms_whthr
(
    cprt_cmpn_id varchar(30),
    pay_noti_yn  char,
    start_hour   numeric(2),
    end_hour     numeric(2)
);

create table ph_pnt_cmpn_user
(
    cprt_cmpn_id     varchar(30) not null,
    cust_id          varchar(20) not null,
    pnt_cmpn_user_id varchar(30),
    rgst_dt          timestamp,
    rgst_user_id     varchar(20),
    mdfy_dt          timestamp(0)
);

comment on table ph_pnt_cmpn_user is '포인트사용처별고객ID';

comment on column ph_pnt_cmpn_user.cprt_cmpn_id is '사용처ID';

comment on column ph_pnt_cmpn_user.cust_id is '고객ID';

comment on column ph_pnt_cmpn_user.pnt_cmpn_user_id is '사용처별사용자ID';

comment on column ph_pnt_cmpn_user.rgst_dt is '등록일시';

comment on column ph_pnt_cmpn_user.rgst_user_id is '등록자ID';

create index ph_pnt_cmpn_user_01fk
    on ph_pnt_cmpn_user (cprt_cmpn_id);

create index ph_pnt_cmpn_user_02fk
    on ph_pnt_cmpn_user (cust_id);

create unique index ph_pnt_cmpn_user_pk
    on ph_pnt_cmpn_user (cprt_cmpn_id, cust_id);

alter table ph_pnt_cmpn_user
    add primary key (cprt_cmpn_id, cust_id);

create table ph_pnt_cust_ctn
(
    cust_id      varchar(20)  not null,
    telecom_ind  varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    cell_mdl_cd  varchar(50),
    cust_ctn_enc varchar(400) not null,
    cust_ctn_sch varchar(400)[]
);

comment on table ph_pnt_cust_ctn is '사용자별CTN';

comment on column ph_pnt_cust_ctn.cust_id is '고객ID';

comment on column ph_pnt_cust_ctn.telecom_ind is '통신사구분';

comment on column ph_pnt_cust_ctn.rgst_dt is '등록일시';

comment on column ph_pnt_cust_ctn.rgst_user_id is '등록자ID';

comment on column ph_pnt_cust_ctn.mdfy_dt is '수정일시';

comment on column ph_pnt_cust_ctn.mdfy_user_id is '수정자ID';

comment on column ph_pnt_cust_ctn.cell_mdl_cd is '휴대폰모델코드';

comment on column ph_pnt_cust_ctn.cust_ctn_enc is '연락처암호화';

comment on column ph_pnt_cust_ctn.cust_ctn_sch is '연락처해시';

create index ph_pnt_cust_ctn_01fk
    on ph_pnt_cust_ctn (cust_id);

alter table ph_pnt_cust_ctn
    add constraint ph_pnt_cust_ctn_pk
        primary key (cust_id, cust_ctn_enc);

create table ph_pnt_cust_ctn_tmp
(
    cust_id      varchar(20) not null,
    cust_ctn     varchar(50) not null,
    telecom_ind  varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

create index ph_pnt_cust_ctn_tmp_01fk
    on ph_pnt_cust_ctn_tmp (cust_id);

alter table ph_pnt_cust_ctn_tmp
    add primary key (cust_id, cust_ctn);

create table ph_pnt_cust_ctn_tmp2
(
    cust_id      varchar(20),
    cust_ctn     varchar(50),
    telecom_ind  varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

create table ph_pnt_prvd_tmzn_info
(
    prvdr_id     varchar(20) not null,
    tmzn_str_dt  varchar(14) not null,
    tmzn_end_dt  varchar(14) not null,
    tmzn_typ     varchar(20),
    use_yn       varchar(20),
    rmrk         varchar(1000),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

comment on table ph_pnt_prvd_tmzn_info is '포인트제공처 타입존 정보';

comment on column ph_pnt_prvd_tmzn_info.prvdr_id is '포인트제공처ID';

comment on column ph_pnt_prvd_tmzn_info.tmzn_str_dt is '적용시작일시';

comment on column ph_pnt_prvd_tmzn_info.tmzn_end_dt is '적용종료일시';

comment on column ph_pnt_prvd_tmzn_info.tmzn_typ is '시간대유형(EXCL/INCL)';

comment on column ph_pnt_prvd_tmzn_info.use_yn is '사용여부(Y/N)';

comment on column ph_pnt_prvd_tmzn_info.rmrk is '비고';

comment on column ph_pnt_prvd_tmzn_info.rgst_dt is '등록일시';

comment on column ph_pnt_prvd_tmzn_info.rgst_user_id is '등록자ID';

comment on column ph_pnt_prvd_tmzn_info.mdfy_dt is '수정일시';

comment on column ph_pnt_prvd_tmzn_info.mdfy_user_id is '수정자ID';

alter table ph_pnt_prvd_tmzn_info
    add primary key (prvdr_id, tmzn_str_dt);

create table ph_pnt_prvdr
(
    prvdr_id        varchar(20) not null,
    prvdr_nm        varchar(50),
    pnt_cd          varchar(30),
    dp_unit         varchar(20),
    pnt_nm          varchar(20),
    pnt_rule        varchar(1000),
    imag_link       varchar(100),
    pnt_prfx        varchar(2),
    deal_unit       integer,
    max_deal_cnt_dd integer,
    athn_key        varchar(100),
    min_avl_pnt     integer,
    max_per_deal    integer,
    dd_deal_lmt     integer,
    mm_deal_lmt     integer,
    window_yn       varchar(1) default 'Y'::character varying,
    andr_yn         varchar(1) default 'Y'::character varying,
    ios_yn          varchar(1) default 'Y'::character varying,
    rgst_dt         timestamp,
    rgst_user_id    varchar(30),
    mdfy_dt         timestamp,
    mdfy_user_id    varchar(30)
);

comment on table ph_pnt_prvdr is '포인트제공처';

comment on column ph_pnt_prvdr.prvdr_id is '제공처ID';

comment on column ph_pnt_prvdr.prvdr_nm is '제공처이름';

comment on column ph_pnt_prvdr.pnt_cd is '포인트코드';

comment on column ph_pnt_prvdr.dp_unit is '표시단위';

comment on column ph_pnt_prvdr.pnt_nm is '포인트명';

comment on column ph_pnt_prvdr.pnt_rule is '포인트규칙';

comment on column ph_pnt_prvdr.imag_link is '이미지링크';

comment on column ph_pnt_prvdr.pnt_prfx is '포인트접두사';

comment on column ph_pnt_prvdr.deal_unit is '거래단위';

comment on column ph_pnt_prvdr.max_deal_cnt_dd is '일일거래횟수한도';

comment on column ph_pnt_prvdr.athn_key is '인증키';

comment on column ph_pnt_prvdr.min_avl_pnt is '최소사용가능포인트';

comment on column ph_pnt_prvdr.max_per_deal is '거래당최대포인트';

comment on column ph_pnt_prvdr.dd_deal_lmt is '일일거래한도';

comment on column ph_pnt_prvdr.mm_deal_lmt is '월거래한도';

comment on column ph_pnt_prvdr.window_yn is '윈도우지원';

comment on column ph_pnt_prvdr.andr_yn is '안드로이드여부';

comment on column ph_pnt_prvdr.ios_yn is 'IOS여부';

comment on column ph_pnt_prvdr.rgst_dt is '등록일시';

comment on column ph_pnt_prvdr.rgst_user_id is '등록자ID';

comment on column ph_pnt_prvdr.mdfy_dt is '수정일시';

comment on column ph_pnt_prvdr.mdfy_user_id is '수정자ID';

create unique index ph_pnt_prvdr_pk
    on ph_pnt_prvdr (prvdr_id);

create unique index phpntprvdr_uk
    on ph_pnt_prvdr (pnt_cd);

create unique index phpntprvdr_uk2
    on ph_pnt_prvdr (pnt_prfx);

alter table ph_pnt_prvdr
    add primary key (prvdr_id);

create table ph_prvd_cmsn_rate_hist
(
    prvdr_id          varchar(20) not null,
    rate_aply_strt_dd varchar(8)  not null,
    pnt_cmsn_rate     numeric(6, 3),
    rate_aply_end_dd  varchar(8),
    rgst_dt           timestamp,
    rgst_user_id      varchar(30),
    mdfy_dt           timestamp,
    mdfy_user_id      varchar(20)
);

comment on table ph_prvd_cmsn_rate_hist is '제공처수수료율이력';

comment on column ph_prvd_cmsn_rate_hist.prvdr_id is '제공처ID';

comment on column ph_prvd_cmsn_rate_hist.rate_aply_strt_dd is '적용시작일자';

comment on column ph_prvd_cmsn_rate_hist.pnt_cmsn_rate is '수수료율';

comment on column ph_prvd_cmsn_rate_hist.rate_aply_end_dd is '적용종료일자';

comment on column ph_prvd_cmsn_rate_hist.rgst_dt is '등록일시';

comment on column ph_prvd_cmsn_rate_hist.rgst_user_id is '등록자ID';

comment on column ph_prvd_cmsn_rate_hist.mdfy_dt is '수정일시';

comment on column ph_prvd_cmsn_rate_hist.mdfy_user_id is '수정자ID';

create index ph_prvd_cmsn_rate_hist_01fk
    on ph_prvd_cmsn_rate_hist (prvdr_id);

create unique index ph_prvd_cmsn_rate_hist_pk
    on ph_prvd_cmsn_rate_hist (prvdr_id, rate_aply_strt_dd);

alter table ph_prvd_cmsn_rate_hist
    add primary key (prvdr_id, rate_aply_strt_dd);

create table ph_prvd_exch_rate_hist
(
    prvdr_id          varchar(20) not null,
    rate_aply_strt_dd varchar(8)  not null,
    pnt_exch_rate     numeric,
    rate_aply_end_dd  varchar(8),
    rgst_dt           timestamp,
    rgst_user_id      varchar(30),
    mdfy_dt           timestamp,
    mdfy_user_id      varchar(20)
);

comment on table ph_prvd_exch_rate_hist is '제공처전환율이력';

comment on column ph_prvd_exch_rate_hist.prvdr_id is '제공처ID';

comment on column ph_prvd_exch_rate_hist.rate_aply_strt_dd is '적용시작일자';

comment on column ph_prvd_exch_rate_hist.pnt_exch_rate is '전환율';

comment on column ph_prvd_exch_rate_hist.rate_aply_end_dd is '적용종료일자';

comment on column ph_prvd_exch_rate_hist.rgst_dt is '등록일시';

comment on column ph_prvd_exch_rate_hist.rgst_user_id is '등록자ID';

comment on column ph_prvd_exch_rate_hist.mdfy_dt is '수정일시';

comment on column ph_prvd_exch_rate_hist.mdfy_user_id is '수정자ID';

create index ph_prvd_exch_rate_hist_01fk
    on ph_prvd_exch_rate_hist (prvdr_id);

create unique index ph_prvd_exch_rate_hist_pk
    on ph_prvd_exch_rate_hist (prvdr_id, rate_aply_strt_dd);

alter table ph_prvd_exch_rate_hist
    add primary key (prvdr_id, rate_aply_strt_dd);

create table rwrd_goods_rgst_info
(
    cust_id            varchar(20) not null,
    cprt_goods_id      varchar(20) not null,
    cprt_goods_nm      varchar(50),
    evnt_entry_dd      varchar(8),
    engg_strt_mm       varchar(6),
    engg_end_mm        varchar(6),
    mm_engg_pnt        integer,
    cndt_stsf_goods_yn varchar(1) default 'Y'::character varying,
    engg_stat_cd       varchar(10),
    bill_user_key      varchar(30),
    rgst_dt            timestamp,
    rgst_user_id       varchar(20),
    mdfy_dt            timestamp,
    mdfy_user_id       varchar(20)
);

comment on table rwrd_goods_rgst_info is '슈퍼리워드제휴상품등록정보';

comment on column rwrd_goods_rgst_info.cust_id is '고객ID';

comment on column rwrd_goods_rgst_info.cprt_goods_id is '제휴상품ID';

comment on column rwrd_goods_rgst_info.cprt_goods_nm is '제휴상품명';

comment on column rwrd_goods_rgst_info.evnt_entry_dd is '이벤트응모일자';

comment on column rwrd_goods_rgst_info.engg_strt_mm is '약정시작년월';

comment on column rwrd_goods_rgst_info.engg_end_mm is '약정종료년월';

comment on column rwrd_goods_rgst_info.mm_engg_pnt is '월약정포인트';

comment on column rwrd_goods_rgst_info.cndt_stsf_goods_yn is '조건충족상품여부';

comment on column rwrd_goods_rgst_info.engg_stat_cd is '약정상태';

comment on column rwrd_goods_rgst_info.bill_user_key is '청구사용자키';

comment on column rwrd_goods_rgst_info.rgst_dt is '등록일시';

comment on column rwrd_goods_rgst_info.rgst_user_id is '등록자ID';

comment on column rwrd_goods_rgst_info.mdfy_dt is '수정일시';

comment on column rwrd_goods_rgst_info.mdfy_user_id is '수정자ID';

alter table rwrd_goods_rgst_info
    add primary key (cust_id, cprt_goods_id);

create table st_deal_dtl
(
    deal_dd           varchar(8)  not null,
    service_id        varchar(30) not null,
    prvdr_id          varchar(20) not null,
    deal_mm           varchar(6),
    pnt_cd            varchar(30),
    pay_pnt           integer,
    pay_pnt_amt       integer,
    pay_cnt           integer,
    pay_fail_pnt      integer,
    pay_fail_pnt_amt  integer,
    pay_fail_cnt      integer,
    cncl_pnt          integer,
    cncl_pnt_amt      integer,
    cncl_cnt          integer,
    cncl_fail_pnt     integer,
    cncl_fail_pnt_amt integer,
    cncl_fail_cnt     integer,
    rgst_dt           timestamp,
    rgst_user_id      varchar(30),
    pay_sale_amt      integer
);

comment on table st_deal_dtl is '통계_거래내역';

comment on column st_deal_dtl.deal_dd is '거래일자';

comment on column st_deal_dtl.service_id is '서비스ID';

comment on column st_deal_dtl.prvdr_id is '제공처ID';

comment on column st_deal_dtl.deal_mm is '거래년월';

comment on column st_deal_dtl.pnt_cd is '포인트코드';

comment on column st_deal_dtl.pay_pnt is '사용포인트';

comment on column st_deal_dtl.pay_pnt_amt is '사용포인트금액';

comment on column st_deal_dtl.pay_cnt is '사용건수';

comment on column st_deal_dtl.pay_fail_pnt is '사용실패포인트';

comment on column st_deal_dtl.pay_fail_pnt_amt is '사용실패포인트금액';

comment on column st_deal_dtl.pay_fail_cnt is '사용실패건수';

comment on column st_deal_dtl.cncl_pnt is '취소포인트';

comment on column st_deal_dtl.cncl_pnt_amt is '취소포인트금액';

comment on column st_deal_dtl.cncl_cnt is '취소건수';

comment on column st_deal_dtl.cncl_fail_pnt is '취소실패포인트';

comment on column st_deal_dtl.cncl_fail_pnt_amt is '취소실패포인트금액';

comment on column st_deal_dtl.cncl_fail_cnt is '취소실패건수';

comment on column st_deal_dtl.rgst_dt is '등록일시';

comment on column st_deal_dtl.rgst_user_id is '등록자ID';

create unique index st_deal_dtl_pk
    on st_deal_dtl (deal_dd, service_id, prvdr_id);

alter table st_deal_dtl
    add primary key (deal_dd, service_id, prvdr_id);

create table st_deal_info
(
    deal_dd           varchar(8)  not null,
    service_id        varchar(30) not null,
    pg_cmpn_id        varchar(40) not null,
    cprt_cmpn_id      varchar(30) not null,
    deal_mm           varchar(6),
    pay_pnt           integer,
    pay_pnt_amt       integer,
    pay_cnt           integer,
    pay_fail_pnt      integer,
    pay_fail_pnt_amt  integer,
    pay_fail_cnt      integer,
    cncl_pnt          integer,
    cncl_pnt_amt      integer,
    cncl_cnt          integer,
    cncl_fail_pnt     integer,
    cncl_fail_pnt_amt integer,
    cncl_fail_cnt     integer,
    rgst_dt           timestamp,
    rgst_user_id      varchar(30),
    pay_sale_amt      integer
);

comment on table st_deal_info is '통계_거래정보';

comment on column st_deal_info.deal_dd is '거래일자';

comment on column st_deal_info.service_id is '서비스ID';

comment on column st_deal_info.pg_cmpn_id is 'PG사ID';

comment on column st_deal_info.cprt_cmpn_id is '사용처ID';

comment on column st_deal_info.deal_mm is '거래년월';

comment on column st_deal_info.pay_pnt is '사용포인트';

comment on column st_deal_info.pay_pnt_amt is '사용포인트금액';

comment on column st_deal_info.pay_cnt is '사용건수';

comment on column st_deal_info.pay_fail_pnt is '사용실패포인트';

comment on column st_deal_info.pay_fail_pnt_amt is '사용실패포인트금액';

comment on column st_deal_info.pay_fail_cnt is '사용실패건수';

comment on column st_deal_info.cncl_pnt is '취소포인트';

comment on column st_deal_info.cncl_pnt_amt is '취소포인트금액';

comment on column st_deal_info.cncl_cnt is '취소건수';

comment on column st_deal_info.cncl_fail_pnt is '취소실패포인트';

comment on column st_deal_info.cncl_fail_pnt_amt is '취소실패포인트금액';

comment on column st_deal_info.cncl_fail_cnt is '취소실패건수';

comment on column st_deal_info.rgst_dt is '등록일시';

comment on column st_deal_info.rgst_user_id is '등록자ID';

comment on column st_deal_info.pay_sale_amt is '할인금액';

create unique index st_deal_info_pk
    on st_deal_info (deal_dd, service_id, pg_cmpn_id, cprt_cmpn_id);

alter table st_deal_info
    add primary key (deal_dd, service_id, pg_cmpn_id, cprt_cmpn_id);

create table st_deal_info_by_agegrd
(
    deal_dd      varchar(8)  not null,
    agegrd       varchar(10) not null,
    service_id   varchar(30) not null,
    pg_cmpn_id   varchar(40) not null,
    cprt_cmpn_id varchar(30) not null,
    deal_mm      varchar(6),
    pay_pnt      integer,
    pay_pnt_amt  integer,
    pay_cnt      integer,
    cncl_pnt     integer,
    cncl_pnt_amt integer,
    cncl_cnt     integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(30)
);

comment on table st_deal_info_by_agegrd is '통계_연령대별거래내역';

comment on column st_deal_info_by_agegrd.deal_dd is '거래일자';

comment on column st_deal_info_by_agegrd.agegrd is '연령대';

comment on column st_deal_info_by_agegrd.service_id is '서비스ID';

comment on column st_deal_info_by_agegrd.pg_cmpn_id is 'PG사ID';

comment on column st_deal_info_by_agegrd.cprt_cmpn_id is '사용처ID';

comment on column st_deal_info_by_agegrd.deal_mm is '거래년월';

comment on column st_deal_info_by_agegrd.pay_pnt is '사용포인트';

comment on column st_deal_info_by_agegrd.pay_pnt_amt is '사용포인트금액';

comment on column st_deal_info_by_agegrd.pay_cnt is '사용건수';

comment on column st_deal_info_by_agegrd.cncl_pnt is '취소포인트';

comment on column st_deal_info_by_agegrd.cncl_pnt_amt is '취소포인트금액';

comment on column st_deal_info_by_agegrd.cncl_cnt is '취소건수';

comment on column st_deal_info_by_agegrd.rgst_dt is '등록일시';

comment on column st_deal_info_by_agegrd.rgst_user_id is '등록자ID';

alter table st_deal_info_by_agegrd
    add primary key (deal_dd, agegrd, service_id, pg_cmpn_id, cprt_cmpn_id);

create table st_deal_info_by_gender
(
    deal_dd      varchar(8)  not null,
    service_id   varchar(30) not null,
    pg_cmpn_id   varchar(40) not null,
    cprt_cmpn_id varchar(30) not null,
    deal_mm      varchar(6),
    pay_pnt      integer,
    pay_pnt_amt  integer,
    pay_cnt      integer,
    cncl_pnt     integer,
    cncl_pnt_amt integer,
    cncl_cnt     integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(30),
    gender_enc   varchar(400)
);

comment on table st_deal_info_by_gender is '통계_성별거래내역';

comment on column st_deal_info_by_gender.deal_dd is '거래일자';

comment on column st_deal_info_by_gender.service_id is '서비스ID';

comment on column st_deal_info_by_gender.pg_cmpn_id is 'PG사ID';

comment on column st_deal_info_by_gender.cprt_cmpn_id is '사용처ID';

comment on column st_deal_info_by_gender.deal_mm is '거래년월';

comment on column st_deal_info_by_gender.pay_pnt is '사용포인트';

comment on column st_deal_info_by_gender.pay_pnt_amt is '사용포인트금액';

comment on column st_deal_info_by_gender.pay_cnt is '사용건수';

comment on column st_deal_info_by_gender.cncl_pnt is '취소포인트';

comment on column st_deal_info_by_gender.cncl_pnt_amt is '취소포인트금액';

comment on column st_deal_info_by_gender.cncl_cnt is '취소건수';

comment on column st_deal_info_by_gender.rgst_dt is '등록일시';

comment on column st_deal_info_by_gender.rgst_user_id is '등록자ID';

comment on column st_deal_info_by_gender.gender_enc is '성별암호화';

create table st_deal_req_pnt_users
(
    deal_dd      varchar(8)  not null,
    pnt_cd       varchar(20) not null,
    req_cnt      integer,
    req_user_cnt integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(30)
);

comment on table st_deal_req_pnt_users is '통계_제공처별거래이용자수';

comment on column st_deal_req_pnt_users.deal_dd is '거래일자';

comment on column st_deal_req_pnt_users.pnt_cd is '포인트코드';

comment on column st_deal_req_pnt_users.req_cnt is '요청건수';

comment on column st_deal_req_pnt_users.req_user_cnt is '요청자수';

comment on column st_deal_req_pnt_users.rgst_dt is '등록일시';

comment on column st_deal_req_pnt_users.rgst_user_id is '등록자ID';

create unique index st_deal_req_pnt_users_pk
    on st_deal_req_pnt_users (deal_dd, pnt_cd);

alter table st_deal_req_pnt_users
    add primary key (deal_dd, pnt_cd);

create table st_deal_req_users
(
    deal_dd      varchar(8)  not null,
    pg_cmpn_id   varchar(40) not null,
    cprt_cmpn_id varchar(20) not null,
    req_cnt      integer,
    req_user_cnt integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(30)
);

comment on table st_deal_req_users is '통계_거래이용자수';

comment on column st_deal_req_users.deal_dd is '거래일자';

comment on column st_deal_req_users.pg_cmpn_id is 'PG사ID';

comment on column st_deal_req_users.cprt_cmpn_id is '가맹점ID';

comment on column st_deal_req_users.req_cnt is '요청건수';

comment on column st_deal_req_users.req_user_cnt is '요청자수';

comment on column st_deal_req_users.rgst_dt is '등록일시';

comment on column st_deal_req_users.rgst_user_id is '등록자ID';

create unique index st_deal_req_users_pk
    on st_deal_req_users (deal_dd, pg_cmpn_id, cprt_cmpn_id);

alter table st_deal_req_users
    add primary key (deal_dd, pg_cmpn_id, cprt_cmpn_id);

create table st_if_err_info
(
    if_dd        varchar(8)  not null,
    if_sys_cd    varchar(10) not null,
    err_cd       varchar(30) not null,
    err_msg      varchar(200),
    if_mm        varchar(6),
    err_cnt      integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(30)
);

comment on table st_if_err_info is '통계_연동오류내역';

comment on column st_if_err_info.if_dd is '연동일자';

comment on column st_if_err_info.if_sys_cd is '연동시스템코드';

comment on column st_if_err_info.err_cd is '오류코드';

comment on column st_if_err_info.err_msg is '오류메시지';

comment on column st_if_err_info.if_mm is '연동년월';

comment on column st_if_err_info.err_cnt is '오류건수';

comment on column st_if_err_info.rgst_dt is '등록일시';

comment on column st_if_err_info.rgst_user_id is '등록자ID';

create unique index st_if_err_info_pk
    on st_if_err_info (if_dd, if_sys_cd, err_cd);

alter table st_if_err_info
    add primary key (if_dd, if_sys_cd, err_cd);

create table st_pay_err_by_cprt
(
    deal_dd      varchar(8)  not null,
    cprt_cmpn_id varchar(20) not null,
    err_cd       varchar(20) not null,
    err_cnt      integer,
    err_pnt      integer,
    err_pnt_amt  integer,
    cust_cnt     integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(30)
);

comment on table st_pay_err_by_cprt is '가맹점_원인별오류통계';

comment on column st_pay_err_by_cprt.deal_dd is '거래일자';

comment on column st_pay_err_by_cprt.cprt_cmpn_id is '가맹점ID';

comment on column st_pay_err_by_cprt.err_cd is '에러코드';

comment on column st_pay_err_by_cprt.err_cnt is '오류건수';

comment on column st_pay_err_by_cprt.err_pnt is '오류포인트';

comment on column st_pay_err_by_cprt.err_pnt_amt is '오류전환금액';

comment on column st_pay_err_by_cprt.cust_cnt is '고객기준건수';

comment on column st_pay_err_by_cprt.rgst_dt is '등록일시';

comment on column st_pay_err_by_cprt.rgst_user_id is '등록자ID';

create unique index st_pay_err_by_cprt_pk
    on st_pay_err_by_cprt (deal_dd, cprt_cmpn_id, err_cd);

alter table st_pay_err_by_cprt
    add primary key (deal_dd, cprt_cmpn_id, err_cd);

create table st_pay_err_by_pnt
(
    deal_dd      varchar(8)  not null,
    pnt_cd       varchar(20) not null,
    err_cd       varchar(20) not null,
    err_cnt      integer,
    err_pnt      integer,
    err_pnt_amt  integer,
    cust_cnt     integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(30)
);

comment on table st_pay_err_by_pnt is '포인트제공처별오류통계';

comment on column st_pay_err_by_pnt.deal_dd is '거래일자';

comment on column st_pay_err_by_pnt.pnt_cd is '포인트코드';

comment on column st_pay_err_by_pnt.err_cd is '오류코드';

comment on column st_pay_err_by_pnt.err_cnt is '오류건수';

comment on column st_pay_err_by_pnt.err_pnt is '오류포인트';

comment on column st_pay_err_by_pnt.err_pnt_amt is '오류전환금액';

comment on column st_pay_err_by_pnt.cust_cnt is '고객기준건수';

comment on column st_pay_err_by_pnt.rgst_dt is '등록일시';

comment on column st_pay_err_by_pnt.rgst_user_id is '등록자ID';

create unique index st_pay_err_by_pnt_pk
    on st_pay_err_by_pnt (deal_dd, pnt_cd, err_cd);

alter table st_pay_err_by_pnt
    add primary key (deal_dd, pnt_cd, err_cd);

create table st_sms_send_info
(
    send_dd       varchar(8)  not null,
    mms_msg_id    varchar(10) not null,
    myothcmp_ind  varchar(10) not null,
    send_mm       varchar(6),
    send_cnt      integer,
    send_sucs_cnt integer,
    send_fail_cnt integer,
    rgst_dt       timestamp,
    rgst_user_id  varchar(20)
);

comment on table st_sms_send_info is '통계_문자발송내역';

comment on column st_sms_send_info.send_dd is '발송일자';

comment on column st_sms_send_info.mms_msg_id is '메시지ID';

comment on column st_sms_send_info.myothcmp_ind is '자타사구분';

comment on column st_sms_send_info.send_mm is '발송년월';

comment on column st_sms_send_info.send_cnt is '발송건수';

comment on column st_sms_send_info.send_sucs_cnt is '발송성공건수';

comment on column st_sms_send_info.send_fail_cnt is '발송실패건수';

comment on column st_sms_send_info.rgst_dt is '등록일시';

comment on column st_sms_send_info.rgst_user_id is '등록자ID';

alter table st_sms_send_info
    add primary key (send_dd, mms_msg_id, myothcmp_ind);

create table st_use_by_step
(
    deal_dd      varchar(8)  not null,
    service_id   varchar(30) not null,
    cprt_cmpn_id varchar(20) not null,
    step_cnt_01  integer,
    step_cnt_02  integer,
    step_cnt_03  integer,
    step_cnt_04  integer,
    step_cnt_05  integer,
    step_cnt_06  integer,
    step_cnt_07  integer,
    step_cnt_08  integer,
    step_cnt_09  integer,
    step_cnt_10  integer,
    sucs_cnt     integer,
    fail_cnt     integer,
    rgst_dt      timestamp,
    rgst_user_id varchar(30)
);

comment on table st_use_by_step is '통계_결제단계별이용내역';

comment on column st_use_by_step.deal_dd is '거래일자';

comment on column st_use_by_step.service_id is '서비스ID';

comment on column st_use_by_step.cprt_cmpn_id is '가맹점ID';

comment on column st_use_by_step.step_cnt_01 is '스텝카운트1';

comment on column st_use_by_step.step_cnt_02 is '스텝카운트2';

comment on column st_use_by_step.step_cnt_03 is '스텝카운트3';

comment on column st_use_by_step.step_cnt_04 is '스텝카운트4';

comment on column st_use_by_step.step_cnt_05 is '스텝카운트5';

comment on column st_use_by_step.step_cnt_06 is '스텝카운트6';

comment on column st_use_by_step.step_cnt_07 is '스텝카운트7';

comment on column st_use_by_step.step_cnt_08 is '스텝카운트8';

comment on column st_use_by_step.step_cnt_09 is '스텝카운트9';

comment on column st_use_by_step.step_cnt_10 is '스텝카운트10';

comment on column st_use_by_step.sucs_cnt is '결제성공건수';

comment on column st_use_by_step.fail_cnt is '결제실패건수';

comment on column st_use_by_step.rgst_dt is '등록일시';

comment on column st_use_by_step.rgst_user_id is '등록자ID';

create unique index st_use_by_step_pk
    on st_use_by_step (deal_dd, service_id, cprt_cmpn_id);

alter table st_use_by_step
    add primary key (deal_dd, service_id, cprt_cmpn_id);

create table ph_pnt_cmpn_attr_info
(
    cprt_cmpn_id varchar(30) not null,
    attr_id      varchar(20) not null,
    attr_val     varchar(50),
    use_yn       varchar(20),
    rmrk         varchar(200),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

alter table ph_pnt_cmpn_attr_info
    add primary key (cprt_cmpn_id, attr_id);

create table ph_pnt_prvd_tmzn_info_hist
(
    prvdr_id     varchar(20) not null,
    tmzn_str_dt  varchar(14) not null,
    hist_seq     varchar(20) not null,
    crud_typ     varchar(20) not null,
    tmzn_end_dt  varchar(14) not null,
    tmzn_typ     varchar(20),
    use_yn       varchar(20),
    rmrk         varchar(200),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20)
);

alter table ph_pnt_prvd_tmzn_info_hist
    add primary key (prvdr_id, tmzn_str_dt, hist_seq);

create table ph_pnt_cust_info
(
    cust_id      varchar(20)  not null,
    clip_mmbr_yn varchar(1) default 'Y'::character varying,
    clip_sbsc_dt varchar(14),
    clip_rtr_dd  varchar(8),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    mdfy_dt      timestamp,
    mdfy_user_id varchar(20),
    pay_noti_yn  varchar(1) default 'Y'::character varying,
    inforn_ind   varchar(10),
    clip_cust_id varchar(20),
    cust_nm_enc  varchar(400) not null,
    cust_nm_sch  varchar(400)[],
    brdt_enc     varchar(400),
    brdt_sch     varchar(400)[],
    cust_ci_enc  varchar(400) not null,
    gender_enc   varchar(400)
);

comment on table ph_pnt_cust_info is '포인트사용고객';

comment on column ph_pnt_cust_info.cust_id is '고객ID';

comment on column ph_pnt_cust_info.clip_mmbr_yn is '클립멤버여부';

comment on column ph_pnt_cust_info.clip_sbsc_dt is '클립가입일시';

comment on column ph_pnt_cust_info.clip_rtr_dd is '클립탈퇴일';

comment on column ph_pnt_cust_info.rgst_dt is '등록일시';

comment on column ph_pnt_cust_info.rgst_user_id is '등록자ID';

comment on column ph_pnt_cust_info.mdfy_dt is '수정일시';

comment on column ph_pnt_cust_info.mdfy_user_id is '수정자ID';

comment on column ph_pnt_cust_info.pay_noti_yn is '결제알림여부';

comment on column ph_pnt_cust_info.inforn_ind is '내외국인구분';

comment on column ph_pnt_cust_info.clip_cust_id is '클립고객ID';

comment on column ph_pnt_cust_info.cust_nm_enc is '고객명암호화';

comment on column ph_pnt_cust_info.cust_nm_sch is '고객명해시';

comment on column ph_pnt_cust_info.brdt_enc is '생년월일암호화';

comment on column ph_pnt_cust_info.cust_ci_enc is '고객CI암호화';

comment on column ph_pnt_cust_info.gender_enc is '성별암호화';

create index ph_pnt_cust_info_idx01
    on ph_pnt_cust_info (cust_ci_enc);

alter table ph_pnt_cust_info
    add primary key (cust_id);

create table k_deal_dailypick_sign_cust_info
(
    cust_id        varchar(20) not null,
    transaction_id varchar(40) not null,
    success_yn     varchar(2)  not null,
    rgst_dt        timestamp   not null
);

alter table k_deal_dailypick_sign_cust_info
    add constraint k_deal_dailypick_sign_cust_info_pk
        primary key (cust_id, transaction_id);

alter table k_deal_dailypick_sign_cust_info
    add constraint k_deal_dailypick_sign_cust_info_fk
        foreign key (cust_id) references ph_pnt_cust_info;

create table adm_batch_log
(
    log_no         varchar(20) not null,
    dd_cmpr_no     varchar(12),
    cmpr_dd        varchar(8),
    task_id        varchar(20),
    job_dt         timestamp,
    tgt_cnt        integer,
    cmpr_cnt       integer,
    tgt_file_path  varchar(100),
    cmpr_file_path varchar(100),
    strt_dt        timestamp,
    end_dt         timestamp,
    rslt_code      varchar(20),
    rslt_msg       varchar(200),
    rgst_dt        timestamp,
    rgst_user_id   varchar(20)
);

comment on column adm_batch_log.log_no is '로그번호';

comment on column adm_batch_log.dd_cmpr_no is '일대사번호';

comment on column adm_batch_log.cmpr_dd is '일대사일자';

comment on column adm_batch_log.task_id is 'task아이디';

comment on column adm_batch_log.job_dt is '작업일시';

comment on column adm_batch_log.tgt_cnt is '대상건수';

comment on column adm_batch_log.cmpr_cnt is '처리건수';

comment on column adm_batch_log.tgt_file_path is '대상파일경로';

comment on column adm_batch_log.cmpr_file_path is '처리파일경로';

comment on column adm_batch_log.strt_dt is '작업시작일시';

comment on column adm_batch_log.end_dt is '작업종료일시';

comment on column adm_batch_log.rslt_code is '결과코드';

comment on column adm_batch_log.rslt_msg is '결과메시지';

comment on column adm_batch_log.rgst_dt is '등록일시';

comment on column adm_batch_log.rgst_user_id is '등록자ID';

create index adm_batch_log_idx_01
    on adm_batch_log (job_dt);

alter table adm_batch_log
    add primary key (log_no);

create table auto_pay_err_hist
(
    cust_id       varchar(20) not null,
    bill_user_key varchar(30) not null,
    pay_req_dt    varchar(14) not null,
    bill_titl     varchar(100),
    pay_req_amt   integer,
    err_cd        varchar(20),
    err_msg       varchar(300),
    rgst_dt       timestamp,
    rgst_user_id  varchar(20)
);

comment on column auto_pay_err_hist.cust_id is '고객ID';

comment on column auto_pay_err_hist.bill_user_key is '청구사용자키';

comment on column auto_pay_err_hist.pay_req_dt is '납부요청일시';

comment on column auto_pay_err_hist.bill_titl is '청구제목';

comment on column auto_pay_err_hist.pay_req_amt is '납부요청금액';

comment on column auto_pay_err_hist.err_cd is '오류코드';

comment on column auto_pay_err_hist.err_msg is '오류메시지';

comment on column auto_pay_err_hist.rgst_dt is '등록일시';

comment on column auto_pay_err_hist.rgst_user_id is '등록자ID';

alter table auto_pay_err_hist
    add constraint auto_pay_err_hist_250917_pkey
        primary key (cust_id, bill_user_key, pay_req_dt);

create table cl_cmpr_fail
(
    dd_cmpr_no    varchar(12) not null,
    seq           integer     not null,
    cmpr_dd       varchar(8),
    pnt_cd        varchar(30),
    phub_tr_no    varchar(30),
    pnt_tr_no     varchar(20),
    ori_pnt_tr_no varchar(20),
    ans_pnt       integer,
    err_cd        varchar(20),
    err_msg       varchar(100)
);

comment on column cl_cmpr_fail.dd_cmpr_no is '일대사번호';

comment on column cl_cmpr_fail.seq is '순번';

comment on column cl_cmpr_fail.cmpr_dd is '대사일자';

comment on column cl_cmpr_fail.pnt_cd is '포인트코드';

comment on column cl_cmpr_fail.phub_tr_no is '포인트허브거래번호';

comment on column cl_cmpr_fail.pnt_tr_no is '포인트별거래번호';

comment on column cl_cmpr_fail.ori_pnt_tr_no is '이전거래번호';

comment on column cl_cmpr_fail.ans_pnt is '포인트';

comment on column cl_cmpr_fail.err_cd is '오류코드';

comment on column cl_cmpr_fail.err_msg is '오류메시지';

create index cl_cmpr_fail_idx_01
    on cl_cmpr_fail (cmpr_dd);

alter table cl_cmpr_fail
    add primary key (dd_cmpr_no, seq);

create table cl_cmpr_file_info
(
    dd_cmpr_no      varchar(12) not null,
    pt_hb_seqnum    integer     not null,
    pt_hb_ver       varchar(4),
    pt_hb_bne_cd    varchar(2),
    pt_hb_uqe_n     varchar(20),
    pt_hb_partner   varchar(20),
    pt_hb_ucd       varchar(10),
    pt_hb_apv_pnt   integer,
    pt_hb_ri_pnt    integer,
    pt_hb_ori_uqe_n varchar(20),
    pt_hb_ct        integer,
    rgst_dt         timestamp,
    rgst_user_id    varchar(20),
    pt_hb_ci_enc    varchar(400)
);

comment on column cl_cmpr_file_info.dd_cmpr_no is '일대사번호';

comment on column cl_cmpr_file_info.pt_hb_seqnum is '거래일련번호';

comment on column cl_cmpr_file_info.pt_hb_ver is '전문버전';

comment on column cl_cmpr_file_info.pt_hb_bne_cd is '거래구분';

comment on column cl_cmpr_file_info.pt_hb_uqe_n is '거래고유번호';

comment on column cl_cmpr_file_info.pt_hb_partner is '포인트코드';

comment on column cl_cmpr_file_info.pt_hb_ucd is '처리결과코드';

comment on column cl_cmpr_file_info.pt_hb_apv_pnt is '사용승인포인트';

comment on column cl_cmpr_file_info.pt_hb_ri_pnt is '거래처리포인트';

comment on column cl_cmpr_file_info.pt_hb_ori_uqe_n is '취소거래번호';

comment on column cl_cmpr_file_info.pt_hb_ct is '총거래건수';

comment on column cl_cmpr_file_info.rgst_dt is '등록일시';

comment on column cl_cmpr_file_info.rgst_user_id is '등록자ID';

comment on column cl_cmpr_file_info.pt_hb_ci_enc is '사용자CI암호화';

create index cl_cmpr_file_info_idx_01
    on cl_cmpr_file_info (rgst_dt);

alter table cl_cmpr_file_info
    add primary key (dd_cmpr_no, pt_hb_seqnum);

create table cl_cmpr_sucs
(
    dd_cmpr_no    varchar(12) not null,
    seq           integer     not null,
    cmpr_dd       varchar(8),
    pnt_cd        varchar(30),
    phub_tr_no    varchar(30),
    pnt_tr_no     varchar(20),
    ori_pnt_tr_no varchar(20),
    ans_pnt       integer
);

comment on column cl_cmpr_sucs.dd_cmpr_no is '일대사번호';

comment on column cl_cmpr_sucs.seq is '순번';

comment on column cl_cmpr_sucs.cmpr_dd is '대사일자';

comment on column cl_cmpr_sucs.pnt_cd is '포인트코드';

comment on column cl_cmpr_sucs.phub_tr_no is '포인트허브거래번호';

comment on column cl_cmpr_sucs.pnt_tr_no is '포인트별거래번호';

comment on column cl_cmpr_sucs.ori_pnt_tr_no is '이전거래번호';

comment on column cl_cmpr_sucs.ans_pnt is '포인트';

create index cl_cmpr_sucs_idx_01
    on cl_cmpr_sucs (cmpr_dd);

alter table cl_cmpr_sucs
    add primary key (dd_cmpr_no, seq);

create table fp_fmly_supot
(
    phub_tr_no     varchar(20)                               not null,
    own_yn         varchar(1) default 'N'::character varying not null,
    end_yn         varchar(1) default 'N'::character varying not null,
    req_stat_cd    varchar(10)                               not null,
    prgr_stat      varchar(10),
    phub_cpn_no    varchar(20),
    rgst_dt        timestamp  default now(),
    rgst_user_id   varchar(20),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(20),
    cust_type_cd   varchar(10),
    cust_ctn_enc   varchar(400)                              not null,
    cust_ctn_sch   varchar(400)[],
    cust_nm_enc    varchar(400)                              not null,
    cust_nm_sch    varchar(400)[],
    kt_cust_id_enc varchar(400)
);

comment on column fp_fmly_supot.phub_tr_no is '포인트허브거래번호';

comment on column fp_fmly_supot.own_yn is '개통자여부';

comment on column fp_fmly_supot.end_yn is '종료여부';

comment on column fp_fmly_supot.req_stat_cd is '요청상태코드';

comment on column fp_fmly_supot.prgr_stat is '진행상태';

comment on column fp_fmly_supot.phub_cpn_no is '포인트허브쿠폰번호';

comment on column fp_fmly_supot.rgst_dt is '등록일시';

comment on column fp_fmly_supot.rgst_user_id is '등록자ID';

comment on column fp_fmly_supot.mdfy_dt is '수정일시';

comment on column fp_fmly_supot.mdfy_user_id is '수정자ID';

comment on column fp_fmly_supot.cust_type_cd is '고객유형코드';

comment on column fp_fmly_supot.cust_ctn_enc is '연락처암호화';

comment on column fp_fmly_supot.cust_ctn_sch is '연락처해시';

comment on column fp_fmly_supot.cust_nm_enc is '고객명암호화';

comment on column fp_fmly_supot.cust_nm_sch is '고객명해시';

comment on column fp_fmly_supot.kt_cust_id_enc is 'KT고객ID암호화';

create index fp_fmly_supot_idx_01
    on fp_fmly_supot (rgst_dt);

alter table fp_fmly_supot
    add constraint fp_fmly_supot_pk
        primary key (phub_tr_no, cust_ctn_enc);

create table kcoin_auto_pay_chng_hist
(
    cust_id       varchar(20) not null,
    bill_user_key varchar(30) not null,
    chng_dt       varchar(14) not null,
    chng_item_cd  varchar(10),
    bill_titl     varchar(100),
    auto_pay_amt  integer,
    auto_pay_dd   integer,
    rgst_dt       timestamp,
    rgst_user_id  varchar(20)
);

comment on column kcoin_auto_pay_chng_hist.cust_id is '고객ID';

comment on column kcoin_auto_pay_chng_hist.bill_user_key is '청구사용자키';

comment on column kcoin_auto_pay_chng_hist.chng_dt is '변경일시';

comment on column kcoin_auto_pay_chng_hist.chng_item_cd is '변경항목';

comment on column kcoin_auto_pay_chng_hist.bill_titl is '청구제목';

comment on column kcoin_auto_pay_chng_hist.auto_pay_amt is '자동납부금액';

comment on column kcoin_auto_pay_chng_hist.auto_pay_dd is '자동납부일';

comment on column kcoin_auto_pay_chng_hist.rgst_dt is '등록일시';

comment on column kcoin_auto_pay_chng_hist.rgst_user_id is '등록자ID';

alter table kcoin_auto_pay_chng_hist
    add constraint kcoin_auto_pay_chng_hist_250917_pkey
        primary key (cust_id, bill_user_key, chng_dt);

create table kcoin_pay_ptcl
(
    phub_tr_no          varchar(30) not null,
    bill_user_key       varchar(30),
    bill_mm             varchar(6),
    bill_titl           varchar(100),
    bill_amt            integer,
    pay_type_cd         varchar(10),
    pay_amt             integer,
    pay_dt              varchar(14),
    rgst_dt             timestamp,
    rgst_user_id        varchar(20),
    mdfy_dt             timestamp,
    mdfy_user_id        varchar(20),
    pay_id              numeric(15),
    pay_rqt_seq         varchar(10),
    prepay_tr_id        varchar(20),
    prepay_trtm_stat_cd varchar(10)
);

comment on column kcoin_pay_ptcl.phub_tr_no is '포인트허브거래번호';

comment on column kcoin_pay_ptcl.bill_user_key is '청구사용자키';

comment on column kcoin_pay_ptcl.bill_mm is '청구년월';

comment on column kcoin_pay_ptcl.bill_titl is '청구제목';

comment on column kcoin_pay_ptcl.bill_amt is '청구금액';

comment on column kcoin_pay_ptcl.pay_type_cd is '납부유형';

comment on column kcoin_pay_ptcl.pay_amt is '납부금액';

comment on column kcoin_pay_ptcl.pay_dt is '납부일시';

comment on column kcoin_pay_ptcl.rgst_dt is '등록일시';

comment on column kcoin_pay_ptcl.rgst_user_id is '등록자ID';

comment on column kcoin_pay_ptcl.mdfy_dt is '수정일시';

comment on column kcoin_pay_ptcl.mdfy_user_id is '수정자ID';

comment on column kcoin_pay_ptcl.pay_id is '납부ID';

comment on column kcoin_pay_ptcl.pay_rqt_seq is '납부요청일련번호';

comment on column kcoin_pay_ptcl.prepay_tr_id is '미리납부트랜잭션ID';

comment on column kcoin_pay_ptcl.prepay_trtm_stat_cd is '미리납부처리상태';

alter table kcoin_pay_ptcl
    add primary key (phub_tr_no);

create table pg_cmpr_info_d
(
    dd_cmpr_no   varchar(12) not null,
    seq          integer     not null,
    phub_tr_no   varchar(20),
    cmpr_dd      varchar(8),
    pg_deal_no   varchar(40),
    pay_amt      integer,
    rmnd_amt     integer,
    ans_pnt      integer,
    deal_ind     varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    dc_amt       integer default 0
);

comment on column pg_cmpr_info_d.dd_cmpr_no is '일대사번호';

comment on column pg_cmpr_info_d.seq is '순번';

comment on column pg_cmpr_info_d.phub_tr_no is '포인트허브거래번호';

comment on column pg_cmpr_info_d.cmpr_dd is '대사일자';

comment on column pg_cmpr_info_d.pg_deal_no is 'PG사거래번호';

comment on column pg_cmpr_info_d.pay_amt is '결제금액';

comment on column pg_cmpr_info_d.rmnd_amt is '결제잔여금액';

comment on column pg_cmpr_info_d.ans_pnt is '포인트';

comment on column pg_cmpr_info_d.deal_ind is '거래구분';

comment on column pg_cmpr_info_d.rgst_dt is '등록일시';

comment on column pg_cmpr_info_d.rgst_user_id is '등록자ID';

comment on column pg_cmpr_info_d.dc_amt is '할인금액';

create index pg_cmpr_info_d_idx_01
    on pg_cmpr_info_d (cmpr_dd);

alter table pg_cmpr_info_d
    add primary key (dd_cmpr_no, seq);

create table ph_cpn_chng_hist
(
    phub_cpn_no        varchar(20)                                not null,
    hist_seq_no        integer                                    not null,
    chng_typ_cd        varchar(10),
    cpn_amt            integer,
    cpn_typ_id         varchar(20),
    phub_tr_no         varchar(20)                                not null,
    cpn_stat_cd        varchar(20)                                not null,
    cpn_isue_dt        timestamp,
    cpn_cncl_dt        timestamp,
    cpn_use_dt         timestamp,
    efct_strt_dd       varchar(8),
    efct_end_dd        varchar(8),
    prnt_phub_cpn_no   varchar(20),
    cust_id            varchar(20)                                not null,
    use_cncl_dt        timestamp,
    cpn_cncl_ind       varchar(10) default 'N'::character varying not null,
    cncl_phub_tr_no    varchar(20),
    rgst_dt            timestamp   default now(),
    rgst_user_id       varchar(20),
    mdfy_dt            timestamp,
    mdfy_user_id       varchar(20),
    cust_type_cd       varchar(10),
    cust_ctn_enc       varchar(400),
    cust_ctn_sch       varchar(400)[],
    kt_cust_id_enc     varchar(400),
    own_kt_cust_id_enc varchar(400),
    pin_no_enc         varchar(400)
);

comment on column ph_cpn_chng_hist.phub_cpn_no is '포인트허브쿠폰번호';

comment on column ph_cpn_chng_hist.hist_seq_no is '변경순번';

comment on column ph_cpn_chng_hist.chng_typ_cd is '쿠폰변경구분코드';

comment on column ph_cpn_chng_hist.cpn_amt is '쿠폰금액';

comment on column ph_cpn_chng_hist.cpn_typ_id is '쿠폰종류';

comment on column ph_cpn_chng_hist.phub_tr_no is '포인트허브거래번호';

comment on column ph_cpn_chng_hist.cpn_stat_cd is '쿠폰상태코드';

comment on column ph_cpn_chng_hist.cpn_isue_dt is '쿠폰발행일시';

comment on column ph_cpn_chng_hist.cpn_cncl_dt is '발행취소일시';

comment on column ph_cpn_chng_hist.cpn_use_dt is '쿠폰사용일시';

comment on column ph_cpn_chng_hist.efct_strt_dd is '유효시작일자';

comment on column ph_cpn_chng_hist.efct_end_dd is '유효종료일자';

comment on column ph_cpn_chng_hist.prnt_phub_cpn_no is '지원쿠폰번호';

comment on column ph_cpn_chng_hist.cust_id is '포인트허브고객ID';

comment on column ph_cpn_chng_hist.use_cncl_dt is '사용취소일시';

comment on column ph_cpn_chng_hist.cpn_cncl_ind is '쿠폰취소구분';

comment on column ph_cpn_chng_hist.cncl_phub_tr_no is '취소포인트허브거래번호';

comment on column ph_cpn_chng_hist.rgst_dt is '등록일시';

comment on column ph_cpn_chng_hist.rgst_user_id is '등록자ID';

comment on column ph_cpn_chng_hist.mdfy_dt is '수정일시';

comment on column ph_cpn_chng_hist.mdfy_user_id is '수정자ID';

comment on column ph_cpn_chng_hist.cust_type_cd is '고객유형코드';

comment on column ph_cpn_chng_hist.cust_ctn_enc is '연락처암호화';

comment on column ph_cpn_chng_hist.cust_ctn_sch is '연락처해시';

comment on column ph_cpn_chng_hist.kt_cust_id_enc is 'KT고객ID암호화';

comment on column ph_cpn_chng_hist.own_kt_cust_id_enc is '개통자KT고객ID암호화';

comment on column ph_cpn_chng_hist.pin_no_enc is '핀번호암호화';

create index ph_cpn_chng_hist_idx_01
    on ph_cpn_chng_hist (rgst_dt);

alter table ph_cpn_chng_hist
    add primary key (phub_cpn_no, hist_seq_no);

create table ph_cpn_isue_info
(
    phub_cpn_no        varchar(20)                                not null,
    cpn_amt            integer,
    cpn_typ_id         varchar(20),
    phub_tr_no         varchar(20)                                not null,
    cpn_isue_dt        timestamp,
    efct_strt_dd       varchar(8),
    kos_tr_no          varchar(20),
    efct_end_dd        varchar(8),
    cpn_stat_cd        varchar(20)                                not null,
    cpn_use_dt         timestamp,
    prnt_phub_cpn_no   varchar(20),
    cpn_cncl_dt        timestamp,
    cust_id            varchar(20)                                not null,
    use_cncl_dt        timestamp,
    cpn_cncl_ind       varchar(10) default 'N'::character varying not null,
    cncl_phub_tr_no    varchar(20),
    rgst_dt            timestamp   default now(),
    rgst_user_id       varchar(20),
    mdfy_dt            timestamp,
    mdfy_user_id       varchar(20),
    cust_type_cd       varchar(10),
    cust_ctn_enc       varchar(400)                               not null,
    cust_ctn_sch       varchar(400)[],
    kt_cust_id_enc     varchar(400)                               not null,
    own_kt_cust_id_enc varchar(400)                               not null,
    pin_no_enc         varchar(400)                               not null
);

comment on column ph_cpn_isue_info.phub_cpn_no is '포인트허브쿠폰번호';

comment on column ph_cpn_isue_info.cpn_amt is '쿠폰금액';

comment on column ph_cpn_isue_info.cpn_typ_id is '쿠폰종류';

comment on column ph_cpn_isue_info.phub_tr_no is '포인트허브거래번호';

comment on column ph_cpn_isue_info.cpn_isue_dt is '쿠폰발행일시';

comment on column ph_cpn_isue_info.efct_strt_dd is '유효시작일자';

comment on column ph_cpn_isue_info.kos_tr_no is 'KOS거래번호';

comment on column ph_cpn_isue_info.efct_end_dd is '유효종료일자';

comment on column ph_cpn_isue_info.cpn_stat_cd is '쿠폰상태코드';

comment on column ph_cpn_isue_info.cpn_use_dt is '쿠폰사용일시';

comment on column ph_cpn_isue_info.prnt_phub_cpn_no is '지원쿠폰번호';

comment on column ph_cpn_isue_info.cpn_cncl_dt is '발행취소일시';

comment on column ph_cpn_isue_info.cust_id is '포인트허브고객ID';

comment on column ph_cpn_isue_info.use_cncl_dt is '사용취소일시';

comment on column ph_cpn_isue_info.cpn_cncl_ind is '쿠폰취소구분';

comment on column ph_cpn_isue_info.cncl_phub_tr_no is '취소포인트허브거래번호';

comment on column ph_cpn_isue_info.rgst_dt is '등록일시';

comment on column ph_cpn_isue_info.rgst_user_id is '등록자ID';

comment on column ph_cpn_isue_info.mdfy_dt is '수정일시';

comment on column ph_cpn_isue_info.mdfy_user_id is '수정자ID';

comment on column ph_cpn_isue_info.cust_type_cd is '고객유형코드';

comment on column ph_cpn_isue_info.cust_ctn_enc is '연락처암호화';

comment on column ph_cpn_isue_info.cust_ctn_sch is '연락처해시';

comment on column ph_cpn_isue_info.kt_cust_id_enc is 'KT고객ID암호화';

comment on column ph_cpn_isue_info.own_kt_cust_id_enc is '개통자KT고객ID암호화';

comment on column ph_cpn_isue_info.pin_no_enc is '핀번호암호화';

alter table ph_cpn_isue_info
    add primary key (phub_cpn_no);

create table ph_deal_dtl
(
    phub_tr_no       varchar(30) not null,
    pnt_tr_no        varchar(20) not null,
    pnt_cd           varchar(30) not null,
    deal_dt          varchar(14),
    ori_pnt_tr_no    varchar(20),
    deal_ind         varchar(20),
    ans_pnt          integer,
    ans_pnt_amt      integer,
    pnt_exch_rate    numeric(5, 2),
    rgst_dt          timestamp,
    rgst_user_id     varchar(20),
    cncl_yn          varchar(2),
    naver_masking_id varchar(20),
    naver_user_key   varchar(20)
);

comment on column ph_deal_dtl.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_dtl.pnt_tr_no is '포인트별거래번호';

comment on column ph_deal_dtl.pnt_cd is '포인트코드';

comment on column ph_deal_dtl.deal_dt is '거래일시';

comment on column ph_deal_dtl.ori_pnt_tr_no is '이전거래번호';

comment on column ph_deal_dtl.deal_ind is '거래구분';

comment on column ph_deal_dtl.ans_pnt is '포인트';

comment on column ph_deal_dtl.ans_pnt_amt is '포인트전환금액';

comment on column ph_deal_dtl.pnt_exch_rate is '포인트전환율';

comment on column ph_deal_dtl.rgst_dt is '등록일시';

comment on column ph_deal_dtl.rgst_user_id is '등록자ID';

comment on column ph_deal_dtl.cncl_yn is '취소여부(Y/N)';

create index ph_deal_dtl_idx_01
    on ph_deal_dtl (deal_dt);

alter table ph_deal_dtl
    add primary key (phub_tr_no, pnt_tr_no);

create table ph_deal_info
(
    phub_tr_no     varchar(30)  not null,
    deal_dt        varchar(14),
    cprt_cmpn_id   varchar(30)  not null,
    pg_cmpn_id     varchar(40)  not null,
    pg_send_po_id  varchar(20),
    deal_ind       varchar(20),
    cust_id        varchar(20),
    cncl_yn        varchar(1)  default 'N'::character varying,
    pay_method     varchar(20),
    pg_deal_no     varchar(40),
    goods_nm       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    cncl_ind       varchar(10),
    inqr_pnt       integer,
    ttl_sale_amt   integer,
    cust_ci_enc    varchar(400) not null
);

comment on column ph_deal_info.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_info.deal_dt is '거래일시';

comment on column ph_deal_info.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_info.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_info.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_info.deal_ind is '거래구분';

comment on column ph_deal_info.cust_id is '고객ID';

comment on column ph_deal_info.cncl_yn is '취소여부';

comment on column ph_deal_info.pay_method is '단일복합결제구분';

comment on column ph_deal_info.pg_deal_no is 'PG거래번호';

comment on column ph_deal_info.goods_nm is '상품명';

comment on column ph_deal_info.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_info.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_info.ttl_pnt is '총포인트';

comment on column ph_deal_info.ttl_pay_amt is '총결제금액';

comment on column ph_deal_info.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_info.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_info.rgst_dt is '등록일시';

comment on column ph_deal_info.rgst_user_id is '등록자ID';

comment on column ph_deal_info.mdfy_dt is '수정일시';

comment on column ph_deal_info.mdfy_user_id is '수정자ID';

comment on column ph_deal_info.service_id is '서비스아이디';

comment on column ph_deal_info.cncl_ind is '취소구분';

comment on column ph_deal_info.inqr_pnt is '조회포인트';

comment on column ph_deal_info.ttl_sale_amt is '할인금액';

comment on column ph_deal_info.cust_ci_enc is '고객CI암호화';

create index ph_deal_info_250917_cust_id_idx
    on ph_deal_info (cust_id);

create index ph_deal_info_250917_pg_cmpn_id_cprt_cmpn_id_idx
    on ph_deal_info (pg_cmpn_id, cprt_cmpn_id);

create index ph_deal_info_idx_01
    on ph_deal_info (deal_dt);

alter table ph_deal_info
    add primary key (phub_tr_no);

create table ph_deal_req_dtl
(
    phub_tr_no       varchar(30)              not null,
    pnt_tr_no        varchar(20)              not null,
    pnt_cd           varchar(30)              not null,
    deal_dt          varchar(14),
    ori_pnt_tr_no    varchar(20),
    deal_ind         varchar(20),
    ans_pnt          integer,
    ans_pnt_amt      integer,
    pnt_exch_rate    numeric(5, 2),
    sucs_yn          varchar(1) default 'N'::character varying,
    err_cd           varchar(20),
    err_msg          varchar(1000),
    mdfy_user_id     varchar(20),
    rgst_dt          timestamp  default now() not null,
    rgst_user_id     varchar(20),
    mdfy_dt          timestamp  default CURRENT_TIMESTAMP,
    cncl_yn          varchar(2),
    naver_user_key   varchar(20),
    naver_masking_id varchar(20)
);

comment on column ph_deal_req_dtl.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_dtl.pnt_tr_no is '포인트별거래번호';

comment on column ph_deal_req_dtl.pnt_cd is '포인트코드';

comment on column ph_deal_req_dtl.deal_dt is '거래일시';

comment on column ph_deal_req_dtl.ori_pnt_tr_no is '이전거래번호';

comment on column ph_deal_req_dtl.deal_ind is '거래구분';

comment on column ph_deal_req_dtl.ans_pnt is '포인트';

comment on column ph_deal_req_dtl.ans_pnt_amt is '포인트전환금액';

comment on column ph_deal_req_dtl.pnt_exch_rate is '포인트전환율';

comment on column ph_deal_req_dtl.sucs_yn is '성공여부';

comment on column ph_deal_req_dtl.err_cd is '오류코드';

comment on column ph_deal_req_dtl.err_msg is '오류메시지';

comment on column ph_deal_req_dtl.cncl_yn is '취소여부(Y/N)';

create index ph_deal_req_dtl_idx_01
    on ph_deal_req_dtl (deal_dt);

alter table ph_deal_req_dtl
    add primary key (phub_tr_no, pnt_tr_no);

create table ph_mms_send_hist
(
    mms_msg_no        varchar(20)  not null,
    mms_msg_id        varchar(10)  not null,
    msg_gen_dt        timestamp,
    send_dt           timestamp,
    phub_tr_no        varchar(20),
    phub_cpn_no       varchar(20),
    rsvt_send_yn      varchar(20),
    send_req_dt       timestamp,
    send_rslt_cd      varchar(20),
    send_rslt_msg     varchar(100),
    sms_call_back     varchar(100),
    prv_use_cd_1      varchar(30),
    prv_use_cd_2      varchar(30),
    prv_use_cd_3      varchar(30),
    rgst_dt           timestamp default now(),
    rgst_user_id      varchar(20),
    mdfy_dt           timestamp,
    mdfy_user_id      varchar(20),
    send_cust_ctn_enc varchar(400) not null,
    send_cust_ctn_sch varchar(400)[],
    send_cust_nm_enc  varchar(400) not null,
    send_cust_nm_sch  varchar(400)[],
    recv_cust_ctn_enc varchar(400) not null,
    recv_cust_ctn_sch varchar(400)[],
    recv_cust_nm_enc  varchar(400) not null,
    recv_cust_nm_sch  varchar(400)[],
    msg_conts_enc     text         not null
);

comment on column ph_mms_send_hist.mms_msg_no is '메시지발송번호';

comment on column ph_mms_send_hist.mms_msg_id is '메시지ID';

comment on column ph_mms_send_hist.msg_gen_dt is '메시지생성일시';

comment on column ph_mms_send_hist.send_dt is '전송일시';

comment on column ph_mms_send_hist.phub_tr_no is '포인트허브거래번호';

comment on column ph_mms_send_hist.phub_cpn_no is '포인트허브쿠폰번호';

comment on column ph_mms_send_hist.rsvt_send_yn is '예약전송여부';

comment on column ph_mms_send_hist.send_req_dt is '전송요청일시';

comment on column ph_mms_send_hist.send_rslt_cd is '전송결과코드';

comment on column ph_mms_send_hist.send_rslt_msg is '전송결과메시지';

comment on column ph_mms_send_hist.sms_call_back is 'SMS콜백';

comment on column ph_mms_send_hist.prv_use_cd_1 is '전용코드_1';

comment on column ph_mms_send_hist.prv_use_cd_2 is '전용코드_2';

comment on column ph_mms_send_hist.prv_use_cd_3 is '전용코드_3';

comment on column ph_mms_send_hist.rgst_dt is '등록일시';

comment on column ph_mms_send_hist.rgst_user_id is '등록자ID';

comment on column ph_mms_send_hist.mdfy_dt is '수정일시';

comment on column ph_mms_send_hist.mdfy_user_id is '수정자ID';

comment on column ph_mms_send_hist.send_cust_ctn_enc is '발신번호암호화';

comment on column ph_mms_send_hist.send_cust_ctn_sch is '발신번호해시';

comment on column ph_mms_send_hist.send_cust_nm_enc is '발신자명암호화';

comment on column ph_mms_send_hist.send_cust_nm_sch is '발신자명해시';

comment on column ph_mms_send_hist.recv_cust_ctn_enc is '수신번호암호화';

comment on column ph_mms_send_hist.recv_cust_ctn_sch is '수신번호해시';

comment on column ph_mms_send_hist.recv_cust_nm_enc is '수신자명암호화';

comment on column ph_mms_send_hist.recv_cust_nm_sch is '수신자명해시';

comment on column ph_mms_send_hist.msg_conts_enc is '메시지전문암호화';

create index ph_mms_send_hist_idx_01
    on ph_mms_send_hist (rgst_dt);

alter table ph_mms_send_hist
    add primary key (mms_msg_no);

create table rwrd_goods_prepay_req_hist
(
    prepay_tr_id  varchar(20) not null,
    cust_id       varchar(20) not null,
    cprt_goods_id varchar(20) not null,
    pay_req_tms   integer,
    pay_req_mm    varchar(6),
    pay_req_pnt   integer,
    afcr_cnvy_msg varchar(100),
    cncl_yn       varchar(1) default 'N'::character varying,
    cncl_dt       varchar(14),
    rgst_dt       timestamp,
    rgst_user_id  varchar(20),
    mdfy_dt       timestamp,
    mdfy_user_id  varchar(20)
);

comment on column rwrd_goods_prepay_req_hist.prepay_tr_id is '미리납부트랜잭션ID';

comment on column rwrd_goods_prepay_req_hist.cust_id is '고객ID';

comment on column rwrd_goods_prepay_req_hist.cprt_goods_id is '제휴상품ID';

comment on column rwrd_goods_prepay_req_hist.pay_req_tms is '납부요청회차';

comment on column rwrd_goods_prepay_req_hist.pay_req_mm is '납부요청년월';

comment on column rwrd_goods_prepay_req_hist.pay_req_pnt is '납부요청포인트';

comment on column rwrd_goods_prepay_req_hist.afcr_cnvy_msg is '제휴사전달메시지';

comment on column rwrd_goods_prepay_req_hist.cncl_yn is '취소여부';

comment on column rwrd_goods_prepay_req_hist.cncl_dt is '취소일시';

comment on column rwrd_goods_prepay_req_hist.rgst_dt is '등록일시';

comment on column rwrd_goods_prepay_req_hist.rgst_user_id is '등록자ID';

comment on column rwrd_goods_prepay_req_hist.mdfy_dt is '수정일시';

comment on column rwrd_goods_prepay_req_hist.mdfy_user_id is '수정자ID';

alter table rwrd_goods_prepay_req_hist
    add primary key (prepay_tr_id);

create table adm_api_if_log
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp,
    req_data_enc text,
    res_data_enc text
);

comment on table adm_api_if_log is '연계API로그';

comment on column adm_api_if_log.log_no is '로그번호_IF';

comment on column adm_api_if_log.actn_uri is '액션URI';

comment on column adm_api_if_log.send_plc is '발신처';

comment on column adm_api_if_log.rcv_plc is '수신처';

comment on column adm_api_if_log.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log.rply_cd is '응답코드';

comment on column adm_api_if_log.rply_msg is '응답메시지';

comment on column adm_api_if_log.rgst_user_id is '등록자ID';

comment on column adm_api_if_log.rgst_dt is '등록일시';

comment on column adm_api_if_log.req_data_enc is '송신데이터암호화';

comment on column adm_api_if_log.res_data_enc is '수신데이터암호화';

create index adm_api_if_log_idx_01
    on adm_api_if_log (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pk
    on adm_api_if_log (log_no);

alter table adm_api_if_log
    add primary key (log_no);

create table adm_api_if_log_pt_2025y07m
(
)
    inherits (adm_api_if_log);

create unique index adm_api_if_log_pt_2025y07m_log_no_idx
    on adm_api_if_log_pt_2025y07m (log_no);

create index adm_api_if_log_pt_2025y07m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2025y07m (rgst_dt, phub_tr_no);

alter table adm_api_if_log_pt_2025y07m
    add primary key (log_no);

alter table adm_api_if_log_pt_2025y07m
    add constraint adm_api_if_log_pt_2025y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-08-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2025y08m
(
)
    inherits (adm_api_if_log);

create unique index adm_api_if_log_pt_2025y08m_log_no_idx
    on adm_api_if_log_pt_2025y08m (log_no);

create index adm_api_if_log_pt_2025y08m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2025y08m (rgst_dt, phub_tr_no);

alter table adm_api_if_log_pt_2025y08m
    add primary key (log_no);

alter table adm_api_if_log_pt_2025y08m
    add constraint adm_api_if_log_pt_2025y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-09-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2025y09m
(
)
    inherits (adm_api_if_log);

create unique index adm_api_if_log_pt_2025y09m_log_no_idx
    on adm_api_if_log_pt_2025y09m (log_no);

create index adm_api_if_log_pt_2025y09m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2025y09m (rgst_dt, phub_tr_no);

alter table adm_api_if_log_pt_2025y09m
    add primary key (log_no);

alter table adm_api_if_log_pt_2025y09m
    add constraint adm_api_if_log_pt_2025y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-10-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2025y10m
(
)
    inherits (adm_api_if_log);

create unique index adm_api_if_log_pt_2025y10m_log_no_idx
    on adm_api_if_log_pt_2025y10m (log_no);

create index adm_api_if_log_pt_2025y10m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2025y10m (rgst_dt, phub_tr_no);

alter table adm_api_if_log_pt_2025y10m
    add primary key (log_no);

alter table adm_api_if_log_pt_2025y10m
    add constraint adm_api_if_log_pt_2025y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-11-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2025y11m
(
)
    inherits (adm_api_if_log);

create unique index adm_api_if_log_pt_2025y11m_log_no_idx
    on adm_api_if_log_pt_2025y11m (log_no);

create index adm_api_if_log_pt_2025y11m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2025y11m (rgst_dt, phub_tr_no);

alter table adm_api_if_log_pt_2025y11m
    add primary key (log_no);

alter table adm_api_if_log_pt_2025y11m
    add constraint adm_api_if_log_pt_2025y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-12-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2025y12m
(
)
    inherits (adm_api_if_log);

create unique index adm_api_if_log_pt_2025y12m_log_no_idx
    on adm_api_if_log_pt_2025y12m (log_no);

create index adm_api_if_log_pt_2025y12m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2025y12m (rgst_dt, phub_tr_no);

alter table adm_api_if_log_pt_2025y12m
    add primary key (log_no);

alter table adm_api_if_log_pt_2025y12m
    add constraint adm_api_if_log_pt_2025y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
);

comment on table ph_cls_ag_hist is '약관동의이력';

comment on column ph_cls_ag_hist.cust_id is '고객ID';

comment on column ph_cls_ag_hist.cls_id is '약관ID';

comment on column ph_cls_ag_hist.hist_seq is '이력순번';

comment on column ph_cls_ag_hist.cls_ver is '약관버전';

comment on column ph_cls_ag_hist.agre_yn is '동의여부';

comment on column ph_cls_ag_hist.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist.rply_cd is '응답코드';

comment on column ph_cls_ag_hist.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pk
    on ph_cls_ag_hist (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist
    add primary key (cust_id, cls_id, hist_seq);

create table ph_cls_ag_hist_pt_2018y08m
(
)
    inherits (ph_cls_ag_hist);

alter table ph_cls_ag_hist_pt_2018y08m
    add constraint ph_cls_ag_hist_pt_2018y08m_ph_cls_ag_hist_pkey
        primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2018y08m
    add constraint ph_cls_ag_hist_pt_2018y08m_partition
        check ((rgst_dt IS NOT NULL) AND (rgst_dt < '2018-09-01 00:00:00'::timestamp without time zone));

create table ph_cls_ag_hist_pt_2018y09m
(
)
    inherits (ph_cls_ag_hist);

alter table ph_cls_ag_hist_pt_2018y09m
    add constraint ph_cls_ag_hist_pt_2018y09m_ph_cls_ag_hist_pkey
        primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2018y09m
    add constraint ph_cls_ag_hist_pt_2018y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2018-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2018-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2018y10m
(
)
    inherits (ph_cls_ag_hist);

alter table ph_cls_ag_hist_pt_2018y10m
    add constraint ph_cls_ag_hist_pt_2018y10m_ph_cls_ag_hist_pkey
        primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2018y10m
    add constraint ph_cls_ag_hist_pt_2018y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2018-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2018-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2018y11m
(
)
    inherits (ph_cls_ag_hist);

alter table ph_cls_ag_hist_pt_2018y11m
    add constraint ph_cls_ag_hist_pt_2018y11m_ph_cls_ag_hist_pkey
        primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2018y11m
    add constraint ph_cls_ag_hist_pt_2018y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2018-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2018-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2018y12m
(
)
    inherits (ph_cls_ag_hist);

alter table ph_cls_ag_hist_pt_2018y12m
    add constraint ph_cls_ag_hist_pt_2018y12m_ph_cls_ag_hist_pkey
        primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2018y12m
    add constraint ph_cls_ag_hist_pt_2018y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2018-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y01m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y01m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y01m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y01m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y01m
    add constraint ph_cls_ag_hist_pt_2019y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-02-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y02m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y02m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y02m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y02m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y02m
    add constraint ph_cls_ag_hist_pt_2019y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-03-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y03m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y03m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y03m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y03m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y03m
    add constraint ph_cls_ag_hist_pt_2019y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-04-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y04m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y04m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y04m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y04m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y04m
    add constraint ph_cls_ag_hist_pt_2019y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-05-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y05m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y05m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y05m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y05m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y05m
    add constraint ph_cls_ag_hist_pt_2019y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-06-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y06m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y06m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y06m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y06m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y06m
    add constraint ph_cls_ag_hist_pt_2019y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-07-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y07m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y07m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y07m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y07m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y07m
    add constraint ph_cls_ag_hist_pt_2019y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-08-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y08m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y08m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y08m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y08m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y08m
    add constraint ph_cls_ag_hist_pt_2019y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-09-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y09m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y09m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y09m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y09m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y09m
    add constraint ph_cls_ag_hist_pt_2019y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y10m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y10m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y10m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y10m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y10m
    add constraint ph_cls_ag_hist_pt_2019y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y11m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y11m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y11m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y11m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y11m
    add constraint ph_cls_ag_hist_pt_2019y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2019y12m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2019y12m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2019y12m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y12m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2019y12m
    add constraint ph_cls_ag_hist_pt_2019y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y01m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y01m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y01m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y01m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y01m
    add constraint ph_cls_ag_hist_pt_2020y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-02-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y02m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y02m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y02m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y02m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y02m
    add constraint ph_cls_ag_hist_pt_2020y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-03-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y03m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y03m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y03m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y03m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y03m
    add constraint ph_cls_ag_hist_pt_2020y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-04-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y04m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y04m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y04m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y04m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y04m
    add constraint ph_cls_ag_hist_pt_2020y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-05-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y05m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y05m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y05m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y05m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y05m
    add constraint ph_cls_ag_hist_pt_2020y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-06-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y06m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y06m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y06m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y06m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y06m
    add constraint ph_cls_ag_hist_pt_2020y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-07-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y07m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y07m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y07m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y07m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y07m
    add constraint ph_cls_ag_hist_pt_2020y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-08-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y08m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y08m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y08m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y08m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y08m
    add constraint ph_cls_ag_hist_pt_2020y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-09-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y09m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y09m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y09m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y09m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y09m
    add constraint ph_cls_ag_hist_pt_2020y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y10m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y10m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y10m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y10m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y10m
    add constraint ph_cls_ag_hist_pt_2020y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y11m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y11m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y11m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y11m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y11m
    add constraint ph_cls_ag_hist_pt_2020y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2020y12m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2020y12m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2020y12m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y12m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2020y12m
    add constraint ph_cls_ag_hist_pt_2020y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y01m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y01m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y01m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y01m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y01m
    add constraint ph_cls_ag_hist_pt_2021y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-02-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y02m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y02m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y02m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y02m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y02m
    add constraint ph_cls_ag_hist_pt_2021y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-03-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y03m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y03m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y03m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y03m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y03m
    add constraint ph_cls_ag_hist_pt_2021y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-04-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y04m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y04m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y04m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y04m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y04m
    add constraint ph_cls_ag_hist_pt_2021y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-05-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y05m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y05m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y05m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y05m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y05m
    add constraint ph_cls_ag_hist_pt_2021y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-06-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y06m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y06m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y06m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y06m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y06m
    add constraint ph_cls_ag_hist_pt_2021y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-07-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y07m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y07m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y07m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y07m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y07m
    add constraint ph_cls_ag_hist_pt_2021y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-08-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y08m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y08m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y08m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y08m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y08m
    add constraint ph_cls_ag_hist_pt_2021y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-09-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y09m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y09m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y09m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y09m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y09m
    add constraint ph_cls_ag_hist_pt_2021y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y10m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y10m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y10m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y10m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y10m
    add constraint ph_cls_ag_hist_pt_2021y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y11m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y11m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y11m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y11m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y11m
    add constraint ph_cls_ag_hist_pt_2021y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2021y12m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2021y12m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2021y12m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y12m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2021y12m
    add constraint ph_cls_ag_hist_pt_2021y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y01m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y01m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y01m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y01m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y01m
    add constraint ph_cls_ag_hist_pt_2022y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-02-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y02m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y02m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y02m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y02m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y02m
    add constraint ph_cls_ag_hist_pt_2022y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-03-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y03m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y03m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y03m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y03m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y03m
    add constraint ph_cls_ag_hist_pt_2022y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-04-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y04m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y04m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y04m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y04m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y04m
    add constraint ph_cls_ag_hist_pt_2022y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-05-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y05m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y05m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y05m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y05m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y05m
    add constraint ph_cls_ag_hist_pt_2022y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-06-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y06m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y06m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y06m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y06m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y06m
    add constraint ph_cls_ag_hist_pt_2022y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-07-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y07m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y07m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y07m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y07m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y07m
    add constraint ph_cls_ag_hist_pt_2022y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-08-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y08m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y08m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y08m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y08m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y08m
    add constraint ph_cls_ag_hist_pt_2022y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-09-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y09m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y09m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y09m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y09m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y09m
    add constraint ph_cls_ag_hist_pt_2022y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y10m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y10m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y10m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y10m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y10m
    add constraint ph_cls_ag_hist_pt_2022y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y11m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y11m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y11m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y11m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y11m
    add constraint ph_cls_ag_hist_pt_2022y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2022y12m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2022y12m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2022y12m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y12m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2022y12m
    add constraint ph_cls_ag_hist_pt_2022y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y01m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y01m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y01m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y01m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y01m
    add constraint ph_cls_ag_hist_pt_2023y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-02-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y02m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y02m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y02m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y02m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y02m
    add constraint ph_cls_ag_hist_pt_2023y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-03-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y03m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y03m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y03m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y03m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y03m
    add constraint ph_cls_ag_hist_pt_2023y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-04-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y04m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y04m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y04m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y04m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y04m
    add constraint ph_cls_ag_hist_pt_2023y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-05-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y05m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y05m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y05m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y05m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y05m
    add constraint ph_cls_ag_hist_pt_2023y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-06-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y06m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y06m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y06m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y06m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y06m
    add constraint ph_cls_ag_hist_pt_2023y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-07-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y07m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y07m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y07m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y07m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y07m
    add constraint ph_cls_ag_hist_pt_2023y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-08-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y08m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y08m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y08m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y08m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y08m
    add constraint ph_cls_ag_hist_pt_2023y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-09-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y09m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y09m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y09m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y09m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y09m
    add constraint ph_cls_ag_hist_pt_2023y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y10m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y10m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y10m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y10m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y10m
    add constraint ph_cls_ag_hist_pt_2023y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y11m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y11m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y11m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y11m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y11m
    add constraint ph_cls_ag_hist_pt_2023y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2023y12m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2023y12m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2023y12m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y12m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2023y12m
    add constraint ph_cls_ag_hist_pt_2023y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y01m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y01m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y01m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y01m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y01m
    add constraint ph_cls_ag_hist_pt_2024y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-02-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y02m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y02m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y02m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y02m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y02m
    add constraint ph_cls_ag_hist_pt_2024y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-03-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y03m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y03m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y03m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y03m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y03m
    add constraint ph_cls_ag_hist_pt_2024y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-04-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y04m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y04m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y04m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y04m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y04m
    add constraint ph_cls_ag_hist_pt_2024y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-05-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y05m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y05m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y05m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y05m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y05m
    add constraint ph_cls_ag_hist_pt_2024y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-06-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y06m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y06m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y06m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y06m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y06m
    add constraint ph_cls_ag_hist_pt_2024y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-07-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y07m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y07m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y07m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y07m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y07m
    add constraint ph_cls_ag_hist_pt_2024y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-08-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y08m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y08m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y08m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y08m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y08m
    add constraint ph_cls_ag_hist_pt_2024y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-09-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y09m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y09m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y09m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y09m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y09m
    add constraint ph_cls_ag_hist_pt_2024y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y10m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y10m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y10m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y10m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y10m
    add constraint ph_cls_ag_hist_pt_2024y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y11m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y11m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y11m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y11m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y11m
    add constraint ph_cls_ag_hist_pt_2024y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2024y12m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2024y12m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2024y12m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y12m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2024y12m
    add constraint ph_cls_ag_hist_pt_2024y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y01m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y01m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y01m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y01m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y01m
    add constraint ph_cls_ag_hist_pt_2025y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-02-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y02m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y02m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y02m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y02m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y02m
    add constraint ph_cls_ag_hist_pt_2025y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-03-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y03m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y03m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y03m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y03m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y03m
    add constraint ph_cls_ag_hist_pt_2025y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-04-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y04m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y04m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y04m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y04m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y04m
    add constraint ph_cls_ag_hist_pt_2025y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-05-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y05m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y05m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y05m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y05m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y05m
    add constraint ph_cls_ag_hist_pt_2025y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-06-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y06m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y06m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y06m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y06m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y06m
    add constraint ph_cls_ag_hist_pt_2025y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-07-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y07m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y07m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y07m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y07m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y07m
    add constraint ph_cls_ag_hist_pt_2025y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-08-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y08m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y08m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y08m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y08m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y08m
    add constraint ph_cls_ag_hist_pt_2025y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-09-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y09m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y09m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y09m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y09m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y09m
    add constraint ph_cls_ag_hist_pt_2025y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y10m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y10m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y10m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y10m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y10m
    add constraint ph_cls_ag_hist_pt_2025y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y11m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y11m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y11m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y11m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y11m
    add constraint ph_cls_ag_hist_pt_2025y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2025y12m
(
)
    inherits (ph_cls_ag_hist);

create unique index ph_cls_ag_hist_pt_2025y12m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2025y12m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y12m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2025y12m
    add constraint ph_cls_ag_hist_pt_2025y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-01-01 00:00:00'::timestamp without time zone)));

create table ph_deal_req_info
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[],
    cust_ci_enc    varchar(400)
);

comment on table ph_deal_req_info is '거래요청정보';

comment on column ph_deal_req_info.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info.deal_dt is '거래일시';

comment on column ph_deal_req_info.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info.deal_ind is '거래구분';

comment on column ph_deal_req_info.goods_nm is '상품명';

comment on column ph_deal_req_info.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info.deal_stat is '거래상태';

comment on column ph_deal_req_info.cust_id is '고객ID';

comment on column ph_deal_req_info.deal_tkn is '거래토큰';

comment on column ph_deal_req_info.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info.ttl_pnt is '총포인트';

comment on column ph_deal_req_info.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info.err_cd is '오류코드';

comment on column ph_deal_req_info.err_msg is '오류메시지';

comment on column ph_deal_req_info.rgst_dt is '등록일시';

comment on column ph_deal_req_info.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info.mdfy_dt is '수정일시';

comment on column ph_deal_req_info.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info.service_id is '서비스아이디';

comment on column ph_deal_req_info.add_param is '추가파라미터';

comment on column ph_deal_req_info.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info.ttl_sale_amt is '할인금액';

comment on column ph_deal_req_info.cust_ctn_enc is '연락처암호화';

comment on column ph_deal_req_info.cust_ctn_sch is '연락처해시';

comment on column ph_deal_req_info.cust_ci_enc is '고객CI암호화';

create index ph_deal_req_info_01
    on ph_deal_req_info (cust_id);

create unique index ph_deal_req_info_pk
    on ph_deal_req_info (phub_tr_no);

alter table ph_deal_req_info
    add primary key (phub_tr_no);

create table ph_deal_req_info_pt_2018y08m
(
)
    inherits (ph_deal_req_info);

alter table ph_deal_req_info_pt_2018y08m
    add constraint ph_deal_req_info_pt_2018y08m_ph_deal_req_info_pkey
        primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2018y08m
    add constraint ph_deal_req_info_pt_2018y08m_partition
        check ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20180901000000'::character varying(14))::text));

create table ph_deal_req_info_pt_2018y09m
(
)
    inherits (ph_deal_req_info);

alter table ph_deal_req_info_pt_2018y09m
    add constraint ph_deal_req_info_pt_2018y09m_ph_deal_req_info_pkey
        primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2018y09m
    add constraint ph_deal_req_info_pt_2018y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20180901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20181001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2018y10m
(
)
    inherits (ph_deal_req_info);

alter table ph_deal_req_info_pt_2018y10m
    add constraint ph_deal_req_info_pt_2018y10m_ph_deal_req_info_pkey
        primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2018y10m
    add constraint ph_deal_req_info_pt_2018y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20181001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20181101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2018y11m
(
)
    inherits (ph_deal_req_info);

alter table ph_deal_req_info_pt_2018y11m
    add constraint ph_deal_req_info_pt_2018y11m_ph_deal_req_info_pkey
        primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2018y11m
    add constraint ph_deal_req_info_pt_2018y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20181101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20181201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2018y12m
(
)
    inherits (ph_deal_req_info);

alter table ph_deal_req_info_pt_2018y12m
    add constraint ph_deal_req_info_pt_2018y12m_ph_deal_req_info_pkey
        primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2018y12m
    add constraint ph_deal_req_info_pt_2018y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20181201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y01m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y01m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y01m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y01m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y01m
    add constraint ph_deal_req_info_pt_2019y01m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y02m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y02m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y02m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y02m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y02m
    add constraint ph_deal_req_info_pt_2019y02m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190301000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y03m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y03m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y03m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y03m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y03m
    add constraint ph_deal_req_info_pt_2019y03m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190301000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190401000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y04m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y04m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y04m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y04m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y04m
    add constraint ph_deal_req_info_pt_2019y04m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190401000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190501000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y05m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y05m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y05m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y05m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y05m
    add constraint ph_deal_req_info_pt_2019y05m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190501000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190601000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y06m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y06m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y06m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y06m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y06m
    add constraint ph_deal_req_info_pt_2019y06m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190601000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190701000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y07m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y07m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y07m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y07m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y07m
    add constraint ph_deal_req_info_pt_2019y07m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190701000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190801000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y08m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y08m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y08m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y08m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y08m
    add constraint ph_deal_req_info_pt_2019y08m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190801000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20190901000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y09m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y09m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y09m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y09m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y09m
    add constraint ph_deal_req_info_pt_2019y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20190901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20191001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y10m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y10m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y10m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y10m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y10m
    add constraint ph_deal_req_info_pt_2019y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20191001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20191101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y11m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y11m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y11m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y11m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y11m
    add constraint ph_deal_req_info_pt_2019y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20191101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20191201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2019y12m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2019y12m_phub_tr_no_idx
    on ph_deal_req_info_pt_2019y12m (phub_tr_no);

alter table ph_deal_req_info_pt_2019y12m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2019y12m
    add constraint ph_deal_req_info_pt_2019y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20191201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y01m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y01m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y01m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y01m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y01m
    add constraint ph_deal_req_info_pt_2020y01m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y02m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y02m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y02m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y02m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y02m
    add constraint ph_deal_req_info_pt_2020y02m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200301000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y03m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y03m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y03m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y03m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y03m
    add constraint ph_deal_req_info_pt_2020y03m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200301000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200401000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y04m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y04m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y04m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y04m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y04m
    add constraint ph_deal_req_info_pt_2020y04m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200401000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200501000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y05m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y05m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y05m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y05m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y05m
    add constraint ph_deal_req_info_pt_2020y05m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200501000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200601000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y06m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y06m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y06m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y06m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y06m
    add constraint ph_deal_req_info_pt_2020y06m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200601000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200701000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y07m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y07m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y07m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y07m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y07m
    add constraint ph_deal_req_info_pt_2020y07m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200701000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200801000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y08m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y08m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y08m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y08m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y08m
    add constraint ph_deal_req_info_pt_2020y08m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200801000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20200901000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y09m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y09m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y09m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y09m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y09m
    add constraint ph_deal_req_info_pt_2020y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20200901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20201001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y10m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y10m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y10m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y10m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y10m
    add constraint ph_deal_req_info_pt_2020y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20201001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20201101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y11m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y11m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y11m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y11m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y11m
    add constraint ph_deal_req_info_pt_2020y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20201101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20201201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2020y12m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2020y12m_phub_tr_no_idx
    on ph_deal_req_info_pt_2020y12m (phub_tr_no);

alter table ph_deal_req_info_pt_2020y12m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2020y12m
    add constraint ph_deal_req_info_pt_2020y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20201201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y01m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y01m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y01m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y01m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y01m
    add constraint ph_deal_req_info_pt_2021y01m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y02m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y02m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y02m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y02m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y02m
    add constraint ph_deal_req_info_pt_2021y02m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210301000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y03m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y03m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y03m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y03m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y03m
    add constraint ph_deal_req_info_pt_2021y03m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210301000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210401000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y04m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y04m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y04m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y04m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y04m
    add constraint ph_deal_req_info_pt_2021y04m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210401000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210501000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y05m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y05m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y05m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y05m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y05m
    add constraint ph_deal_req_info_pt_2021y05m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210501000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210601000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y06m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y06m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y06m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y06m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y06m
    add constraint ph_deal_req_info_pt_2021y06m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210601000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210701000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y07m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y07m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y07m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y07m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y07m
    add constraint ph_deal_req_info_pt_2021y07m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210701000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210801000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y08m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y08m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y08m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y08m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y08m
    add constraint ph_deal_req_info_pt_2021y08m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210801000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20210901000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y09m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y09m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y09m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y09m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y09m
    add constraint ph_deal_req_info_pt_2021y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20210901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20211001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y10m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y10m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y10m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y10m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y10m
    add constraint ph_deal_req_info_pt_2021y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20211001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20211101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y11m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y11m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y11m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y11m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y11m
    add constraint ph_deal_req_info_pt_2021y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20211101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20211201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2021y12m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2021y12m_phub_tr_no_idx
    on ph_deal_req_info_pt_2021y12m (phub_tr_no);

alter table ph_deal_req_info_pt_2021y12m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2021y12m
    add constraint ph_deal_req_info_pt_2021y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20211201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y01m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y01m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y01m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y01m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y01m
    add constraint ph_deal_req_info_pt_2022y01m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y02m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y02m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y02m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y02m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y02m
    add constraint ph_deal_req_info_pt_2022y02m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220301000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y03m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y03m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y03m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y03m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y03m
    add constraint ph_deal_req_info_pt_2022y03m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220301000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220401000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y04m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y04m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y04m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y04m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y04m
    add constraint ph_deal_req_info_pt_2022y04m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220401000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220501000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y05m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y05m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y05m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y05m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y05m
    add constraint ph_deal_req_info_pt_2022y05m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220501000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220601000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y06m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y06m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y06m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y06m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y06m
    add constraint ph_deal_req_info_pt_2022y06m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220601000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220701000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y07m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y07m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y07m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y07m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y07m
    add constraint ph_deal_req_info_pt_2022y07m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220701000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220801000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y08m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y08m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y08m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y08m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y08m
    add constraint ph_deal_req_info_pt_2022y08m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220801000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20220901000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y09m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y09m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y09m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y09m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y09m
    add constraint ph_deal_req_info_pt_2022y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20220901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20221001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y10m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y10m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y10m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y10m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y10m
    add constraint ph_deal_req_info_pt_2022y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20221001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20221101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y11m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y11m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y11m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y11m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y11m
    add constraint ph_deal_req_info_pt_2022y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20221101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20221201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2022y12m
(
)
    inherits (ph_deal_req_info);

create unique index ph_deal_req_info_pt_2022y12m_phub_tr_no_idx
    on ph_deal_req_info_pt_2022y12m (phub_tr_no);

alter table ph_deal_req_info_pt_2022y12m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2022y12m
    add constraint ph_deal_req_info_pt_2022y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20221201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y01m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y01m_cust_id_idx
    on ph_deal_req_info_pt_2023y01m (cust_id);

create unique index ph_deal_req_info_pt_2023y01m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y01m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y01m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y01m
    add constraint ph_deal_req_info_pt_2023y01m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y02m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y02m_cust_id_idx
    on ph_deal_req_info_pt_2023y02m (cust_id);

create unique index ph_deal_req_info_pt_2023y02m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y02m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y02m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y02m
    add constraint ph_deal_req_info_pt_2023y02m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230301000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y03m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y03m_cust_id_idx
    on ph_deal_req_info_pt_2023y03m (cust_id);

create unique index ph_deal_req_info_pt_2023y03m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y03m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y03m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y03m
    add constraint ph_deal_req_info_pt_2023y03m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230301000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230401000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y04m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y04m_cust_id_idx
    on ph_deal_req_info_pt_2023y04m (cust_id);

create unique index ph_deal_req_info_pt_2023y04m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y04m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y04m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y04m
    add constraint ph_deal_req_info_pt_2023y04m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230401000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230501000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y05m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y05m_cust_id_idx
    on ph_deal_req_info_pt_2023y05m (cust_id);

create unique index ph_deal_req_info_pt_2023y05m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y05m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y05m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y05m
    add constraint ph_deal_req_info_pt_2023y05m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230501000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230601000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y06m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y06m_cust_id_idx
    on ph_deal_req_info_pt_2023y06m (cust_id);

create unique index ph_deal_req_info_pt_2023y06m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y06m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y06m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y06m
    add constraint ph_deal_req_info_pt_2023y06m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230601000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230701000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y07m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y07m_cust_id_idx
    on ph_deal_req_info_pt_2023y07m (cust_id);

create unique index ph_deal_req_info_pt_2023y07m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y07m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y07m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y07m
    add constraint ph_deal_req_info_pt_2023y07m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230701000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230801000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y08m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y08m_cust_id_idx
    on ph_deal_req_info_pt_2023y08m (cust_id);

create unique index ph_deal_req_info_pt_2023y08m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y08m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y08m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y08m
    add constraint ph_deal_req_info_pt_2023y08m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230801000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20230901000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y09m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y09m_cust_id_idx
    on ph_deal_req_info_pt_2023y09m (cust_id);

create unique index ph_deal_req_info_pt_2023y09m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y09m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y09m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y09m
    add constraint ph_deal_req_info_pt_2023y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20230901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20231001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y10m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y10m_cust_id_idx
    on ph_deal_req_info_pt_2023y10m (cust_id);

create unique index ph_deal_req_info_pt_2023y10m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y10m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y10m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y10m
    add constraint ph_deal_req_info_pt_2023y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20231001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20231101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y11m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y11m_cust_id_idx
    on ph_deal_req_info_pt_2023y11m (cust_id);

create unique index ph_deal_req_info_pt_2023y11m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y11m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y11m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y11m
    add constraint ph_deal_req_info_pt_2023y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20231101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20231201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2023y12m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2023y12m_cust_id_idx
    on ph_deal_req_info_pt_2023y12m (cust_id);

create unique index ph_deal_req_info_pt_2023y12m_phub_tr_no_idx
    on ph_deal_req_info_pt_2023y12m (phub_tr_no);

alter table ph_deal_req_info_pt_2023y12m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2023y12m
    add constraint ph_deal_req_info_pt_2023y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20231201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y01m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y01m_cust_id_idx
    on ph_deal_req_info_pt_2024y01m (cust_id);

create unique index ph_deal_req_info_pt_2024y01m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y01m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y01m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y01m
    add constraint ph_deal_req_info_pt_2024y01m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y02m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y02m_cust_id_idx
    on ph_deal_req_info_pt_2024y02m (cust_id);

create unique index ph_deal_req_info_pt_2024y02m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y02m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y02m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y02m
    add constraint ph_deal_req_info_pt_2024y02m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240301000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y03m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y03m_cust_id_idx
    on ph_deal_req_info_pt_2024y03m (cust_id);

create unique index ph_deal_req_info_pt_2024y03m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y03m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y03m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y03m
    add constraint ph_deal_req_info_pt_2024y03m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240301000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240401000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y04m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y04m_cust_id_idx
    on ph_deal_req_info_pt_2024y04m (cust_id);

create unique index ph_deal_req_info_pt_2024y04m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y04m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y04m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y04m
    add constraint ph_deal_req_info_pt_2024y04m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240401000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240501000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y05m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y05m_cust_id_idx
    on ph_deal_req_info_pt_2024y05m (cust_id);

create unique index ph_deal_req_info_pt_2024y05m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y05m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y05m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y05m
    add constraint ph_deal_req_info_pt_2024y05m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240501000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240601000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y06m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y06m_cust_id_idx
    on ph_deal_req_info_pt_2024y06m (cust_id);

create unique index ph_deal_req_info_pt_2024y06m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y06m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y06m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y06m
    add constraint ph_deal_req_info_pt_2024y06m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240601000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240701000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y07m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y07m_cust_id_idx
    on ph_deal_req_info_pt_2024y07m (cust_id);

create unique index ph_deal_req_info_pt_2024y07m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y07m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y07m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y07m
    add constraint ph_deal_req_info_pt_2024y07m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240701000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240801000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y08m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y08m_cust_id_idx
    on ph_deal_req_info_pt_2024y08m (cust_id);

create unique index ph_deal_req_info_pt_2024y08m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y08m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y08m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y08m
    add constraint ph_deal_req_info_pt_2024y08m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240801000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20240901000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y09m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y09m_cust_id_idx
    on ph_deal_req_info_pt_2024y09m (cust_id);

create unique index ph_deal_req_info_pt_2024y09m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y09m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y09m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y09m
    add constraint ph_deal_req_info_pt_2024y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20240901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20241001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y10m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y10m_cust_id_idx
    on ph_deal_req_info_pt_2024y10m (cust_id);

create unique index ph_deal_req_info_pt_2024y10m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y10m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y10m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y10m
    add constraint ph_deal_req_info_pt_2024y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20241001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20241101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y11m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y11m_cust_id_idx
    on ph_deal_req_info_pt_2024y11m (cust_id);

create unique index ph_deal_req_info_pt_2024y11m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y11m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y11m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y11m
    add constraint ph_deal_req_info_pt_2024y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20241101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20241201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2024y12m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2024y12m_cust_id_idx
    on ph_deal_req_info_pt_2024y12m (cust_id);

create unique index ph_deal_req_info_pt_2024y12m_phub_tr_no_idx
    on ph_deal_req_info_pt_2024y12m (phub_tr_no);

alter table ph_deal_req_info_pt_2024y12m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2024y12m
    add constraint ph_deal_req_info_pt_2024y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20241201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y01m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y01m_cust_id_idx
    on ph_deal_req_info_pt_2025y01m (cust_id);

create unique index ph_deal_req_info_pt_2025y01m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y01m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y01m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y01m
    add constraint ph_deal_req_info_pt_2025y01m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y02m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y02m_cust_id_idx
    on ph_deal_req_info_pt_2025y02m (cust_id);

create unique index ph_deal_req_info_pt_2025y02m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y02m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y02m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y02m
    add constraint ph_deal_req_info_pt_2025y02m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250301000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y03m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y03m_cust_id_idx
    on ph_deal_req_info_pt_2025y03m (cust_id);

create unique index ph_deal_req_info_pt_2025y03m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y03m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y03m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y03m
    add constraint ph_deal_req_info_pt_2025y03m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250301000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250401000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y04m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y04m_cust_id_idx
    on ph_deal_req_info_pt_2025y04m (cust_id);

create unique index ph_deal_req_info_pt_2025y04m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y04m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y04m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y04m
    add constraint ph_deal_req_info_pt_2025y04m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250401000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250501000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y05m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y05m_cust_id_idx
    on ph_deal_req_info_pt_2025y05m (cust_id);

create unique index ph_deal_req_info_pt_2025y05m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y05m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y05m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y05m
    add constraint ph_deal_req_info_pt_2025y05m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250501000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250601000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y06m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y06m_cust_id_idx
    on ph_deal_req_info_pt_2025y06m (cust_id);

create unique index ph_deal_req_info_pt_2025y06m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y06m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y06m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y06m
    add constraint ph_deal_req_info_pt_2025y06m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250601000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250701000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y07m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y07m_cust_id_idx
    on ph_deal_req_info_pt_2025y07m (cust_id);

create unique index ph_deal_req_info_pt_2025y07m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y07m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y07m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y07m
    add constraint ph_deal_req_info_pt_2025y07m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250701000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250801000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y08m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y08m_cust_id_idx
    on ph_deal_req_info_pt_2025y08m (cust_id);

create unique index ph_deal_req_info_pt_2025y08m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y08m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y08m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y08m
    add constraint ph_deal_req_info_pt_2025y08m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250801000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20250901000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y09m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y09m_cust_id_idx
    on ph_deal_req_info_pt_2025y09m (cust_id);

create unique index ph_deal_req_info_pt_2025y09m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y09m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y09m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y09m
    add constraint ph_deal_req_info_pt_2025y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20250901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20251001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y10m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y10m_cust_id_idx
    on ph_deal_req_info_pt_2025y10m (cust_id);

create unique index ph_deal_req_info_pt_2025y10m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y10m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y10m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y10m
    add constraint ph_deal_req_info_pt_2025y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20251001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20251101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y11m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y11m_cust_id_idx
    on ph_deal_req_info_pt_2025y11m (cust_id);

create unique index ph_deal_req_info_pt_2025y11m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y11m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y11m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y11m
    add constraint ph_deal_req_info_pt_2025y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20251101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20251201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2025y12m
(
)
    inherits (ph_deal_req_info);

create index ph_deal_req_info_pt_2025y12m_cust_id_idx
    on ph_deal_req_info_pt_2025y12m (cust_id);

create unique index ph_deal_req_info_pt_2025y12m_phub_tr_no_idx
    on ph_deal_req_info_pt_2025y12m (phub_tr_no);

alter table ph_deal_req_info_pt_2025y12m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2025y12m
    add constraint ph_deal_req_info_pt_2025y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20251201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260101000000'::character varying(14))::text)));

create table ph_info_prvd_ag_hist
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
);

comment on table ph_info_prvd_ag_hist is '정보제공동의이력';

comment on column ph_info_prvd_ag_hist.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_01fk
    on ph_info_prvd_ag_hist (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pk
    on ph_info_prvd_ag_hist (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

create table ph_info_prvd_ag_hist_pt_2018y08m
(
)
    inherits (ph_info_prvd_ag_hist);

alter table ph_info_prvd_ag_hist_pt_2018y08m
    add constraint ph_info_prvd_ag_hist_pt_2018y08m_ph_info_prvd_ag_hist_pkey
        primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2018y08m
    add constraint ph_info_prvd_ag_hist_pt_2018y08m_partition
        check ((rgst_dt IS NOT NULL) AND (rgst_dt < '2018-09-01 00:00:00'::timestamp without time zone));

create table ph_info_prvd_ag_hist_pt_2018y09m
(
)
    inherits (ph_info_prvd_ag_hist);

alter table ph_info_prvd_ag_hist_pt_2018y09m
    add constraint ph_info_prvd_ag_hist_pt_2018y09m_ph_info_prvd_ag_hist_pkey
        primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2018y09m
    add constraint ph_info_prvd_ag_hist_pt_2018y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2018-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2018-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2018y10m
(
)
    inherits (ph_info_prvd_ag_hist);

alter table ph_info_prvd_ag_hist_pt_2018y10m
    add constraint ph_info_prvd_ag_hist_pt_2018y10m_ph_info_prvd_ag_hist_pkey
        primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2018y10m
    add constraint ph_info_prvd_ag_hist_pt_2018y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2018-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2018-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2018y11m
(
)
    inherits (ph_info_prvd_ag_hist);

alter table ph_info_prvd_ag_hist_pt_2018y11m
    add constraint ph_info_prvd_ag_hist_pt_2018y11m_ph_info_prvd_ag_hist_pkey
        primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2018y11m
    add constraint ph_info_prvd_ag_hist_pt_2018y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2018-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2018-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2018y12m
(
)
    inherits (ph_info_prvd_ag_hist);

alter table ph_info_prvd_ag_hist_pt_2018y12m
    add constraint ph_info_prvd_ag_hist_pt_2018y12m_ph_info_prvd_ag_hist_pkey
        primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2018y12m
    add constraint ph_info_prvd_ag_hist_pt_2018y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2018-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-01-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y01m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y01m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y01m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist__idx
    on ph_info_prvd_ag_hist_pt_2019y01m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y01m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y01m
    add constraint ph_info_prvd_ag_hist_pt_2019y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-02-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y02m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y02m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y02m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx1
    on ph_info_prvd_ag_hist_pt_2019y02m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y02m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y02m
    add constraint ph_info_prvd_ag_hist_pt_2019y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-03-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y03m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y03m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y03m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx2
    on ph_info_prvd_ag_hist_pt_2019y03m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y03m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y03m
    add constraint ph_info_prvd_ag_hist_pt_2019y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-04-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y04m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y04m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y04m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx3
    on ph_info_prvd_ag_hist_pt_2019y04m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y04m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y04m
    add constraint ph_info_prvd_ag_hist_pt_2019y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-05-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y05m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y05m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y05m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx4
    on ph_info_prvd_ag_hist_pt_2019y05m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y05m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y05m
    add constraint ph_info_prvd_ag_hist_pt_2019y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-06-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y06m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y06m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y06m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx5
    on ph_info_prvd_ag_hist_pt_2019y06m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y06m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y06m
    add constraint ph_info_prvd_ag_hist_pt_2019y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-07-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y07m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y07m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y07m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx6
    on ph_info_prvd_ag_hist_pt_2019y07m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y07m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y07m
    add constraint ph_info_prvd_ag_hist_pt_2019y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-08-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y08m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y08m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y08m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx7
    on ph_info_prvd_ag_hist_pt_2019y08m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y08m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y08m
    add constraint ph_info_prvd_ag_hist_pt_2019y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-09-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y09m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y09m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y09m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx8
    on ph_info_prvd_ag_hist_pt_2019y09m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y09m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y09m
    add constraint ph_info_prvd_ag_hist_pt_2019y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y10m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2019y10m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y10m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2019y_cls_id_prvdr_id_cust_id_hist_idx9
    on ph_info_prvd_ag_hist_pt_2019y10m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y10m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y10m
    add constraint ph_info_prvd_ag_hist_pt_2019y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y11m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2019_cls_id_prvdr_id_cust_id_hist_idx10
    on ph_info_prvd_ag_hist_pt_2019y11m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2019y11m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y11m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y11m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y11m
    add constraint ph_info_prvd_ag_hist_pt_2019y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2019-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2019y12m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2019_cls_id_prvdr_id_cust_id_hist_idx11
    on ph_info_prvd_ag_hist_pt_2019y12m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2019y12m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2019y12m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y12m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2019y12m
    add constraint ph_info_prvd_ag_hist_pt_2019y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2019-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-01-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y01m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y01m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y01m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist__idx
    on ph_info_prvd_ag_hist_pt_2020y01m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y01m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y01m
    add constraint ph_info_prvd_ag_hist_pt_2020y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-02-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y02m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y02m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y02m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx1
    on ph_info_prvd_ag_hist_pt_2020y02m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y02m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y02m
    add constraint ph_info_prvd_ag_hist_pt_2020y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-03-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y03m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y03m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y03m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx2
    on ph_info_prvd_ag_hist_pt_2020y03m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y03m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y03m
    add constraint ph_info_prvd_ag_hist_pt_2020y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-04-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y04m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y04m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y04m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx3
    on ph_info_prvd_ag_hist_pt_2020y04m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y04m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y04m
    add constraint ph_info_prvd_ag_hist_pt_2020y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-05-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y05m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y05m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y05m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx4
    on ph_info_prvd_ag_hist_pt_2020y05m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y05m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y05m
    add constraint ph_info_prvd_ag_hist_pt_2020y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-06-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y06m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y06m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y06m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx5
    on ph_info_prvd_ag_hist_pt_2020y06m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y06m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y06m
    add constraint ph_info_prvd_ag_hist_pt_2020y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-07-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y07m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y07m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y07m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx6
    on ph_info_prvd_ag_hist_pt_2020y07m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y07m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y07m
    add constraint ph_info_prvd_ag_hist_pt_2020y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-08-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y08m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y08m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y08m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx7
    on ph_info_prvd_ag_hist_pt_2020y08m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y08m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y08m
    add constraint ph_info_prvd_ag_hist_pt_2020y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-09-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y09m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y09m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y09m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx8
    on ph_info_prvd_ag_hist_pt_2020y09m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y09m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y09m
    add constraint ph_info_prvd_ag_hist_pt_2020y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y10m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2020y10m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y10m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2020y_cls_id_prvdr_id_cust_id_hist_idx9
    on ph_info_prvd_ag_hist_pt_2020y10m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y10m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y10m
    add constraint ph_info_prvd_ag_hist_pt_2020y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y11m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2020_cls_id_prvdr_id_cust_id_hist_idx10
    on ph_info_prvd_ag_hist_pt_2020y11m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2020y11m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y11m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y11m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y11m
    add constraint ph_info_prvd_ag_hist_pt_2020y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2020-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2020y12m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2020_cls_id_prvdr_id_cust_id_hist_idx11
    on ph_info_prvd_ag_hist_pt_2020y12m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2020y12m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2020y12m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y12m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2020y12m
    add constraint ph_info_prvd_ag_hist_pt_2020y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2020-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-01-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y01m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y01m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y01m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist__idx
    on ph_info_prvd_ag_hist_pt_2021y01m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y01m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y01m
    add constraint ph_info_prvd_ag_hist_pt_2021y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-02-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y02m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y02m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y02m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx1
    on ph_info_prvd_ag_hist_pt_2021y02m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y02m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y02m
    add constraint ph_info_prvd_ag_hist_pt_2021y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-03-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y03m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y03m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y03m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx2
    on ph_info_prvd_ag_hist_pt_2021y03m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y03m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y03m
    add constraint ph_info_prvd_ag_hist_pt_2021y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-04-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y04m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y04m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y04m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx3
    on ph_info_prvd_ag_hist_pt_2021y04m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y04m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y04m
    add constraint ph_info_prvd_ag_hist_pt_2021y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-05-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y05m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y05m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y05m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx4
    on ph_info_prvd_ag_hist_pt_2021y05m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y05m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y05m
    add constraint ph_info_prvd_ag_hist_pt_2021y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-06-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y06m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y06m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y06m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx5
    on ph_info_prvd_ag_hist_pt_2021y06m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y06m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y06m
    add constraint ph_info_prvd_ag_hist_pt_2021y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-07-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y07m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y07m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y07m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx6
    on ph_info_prvd_ag_hist_pt_2021y07m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y07m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y07m
    add constraint ph_info_prvd_ag_hist_pt_2021y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-08-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y08m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y08m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y08m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx7
    on ph_info_prvd_ag_hist_pt_2021y08m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y08m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y08m
    add constraint ph_info_prvd_ag_hist_pt_2021y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-09-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y09m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y09m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y09m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx8
    on ph_info_prvd_ag_hist_pt_2021y09m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y09m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y09m
    add constraint ph_info_prvd_ag_hist_pt_2021y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y10m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2021y10m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y10m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2021y_cls_id_prvdr_id_cust_id_hist_idx9
    on ph_info_prvd_ag_hist_pt_2021y10m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y10m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y10m
    add constraint ph_info_prvd_ag_hist_pt_2021y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y11m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2021_cls_id_prvdr_id_cust_id_hist_idx10
    on ph_info_prvd_ag_hist_pt_2021y11m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2021y11m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y11m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y11m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y11m
    add constraint ph_info_prvd_ag_hist_pt_2021y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2021-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2021y12m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2021_cls_id_prvdr_id_cust_id_hist_idx11
    on ph_info_prvd_ag_hist_pt_2021y12m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2021y12m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2021y12m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y12m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2021y12m
    add constraint ph_info_prvd_ag_hist_pt_2021y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2021-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-01-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y01m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y01m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y01m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist__idx
    on ph_info_prvd_ag_hist_pt_2022y01m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y01m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y01m
    add constraint ph_info_prvd_ag_hist_pt_2022y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-02-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y02m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y02m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y02m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx1
    on ph_info_prvd_ag_hist_pt_2022y02m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y02m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y02m
    add constraint ph_info_prvd_ag_hist_pt_2022y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-03-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y03m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y03m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y03m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx2
    on ph_info_prvd_ag_hist_pt_2022y03m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y03m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y03m
    add constraint ph_info_prvd_ag_hist_pt_2022y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-04-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y04m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y04m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y04m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx3
    on ph_info_prvd_ag_hist_pt_2022y04m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y04m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y04m
    add constraint ph_info_prvd_ag_hist_pt_2022y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-05-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y05m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y05m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y05m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx4
    on ph_info_prvd_ag_hist_pt_2022y05m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y05m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y05m
    add constraint ph_info_prvd_ag_hist_pt_2022y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-06-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y06m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y06m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y06m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx5
    on ph_info_prvd_ag_hist_pt_2022y06m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y06m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y06m
    add constraint ph_info_prvd_ag_hist_pt_2022y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-07-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y07m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y07m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y07m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx6
    on ph_info_prvd_ag_hist_pt_2022y07m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y07m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y07m
    add constraint ph_info_prvd_ag_hist_pt_2022y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-08-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y08m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y08m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y08m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx7
    on ph_info_prvd_ag_hist_pt_2022y08m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y08m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y08m
    add constraint ph_info_prvd_ag_hist_pt_2022y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-09-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y09m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y09m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y09m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx8
    on ph_info_prvd_ag_hist_pt_2022y09m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y09m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y09m
    add constraint ph_info_prvd_ag_hist_pt_2022y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y10m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2022y10m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y10m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2022y_cls_id_prvdr_id_cust_id_hist_idx9
    on ph_info_prvd_ag_hist_pt_2022y10m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y10m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y10m
    add constraint ph_info_prvd_ag_hist_pt_2022y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y11m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2022_cls_id_prvdr_id_cust_id_hist_idx10
    on ph_info_prvd_ag_hist_pt_2022y11m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2022y11m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y11m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y11m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y11m
    add constraint ph_info_prvd_ag_hist_pt_2022y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2022-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2022y12m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2022_cls_id_prvdr_id_cust_id_hist_idx11
    on ph_info_prvd_ag_hist_pt_2022y12m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2022y12m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2022y12m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y12m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2022y12m
    add constraint ph_info_prvd_ag_hist_pt_2022y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2022-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-01-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y01m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y01m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y01m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist__idx
    on ph_info_prvd_ag_hist_pt_2023y01m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y01m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y01m
    add constraint ph_info_prvd_ag_hist_pt_2023y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-02-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y02m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y02m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y02m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx1
    on ph_info_prvd_ag_hist_pt_2023y02m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y02m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y02m
    add constraint ph_info_prvd_ag_hist_pt_2023y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-03-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y03m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y03m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y03m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx2
    on ph_info_prvd_ag_hist_pt_2023y03m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y03m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y03m
    add constraint ph_info_prvd_ag_hist_pt_2023y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-04-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y04m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y04m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y04m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx3
    on ph_info_prvd_ag_hist_pt_2023y04m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y04m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y04m
    add constraint ph_info_prvd_ag_hist_pt_2023y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-05-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y05m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y05m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y05m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx4
    on ph_info_prvd_ag_hist_pt_2023y05m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y05m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y05m
    add constraint ph_info_prvd_ag_hist_pt_2023y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-06-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y06m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y06m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y06m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx5
    on ph_info_prvd_ag_hist_pt_2023y06m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y06m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y06m
    add constraint ph_info_prvd_ag_hist_pt_2023y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-07-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y07m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y07m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y07m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx6
    on ph_info_prvd_ag_hist_pt_2023y07m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y07m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y07m
    add constraint ph_info_prvd_ag_hist_pt_2023y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-08-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y08m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y08m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y08m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx7
    on ph_info_prvd_ag_hist_pt_2023y08m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y08m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y08m
    add constraint ph_info_prvd_ag_hist_pt_2023y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-09-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y09m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y09m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y09m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx8
    on ph_info_prvd_ag_hist_pt_2023y09m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y09m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y09m
    add constraint ph_info_prvd_ag_hist_pt_2023y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y10m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2023y10m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y10m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2023y_cls_id_prvdr_id_cust_id_hist_idx9
    on ph_info_prvd_ag_hist_pt_2023y10m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y10m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y10m
    add constraint ph_info_prvd_ag_hist_pt_2023y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y11m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2023_cls_id_prvdr_id_cust_id_hist_idx10
    on ph_info_prvd_ag_hist_pt_2023y11m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2023y11m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y11m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y11m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y11m
    add constraint ph_info_prvd_ag_hist_pt_2023y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2023-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2023y12m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2023_cls_id_prvdr_id_cust_id_hist_idx11
    on ph_info_prvd_ag_hist_pt_2023y12m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2023y12m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2023y12m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y12m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2023y12m
    add constraint ph_info_prvd_ag_hist_pt_2023y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2023-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-01-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y01m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y01m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y01m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist__idx
    on ph_info_prvd_ag_hist_pt_2024y01m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y01m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y01m
    add constraint ph_info_prvd_ag_hist_pt_2024y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-02-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y02m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y02m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y02m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx1
    on ph_info_prvd_ag_hist_pt_2024y02m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y02m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y02m
    add constraint ph_info_prvd_ag_hist_pt_2024y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-03-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y03m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y03m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y03m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx2
    on ph_info_prvd_ag_hist_pt_2024y03m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y03m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y03m
    add constraint ph_info_prvd_ag_hist_pt_2024y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-04-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y04m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y04m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y04m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx3
    on ph_info_prvd_ag_hist_pt_2024y04m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y04m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y04m
    add constraint ph_info_prvd_ag_hist_pt_2024y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-05-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y05m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y05m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y05m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx4
    on ph_info_prvd_ag_hist_pt_2024y05m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y05m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y05m
    add constraint ph_info_prvd_ag_hist_pt_2024y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-06-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y06m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y06m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y06m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx5
    on ph_info_prvd_ag_hist_pt_2024y06m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y06m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y06m
    add constraint ph_info_prvd_ag_hist_pt_2024y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-07-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y07m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y07m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y07m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx6
    on ph_info_prvd_ag_hist_pt_2024y07m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y07m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y07m
    add constraint ph_info_prvd_ag_hist_pt_2024y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-08-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y08m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y08m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y08m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx7
    on ph_info_prvd_ag_hist_pt_2024y08m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y08m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y08m
    add constraint ph_info_prvd_ag_hist_pt_2024y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-09-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y09m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y09m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y09m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx8
    on ph_info_prvd_ag_hist_pt_2024y09m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y09m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y09m
    add constraint ph_info_prvd_ag_hist_pt_2024y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y10m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2024y10m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y10m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2024y_cls_id_prvdr_id_cust_id_hist_idx9
    on ph_info_prvd_ag_hist_pt_2024y10m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y10m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y10m
    add constraint ph_info_prvd_ag_hist_pt_2024y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y11m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2024_cls_id_prvdr_id_cust_id_hist_idx10
    on ph_info_prvd_ag_hist_pt_2024y11m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2024y11m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y11m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y11m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y11m
    add constraint ph_info_prvd_ag_hist_pt_2024y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2024-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2024y12m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2024_cls_id_prvdr_id_cust_id_hist_idx11
    on ph_info_prvd_ag_hist_pt_2024y12m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2024y12m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2024y12m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y12m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2024y12m
    add constraint ph_info_prvd_ag_hist_pt_2024y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2024-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-01-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y01m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y01m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y01m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist__idx
    on ph_info_prvd_ag_hist_pt_2025y01m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y01m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y01m
    add constraint ph_info_prvd_ag_hist_pt_2025y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-02-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y02m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y02m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y02m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx1
    on ph_info_prvd_ag_hist_pt_2025y02m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y02m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y02m
    add constraint ph_info_prvd_ag_hist_pt_2025y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-03-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y03m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y03m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y03m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx2
    on ph_info_prvd_ag_hist_pt_2025y03m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y03m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y03m
    add constraint ph_info_prvd_ag_hist_pt_2025y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-04-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y04m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y04m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y04m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx3
    on ph_info_prvd_ag_hist_pt_2025y04m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y04m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y04m
    add constraint ph_info_prvd_ag_hist_pt_2025y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-05-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y05m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y05m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y05m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx4
    on ph_info_prvd_ag_hist_pt_2025y05m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y05m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y05m
    add constraint ph_info_prvd_ag_hist_pt_2025y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-06-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y06m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y06m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y06m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx5
    on ph_info_prvd_ag_hist_pt_2025y06m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y06m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y06m
    add constraint ph_info_prvd_ag_hist_pt_2025y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-07-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y07m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y07m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y07m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx6
    on ph_info_prvd_ag_hist_pt_2025y07m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y07m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y07m
    add constraint ph_info_prvd_ag_hist_pt_2025y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-08-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y08m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y08m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y08m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx7
    on ph_info_prvd_ag_hist_pt_2025y08m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y08m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y08m
    add constraint ph_info_prvd_ag_hist_pt_2025y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-09-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y09m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y09m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y09m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx8
    on ph_info_prvd_ag_hist_pt_2025y09m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y09m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y09m
    add constraint ph_info_prvd_ag_hist_pt_2025y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y10m
(
)
    inherits (ph_info_prvd_ag_hist);

create index ph_info_prvd_ag_hist_pt_2025y10m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y10m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2025y_cls_id_prvdr_id_cust_id_hist_idx9
    on ph_info_prvd_ag_hist_pt_2025y10m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y10m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y10m
    add constraint ph_info_prvd_ag_hist_pt_2025y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y11m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2025_cls_id_prvdr_id_cust_id_hist_idx10
    on ph_info_prvd_ag_hist_pt_2025y11m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2025y11m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y11m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y11m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y11m
    add constraint ph_info_prvd_ag_hist_pt_2025y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2025-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2025y12m
(
)
    inherits (ph_info_prvd_ag_hist);

create unique index ph_info_prvd_ag_hist_pt_2025_cls_id_prvdr_id_cust_id_hist_idx11
    on ph_info_prvd_ag_hist_pt_2025y12m (cls_id, prvdr_id, cust_id, hist_seq);

create index ph_info_prvd_ag_hist_pt_2025y12m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2025y12m (cust_id, cls_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y12m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2025y12m
    add constraint ph_info_prvd_ag_hist_pt_2025y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2025-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-01-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y01m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y01m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y01m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y01m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y01m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y01m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y01m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y01m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y01m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y01m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y01m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y01m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y01m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y01m_log_no_idx
    on adm_api_if_log_pt_2026y01m (log_no);

alter table adm_api_if_log_pt_2026y01m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y01m
    add constraint adm_api_if_log_pt_2026y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-02-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y02m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y02m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y02m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y02m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y02m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y02m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y02m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y02m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y02m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y02m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y02m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y02m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y02m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y02m_log_no_idx
    on adm_api_if_log_pt_2026y02m (log_no);

alter table adm_api_if_log_pt_2026y02m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y02m
    add constraint adm_api_if_log_pt_2026y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-03-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y03m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y03m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y03m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y03m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y03m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y03m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y03m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y03m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y03m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y03m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y03m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y03m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y03m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y03m_log_no_idx
    on adm_api_if_log_pt_2026y03m (log_no);

alter table adm_api_if_log_pt_2026y03m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y03m
    add constraint adm_api_if_log_pt_2026y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-04-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y04m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y04m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y04m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y04m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y04m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y04m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y04m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y04m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y04m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y04m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y04m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y04m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y04m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y04m_log_no_idx
    on adm_api_if_log_pt_2026y04m (log_no);

alter table adm_api_if_log_pt_2026y04m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y04m
    add constraint adm_api_if_log_pt_2026y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-05-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y05m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y05m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y05m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y05m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y05m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y05m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y05m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y05m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y05m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y05m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y05m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y05m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y05m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y05m_log_no_idx
    on adm_api_if_log_pt_2026y05m (log_no);

alter table adm_api_if_log_pt_2026y05m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y05m
    add constraint adm_api_if_log_pt_2026y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-06-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y06m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y06m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y06m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y06m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y06m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y06m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y06m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y06m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y06m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y06m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y06m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y06m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y06m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y06m_log_no_idx
    on adm_api_if_log_pt_2026y06m (log_no);

alter table adm_api_if_log_pt_2026y06m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y06m
    add constraint adm_api_if_log_pt_2026y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-07-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y07m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y07m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y07m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y07m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y07m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y07m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y07m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y07m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y07m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y07m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y07m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y07m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y07m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y07m_log_no_idx
    on adm_api_if_log_pt_2026y07m (log_no);

alter table adm_api_if_log_pt_2026y07m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y07m
    add constraint adm_api_if_log_pt_2026y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-08-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y08m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y08m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y08m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y08m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y08m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y08m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y08m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y08m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y08m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y08m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y08m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y08m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y08m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y08m_log_no_idx
    on adm_api_if_log_pt_2026y08m (log_no);

alter table adm_api_if_log_pt_2026y08m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y08m
    add constraint adm_api_if_log_pt_2026y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-09-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y09m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y09m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y09m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y09m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y09m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y09m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y09m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y09m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y09m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y09m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y09m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y09m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y09m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y09m_log_no_idx
    on adm_api_if_log_pt_2026y09m (log_no);

alter table adm_api_if_log_pt_2026y09m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y09m
    add constraint adm_api_if_log_pt_2026y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-10-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y10m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y10m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y10m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y10m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y10m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y10m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y10m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y10m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y10m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y10m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y10m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y10m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y10m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y10m_log_no_idx
    on adm_api_if_log_pt_2026y10m (log_no);

alter table adm_api_if_log_pt_2026y10m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y10m
    add constraint adm_api_if_log_pt_2026y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-11-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y11m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y11m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y11m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y11m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y11m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y11m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y11m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y11m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y11m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y11m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y11m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y11m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y11m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y11m_log_no_idx
    on adm_api_if_log_pt_2026y11m (log_no);

alter table adm_api_if_log_pt_2026y11m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y11m
    add constraint adm_api_if_log_pt_2026y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-12-01 00:00:00'::timestamp without time zone)));

create table adm_api_if_log_pt_2026y12m
(
    log_no       varchar(20) not null,
    actn_uri     varchar(200),
    send_plc     varchar(20),
    rcv_plc      varchar(20),
    phub_tr_no   varchar(30),
    pg_deal_no   varchar(40),
    rply_cd      varchar(30),
    rply_msg     varchar(2000),
    rgst_user_id varchar(20),
    rgst_dt      timestamp
)
    inherits (adm_api_if_log);

comment on column adm_api_if_log_pt_2026y12m.log_no is '로그번호_IF';

comment on column adm_api_if_log_pt_2026y12m.actn_uri is '액션URI';

comment on column adm_api_if_log_pt_2026y12m.send_plc is '발신처';

comment on column adm_api_if_log_pt_2026y12m.rcv_plc is '수신처';

comment on column adm_api_if_log_pt_2026y12m.phub_tr_no is '포인트허브거래번호';

comment on column adm_api_if_log_pt_2026y12m.pg_deal_no is 'PG거래번호';

comment on column adm_api_if_log_pt_2026y12m.rply_cd is '응답코드';

comment on column adm_api_if_log_pt_2026y12m.rply_msg is '응답메시지';

comment on column adm_api_if_log_pt_2026y12m.rgst_user_id is '등록자ID';

comment on column adm_api_if_log_pt_2026y12m.rgst_dt is '등록일시';

create index adm_api_if_log_pt_2026y12m_rgst_dt_phub_tr_no_idx
    on adm_api_if_log_pt_2026y12m (rgst_dt, phub_tr_no);

create unique index adm_api_if_log_pt_2026y12m_log_no_idx
    on adm_api_if_log_pt_2026y12m (log_no);

alter table adm_api_if_log_pt_2026y12m
    add primary key (log_no);

alter table adm_api_if_log_pt_2026y12m
    add constraint adm_api_if_log_pt_2026y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2027-01-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y01m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y01m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y01m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y01m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y01m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y01m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y01m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y01m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y01m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y01m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y01m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y01m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y01m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y01m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y01m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y01m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y01m
    add constraint ph_cls_ag_hist_pt_2026y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-02-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y02m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y02m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y02m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y02m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y02m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y02m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y02m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y02m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y02m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y02m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y02m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y02m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y02m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y02m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y02m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y02m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y02m
    add constraint ph_cls_ag_hist_pt_2026y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-03-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y03m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y03m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y03m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y03m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y03m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y03m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y03m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y03m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y03m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y03m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y03m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y03m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y03m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y03m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y03m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y03m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y03m
    add constraint ph_cls_ag_hist_pt_2026y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-04-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y04m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y04m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y04m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y04m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y04m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y04m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y04m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y04m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y04m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y04m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y04m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y04m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y04m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y04m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y04m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y04m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y04m
    add constraint ph_cls_ag_hist_pt_2026y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-05-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y05m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y05m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y05m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y05m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y05m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y05m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y05m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y05m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y05m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y05m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y05m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y05m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y05m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y05m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y05m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y05m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y05m
    add constraint ph_cls_ag_hist_pt_2026y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-06-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y06m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y06m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y06m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y06m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y06m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y06m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y06m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y06m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y06m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y06m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y06m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y06m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y06m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y06m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y06m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y06m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y06m
    add constraint ph_cls_ag_hist_pt_2026y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-07-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y07m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y07m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y07m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y07m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y07m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y07m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y07m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y07m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y07m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y07m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y07m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y07m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y07m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y07m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y07m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y07m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y07m
    add constraint ph_cls_ag_hist_pt_2026y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-08-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y08m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y08m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y08m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y08m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y08m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y08m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y08m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y08m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y08m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y08m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y08m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y08m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y08m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y08m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y08m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y08m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y08m
    add constraint ph_cls_ag_hist_pt_2026y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-09-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y09m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y09m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y09m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y09m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y09m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y09m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y09m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y09m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y09m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y09m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y09m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y09m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y09m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y09m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y09m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y09m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y09m
    add constraint ph_cls_ag_hist_pt_2026y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-10-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y10m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y10m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y10m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y10m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y10m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y10m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y10m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y10m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y10m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y10m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y10m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y10m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y10m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y10m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y10m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y10m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y10m
    add constraint ph_cls_ag_hist_pt_2026y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-11-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y11m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y11m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y11m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y11m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y11m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y11m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y11m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y11m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y11m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y11m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y11m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y11m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y11m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y11m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y11m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y11m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y11m
    add constraint ph_cls_ag_hist_pt_2026y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-12-01 00:00:00'::timestamp without time zone)));

create table ph_cls_ag_hist_pt_2026y12m
(
    cust_id      varchar(20)                                                not null,
    cls_id       varchar(10)                                                not null,
    hist_seq     integer    default nextval('seq_ph_cls_ag_hist'::regclass) not null,
    cls_ver      varchar(10),
    agre_yn      varchar(1) default 'Y'::character varying,
    cls_titl     varchar(400),
    phub_tr_no   varchar(20),
    rgst_dt      timestamp,
    rgst_user_id varchar(20),
    log_no       varchar(20),
    rply_cd      varchar(30),
    rply_msg     varchar(2000)
)
    inherits (ph_cls_ag_hist);

comment on column ph_cls_ag_hist_pt_2026y12m.cust_id is '고객ID';

comment on column ph_cls_ag_hist_pt_2026y12m.cls_id is '약관ID';

comment on column ph_cls_ag_hist_pt_2026y12m.hist_seq is '이력순번';

comment on column ph_cls_ag_hist_pt_2026y12m.cls_ver is '약관버전';

comment on column ph_cls_ag_hist_pt_2026y12m.agre_yn is '동의여부';

comment on column ph_cls_ag_hist_pt_2026y12m.cls_titl is '약관타이틀';

comment on column ph_cls_ag_hist_pt_2026y12m.phub_tr_no is '포인트허브거래번호';

comment on column ph_cls_ag_hist_pt_2026y12m.rgst_dt is '등록일시';

comment on column ph_cls_ag_hist_pt_2026y12m.rgst_user_id is '등록자ID';

comment on column ph_cls_ag_hist_pt_2026y12m.log_no is '로그번호_IF';

comment on column ph_cls_ag_hist_pt_2026y12m.rply_cd is '응답코드';

comment on column ph_cls_ag_hist_pt_2026y12m.rply_msg is '응답메시지';

create unique index ph_cls_ag_hist_pt_2026y12m_cust_id_cls_id_hist_seq_idx
    on ph_cls_ag_hist_pt_2026y12m (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y12m
    add primary key (cust_id, cls_id, hist_seq);

alter table ph_cls_ag_hist_pt_2026y12m
    add constraint ph_cls_ag_hist_pt_2026y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2027-01-01 00:00:00'::timestamp without time zone)));

create table ph_deal_req_info_pt_2026y01m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y01m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y01m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y01m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y01m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y01m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y01m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y01m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y01m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y01m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y01m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y01m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y01m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y01m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y01m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y01m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y01m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y01m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y01m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y01m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y01m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y01m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y01m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y01m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y01m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y01m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y01m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y01m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y01m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y01m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y01m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y01m_cust_id_idx
    on ph_deal_req_info_pt_2026y01m (cust_id);

create unique index ph_deal_req_info_pt_2026y01m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y01m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y01m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y01m
    add constraint ph_deal_req_info_pt_2026y01m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y02m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y02m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y02m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y02m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y02m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y02m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y02m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y02m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y02m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y02m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y02m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y02m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y02m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y02m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y02m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y02m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y02m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y02m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y02m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y02m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y02m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y02m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y02m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y02m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y02m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y02m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y02m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y02m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y02m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y02m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y02m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y02m_cust_id_idx
    on ph_deal_req_info_pt_2026y02m (cust_id);

create unique index ph_deal_req_info_pt_2026y02m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y02m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y02m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y02m
    add constraint ph_deal_req_info_pt_2026y02m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260301000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y03m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y03m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y03m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y03m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y03m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y03m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y03m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y03m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y03m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y03m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y03m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y03m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y03m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y03m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y03m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y03m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y03m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y03m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y03m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y03m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y03m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y03m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y03m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y03m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y03m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y03m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y03m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y03m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y03m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y03m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y03m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y03m_cust_id_idx
    on ph_deal_req_info_pt_2026y03m (cust_id);

create unique index ph_deal_req_info_pt_2026y03m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y03m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y03m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y03m
    add constraint ph_deal_req_info_pt_2026y03m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260301000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260401000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y04m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y04m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y04m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y04m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y04m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y04m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y04m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y04m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y04m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y04m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y04m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y04m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y04m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y04m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y04m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y04m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y04m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y04m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y04m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y04m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y04m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y04m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y04m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y04m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y04m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y04m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y04m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y04m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y04m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y04m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y04m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y04m_cust_id_idx
    on ph_deal_req_info_pt_2026y04m (cust_id);

create unique index ph_deal_req_info_pt_2026y04m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y04m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y04m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y04m
    add constraint ph_deal_req_info_pt_2026y04m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260401000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260501000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y05m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y05m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y05m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y05m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y05m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y05m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y05m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y05m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y05m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y05m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y05m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y05m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y05m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y05m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y05m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y05m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y05m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y05m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y05m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y05m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y05m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y05m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y05m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y05m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y05m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y05m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y05m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y05m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y05m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y05m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y05m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y05m_cust_id_idx
    on ph_deal_req_info_pt_2026y05m (cust_id);

create unique index ph_deal_req_info_pt_2026y05m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y05m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y05m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y05m
    add constraint ph_deal_req_info_pt_2026y05m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260501000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260601000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y06m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y06m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y06m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y06m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y06m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y06m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y06m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y06m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y06m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y06m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y06m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y06m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y06m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y06m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y06m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y06m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y06m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y06m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y06m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y06m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y06m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y06m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y06m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y06m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y06m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y06m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y06m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y06m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y06m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y06m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y06m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y06m_cust_id_idx
    on ph_deal_req_info_pt_2026y06m (cust_id);

create unique index ph_deal_req_info_pt_2026y06m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y06m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y06m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y06m
    add constraint ph_deal_req_info_pt_2026y06m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260601000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260701000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y07m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y07m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y07m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y07m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y07m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y07m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y07m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y07m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y07m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y07m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y07m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y07m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y07m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y07m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y07m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y07m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y07m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y07m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y07m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y07m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y07m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y07m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y07m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y07m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y07m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y07m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y07m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y07m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y07m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y07m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y07m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y07m_cust_id_idx
    on ph_deal_req_info_pt_2026y07m (cust_id);

create unique index ph_deal_req_info_pt_2026y07m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y07m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y07m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y07m
    add constraint ph_deal_req_info_pt_2026y07m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260701000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260801000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y08m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y08m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y08m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y08m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y08m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y08m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y08m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y08m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y08m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y08m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y08m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y08m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y08m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y08m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y08m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y08m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y08m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y08m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y08m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y08m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y08m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y08m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y08m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y08m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y08m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y08m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y08m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y08m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y08m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y08m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y08m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y08m_cust_id_idx
    on ph_deal_req_info_pt_2026y08m (cust_id);

create unique index ph_deal_req_info_pt_2026y08m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y08m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y08m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y08m
    add constraint ph_deal_req_info_pt_2026y08m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260801000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20260901000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y09m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y09m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y09m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y09m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y09m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y09m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y09m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y09m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y09m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y09m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y09m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y09m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y09m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y09m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y09m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y09m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y09m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y09m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y09m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y09m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y09m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y09m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y09m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y09m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y09m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y09m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y09m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y09m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y09m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y09m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y09m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y09m_cust_id_idx
    on ph_deal_req_info_pt_2026y09m (cust_id);

create unique index ph_deal_req_info_pt_2026y09m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y09m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y09m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y09m
    add constraint ph_deal_req_info_pt_2026y09m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20260901000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20261001000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y10m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y10m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y10m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y10m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y10m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y10m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y10m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y10m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y10m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y10m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y10m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y10m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y10m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y10m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y10m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y10m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y10m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y10m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y10m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y10m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y10m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y10m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y10m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y10m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y10m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y10m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y10m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y10m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y10m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y10m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y10m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y10m_cust_id_idx
    on ph_deal_req_info_pt_2026y10m (cust_id);

create unique index ph_deal_req_info_pt_2026y10m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y10m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y10m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y10m
    add constraint ph_deal_req_info_pt_2026y10m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20261001000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20261101000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y11m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y11m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y11m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y11m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y11m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y11m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y11m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y11m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y11m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y11m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y11m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y11m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y11m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y11m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y11m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y11m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y11m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y11m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y11m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y11m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y11m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y11m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y11m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y11m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y11m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y11m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y11m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y11m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y11m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y11m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y11m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y11m_cust_id_idx
    on ph_deal_req_info_pt_2026y11m (cust_id);

create unique index ph_deal_req_info_pt_2026y11m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y11m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y11m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y11m
    add constraint ph_deal_req_info_pt_2026y11m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20261101000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20261201000000'::character varying(14))::text)));

create table ph_deal_req_info_pt_2026y12m
(
    phub_tr_no     varchar(30) not null,
    deal_dt        varchar(14),
    pg_deal_no     varchar(40),
    pg_send_po_id  varchar(20),
    cprt_cmpn_id   varchar(30),
    pg_cmpn_id     varchar(40),
    deal_ind       varchar(20),
    goods_nm       varchar(100),
    pay_method     varchar(20),
    deal_stat      varchar(20),
    cust_id        varchar(20),
    deal_tkn       varchar(100),
    ori_phub_tr_no varchar(20),
    ori_pg_deal_no varchar(40),
    ttl_pnt        integer,
    ttl_pay_amt    integer,
    ttl_pnt_amt    integer,
    ttl_rmnd_amt   integer,
    err_cd         varchar(20),
    err_msg        varchar(100),
    rgst_dt        timestamp,
    rgst_user_id   varchar(50),
    mdfy_dt        timestamp,
    mdfy_user_id   varchar(50),
    auth_limit_dtm varchar(14),
    service_id     varchar(30) default 'SVC_BASE'::character varying,
    add_param      varchar(1000),
    inqr_pnt       integer,
    pltf_ind       varchar(20),
    ttl_sale_amt   integer,
    cust_ctn_enc   varchar(400),
    cust_ctn_sch   varchar(400)[]
)
    inherits (ph_deal_req_info);

comment on column ph_deal_req_info_pt_2026y12m.phub_tr_no is '포인트허브거래번호';

comment on column ph_deal_req_info_pt_2026y12m.deal_dt is '거래일시';

comment on column ph_deal_req_info_pt_2026y12m.pg_deal_no is 'PG거래번호';

comment on column ph_deal_req_info_pt_2026y12m.pg_send_po_id is 'PG제공사용처ID';

comment on column ph_deal_req_info_pt_2026y12m.cprt_cmpn_id is '사용처ID';

comment on column ph_deal_req_info_pt_2026y12m.pg_cmpn_id is 'PG사ID';

comment on column ph_deal_req_info_pt_2026y12m.deal_ind is '거래구분';

comment on column ph_deal_req_info_pt_2026y12m.goods_nm is '상품명';

comment on column ph_deal_req_info_pt_2026y12m.pay_method is '단일복합결제구분';

comment on column ph_deal_req_info_pt_2026y12m.deal_stat is '거래상태';

comment on column ph_deal_req_info_pt_2026y12m.cust_id is '고객ID';

comment on column ph_deal_req_info_pt_2026y12m.deal_tkn is '거래토큰';

comment on column ph_deal_req_info_pt_2026y12m.ori_phub_tr_no is '이전거래번호';

comment on column ph_deal_req_info_pt_2026y12m.ori_pg_deal_no is '이전PG거래번호';

comment on column ph_deal_req_info_pt_2026y12m.ttl_pnt is '총포인트';

comment on column ph_deal_req_info_pt_2026y12m.ttl_pay_amt is '총결제금액';

comment on column ph_deal_req_info_pt_2026y12m.ttl_pnt_amt is '총포인트전환금액';

comment on column ph_deal_req_info_pt_2026y12m.ttl_rmnd_amt is '총잔여금액';

comment on column ph_deal_req_info_pt_2026y12m.err_cd is '오류코드';

comment on column ph_deal_req_info_pt_2026y12m.err_msg is '오류메시지';

comment on column ph_deal_req_info_pt_2026y12m.rgst_dt is '등록일시';

comment on column ph_deal_req_info_pt_2026y12m.rgst_user_id is '등록자ID';

comment on column ph_deal_req_info_pt_2026y12m.mdfy_dt is '수정일시';

comment on column ph_deal_req_info_pt_2026y12m.mdfy_user_id is '수정자ID';

comment on column ph_deal_req_info_pt_2026y12m.auth_limit_dtm is '인증만료일시';

comment on column ph_deal_req_info_pt_2026y12m.service_id is '서비스아이디';

comment on column ph_deal_req_info_pt_2026y12m.add_param is '추가파라미터';

comment on column ph_deal_req_info_pt_2026y12m.inqr_pnt is '조회포인트';

comment on column ph_deal_req_info_pt_2026y12m.pltf_ind is '플랫폼구분(PC/모바일)';

comment on column ph_deal_req_info_pt_2026y12m.ttl_sale_amt is '할인금액';

create index ph_deal_req_info_pt_2026y12m_cust_id_idx
    on ph_deal_req_info_pt_2026y12m (cust_id);

create unique index ph_deal_req_info_pt_2026y12m_phub_tr_no_idx
    on ph_deal_req_info_pt_2026y12m (phub_tr_no);

alter table ph_deal_req_info_pt_2026y12m
    add primary key (phub_tr_no);

alter table ph_deal_req_info_pt_2026y12m
    add constraint ph_deal_req_info_pt_2026y12m_partition
        check (((deal_dt IS NULL) OR ((deal_dt)::text >= ('20261201000000'::character varying(14))::text)) AND
               ((deal_dt IS NOT NULL) AND ((deal_dt)::text < ('20270101000000'::character varying(14))::text)));

create table ph_info_prvd_ag_hist_pt_2026y01m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y01m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y01m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y01m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y01m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y01m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y01m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y01m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y01m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y01m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist__idx
    on ph_info_prvd_ag_hist_pt_2026y01m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y01m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y01m
    add constraint ph_info_prvd_ag_hist_pt_2026y01m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-01-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-02-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y02m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y02m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y02m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y02m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y02m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y02m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y02m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y02m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y02m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y02m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx1
    on ph_info_prvd_ag_hist_pt_2026y02m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y02m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y02m
    add constraint ph_info_prvd_ag_hist_pt_2026y02m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-02-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-03-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y03m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y03m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y03m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y03m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y03m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y03m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y03m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y03m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y03m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y03m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx2
    on ph_info_prvd_ag_hist_pt_2026y03m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y03m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y03m
    add constraint ph_info_prvd_ag_hist_pt_2026y03m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-03-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-04-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y04m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y04m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y04m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y04m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y04m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y04m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y04m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y04m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y04m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y04m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx3
    on ph_info_prvd_ag_hist_pt_2026y04m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y04m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y04m
    add constraint ph_info_prvd_ag_hist_pt_2026y04m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-04-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-05-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y05m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y05m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y05m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y05m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y05m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y05m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y05m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y05m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y05m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y05m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx4
    on ph_info_prvd_ag_hist_pt_2026y05m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y05m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y05m
    add constraint ph_info_prvd_ag_hist_pt_2026y05m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-05-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-06-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y06m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y06m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y06m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y06m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y06m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y06m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y06m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y06m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y06m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y06m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx5
    on ph_info_prvd_ag_hist_pt_2026y06m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y06m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y06m
    add constraint ph_info_prvd_ag_hist_pt_2026y06m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-06-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-07-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y07m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y07m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y07m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y07m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y07m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y07m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y07m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y07m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y07m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y07m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx6
    on ph_info_prvd_ag_hist_pt_2026y07m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y07m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y07m
    add constraint ph_info_prvd_ag_hist_pt_2026y07m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-07-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-08-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y08m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y08m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y08m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y08m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y08m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y08m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y08m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y08m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y08m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y08m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx7
    on ph_info_prvd_ag_hist_pt_2026y08m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y08m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y08m
    add constraint ph_info_prvd_ag_hist_pt_2026y08m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-08-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-09-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y09m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y09m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y09m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y09m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y09m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y09m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y09m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y09m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y09m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y09m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx8
    on ph_info_prvd_ag_hist_pt_2026y09m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y09m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y09m
    add constraint ph_info_prvd_ag_hist_pt_2026y09m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-09-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-10-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y10m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y10m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y10m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y10m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y10m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y10m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y10m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y10m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y10m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y10m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026y_cls_id_prvdr_id_cust_id_hist_idx9
    on ph_info_prvd_ag_hist_pt_2026y10m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y10m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y10m
    add constraint ph_info_prvd_ag_hist_pt_2026y10m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-10-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-11-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y11m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y11m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y11m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y11m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y11m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y11m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y11m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y11m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y11m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y11m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026_cls_id_prvdr_id_cust_id_hist_idx10
    on ph_info_prvd_ag_hist_pt_2026y11m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y11m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y11m
    add constraint ph_info_prvd_ag_hist_pt_2026y11m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-11-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2026-12-01 00:00:00'::timestamp without time zone)));

create table ph_info_prvd_ag_hist_pt_2026y12m
(
    cls_id       varchar(10)                                                      not null,
    prvdr_id     varchar(20)                                                      not null,
    cust_id      varchar(20)                                                      not null,
    hist_seq     integer    default nextval('seq_ph_info_prvd_ag_hist'::regclass) not null,
    agre_yn      varchar(1) default 'Y'::character varying,
    rgst_dt      timestamp,
    rgst_user_id varchar(20)
)
    inherits (ph_info_prvd_ag_hist);

comment on column ph_info_prvd_ag_hist_pt_2026y12m.cls_id is '약관ID';

comment on column ph_info_prvd_ag_hist_pt_2026y12m.prvdr_id is '제공처ID';

comment on column ph_info_prvd_ag_hist_pt_2026y12m.cust_id is '고객ID';

comment on column ph_info_prvd_ag_hist_pt_2026y12m.hist_seq is '이력순번';

comment on column ph_info_prvd_ag_hist_pt_2026y12m.agre_yn is '동의여부';

comment on column ph_info_prvd_ag_hist_pt_2026y12m.rgst_dt is '등록일시';

comment on column ph_info_prvd_ag_hist_pt_2026y12m.rgst_user_id is '등록자ID';

create index ph_info_prvd_ag_hist_pt_2026y12m_cust_id_cls_id_hist_seq_idx
    on ph_info_prvd_ag_hist_pt_2026y12m (cust_id, cls_id, hist_seq);

create unique index ph_info_prvd_ag_hist_pt_2026_cls_id_prvdr_id_cust_id_hist_idx11
    on ph_info_prvd_ag_hist_pt_2026y12m (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y12m
    add primary key (cls_id, prvdr_id, cust_id, hist_seq);

alter table ph_info_prvd_ag_hist_pt_2026y12m
    add constraint ph_info_prvd_ag_hist_pt_2026y12m_partition
        check (((rgst_dt IS NULL) OR (rgst_dt >= '2026-12-01 00:00:00'::timestamp without time zone)) AND
               ((rgst_dt IS NOT NULL) AND (rgst_dt < '2027-01-01 00:00:00'::timestamp without time zone)));

create table adm_user_info_hist
(
    hist_seq_no     serial,
    user_id         varchar(20) not null,
    stat_cd         varchar(20) default '1000'::character varying,
    efct_strt_dd    varchar(8),
    efct_end_dd     varchar(8),
    login_err_cnt   integer,
    user_grp_id     varchar(20),
    dept_cd         varchar(20),
    jnng_pwd        varchar(100),
    ip_addr         varchar(20),
    ip_addr2        varchar(20),
    ip_addr3        varchar(20),
    rcnt_jnng_dd    timestamp,
    max_inqr_cnt    integer     default 0,
    otp_auth_yn     varchar(1)  default 'Y'::character varying,
    captcha_auth_yn varchar(1)  default 'Y'::character varying,
    ldap_auth_yn    varchar(1)  default 'Y'::character varying,
    user_nm_enc     varchar(400),
    user_nm_sch     character varying[],
    cnt_plc_enc     varchar(400),
    cnt_plc_sch     character varying[],
    chng_dt         timestamp,
    chng_user_id    varchar(20),
    chng_type       varchar(1),
    chng_rsn        varchar(100)
);

comment on column adm_user_info_hist.user_nm_enc is '사용자명암호화';

comment on column adm_user_info_hist.user_nm_sch is '사용자명해시';

comment on column adm_user_info_hist.cnt_plc_enc is '연락처암호화';

comment on column adm_user_info_hist.cnt_plc_sch is '연락처해시';

create index idx_adm_user_info_hist_user_id
    on adm_user_info_hist (user_id);

create index idx_adm_user_info_hist_chng_dt
    on adm_user_info_hist (chng_dt);

alter table adm_user_info_hist
    add primary key (hist_seq_no);

create view lc_view_enc
            (logtim, seq, sys_id, user_id, user_nm_enc, org_nm, user_ip_enc, cust_id, deal_dtm2, rtrv_menu, rtrv_type_nm, multi_log_type, multi_log_param, rtrv_caus_nm) as
SELECT to_char(lc.rgst_dt, 'YYYYMMDD'::character varying::text) AS logtim,
    row_number() OVER (PARTITION BY (to_char(lc.rgst_dt, 'YYYYMMDD'::character varying::text)) ORDER BY lc.rgst_dt) AS seq,
    '포인트허브(PG028608)'::text AS sys_id,
    lc.rgst_user_id AS user_id,
    ui.user_nm_enc,
    ( SELECT adm_cmn_cd_d.dtl_cd_nm
           FROM adm_cmn_cd_d
          WHERE adm_cmn_cd_d.ind_cd::text = 'USER_DEPT'::text AND adm_cmn_cd_d.dtl_cd::text = ui.dept_cd::text) AS org_nm,
    lc.jnng_ip_enc AS user_ip_enc,
    lc.cust_id,
    lc.rgst_dt AS deal_dtm2,
    lc.menu_nm AS rtrv_menu,
    ai.uri_method AS rtrv_type_nm,
    lc.sngl_mult_ind AS multi_log_type,
    lc.prmt AS multi_log_param,
    lc.inqr_rsn AS rtrv_caus_nm
   FROM adm_user_info ui,
    adm_action_info ai,
    adm_logcntr_log lc
  WHERE lc.rgst_user_id::text = ui.user_id::text AND lc.actn_id::text = ai.menu_id::text AND lc.uri::text = ai.uri::text;

create function fnc_cprt_limit(p_pg_cmpn_id character varying, p_cprt_cmpn_id character varying, p_date character varying)
    returns TABLE(limit_amount integer, ttl_pnt_amt integer, limit_yn text)
    language plpgsql
as
$$
DECLARE
    V_RECORD          record;
    V_LIMIT_AMOUNT INTEGER;
    V_LIMIT_YN    TEXT;
BEGIN

    IF p_date IS NULL OR p_date = '' THEN
  p_date := TO_CHAR(NOW(),'YYYYMMDD');
 END IF;

 SELECT   A.LIMIT_AMOUNT, A.LIMIT_YN
 INTO     V_LIMIT_AMOUNT, V_LIMIT_YN
 FROM     PH_PG_CPRT_LIMIT_INFO A
 WHERE    A.PG_CMPN_ID   = p_pg_cmpn_id
 AND      A.CPRT_CMPN_ID = p_cprt_cmpn_id
 ORDER BY CPRT_CMPN_SEQ DESC
 LIMIT 1;

 IF V_LIMIT_YN = 'Y' THEN
  FOR V_RECORD IN(
  SELECT  A.CPRT_CMPN_ID
      ,A.DEAL_DT
         ,SUM(A.TTL_PNT_AMT) AS TTL_PNT_AMT
   FROM   PH_PG_CPRT_LIMIT_HIST A
   WHERE  A.PG_CMPN_ID   = p_pg_cmpn_id
   AND    A.CPRT_CMPN_ID = p_cprt_cmpn_id
   AND    A.DEAL_DT      = p_date
   GROUP  BY A.CPRT_CMPN_ID, A.DEAL_DT
   )
     LOOP
  LIMIT_AMOUNT := V_LIMIT_AMOUNT;
  TTL_PNT_AMT  := V_RECORD.TTL_PNT_AMT;
  LIMIT_YN        := V_LIMIT_YN;
  RETURN NEXT;
     END LOOP;

     IF NOT FOUND THEN
  LIMIT_AMOUNT := V_LIMIT_AMOUNT;
  TTL_PNT_AMT  := 0;
  LIMIT_YN        := V_LIMIT_YN;
  RETURN NEXT;
     END IF;
 ELSE
  LIMIT_AMOUNT := NULL;
 TTL_PNT_AMT  := NULL;
 LIMIT_YN        := 'N';
 RETURN NEXT;
 END IF;
    RETURN;

END;
$$;

create function fnc_cprt_limit_amount(p_pg_cmpn_id character varying, p_cprt_cmpn_id character varying) returns numeric
    language plpgsql
as
$$

DECLARE RESULT_VALUE NUMERIC ;

BEGIN

    SELECT LIMIT_AMOUNT
    INTO   RESULT_VALUE
    FROM   PH_PG_CPRT_LIMIT_INFO A
    WHERE  PG_CMPN_ID   = p_pg_cmpn_id
    AND    CPRT_CMPN_ID = p_cprt_cmpn_id
    ORDER  BY CPRT_CMPN_SEQ DESC
    LIMIT  1;

    RETURN RESULT_VALUE;
END;

$$;

create function fnc_cust_ctn(p_cust_id text) returns text
    language plpgsql
as
$$

DECLARE RESULT_VALUE text;

BEGIN

   SELECT CUST_CTN
   INTO   RESULT_VALUE
   FROM   PH_PNT_CUST_CTN
   WHERE  CUST_ID = P_CUST_ID
   ORDER  BY RGST_DT DESC
   LIMIT  1;

   RETURN RESULT_VALUE;
END;

$$;

create function fnc_get_name(p_gubun character varying, p_id character varying) returns text
    language plpgsql
as
$$

DECLARE RESULT_VALUE text;

BEGIN

    IF p_gubun = 'PG' THEN
    SELECT PG_CMPN_NM
       INTO   RESULT_VALUE
       FROM   PH_PG_CMPN_INFO A
       WHERE  PG_CMPN_ID   = p_id;
    ELSIF p_gubun = 'CPRT' THEN
    SELECT CPRT_CMPN_NM
       INTO   RESULT_VALUE
       FROM   PH_PNT_CMPN_INFO A
       WHERE  CPRT_CMPN_ID = p_id;
    END IF;

    RETURN RESULT_VALUE;
END;

$$;

create function fnc_texttotimestamp(yyyymmdd text) returns timestamp without time zone
    immutable
    language plpgsql
as
$$
        BEGIN
    RETURN to_timestamp(yyyymmdd, 'YYYYMMDD');
        END;
$$;

create function fnc_pnt_exch_rate(p_prvdr_id text) returns numeric
    language plpgsql
as
$$

DECLARE RESULT_VALUE NUMERIC(18,16) := 0;

BEGIN

   SELECT PNT_EXCH_RATE
   INTO   RESULT_VALUE
   FROM   PH_PRVD_EXCH_RATE_HIST
   WHERE  PRVDR_ID = p_prvdr_id
   ORDER  BY MDFY_DT DESC
   LIMIT  1;

   IF NOT FOUND THEN
 RESULT_VALUE = 0;
   END IF;


   RETURN RESULT_VALUE;
END;

$$;

create function adm_api_if_log_part_func() returns trigger
    language plpgsql
as
$$
begin
	if ( new.rgst_dt >= '20241001'::timestamp and new.rgst_dt < '20241101'::timestamp ) then insert into phub.adm_api_if_log_pt_2024y10m values (new.*);
	elseif ( new.rgst_dt >= '20241101'::timestamp and new.rgst_dt < '20241201'::timestamp ) then insert into phub.adm_api_if_log_pt_2024y11m values (new.*);
	elseif ( new.rgst_dt >= '20241201'::timestamp and new.rgst_dt < '20250101'::timestamp ) then insert into phub.adm_api_if_log_pt_2024y12m values (new.*);
	elseif ( new.rgst_dt >= '20250101'::timestamp and new.rgst_dt < '20250201'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y01m values (new.*);
	elseif ( new.rgst_dt >= '20250201'::timestamp and new.rgst_dt < '20250301'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y02m values (new.*);
	elseif ( new.rgst_dt >= '20250301'::timestamp and new.rgst_dt < '20250401'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y03m values (new.*);
	elseif ( new.rgst_dt >= '20250401'::timestamp and new.rgst_dt < '20250501'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y04m values (new.*);
	elseif ( new.rgst_dt >= '20250501'::timestamp and new.rgst_dt < '20250601'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y05m values (new.*);
	elseif ( new.rgst_dt >= '20250601'::timestamp and new.rgst_dt < '20250701'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y06m values (new.*);
	elseif ( new.rgst_dt >= '20250701'::timestamp and new.rgst_dt < '20250801'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y07m values (new.*);
	elseif ( new.rgst_dt >= '20250801'::timestamp and new.rgst_dt < '20250901'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y08m values (new.*);
	elseif ( new.rgst_dt >= '20250901'::timestamp and new.rgst_dt < '20251001'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y09m values (new.*);
	elseif ( new.rgst_dt >= '20251001'::timestamp and new.rgst_dt < '20251101'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y10m values (new.*);
	elseif ( new.rgst_dt >= '20251101'::timestamp and new.rgst_dt < '20251201'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y11m values (new.*);
	elseif ( new.rgst_dt >= '20251201'::timestamp and new.rgst_dt < '20260101'::timestamp ) then insert into phub.adm_api_if_log_pt_2025y12m values (new.*);
	elseif ( new.rgst_dt >= '20260101'::timestamp and new.rgst_dt < '20260201'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y01m values (new.*);
	elseif ( new.rgst_dt >= '20260201'::timestamp and new.rgst_dt < '20260301'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y02m values (new.*);
	elseif ( new.rgst_dt >= '20260301'::timestamp and new.rgst_dt < '20260401'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y03m values (new.*);
	elseif ( new.rgst_dt >= '20260401'::timestamp and new.rgst_dt < '20260501'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y04m values (new.*);
	elseif ( new.rgst_dt >= '20260501'::timestamp and new.rgst_dt < '20260601'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y05m values (new.*);
	elseif ( new.rgst_dt >= '20260601'::timestamp and new.rgst_dt < '20260701'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y06m values (new.*);
	elseif ( new.rgst_dt >= '20260701'::timestamp and new.rgst_dt < '20260801'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y07m values (new.*);
	elseif ( new.rgst_dt >= '20260801'::timestamp and new.rgst_dt < '20260901'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y08m values (new.*);
	elseif ( new.rgst_dt >= '20260901'::timestamp and new.rgst_dt < '20261001'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y09m values (new.*);
	elseif ( new.rgst_dt >= '20261001'::timestamp and new.rgst_dt < '20261101'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y10m values (new.*);
	elseif ( new.rgst_dt >= '20261101'::timestamp and new.rgst_dt < '20261201'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y11m values (new.*);
	elseif ( new.rgst_dt >= '20261201'::timestamp and new.rgst_dt < '20270101'::timestamp ) then insert into phub.adm_api_if_log_pt_2026y12m values (new.*);
	else
		raise exception 'date out of range. implement additional partitions';
    end if;
    return null;
end;
$$;

create trigger adm_api_if_log_part_trigger
    before insert
    on adm_api_if_log
    for each row
execute procedure adm_api_if_log_part_func();

create function ph_cls_ag_hist_part_func() returns trigger
    language plpgsql
as
$$
begin
	if ( new.rgst_dt >= '20241001'::timestamp and new.rgst_dt < '20241101'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2024y10m values (new.*);
	elseif ( new.rgst_dt >= '20241101'::timestamp and new.rgst_dt < '20241201'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2024y11m values (new.*);
	elseif ( new.rgst_dt >= '20241201'::timestamp and new.rgst_dt < '20250101'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2024y12m values (new.*);
	elseif ( new.rgst_dt >= '20250101'::timestamp and new.rgst_dt < '20250201'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y01m values (new.*);
	elseif ( new.rgst_dt >= '20250201'::timestamp and new.rgst_dt < '20250301'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y02m values (new.*);
	elseif ( new.rgst_dt >= '20250301'::timestamp and new.rgst_dt < '20250401'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y03m values (new.*);
	elseif ( new.rgst_dt >= '20250401'::timestamp and new.rgst_dt < '20250501'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y04m values (new.*);
	elseif ( new.rgst_dt >= '20250501'::timestamp and new.rgst_dt < '20250601'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y05m values (new.*);
	elseif ( new.rgst_dt >= '20250601'::timestamp and new.rgst_dt < '20250701'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y06m values (new.*);
	elseif ( new.rgst_dt >= '20250701'::timestamp and new.rgst_dt < '20250801'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y07m values (new.*);
	elseif ( new.rgst_dt >= '20250801'::timestamp and new.rgst_dt < '20250901'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y08m values (new.*);
	elseif ( new.rgst_dt >= '20250901'::timestamp and new.rgst_dt < '20251001'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y09m values (new.*);
	elseif ( new.rgst_dt >= '20251001'::timestamp and new.rgst_dt < '20251101'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y10m values (new.*);
	elseif ( new.rgst_dt >= '20251101'::timestamp and new.rgst_dt < '20251201'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y11m values (new.*);
	elseif ( new.rgst_dt >= '20251201'::timestamp and new.rgst_dt < '20260101'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2025y12m values (new.*);
	elseif ( new.rgst_dt >= '20260101'::timestamp and new.rgst_dt < '20260201'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y01m values (new.*);
	elseif ( new.rgst_dt >= '20260201'::timestamp and new.rgst_dt < '20260301'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y02m values (new.*);
	elseif ( new.rgst_dt >= '20260301'::timestamp and new.rgst_dt < '20260401'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y03m values (new.*);
	elseif ( new.rgst_dt >= '20260401'::timestamp and new.rgst_dt < '20260501'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y04m values (new.*);
	elseif ( new.rgst_dt >= '20260501'::timestamp and new.rgst_dt < '20260601'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y05m values (new.*);
	elseif ( new.rgst_dt >= '20260601'::timestamp and new.rgst_dt < '20260701'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y06m values (new.*);
	elseif ( new.rgst_dt >= '20260701'::timestamp and new.rgst_dt < '20260801'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y07m values (new.*);
	elseif ( new.rgst_dt >= '20260801'::timestamp and new.rgst_dt < '20260901'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y08m values (new.*);
	elseif ( new.rgst_dt >= '20260901'::timestamp and new.rgst_dt < '20261001'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y09m values (new.*);
	elseif ( new.rgst_dt >= '20261001'::timestamp and new.rgst_dt < '20261101'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y10m values (new.*);
	elseif ( new.rgst_dt >= '20261101'::timestamp and new.rgst_dt < '20261201'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y11m values (new.*);
	elseif ( new.rgst_dt >= '20261201'::timestamp and new.rgst_dt < '20270101'::timestamp ) then insert into phub.ph_cls_ag_hist_pt_2026y12m values (new.*);
	else
      raise exception 'date out of range. implement additional partitions';
    end if;
    return null;
end;
$$;

create trigger ph_cls_ag_hist_part_trigger
    before insert
    on ph_cls_ag_hist
    for each row
execute procedure ph_cls_ag_hist_part_func();

create function ph_deal_req_info_part_func() returns trigger
    language plpgsql
as
$$
begin
	if ( new.deal_dt >= '20241001000000' and new.deal_dt < '20241101000000' ) then insert into phub.ph_deal_req_info_pt_2024y10m values (new.*);
	elseif ( new.deal_dt >= '20241101000000' and new.deal_dt < '20241201000000' ) then insert into phub.ph_deal_req_info_pt_2024y11m values (new.*);
	elseif ( new.deal_dt >= '20241201000000' and new.deal_dt < '20250101000000' ) then insert into phub.ph_deal_req_info_pt_2024y12m values (new.*);
	elseif ( new.deal_dt >= '20250101000000' and new.deal_dt < '20250201000000' ) then insert into phub.ph_deal_req_info_pt_2025y01m values (new.*);
	elseif ( new.deal_dt >= '20250201000000' and new.deal_dt < '20250301000000' ) then insert into phub.ph_deal_req_info_pt_2025y02m values (new.*);
	elseif ( new.deal_dt >= '20250301000000' and new.deal_dt < '20250401000000' ) then insert into phub.ph_deal_req_info_pt_2025y03m values (new.*);
	elseif ( new.deal_dt >= '20250401000000' and new.deal_dt < '20250501000000' ) then insert into phub.ph_deal_req_info_pt_2025y04m values (new.*);
	elseif ( new.deal_dt >= '20250501000000' and new.deal_dt < '20250601000000' ) then insert into phub.ph_deal_req_info_pt_2025y05m values (new.*);
	elseif ( new.deal_dt >= '20250601000000' and new.deal_dt < '20250701000000' ) then insert into phub.ph_deal_req_info_pt_2025y06m values (new.*);
	elseif ( new.deal_dt >= '20250701000000' and new.deal_dt < '20250801000000' ) then insert into phub.ph_deal_req_info_pt_2025y07m values (new.*);
	elseif ( new.deal_dt >= '20250801000000' and new.deal_dt < '20250901000000' ) then insert into phub.ph_deal_req_info_pt_2025y08m values (new.*);
	elseif ( new.deal_dt >= '20250901000000' and new.deal_dt < '20251001000000' ) then insert into phub.ph_deal_req_info_pt_2025y09m values (new.*);
	elseif ( new.deal_dt >= '20251001000000' and new.deal_dt < '20251101000000' ) then insert into phub.ph_deal_req_info_pt_2025y10m values (new.*);
	elseif ( new.deal_dt >= '20251101000000' and new.deal_dt < '20251201000000' ) then insert into phub.ph_deal_req_info_pt_2025y11m values (new.*);
	elseif ( new.deal_dt >= '20251201000000' and new.deal_dt < '20260101000000' ) then insert into phub.ph_deal_req_info_pt_2025y12m values (new.*);
	elseif ( new.deal_dt >= '20260101000000' and new.deal_dt < '20260201000000' ) then insert into phub.ph_deal_req_info_pt_2026y01m values (new.*);
	elseif ( new.deal_dt >= '20260201000000' and new.deal_dt < '20260301000000' ) then insert into phub.ph_deal_req_info_pt_2026y02m values (new.*);
	elseif ( new.deal_dt >= '20260301000000' and new.deal_dt < '20260401000000' ) then insert into phub.ph_deal_req_info_pt_2026y03m values (new.*);
	elseif ( new.deal_dt >= '20260401000000' and new.deal_dt < '20260501000000' ) then insert into phub.ph_deal_req_info_pt_2026y04m values (new.*);
	elseif ( new.deal_dt >= '20260501000000' and new.deal_dt < '20260601000000' ) then insert into phub.ph_deal_req_info_pt_2026y05m values (new.*);
	elseif ( new.deal_dt >= '20260601000000' and new.deal_dt < '20260701000000' ) then insert into phub.ph_deal_req_info_pt_2026y06m values (new.*);
	elseif ( new.deal_dt >= '20260701000000' and new.deal_dt < '20260801000000' ) then insert into phub.ph_deal_req_info_pt_2026y07m values (new.*);
	elseif ( new.deal_dt >= '20260801000000' and new.deal_dt < '20260901000000' ) then insert into phub.ph_deal_req_info_pt_2026y08m values (new.*);
	elseif ( new.deal_dt >= '20260901000000' and new.deal_dt < '20261001000000' ) then insert into phub.ph_deal_req_info_pt_2026y09m values (new.*);
	elseif ( new.deal_dt >= '20261001000000' and new.deal_dt < '20261101000000' ) then insert into phub.ph_deal_req_info_pt_2026y10m values (new.*);
	elseif ( new.deal_dt >= '20261101000000' and new.deal_dt < '20261201000000' ) then insert into phub.ph_deal_req_info_pt_2026y11m values (new.*);
	elseif ( new.deal_dt >= '20261201000000' and new.deal_dt < '20270101000000' ) then insert into phub.ph_deal_req_info_pt_2026y12m values (new.*);
	else
        raise exception 'date out of range. implement additional partitions';
    end if;
    return null;
end;
$$;

create trigger ph_deal_req_info_part_trigger
    before insert
    on ph_deal_req_info
    for each row
execute procedure ph_deal_req_info_part_func();

create function ph_info_prvd_ag_hist_part_func() returns trigger
    language plpgsql
as
$$
begin
	if ( new.rgst_dt >= '20241001'::timestamp and new.rgst_dt < '20241101'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2024y10m values (new.*);
	elseif ( new.rgst_dt >= '20241101'::timestamp and new.rgst_dt < '20241201'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2024y11m values (new.*);
	elseif ( new.rgst_dt >= '20241201'::timestamp and new.rgst_dt < '20250101'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2024y12m values (new.*);
	elseif ( new.rgst_dt >= '20250101'::timestamp and new.rgst_dt < '20250201'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y01m values (new.*);
	elseif ( new.rgst_dt >= '20250201'::timestamp and new.rgst_dt < '20250301'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y02m values (new.*);
	elseif ( new.rgst_dt >= '20250301'::timestamp and new.rgst_dt < '20250401'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y03m values (new.*);
	elseif ( new.rgst_dt >= '20250401'::timestamp and new.rgst_dt < '20250501'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y04m values (new.*);
	elseif ( new.rgst_dt >= '20250501'::timestamp and new.rgst_dt < '20250601'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y05m values (new.*);
	elseif ( new.rgst_dt >= '20250601'::timestamp and new.rgst_dt < '20250701'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y06m values (new.*);
	elseif ( new.rgst_dt >= '20250701'::timestamp and new.rgst_dt < '20250801'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y07m values (new.*);
	elseif ( new.rgst_dt >= '20250801'::timestamp and new.rgst_dt < '20250901'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y08m values (new.*);
	elseif ( new.rgst_dt >= '20250901'::timestamp and new.rgst_dt < '20251001'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y09m values (new.*);
	elseif ( new.rgst_dt >= '20251001'::timestamp and new.rgst_dt < '20251101'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y10m values (new.*);
	elseif ( new.rgst_dt >= '20251101'::timestamp and new.rgst_dt < '20251201'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y11m values (new.*);
	elseif ( new.rgst_dt >= '20251201'::timestamp and new.rgst_dt < '20260101'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2025y12m values (new.*);
	elseif ( new.rgst_dt >= '20260101'::timestamp and new.rgst_dt < '20260201'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y01m values (new.*);
	elseif ( new.rgst_dt >= '20260201'::timestamp and new.rgst_dt < '20260301'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y02m values (new.*);
	elseif ( new.rgst_dt >= '20260301'::timestamp and new.rgst_dt < '20260401'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y03m values (new.*);
	elseif ( new.rgst_dt >= '20260401'::timestamp and new.rgst_dt < '20260501'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y04m values (new.*);
	elseif ( new.rgst_dt >= '20260501'::timestamp and new.rgst_dt < '20260601'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y05m values (new.*);
	elseif ( new.rgst_dt >= '20260601'::timestamp and new.rgst_dt < '20260701'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y06m values (new.*);
	elseif ( new.rgst_dt >= '20260701'::timestamp and new.rgst_dt < '20260801'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y07m values (new.*);
	elseif ( new.rgst_dt >= '20260801'::timestamp and new.rgst_dt < '20260901'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y08m values (new.*);
	elseif ( new.rgst_dt >= '20260901'::timestamp and new.rgst_dt < '20261001'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y09m values (new.*);
	elseif ( new.rgst_dt >= '20261001'::timestamp and new.rgst_dt < '20261101'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y10m values (new.*);
	elseif ( new.rgst_dt >= '20261101'::timestamp and new.rgst_dt < '20261201'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y11m values (new.*);
	elseif ( new.rgst_dt >= '20261201'::timestamp and new.rgst_dt < '20270101'::timestamp ) then insert into phub.ph_info_prvd_ag_hist_pt_2026y12m values (new.*);
	 else
        raise exception 'date out of range. implement additional partitions';
    end if;
    return null;
end;
$$;

create trigger ph_info_prvd_ag_hist_part_trigger
    before insert
    on ph_info_prvd_ag_hist
    for each row
execute procedure ph_info_prvd_ag_hist_part_func();

create function generate_hashed(plaintext text, salt text) returns text[]
    security definer
    SET search_path = phub, pgcrypto
    language plpgsql
as
$$
DECLARE
	hashed_arrays TEXT[] := '{}'::TEXT[];
	current_value TEXT;
	-- 해시 값을 저장할 변수를 추가하여 중복 계산을 피합니다.	
	v_hashed_value TEXT;
	BEGIN
		/* 조회된 배열을 여러껀으로 만들어야됨 */
		FOR current_value IN
		WITH data AS (
			SELECT plaintext AS text_input
		),
		combinations AS (
			SELECT DISTINCT
			SUBSTRING(text_input FROM start_pos FOR len) AS combination
			FROM data,
			 generate_series(1, length(text_input)) AS start_pos,
			 generate_series(1, length(text_input)) AS len
			WHERE start_pos + len - 1 <= length(text_input)
		)
		SELECT combination FROM combinations
		LOOP
				-- 1. 현재 trigram을 해시 처리합니다.
				-- 반드시 pgcrypto 스키마를 명시
				v_hashed_value := encode(pgcrypto.digest(current_value || salt, 'sha256'),'hex');
						
				-- 2. 배열에 해시 값을 추가합니다.
				hashed_arrays := array_append(hashed_arrays, v_hashed_value);
			END LOOP;
			RETURN hashed_arrays;
		END;
		$$;

create function fnc_cust_ctn_enc(p_cust_id text) returns text
    language plpgsql
as
$$

DECLARE RESULT_VALUE text;

BEGIN
    SELECT CUST_CTN_ENC
    INTO   RESULT_VALUE
    FROM   PH_PNT_CUST_CTN
    WHERE  CUST_ID = P_CUST_ID
    ORDER  BY RGST_DT DESC
    LIMIT  1;

    RETURN RESULT_VALUE;
END;

$$;
