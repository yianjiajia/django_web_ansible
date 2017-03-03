/*

SQLyog Community v8.4
MySQL - 5.5.41-MariaDB : Database - devops

*********************************************************************

*/



/*!40101 SET NAMES utf8 */;


/*!40101 SET SQL_MODE = '' */;


/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;

/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS */`devops` /*!40100 DEFAULT CHARACTER SET utf8
  COLLATE utf8_unicode_ci */;


USE `devops`;


/*Table structure for table `agent` */



DROP TABLE IF EXISTS `account_profile`;

CREATE TABLE account_profile
(
  id           INTEGER PRIMARY KEY NOT NULL,
  user_id      INTEGER             NOT NULL,
  cn_name      TEXT,
  ssh_password TEXT,
  ssh_key      TEXT,
  phonenum     TEXT,
  KEY `FK_Reference_1` (`user_id`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `ansible_credential`;

CREATE TABLE ansible_credential
(
  id             INTEGER PRIMARY KEY NOT NULL,
  description    TEXT                NOT NULL,
  created_by_id  INTEGER,
  creation_date  TEXT                NOT NULL,
  active         INTEGER             NOT NULL,
  name           TEXT                NOT NULL,
  user_id        INTEGER,
  ssh_username   TEXT                NOT NULL,
  ssh_password   TEXT                NOT NULL,
  ssh_key_data   TEXT                NOT NULL,
  ssh_key_unlock TEXT                NOT NULL,
  sudo_username  TEXT                NOT NULL,
  sudo_password  TEXT                NOT NULL,
  KEY `FK_Reference_2` (`created_by_id`),
  KEY `FK_Reference_3` (`user_id`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `ansible_job`;

CREATE TABLE ansible_job
(
  id               INTEGER PRIMARY KEY NOT NULL,
  description      TEXT                NOT NULL,
  created_by_id    INTEGER,
  creation_date    TEXT                NOT NULL,
  active           INTEGER             NOT NULL,
  name             TEXT                NOT NULL,
  project_id       INTEGER,
  inventory        TEXT                NOT NULL,
  playbook         TEXT                NOT NULL,
  job_type         TEXT                NOT NULL,
  credential_id    INTEGER,
  use_sudo         INTEGER,
  sudo_user        TEXT                NOT NULL,
  sudo_password    TEXT                NOT NULL,
  forks            INTEGER             NOT NULL,
  `limit`          TEXT                NOT NULL,
  vars_files       TEXT                NOT NULL,
  extra_vars       TEXT                NOT NULL,
  email            TEXT                NOT NULL,
  cancel_flag      INTEGER             NOT NULL,
  status           TEXT                NOT NULL,
  result_stdout    TEXT                NOT NULL,
  result_stderr    TEXT                NOT NULL,
  result_traceback TEXT                NOT NULL,
  celery_task_id   TEXT                NOT NULL,
  countdown        INTEGER             NOT NULL,
  execute_date     TEXT                NOT NULL,
  KEY `FK_Reference_4` (`created_by_id`),
  KEY `FK_Reference_5` (`project_id`),
  KEY `FK_Reference_6` (`credential_id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`project_id`) REFERENCES `ansible_project` (`id`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`credential_id`) REFERENCES `ansible_credential` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `ansible_jobtemplate`;
CREATE TABLE ansible_jobtemplate
(
  id            INTEGER PRIMARY KEY NOT NULL,
  description   TEXT                NOT NULL,
  created_by_id INTEGER,
  creation_date TEXT                NOT NULL,
  active        INTEGER             NOT NULL,
  name          TEXT                NOT NULL,
  project_id    INTEGER,
  playbook      TEXT                NOT NULL,
  inventory     TEXT                NOT NULL,
  hosts         TEXT                NOT NULL,
  user          TEXT                NOT NULL,
  use_sudo      INTEGER,
  sudo_user     TEXT                NOT NULL,
  forks         INTEGER             NOT NULL,
  `limit`       TEXT                NOT NULL,
  vars_files    TEXT                NOT NULL,
  extra_vars    TEXT                NOT NULL,
  email         TEXT                NOT NULL,
  KEY `FK_Reference_7` (`created_by_id`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `ansible_package`;
CREATE TABLE ansible_package
(
  id         INTEGER PRIMARY KEY NOT NULL,
  project_id INTEGER,
  version    INTEGER             NOT NULL,
  date       TEXT                NOT NULL,
  scmurl     TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `ansible_project`;
CREATE TABLE ansible_project
(
  id            INTEGER PRIMARY KEY NOT NULL,
  description   TEXT                NOT NULL,
  created_by_id INTEGER,
  creation_date TEXT                NOT NULL,
  active        INTEGER             NOT NULL,
  name          TEXT                NOT NULL,
  scmtype       TEXT                NOT NULL,
  scmurl        TEXT,
  `group`       TEXT,
  KEY `FK_Reference_8` (`created_by_id`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE auth_group
(
  id   INTEGER PRIMARY KEY NOT NULL,
  name TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE auth_group_permissions
(
  id            INTEGER PRIMARY KEY NOT NULL,
  group_id      INTEGER             NOT NULL,
  permission_id INTEGER             NOT NULL,
  KEY `FK_Reference_9` (`permission_id`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE auth_permission
(
  id              INTEGER PRIMARY KEY NOT NULL,
  name            TEXT                NOT NULL,
  content_type_id INTEGER             NOT NULL,
  codename        TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE auth_user
(
  id           INTEGER PRIMARY KEY NOT NULL,
  password     TEXT                NOT NULL,
  last_login   TEXT                NOT NULL,
  is_superuser INTEGER             NOT NULL,
  username     TEXT                NOT NULL,
  first_name   TEXT                NOT NULL,
  last_name    TEXT                NOT NULL,
  email        TEXT                NOT NULL,
  is_staff     INTEGER             NOT NULL,
  is_active    INTEGER             NOT NULL,
  date_joined  TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE auth_user_groups
(
  id       INTEGER PRIMARY KEY NOT NULL,
  user_id  INTEGER             NOT NULL,
  group_id INTEGER             NOT NULL,
  KEY `FK_Reference_10` (`group_id`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE auth_user_user_permissions
(
  id            INTEGER PRIMARY KEY NOT NULL,
  user_id       INTEGER             NOT NULL,
  permission_id INTEGER             NOT NULL,
  KEY `FK_Reference_11` (`permission_id`),
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `celery_taskmeta`;
CREATE TABLE celery_taskmeta
(
  status    TEXT    NOT NULL,
  task_id   TEXT    NOT NULL,
  date_done TEXT    NOT NULL,
  traceback TEXT,
  meta      TEXT,
  result    TEXT,
  hidden    INTEGER NOT NULL,
  id        INTEGER PRIMARY KEY
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `celery_tasksetmeta`;
CREATE TABLE celery_tasksetmeta
(
  taskset_id TEXT    NOT NULL,
  hidden     INTEGER NOT NULL,
  id         INTEGER PRIMARY KEY,
  date_done  TEXT    NOT NULL,
  result     TEXT    NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE django_admin_log
(
  id              INTEGER PRIMARY KEY NOT NULL,
  action_time     TEXT                NOT NULL,
  user_id         INTEGER             NOT NULL,
  content_type_id INTEGER,
  object_id       TEXT,
  object_repr     TEXT                NOT NULL,
  action_flag     INTEGER             NOT NULL,
  change_message  TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;


DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE django_content_type
(
  id        INTEGER PRIMARY KEY NOT NULL,
  name      TEXT                NOT NULL,
  app_label TEXT                NOT NULL,
  model     TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE django_session
(
  session_key  VARCHAR(64) PRIMARY KEY NOT NULL,
  session_data TEXT             NOT NULL,
  expire_date  TEXT             NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `djcelery_crontabschedule`;
CREATE TABLE djcelery_crontabschedule
(
  hour          TEXT NOT NULL,
  day_of_month  TEXT NOT NULL,
  day_of_week   TEXT NOT NULL,
  month_of_year TEXT NOT NULL,
  id            INTEGER PRIMARY KEY,
  minute        TEXT NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `djcelery_intervalschedule`;
CREATE TABLE djcelery_intervalschedule
(
  id     INTEGER PRIMARY KEY NOT NULL,
  every  INTEGER             NOT NULL,
  period TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `djcelery_periodictask`;
CREATE TABLE djcelery_periodictask
(
  crontab_id      INTEGER,
  task            TEXT    NOT NULL,
  name            TEXT    NOT NULL,
  exchange        TEXT,
  args            TEXT    NOT NULL,
  enabled         INTEGER NOT NULL,
  routing_key     TEXT,
  interval_id     INTEGER,
  last_run_at     TEXT,
  queue           TEXT,
  total_run_count INTEGER NOT NULL,
  expires         TEXT,
  kwargs          TEXT    NOT NULL,
  date_changed    TEXT    NOT NULL,
  id              INTEGER PRIMARY KEY,
  description     TEXT    NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `djcelery_periodictasks`;
CREATE TABLE djcelery_periodictasks
(
  ident       INTEGER PRIMARY KEY NOT NULL,
  last_update TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `djcelery_taskstate`;
CREATE TABLE djcelery_taskstate
(
  id        INTEGER PRIMARY KEY NOT NULL,
  state     TEXT                NOT NULL,
  task_id   TEXT                NOT NULL,
  name      TEXT,
  tstamp    TEXT                NOT NULL,
  args      TEXT,
  kwargs    TEXT,
  eta       TEXT,
  expires   TEXT,
  result    TEXT,
  traceback TEXT,
  runtime   REAL,
  retries   INTEGER             NOT NULL,
  worker_id INTEGER,
  hidden    INTEGER             NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `djcelery_workerstate`;
CREATE TABLE djcelery_workerstate
(
  id             INTEGER PRIMARY KEY NOT NULL,
  hostname       TEXT                NOT NULL,
  last_heartbeat TEXT
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `djkombu_message`;
CREATE TABLE djkombu_message
(
  id       INTEGER PRIMARY KEY NOT NULL,
  visible  INTEGER             NOT NULL,
  sent_at  TEXT,
  payload  TEXT                NOT NULL,
  queue_id INTEGER             NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `djkombu_queue`;
CREATE TABLE djkombu_queue
(
  id   INTEGER PRIMARY KEY NOT NULL,
  name TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `gaga_fileserver`;
CREATE TABLE gaga_fileserver
(
  id          INTEGER PRIMARY KEY NOT NULL,
  disk_useage TEXT                NOT NULL,
  smb_status  TEXT                NOT NULL,
  raid_status TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `gaga_linuxserver`;
CREATE TABLE gaga_linuxserver
(
  id        INTEGER PRIMARY KEY NOT NULL,
  serverip  TEXT                NOT NULL,
  mingcheng TEXT                NOT NULL,
  leixing   TEXT                NOT NULL,
  version   TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `gaga_namepassword`;
CREATE TABLE gaga_namepassword
(
  id       INTEGER PRIMARY KEY NOT NULL,
  IP       TEXT                NOT NULL,
  username TEXT                NOT NULL,
  password TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `gaga_resource`;
CREATE TABLE gaga_resource
(
  id       INTEGER PRIMARY KEY NOT NULL,
  leixin   TEXT                NOT NULL,
  banben   TEXT                NOT NULL,
  ip       TEXT                NOT NULL,
  username TEXT                NOT NULL,
  password TEXT                NOT NULL,
  beizhu   TEXT                NOT NULL,
  tester   TEXT                NOT NULL,
  rd       TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `gaga_serverip`;
CREATE TABLE gaga_serverip
(
  id       INTEGER PRIMARY KEY NOT NULL,
  ip       TEXT                NOT NULL,
  useornot TEXT                NOT NULL,
  beizhu   TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `gaga_user`;
CREATE TABLE gaga_user
(
  id       INTEGER PRIMARY KEY NOT NULL,
  username TEXT                NOT NULL,
  password TEXT                NOT NULL,
  realname TEXT                NOT NULL,
  sex      TEXT                NOT NULL,
  email    TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `gaga_feature`;
CREATE TABLE gaga_feature
(
  id       INTEGER PRIMARY KEY NOT NULL,
  textarea TEXT                NOT NULL,
  who      TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `guardian_groupobjectpermission`;
CREATE TABLE guardian_groupobjectpermission
(
  permission_id   INTEGER NOT NULL,
  object_pk       TEXT    NOT NULL,
  group_id        INTEGER NOT NULL,
  content_type_id INTEGER NOT NULL,
  id              INTEGER PRIMARY KEY
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `guardian_userobjectpermission`;
CREATE TABLE guardian_userobjectpermission
(
  permission_id   INTEGER NOT NULL,
  object_pk       TEXT    NOT NULL,
  user_id         INTEGER NOT NULL,
  content_type_id INTEGER NOT NULL,
  id              INTEGER PRIMARY KEY
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

DROP TABLE IF EXISTS `south_migrationhistory`;
CREATE TABLE south_migrationhistory
(
  id        INTEGER PRIMARY KEY NOT NULL,
  app_name  TEXT                NOT NULL,
  migration TEXT                NOT NULL,
  applied   TEXT                NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;