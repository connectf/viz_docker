
DROP DATABASE IF EXISTS viz_backend;

CREATE DATABASE IF NOT EXISTS viz_backend CHARACTER SET = utf8;

USE viz_backend;

# data source maintain 
CREATE TABLE datasource
(
	id VARCHAR(128) PRIMARY KEY,
	name VARCHAR(128) UNIQUE,
	dataSourceType VARCHAR(128),
	dataSourceDescription VARCHAR(512),
	registerDate DATE
);

# data source location linked to data source
CREATE TABLE datasourcelocation
(
	id VARCHAR(128) PRIMARY KEY,
	name VARCHAR(128),
	dataSourceId VARCHAR(128),
	dataSourceType VARCHAR(128),
	ip VARCHAR(128),
	port INTEGER,
	databaseName VARCHAR(128),
	userName VARCHAR(64),
	password VARCHAR(64),
	parameters VARCHAR(1024)
);

CREATE INDEX INDEX_DATASOURCELOCATION_ON_DATASOURCEID ON datasourcelocation(dataSourceId);

CREATE TABLE dataset
(
	id VARCHAR(128) PRIMARY KEY,
	name VARCHAR(128),
	dataSourceId VARCHAR(128),
	dataSourceName VARCHAR(128),
	dataSetType VARCHAR(64),
	dataSetDescription VARCHAR(512)
);

CREATE INDEX INDEX_DATASET_ON_DATASOURCEID ON dataset(dataSourceId);

CREATE TABLE attribute
(
	id VARCHAR(128) PRIMARY KEY,
	dataSourceId VARCHAR(128),
	dataSetId VARCHAR(128),
	seqno INTEGER,
	name VARCHAR(128),
	attributeDataType VARCHAR(32),
	attributeDataTypeId INTEGER
);

CREATE INDEX INDEX_ATTRIBUTE_ON_DATASOURCEID_DATASETID ON attribute(dataSourceId, dataSetId);

CREATE TABLE user
(
	id VARCHAR(128) NOT NULL,
	name VARCHAR(128) PRIMARY KEY,
	password VARCHAR(128),
	email VARCHAR(128),
	description VARCHAR(512),
	userGroupId VARCHAR(128),
	userRole VARCHAR(128),
	registerDate DATE,
	lastLogonDate DATE,
	enabled TINYINT NOT NULL DEFAULT 1
);

CREATE INDEX INDEX_USER_ON_USERGROUPID ON user(userGroupId);
CREATE INDEX INDEX_USER_ON_ID ON user(id);

INSERT INTO user(id,name,password,email,description,userGroupId,userRole,registerDate,lastLogonDate,enabled) VALUES('admin-user-id','admin','admin','admin@admin.com','build-in admin user','admin-group-id','ROLE_ADMIN',CURDATE(),CURDATE(),true);
INSERT INTO user(id,name,password,email,description,userGroupId,userRole,registerDate,lastLogonDate,enabled) VALUES('test-user-id','test','test','test@test.com','build-in test user','public-group-id','ROLE_USER',CURDATE(),CURDATE(),true);
INSERT INTO user(id,name,password,email,description,userGroupId,userRole,registerDate,lastLogonDate,enabled) VALUES('alex-user-id','alex','123456','alex@test.com','build-in test user','public-group-id','ROLE_USER',CURDATE(),CURDATE(),true);
INSERT INTO user(id,name,password,email,description,userGroupId,userRole,registerDate,lastLogonDate,enabled) VALUES('mkyong-user-id','mkyong','123456','test@test.com','build-in test user','public-group-id','ROLE_ADMIN',CURDATE(),CURDATE(),true);



CREATE TABLE userrole (
	id INT(11) NOT NULL AUTO_INCREMENT,
	userid VARCHAR(128) NOT NULL,
	username VARCHAR(128) NOT NULL,
	role VARCHAR(128) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY uni_username_role (role,username),
	KEY fk_username_idx (username),
	CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES user (name)
);

INSERT INTO userrole (userid, username, role)VALUES ('admin-user-id', 'admin', 'ROLE_ADMIN');
INSERT INTO userrole (userid, username, role)VALUES ('mkyong-user-id', 'mkyong', 'ROLE_ADMIN');
INSERT INTO userrole (userid, username, role)VALUES ('alex-user-id', 'alex', 'ROLE_USER');
INSERT INTO userrole (userid, username, role)VALUES ('test-user-id','test', 'ROLE_USER');


CREATE TABLE usergroup
(
	id VARCHAR(128) PRIMARY KEY,
	name VARCHAR(128) UNIQUE,
	userGroupDescription VARCHAR(512),
	registerDate DATE
);

INSERT INTO usergroup(id, name, userGroupDescription,registerDate) VALUES('admin-group-id','AdminGroup','This is the admin group',CURDATE());
INSERT INTO usergroup(id, name, userGroupDescription,registerDate) VALUES('public-group-id','PublicGroup','This is the public group',CURDATE());

CREATE TABLE usergroupprivilege
(
	id VARCHAR(128) PRIMARY KEY,
	name VARCHAR(128),
	userGroupId VARCHAR(128),
	userGroupName VARCHAR(128),
	dataSourceId VARCHAR(128),
	dataSourceName VARCHAR(128),
	privilege VARCHAR(128),
	CONSTRAINT UserGroupNameDataSourceName_C UNIQUE (userGroupName,dataSourceName)
);

CREATE INDEX INDEX_USERGROUPPRIVILEGE_ON_USERGROUPID ON usergroupprivilege(userGroupId);
CREATE INDEX INDEX_USERGROUPPRIVILEGE_ON_DATASOURCEID ON usergroupprivilege(dataSourceId);


create table attributeuserlocal
(
	id VARCHAR(128) PRIMARY KEY,

	datasourceid VARCHAR(128),
	datasourcename VARCHAR(128),

	datasetid VARCHAR(128),
	datasetname VARCHAR(128),

	attributeid VARCHAR(128),
	attributeName VARCHAR(128),

	userid VARCHAR(128),
	username VARCHAR(128),

	properties VARCHAR(2048)
);

CREATE INDEX INDEX_ATTRIBUTEUSERLOCAL_ON_DATASETID ON attributeuserlocal(datasetid);
CREATE INDEX INDEX_ATTRIBUTEUSERLOCAL_ON_ATTRIBUTEID ON attributeuserlocal(attributeid);
CREATE INDEX INDEX_ATTRIBUTEUSERLOCAL_ON_USERID ON attributeuserlocal(userid);

CREATE TABLE datacategory
(
	id VARCHAR(128),
	name VARCHAR(128),
	format VARCHAR(256),
	example VARCHAR(256)
);

INSERT INTO datacategory(id, name, format, example) VALUES('IP_ADDRESS', 'IP', 'xxx.xxx.xxx.xxx,其中xxx为0~255','127.0.0.1');
INSERT INTO datacategory(id, name, format, example) VALUES('NATION_NAME','国家名称(中文)','国家名称字符串','中国，中华人民共和国');
INSERT INTO datacategory(id, name, format, example) VALUES('LONGITUDE','经度','xx.xx','12.34');
INSERT INTO datacategory(id, name, format, example) VALUES('LATITUDE','维度','xx.xx','12.34');
INSERT INTO datacategory(id, name, format, example) VALUES('MOBILE_PHONE','移动电话','1397247XXXX','1397247XXXX');
INSERT INTO datacategory(id, name, format, example) VALUES('FIX_PHONE','固定电话','区号+号码','0102233XXXX');
INSERT INTO datacategory(id, name, format, example) VALUES('CHINA_PROVINCE','中国省市自治区','浙江','上海');
INSERT INTO datacategory(id, name, format, example) VALUES('CHINA_CITY','中国城市','杭州','宁波');
INSERT INTO datacategory(id, name, format, example) VALUES('DEFAULT','默认','默认','默认');








