DROP SEQUENCE "SEQ_BUY_ID";
CREATE SEQUENCE "SEQ_BUY_ID" ;

DROP SEQUENCE "SEQ_DIARY_ID";
CREATE SEQUENCE "SEQ_DIARY_ID";

DROP SEQUENCE "SEQ_PLAN_ID";
CREATE SEQUENCE "SEQ_PLAN_ID";



--DROP TABLE "MEMBER" CASCADE CONSTRAINTS;
--DROP TABLE "ITEM" CASCADE CONSTRAINTS;
--DROP TABLE "PLACE" CASCADE CONSTRAINTS;
--DROP TABLE "BUY" CASCADE CONSTRAINTS;
--DROP TABLE "PLAN" CASCADE CONSTRAINTS;
--DROP TABLE "CART" CASCADE CONSTRAINTS;
--DROP TABLE "PLAN_SPOT" CASCADE CONSTRAINTS;
--DROP TABLE "PLAN_STAY" CASCADE CONSTRAINTS;
--DROP TABLE "PLAN_MEMBER" CASCADE CONSTRAINTS;
--DROP TABLE "AREA" CASCADE CONSTRAINTS;
--DROP TABLE "PLAN_SCHEDULE" CASCADE CONSTRAINTS;
--DROP TABLE "DIARY" CASCADE CONSTRAINTS;
--DROP TABLE "PLACE_MOVE_TIME" CASCADE CONSTRAINTS;
--DROP TABLE "DIARY_LIKES" CASCADE CONSTRAINTS;
--DROP TABLE "DIARY_REPORTS" CASCADE CONSTRAINTS;

DROP TABLE "DIARY_REPORTS";
DROP TABLE "DIARY_LIKES";
DROP TABLE "DIARY";

DROP TABLE "BUY";
DROP TABLE "CART";
DROP TABLE "ITEM";

DROP TABLE "PLACE_MOVE_TIME";
DROP TABLE "PLAN_SPOT";
DROP TABLE "PLAN_STAY";
DROP TABLE "PLAN_SCHEDULE";
DROP TABLE "PLAN_MEMBER";
DROP TABLE "PLACE";
DROP TABLE "PLAN";
DROP TABLE "AREA";

DROP TABLE "LOG";
DROP TABLE "QUIT_MEMBER";
DROP TABLE "MEMBER";


CREATE TABLE "MEMBER" (
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"MEM_NICK"	NVARCHAR2(8)		NOT NULL    UNIQUE,
	"MEM_PASSWORD"	VARCHAR2(100)		NOT NULL,
	"MEM_ROLE"	VARCHAR2(30)		NOT NULL,
	"MEM_ENABLED"	NUMBER	DEFAULT 1	NOT NULL,
	"MEM_TYPE"	VARCHAR2(20)		NOT NULL,
	"MEM_JOIN_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEM_BIRTH"	DATE		NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEM_EMAIL" IS '이메일';

COMMENT ON COLUMN "MEMBER"."MEM_NICK" IS '회원 닉네임(한글 2~8자), UNIQUE';

COMMENT ON COLUMN "MEMBER"."MEM_PASSWORD" IS '비밀번호 (영문 대문자, 소문자, 숫자 포함 8~20자)';

COMMENT ON COLUMN "MEMBER"."MEM_ROLE" IS '회원 권한 등급 [일반회원(MEM), 폰트 적용 회원(VIP), 관리자(ADMIN), 소유자(OWNER)]';

COMMENT ON COLUMN "MEMBER"."MEM_ENABLED" IS '활성 여부 [비활성(0), 활성(1)]';

COMMENT ON COLUMN "MEMBER"."MEM_TYPE" IS 'SNS 여부 [이메일(T), 카카오(K), 네이버(N), 구글(G)]';

COMMENT ON COLUMN "MEMBER"."MEM_JOIN_DATE" IS '가입날짜';

COMMENT ON COLUMN "MEMBER"."MEM_BIRTH" IS '생일';

CREATE TABLE "QUIT_MEMBER" (
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"MEM_NICK"	NVARCHAR2(8)		NOT NULL,
	"MEM_ROLE"	VARCHAR2(30)		NOT NULL,
	"MEM_ENABLED"	NUMBER	DEFAULT 1	NOT NULL,
	"MEM_TYPE"	VARCHAR2(20)		NOT NULL,
	"MEM_JOIN_DATE"	DATE		NOT NULL,
	"MEM_QUIT_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEM_BIRTH"	DATE		NOT NULL
);

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_EMAIL" IS '이메일';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_NICK" IS '회원 닉네임(한글 2~8자)';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_ROLE" IS '회원 권한 등급 [휴면회원(ROLE_SLEEP), 일반회원(ROLE_MEM), 폰트적용회원(ROLE_VIP), 관리자(ROLE_ADMIN), 소유자(ROLE_OWNER)]';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_ENABLED" IS '활성 여부 [비활성(0), 활성(1)]';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_TYPE" IS 'SNS 여부[이메일(T), 카카오(K), 네이버(N), 구글(G)]';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_JOIN_DATE" IS '가입날짜';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_QUIT_DATE" IS '탈퇴날짜';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_BIRTH" IS '생일';

CREATE TABLE "LOG" (
	"LOG_TIME"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"LOG_IP"	VARCHAR2(30)		NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"LOG_TF"	CHAR(1)		NOT NULL
);

COMMENT ON COLUMN "LOG"."LOG_TIME" IS '로그인 시간';

COMMENT ON COLUMN "LOG"."LOG_IP" IS '로그인 IPv4(000:000:000:000)';

COMMENT ON COLUMN "LOG"."MEM_EMAIL" IS '이메일';

COMMENT ON COLUMN "LOG"."LOG_TF" IS '로그인 성공 여부[T, F]';

CREATE TABLE "BUY" (
	"BUY_ID"	NUMBER		NOT NULL,
	"BUY_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"BUY_ITEM_CODE"	VARCHAR2(20)		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NULL,
	"BUY_EXP"	DATE	DEFAULT SYSDATE	NULL
);

COMMENT ON COLUMN "BUY"."BUY_ID" IS '구매내역 ID';

COMMENT ON COLUMN "BUY"."BUY_DATE" IS '구매일자';

COMMENT ON COLUMN "BUY"."BUY_ITEM_CODE" IS '상품코드(폰트 2개, 테마 10개)';

COMMENT ON COLUMN "BUY"."MEM_EMAIL" IS '이메일';

COMMENT ON COLUMN "BUY"."BUY_EXP" IS '만료일자';

CREATE TABLE "ITEM" (
	"ITEM_CODE"	VARCHAR2(20)		NOT NULL,
	"ITEM_NAME"	VARCHAR2(1000)		NOT NULL,
	"ITEM_PRICE"	NUMBER		NOT NULL,
	"ITEM_DUR"	NUMBER		NULL, 
    "ITEM_SALE"	NUMBER		NULL
);

COMMENT ON COLUMN "ITEM"."ITEM_CODE" IS '상품코드(폰트 2개, 테마 10개)';

COMMENT ON COLUMN "ITEM"."ITEM_NAME" IS '상품명';

COMMENT ON COLUMN "ITEM"."ITEM_PRICE" IS '상품가격';

COMMENT ON COLUMN "ITEM"."ITEM_DUR" IS '상품기간';

COMMENT ON COLUMN "ITEM"."ITEM_SALE" IS '상품할인율';

CREATE TABLE "PLACE" (
	"TYPE"	NUMBER		NOT NULL,
	"CONTENTID"	NUMBER		NOT NULL,
	"CONTENTTYPEID"	VARCHAR2(10)		NOT NULL,
	"ADD1"	VARCHAR2(500)		NOT NULL,
	"ADD2"	VARCHAR2(100)		NULL,
	"AREACODE"	NUMBER		NOT NULL,
	"BOOKTOUR"	VARCHAR2(10)		NULL,
	"CAT1"	VARCHAR2(3)		NOT NULL,
	"CAT2"	VARCHAR2(5)		NOT NULL,
	"CAT3"	VARCHAR2(9)		NOT NULL,
	"FIRSTIMAGE"	VARCHAR2(1000)		NULL,
	"FIRSTIMAGE2"	VARCHAR2(1000)		NULL,
	"CPYRHT_DIV_CD"	VARCHAR2(10)		NULL,
	"MAPX"	VARCHAR2(50)		NOT NULL,
	"MAPY"	VARCHAR2(50)		NOT NULL,
	"CREATETIME"	VARCHAR2(30)		NULL,
	"MLEVEL"	CHAR(2)		NULL,
	"SIGUNGUCODE"	VARCHAR2(2)		NULL,
	"TEL"	NVARCHAR2(40)		NULL,
	"TITLE"	VARCHAR2(500)		NOT NULL,
	"MODIFIEDTIME"	VARCHAR2(30)		NULL,
	"GETTIME"	VARCHAR2(30)	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "PLACE"."TYPE" IS '장소 타입(필요한것만 분류, 나머지 10)';

COMMENT ON COLUMN "PLACE"."CONTENTID" IS '장소 ID';

COMMENT ON COLUMN "PLACE"."CONTENTTYPEID" IS '관광타입(12:관광지, 14:문화시설, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점)';

COMMENT ON COLUMN "PLACE"."ADD1" IS '주소(예, 서울중구다동)를응답';

COMMENT ON COLUMN "PLACE"."ADD2" IS '상세주소';

COMMENT ON COLUMN "PLACE"."AREACODE" IS '지역코드';

COMMENT ON COLUMN "PLACE"."BOOKTOUR" IS '교과서속여행지여부 (1=여행지, 0=해당없음)';

COMMENT ON COLUMN "PLACE"."CAT1" IS '대분류';

COMMENT ON COLUMN "PLACE"."CAT2" IS '중분류';

COMMENT ON COLUMN "PLACE"."CAT3" IS '소분류 (캠핑장)';

COMMENT ON COLUMN "PLACE"."FIRSTIMAGE" IS '원본대표이미지';

COMMENT ON COLUMN "PLACE"."FIRSTIMAGE2" IS '썸네일대표이미지';

COMMENT ON COLUMN "PLACE"."CPYRHT_DIV_CD" IS '저작권 유형(Type1:제1유형(출처표시-권장) Type3:제3유형(제1유형 + 변경금지))';

COMMENT ON COLUMN "PLACE"."MAPX" IS 'GPS X좌표(WGS84 경도좌표) 응답';

COMMENT ON COLUMN "PLACE"."MAPY" IS 'GPS Y좌표(WGS84 위도좌표) 응답';

COMMENT ON COLUMN "PLACE"."CREATETIME" IS '콘텐츠최초등록일';

COMMENT ON COLUMN "PLACE"."MLEVEL" IS '지도확대레벨';

COMMENT ON COLUMN "PLACE"."SIGUNGUCODE" IS '시군구코드';

COMMENT ON COLUMN "PLACE"."TEL" IS '전화번호';

COMMENT ON COLUMN "PLACE"."TITLE" IS '콘텐츠제목';

COMMENT ON COLUMN "PLACE"."MODIFIEDTIME" IS '콘텐츠수정일';

COMMENT ON COLUMN "PLACE"."GETTIME" IS 'API 가져온 시각';

CREATE TABLE "PLAN" (
	"PLAN_ID"	NUMBER		NOT NULL,
	"PLAN_AREA_CODE"	NUMBER		NOT NULL,
	"PLAN_TITLE"	VARCHAR2(100)		NOT NULL,
	"PLAN_START_DAY"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PLAN_END_DAY"	DATE	DEFAULT SYSDATE	NULL,
	"PLAN_MAKE_DAY"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PLAN_DELETE_DAY"	DATE	DEFAULT SYSDATE	NULL
);

COMMENT ON COLUMN "PLAN"."PLAN_ID" IS '일정 ID';

COMMENT ON COLUMN "PLAN"."PLAN_AREA_CODE" IS '지역 코드(1~17)';

COMMENT ON COLUMN "PLAN"."PLAN_TITLE" IS '일정 제목';

COMMENT ON COLUMN "PLAN"."PLAN_START_DAY" IS '시작날짜';

COMMENT ON COLUMN "PLAN"."PLAN_END_DAY" IS '종료날짜';

COMMENT ON COLUMN "PLAN"."PLAN_MAKE_DAY" IS '생성일자';

COMMENT ON COLUMN "PLAN"."PLAN_DELETE_DAY" IS '삭제일자';

CREATE TABLE "CART" (
	"ITEM_CODE"	VARCHAR2(20)		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NULL
);

COMMENT ON COLUMN "CART"."ITEM_CODE" IS '상품코드(10개)';

COMMENT ON COLUMN "CART"."MEM_EMAIL" IS '이메일';

CREATE TABLE "PLAN_SPOT" (
	"SPOT_DAY"	DATE		NOT NULL,
	"SPOT_PLAN_ID"	NUMBER		NOT NULL,
	"SPOT_TYPE"	NUMBER		NOT NULL,
	"SPOT_CONTENTID"	NUMBER		NOT NULL,
	"SPOT_ORDER"	NUMBER		NULL,
	"SPOT_STAY_TIME"	VARCHAR2(50)	DEFAULT 7200	NULL,
	"SPOT_MEMO"	VARCHAR2(300)		NULL
);

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_DAY" IS '방문 날짜';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_PLAN_ID" IS '일정ID';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_TYPE" IS '장소 타입(필요한것만 분류, 나머지 0)';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_CONTENTID" IS '장소 ID';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_ORDER" IS '일별 장소 방문순서';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_STAY_TIME" IS '머무는 시간 초단위 (기본2시간)';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_MEMO" IS '메모(최대100자)';

CREATE TABLE "PLAN_STAY" (
	"STAY_DAY"	DATE		NOT NULL,
	"STAY_PLAN_ID"	NUMBER		NOT NULL,
	"STAY_CONTENTID"	NUMBER		NOT NULL,
	"STAY_TYPE"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "PLAN_STAY"."STAY_DAY" IS '해당 날짜N번째일자';

COMMENT ON COLUMN "PLAN_STAY"."STAY_PLAN_ID" IS '일정ID';

COMMENT ON COLUMN "PLAN_STAY"."STAY_CONTENTID" IS '장소 ID';

COMMENT ON COLUMN "PLAN_STAY"."STAY_TYPE" IS '장소 타입(필요한것만 분류, 나머지 0)';

CREATE TABLE "PLAN_MEMBER" (
	"PLAN_ID"	NUMBER		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"PLAN_MEM_ROLE"	CHAR(1)		NOT NULL
);

COMMENT ON COLUMN "PLAN_MEMBER"."PLAN_ID" IS '일정 ID';

COMMENT ON COLUMN "PLAN_MEMBER"."MEM_EMAIL" IS '이메일';

COMMENT ON COLUMN "PLAN_MEMBER"."PLAN_MEM_ROLE" IS '권한 [생성자(1) /  공유자(0)]';

CREATE TABLE "AREA" (
	"AREA_CODE"	NUMBER		NOT NULL,
	"AREA_NAME"	VARCHAR2(50)		NOT NULL,
	"AREA_SHORT_NAME"	VARCHAR2(10)		NOT NULL,
	"AREA_ENG_NAME"	VARCHAR2(50)		NOT NULL,
	"AREA_FILE_NAME"	VARCHAR2(50)		NOT NULL,
	"AREA_LANDMARK"	VARCHAR2(50)		NOT NULL,
	"AREA_X"	VARCHAR2(50)		NOT NULL,
	"AREA_Y"	VARCHAR2(50)		NOT NULL,
	"AREA_EXPLAIN"	VARCHAR2(1000)		NOT NULL
);

COMMENT ON COLUMN "AREA"."AREA_CODE" IS '지역 코드(1~17)';

COMMENT ON COLUMN "AREA"."AREA_NAME" IS '지역명';

COMMENT ON COLUMN "AREA"."AREA_SHORT_NAME" IS '지역 약어(2글자)';

COMMENT ON COLUMN "AREA"."AREA_ENG_NAME" IS '지역 영문명';

COMMENT ON COLUMN "AREA"."AREA_FILE_NAME" IS '지역 이미지 파일명';

COMMENT ON COLUMN "AREA"."AREA_LANDMARK" IS '대표 장소명';

COMMENT ON COLUMN "AREA"."AREA_X" IS 'X좌표lng';

COMMENT ON COLUMN "AREA"."AREA_Y" IS 'Y좌표lat';

COMMENT ON COLUMN "AREA"."AREA_EXPLAIN" IS '지역 설명';

CREATE TABLE "PLAN_SCHEDULE" (
	"SCHEDULE_DAY"	DATE		NOT NULL,
	"SCHEDULE_PLAN_ID"	NUMBER		NOT NULL,
	"SCHEDULE_START"	DATE		NOT NULL,
	"SCHEDULE_END"	DATE		NOT NULL
);

COMMENT ON COLUMN "PLAN_SCHEDULE"."SCHEDULE_DAY" IS '여행 날짜';

COMMENT ON COLUMN "PLAN_SCHEDULE"."SCHEDULE_PLAN_ID" IS '일정ID';

COMMENT ON COLUMN "PLAN_SCHEDULE"."SCHEDULE_START" IS '일별 여행 시작 시간';

COMMENT ON COLUMN "PLAN_SCHEDULE"."SCHEDULE_END" IS '일별 여행 종료 시간';

CREATE TABLE "DIARY" (
	"DIARY_ID"	NUMBER		NOT NULL,
	"DIARY_MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"DIARY_PLAN_ID"	NUMBER		NOT NULL,
	"DIARY_TITLE"	VARCHAR2(100)		NOT NULL,
	"DIARY_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"DIARY_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"DIARY_OPEN"	CHAR(1)	DEFAULT 1	NOT NULL,
	"DIARY_VIEWS"	NUMBER		NULL,
	"DIARY_THEME"	VARCHAR2(50)		NULL
);

COMMENT ON COLUMN "DIARY"."DIARY_ID" IS '여행기 ID';

COMMENT ON COLUMN "DIARY"."DIARY_MEM_EMAIL" IS '이메일';

COMMENT ON COLUMN "DIARY"."DIARY_PLAN_ID" IS '일정 ID';

COMMENT ON COLUMN "DIARY"."DIARY_TITLE" IS '게시글 타이틀';

COMMENT ON COLUMN "DIARY"."DIARY_CONTENT" IS '게시글 내용';

COMMENT ON COLUMN "DIARY"."DIARY_DATE" IS '글 작성 날짜';

COMMENT ON COLUMN "DIARY"."DIARY_OPEN" IS '공개 여부 1이면 공개 0이면 비공개';

COMMENT ON COLUMN "DIARY"."DIARY_VIEWS" IS '조회수';

COMMENT ON COLUMN "DIARY"."DIARY_THEME" IS '테마';

CREATE TABLE "PLACE_MOVE_TIME" (
	"MOVE_TIME"	VARCHAR2(50)		NOT NULL,
	"TYPE_START"	NUMBER		NOT NULL,
	"CONTENTID_START"	NUMBER		NOT NULL,
	"TYPE_END"	NUMBER		NOT NULL,
	"CONTENTID_END"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "PLACE_MOVE_TIME"."MOVE_TIME" IS '소요시간';

COMMENT ON COLUMN "PLACE_MOVE_TIME"."TYPE_START" IS '출발 장소 타입(필요한것만 분류, 나머지 10)';

COMMENT ON COLUMN "PLACE_MOVE_TIME"."CONTENTID_START" IS '출발  장소 ID';

COMMENT ON COLUMN "PLACE_MOVE_TIME"."TYPE_END" IS '도착 장소 타입(필요한것만 분류, 나머지 10)';

COMMENT ON COLUMN "PLACE_MOVE_TIME"."CONTENTID_END" IS '도착 장소 ID';

CREATE TABLE "DIARY_LIKES" (
	"DIARY_ID"	NUMBER		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "DIARY_LIKES"."DIARY_ID" IS '여행기 ID';

COMMENT ON COLUMN "DIARY_LIKES"."MEM_EMAIL" IS '좋아요를 남긴 회원 이메일';

CREATE TABLE "DIARY_REPORTS" (
	"DIARY_ID"	NUMBER		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"REPORT_STATE"	CHAR(1)	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "DIARY_REPORTS"."DIARY_ID" IS '여행기 ID';

COMMENT ON COLUMN "DIARY_REPORTS"."MEM_EMAIL" IS '신고하기남긴 회원 이메일';

COMMENT ON COLUMN "DIARY_REPORTS"."REPORT_STATE" IS '게시글 상태(일반 1, 제한됨 0 )';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEM_EMAIL"
);

ALTER TABLE "LOG" ADD CONSTRAINT "PK_LOG" PRIMARY KEY (
	"LOG_TIME",
	"LOG_IP",
	"MEM_EMAIL"
);

ALTER TABLE "LOG" ADD CONSTRAINT "FK_MEMBER_TO_LOG_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
);

ALTER TABLE "BUY" ADD CONSTRAINT "PK_BUY" PRIMARY KEY (
	"BUY_ID",
	"BUY_DATE",
	"BUY_ITEM_CODE"
);

ALTER TABLE "ITEM" ADD CONSTRAINT "PK_ITEM" PRIMARY KEY (
	"ITEM_CODE"
);

ALTER TABLE "PLACE" ADD CONSTRAINT "PK_PLACE" PRIMARY KEY (
	"TYPE",
	"CONTENTID"
);

ALTER TABLE "PLAN" ADD CONSTRAINT "PK_PLAN" PRIMARY KEY (
	"PLAN_ID"
);

ALTER TABLE "CART" ADD CONSTRAINT "PK_CART" PRIMARY KEY (
	"ITEM_CODE"
);

ALTER TABLE "PLAN_SPOT" ADD CONSTRAINT "PK_PLAN_SPOT" PRIMARY KEY (
	"SPOT_DAY",
	"SPOT_PLAN_ID",
	"SPOT_TYPE",
	"SPOT_CONTENTID"
);

ALTER TABLE "PLAN_STAY" ADD CONSTRAINT "PK_PLAN_STAY" PRIMARY KEY (
	"STAY_DAY",
	"STAY_PLAN_ID"
);

ALTER TABLE "PLAN_MEMBER" ADD CONSTRAINT "PK_PLAN_MEMBER" PRIMARY KEY (
	"PLAN_ID",
	"MEM_EMAIL"
);

ALTER TABLE "AREA" ADD CONSTRAINT "PK_AREA" PRIMARY KEY (
	"AREA_CODE"
);

ALTER TABLE "PLAN_SCHEDULE" ADD CONSTRAINT "PK_PLAN_SCHEDULE" PRIMARY KEY (
	"SCHEDULE_DAY",
	"SCHEDULE_PLAN_ID"
);

ALTER TABLE "DIARY" ADD CONSTRAINT "PK_DIARY" PRIMARY KEY (
	"DIARY_ID"
);

ALTER TABLE "DIARY_LIKES" ADD CONSTRAINT "PK_DIARY_LIKES" PRIMARY KEY (
	"DIARY_ID"
);

ALTER TABLE "DIARY_REPORTS" ADD CONSTRAINT "PK_DIARY_REPORTS" PRIMARY KEY (
	"DIARY_ID"
);

ALTER TABLE "BUY" ADD CONSTRAINT "FK_ITEM_TO_BUY_1" FOREIGN KEY (
	"BUY_ITEM_CODE"
)
REFERENCES "ITEM" (
	"ITEM_CODE"
);

ALTER TABLE "BUY" ADD CONSTRAINT "FK_MEMBER_TO_BUY_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
);

ALTER TABLE "PLAN" ADD CONSTRAINT "FK_AREA_TO_PLAN_1" FOREIGN KEY (
	"PLAN_AREA_CODE"
)
REFERENCES "AREA" (
	"AREA_CODE"
);

ALTER TABLE "CART" ADD CONSTRAINT "FK_ITEM_TO_CART_1" FOREIGN KEY (
	"ITEM_CODE"
)
REFERENCES "ITEM" (
	"ITEM_CODE"
);

ALTER TABLE "CART" ADD CONSTRAINT "FK_MEMBER_TO_CART_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
);

-- ORA-02270
ALTER TABLE "PLAN_SPOT" ADD CONSTRAINT "FK_PLAN_SCHEDULE_TO_PLAN_SPOT_1" FOREIGN KEY (
	"SPOT_DAY", "SPOT_PLAN_ID"
)
REFERENCES "PLAN_SCHEDULE" (
	"SCHEDULE_DAY", "SCHEDULE_PLAN_ID"
);

-- ORA-02270
ALTER TABLE "PLAN_SPOT" ADD CONSTRAINT "FK_PLACE_TO_PLAN_SPOT_1" FOREIGN KEY (
	"SPOT_TYPE", "SPOT_CONTENTID"
)
REFERENCES "PLACE" (
	"TYPE", "CONTENTID"
);

-- ORA-02270
ALTER TABLE "PLAN_STAY" ADD CONSTRAINT "FK_PLAN_SCHEDULE_TO_PLAN_STAY_1" FOREIGN KEY (
	"STAY_DAY", "STAY_PLAN_ID"
)
REFERENCES "PLAN_SCHEDULE" (
	"SCHEDULE_DAY", "SCHEDULE_PLAN_ID"
);

--ORA-02270
ALTER TABLE "PLAN_STAY" ADD CONSTRAINT "FK_PLACE_TO_PLAN_STAY_1" FOREIGN KEY (
	"STAY_CONTENTID", "STAY_TYPE"
)
REFERENCES "PLACE" (
	"CONTENTID", "TYPE"
);

ALTER TABLE "PLAN_MEMBER" ADD CONSTRAINT "FK_PLAN_TO_PLAN_MEMBER_1" FOREIGN KEY (
	"PLAN_ID"
)
REFERENCES "PLAN" (
	"PLAN_ID"
);

ALTER TABLE "PLAN_MEMBER" ADD CONSTRAINT "FK_MEMBER_TO_PLAN_MEMBER_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
);

ALTER TABLE "PLAN_SCHEDULE" ADD CONSTRAINT "FK_PLAN_TO_PLAN_SCHEDULE_1" FOREIGN KEY (
	"SCHEDULE_PLAN_ID"
)
REFERENCES "PLAN" (
	"PLAN_ID"
);

ALTER TABLE "DIARY" ADD CONSTRAINT "FK_MEMBER_TO_DIARY_1" FOREIGN KEY (
	"DIARY_MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
);

ALTER TABLE "DIARY" ADD CONSTRAINT "FK_PLAN_TO_DIARY_1" FOREIGN KEY (
	"DIARY_PLAN_ID"
)
REFERENCES "PLAN" (
	"PLAN_ID"
);

-- ORA-02270
ALTER TABLE "PLACE_MOVE_TIME" ADD CONSTRAINT "FK_PLACE_TO_PLACE_MOVE_TIME_1" FOREIGN KEY (
	"CONTENTID_START", "TYPE_START"
)
REFERENCES "PLACE" (
	"CONTENTID", "TYPE"
);

ALTER TABLE "PLACE_MOVE_TIME" ADD CONSTRAINT "FK_PLACE_TO_PLACE_MOVE_TIME_2" FOREIGN KEY (
	"CONTENTID_END", "TYPE_END"
)
REFERENCES "PLACE" (
	"CONTENTID", "TYPE"
);

ALTER TABLE "DIARY_LIKES" ADD CONSTRAINT "FK_DIARY_TO_DIARY_LIKES_1" FOREIGN KEY (
	"DIARY_ID"
)
REFERENCES "DIARY" (
	"DIARY_ID"
);

ALTER TABLE "DIARY_LIKES" ADD CONSTRAINT "FK_MEMBER_TO_DIARY_LIKES_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
);

ALTER TABLE "DIARY_REPORTS" ADD CONSTRAINT "FK_DIARY_TO_DIARY_REPORTS_1" FOREIGN KEY (
	"DIARY_ID"
)
REFERENCES "DIARY" (
	"DIARY_ID"
);

ALTER TABLE "DIARY_REPORTS" ADD CONSTRAINT "FK_MEMBER_TO_DIARY_REPORTS_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
);


-- 회원 탈퇴 시 insert into quit_member-> delete from member
create or replace NONEDITIONABLE TRIGGER trg_member_quit
    BEFORE delete ON member
    REFERENCING OLD AS OLD
    FOR EACH ROW
DECLARE
BEGIN
   insert into quit_member values (
   :OLD.MEM_EMAIL, 
   :OLD.MEM_NICK, 
   :OLD.MEM_ROLE, 
   :OLD.MEM_ENABLED, 
   :OLD.MEM_TYPE, 
   :OLD.MEM_JOIN_DATE, 
   default, 
   :OLD.MEM_BIRTH
   );
END;
/