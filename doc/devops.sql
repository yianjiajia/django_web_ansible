/*

SQLyog Community v8.4
MySQL - 5.5.41-MariaDB : Database - naas

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
  FOREIGN KEY (user_id) REFERENCES auth_user (id)
);

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
  FOREIGN KEY (created_by_id) REFERENCES auth_user (id),
  FOREIGN KEY (user_id) REFERENCES auth_user (id)
);

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
  "limit"          TEXT                NOT NULL,
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
  FOREIGN KEY (created_by_id) REFERENCES auth_user (id),
  FOREIGN KEY (project_id) REFERENCES ansible_project (id),
  FOREIGN KEY (credential_id) REFERENCES ansible_credential (id)
);
CREATE UNIQUE INDEX ansible_job_name
  ON ansible_job (name);

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
  "limit"       TEXT                NOT NULL,
  vars_files    TEXT                NOT NULL,
  extra_vars    TEXT                NOT NULL,
  email         TEXT                NOT NULL,
  FOREIGN KEY (created_by_id) REFERENCES auth_user (id)
);

CREATE UNIQUE INDEX ansible_jobtemplate_name
  ON ansible_jobtemplate (name);
CREATE UNIQUE INDEX ansible_jobtemplate_project_id
  ON ansible_jobtemplate (project_id);

DROP TABLE IF EXISTS `ansible_package`;
CREATE TABLE ansible_package
(
  id         INTEGER PRIMARY KEY NOT NULL,
  project_id INTEGER,
  version    INTEGER             NOT NULL,
  date       TEXT                NOT NULL,
  scmurl     TEXT                NOT NULL
);
CREATE UNIQUE INDEX ansible_package_project_id
  ON ansible_package (project_id);

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
  "group"       TEXT,
  FOREIGN KEY (created_by_id) REFERENCES auth_user (id)
);
CREATE UNIQUE INDEX ansible_project_name
  ON ansible_project (name);

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE auth_group
(
  id   INTEGER PRIMARY KEY NOT NULL,
  name TEXT                NOT NULL
);
CREATE UNIQUE INDEX auth_group_name
  ON auth_group (name);

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE auth_group_permissions
(
  id            INTEGER PRIMARY KEY NOT NULL,
  group_id      INTEGER             NOT NULL,
  permission_id INTEGER             NOT NULL,
  FOREIGN KEY (permission_id) REFERENCES auth_permission (id)
);
CREATE UNIQUE INDEX auth_group_permissions
  ON auth_group_permissions (group_id, permission_id);
CREATE UNIQUE INDEX auth_group_permissions_group_id
  ON auth_group_permissions (group_id);

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE auth_permission
(
  id              INTEGER PRIMARY KEY NOT NULL,
  name            TEXT                NOT NULL,
  content_type_id INTEGER             NOT NULL,
  codename        TEXT                NOT NULL
);
CREATE UNIQUE INDEX auth_permission
  ON auth_permission (content_type_id, codename);
CREATE UNIQUE INDEX auth_permission_content_type_id
  ON auth_permission (content_type_id);

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
);
CREATE UNIQUE INDEX auth_user_username
  ON auth_user (username);

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE auth_user_groups
(
  id       INTEGER PRIMARY KEY NOT NULL,
  user_id  INTEGER             NOT NULL,
  group_id INTEGER             NOT NULL,
  FOREIGN KEY (group_id) REFERENCES auth_group (id)
);
CREATE UNIQUE INDEX auth_user_groups
  ON auth_user_groups (user_id, group_id);
CREATE UNIQUE INDEX auth_user_groups_user_id
  ON auth_user_groups (user_id);

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE auth_user_user_permissions
(
  id            INTEGER PRIMARY KEY NOT NULL,
  user_id       INTEGER             NOT NULL,
  permission_id INTEGER             NOT NULL,
  FOREIGN KEY (permission_id) REFERENCES auth_permission (id)
);

CREATE UNIQUE INDEX auth_user_user_permissions
  ON auth_user_user_permissions (user_id, permission_id);
CREATE UNIQUE INDEX auth_user_user_permissions_user_id
  ON auth_user_user_permissions (user_id);

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
);
CREATE UNIQUE INDEX celery_taskmeta_task_id
  ON celery_taskmeta (task_id);

DROP TABLE IF EXISTS `celery_tasksetmeta`;
CREATE TABLE celery_tasksetmeta
(
  taskset_id TEXT    NOT NULL,
  hidden     INTEGER NOT NULL,
  id         INTEGER PRIMARY KEY,
  date_done  TEXT    NOT NULL,
  result     TEXT    NOT NULL
);
CREATE UNIQUE INDEX celery_tasksetmeta_taskset_id
  ON celery_tasksetmeta (taskset_id);
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
);
CREATE UNIQUE INDEX django_admin_log_6340c63c
  ON django_admin_log (user_id);
CREATE UNIQUE INDEX django_admin_log_37ef4eb4
  ON django_admin_log (content_type_id);
CREATE TABLE django_content_type
(
  id        INTEGER PRIMARY KEY NOT NULL,
  name      TEXT                NOT NULL,
  app_label TEXT                NOT NULL,
  model     TEXT                NOT NULL
);
CREATE UNIQUE INDEX sqlite_autoindex_django_content_type_1
  ON django_content_type (app_label, model);
CREATE TABLE django_session
(
  session_key  TEXT PRIMARY KEY NOT NULL,
  session_data TEXT             NOT NULL,
  expire_date  TEXT             NOT NULL
);
CREATE UNIQUE INDEX django_session_b7b81f0c
  ON django_session (expire_date);
CREATE TABLE djcelery_crontabschedule
(
  hour          TEXT NOT NULL,
  day_of_month  TEXT NOT NULL,
  day_of_week   TEXT NOT NULL,
  month_of_year TEXT NOT NULL,
  id            INTEGER PRIMARY KEY,
  minute        TEXT NOT NULL
);
CREATE TABLE djcelery_intervalschedule
(
  id     INTEGER PRIMARY KEY NOT NULL,
  every  INTEGER             NOT NULL,
  period TEXT                NOT NULL
);
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
);
CREATE UNIQUE INDEX djcelery_periodictask_7280124f
  ON djcelery_periodictask (crontab_id);
CREATE UNIQUE INDEX sqlite_autoindex_djcelery_periodictask_1
  ON djcelery_periodictask (name);
CREATE UNIQUE INDEX djcelery_periodictask_8905f60d
  ON djcelery_periodictask (interval_id);
CREATE TABLE djcelery_periodictasks
(
  ident       INTEGER PRIMARY KEY NOT NULL,
  last_update TEXT                NOT NULL
);
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
);
CREATE UNIQUE INDEX djcelery_taskstate_5654bf12
  ON djcelery_taskstate (state);
CREATE UNIQUE INDEX sqlite_autoindex_djcelery_taskstate_1
  ON djcelery_taskstate (task_id);
CREATE UNIQUE INDEX djcelery_taskstate_4da47e07
  ON djcelery_taskstate (name);
CREATE UNIQUE INDEX djcelery_taskstate_abaacd02
  ON djcelery_taskstate (tstamp);
CREATE UNIQUE INDEX djcelery_taskstate_cac6a03d
  ON djcelery_taskstate (worker_id);
CREATE UNIQUE INDEX djcelery_taskstate_2ff6b945
  ON djcelery_taskstate (hidden);
CREATE TABLE djcelery_workerstate
(
  id             INTEGER PRIMARY KEY NOT NULL,
  hostname       TEXT                NOT NULL,
  last_heartbeat TEXT
);
CREATE UNIQUE INDEX sqlite_autoindex_djcelery_workerstate_1
  ON djcelery_workerstate (hostname);
CREATE UNIQUE INDEX djcelery_workerstate_11e400ef
  ON djcelery_workerstate (last_heartbeat);
CREATE TABLE djkombu_message
(
  id       INTEGER PRIMARY KEY NOT NULL,
  visible  INTEGER             NOT NULL,
  sent_at  TEXT,
  payload  TEXT                NOT NULL,
  queue_id INTEGER             NOT NULL
);
CREATE UNIQUE INDEX djkombu_message_5907bb86
  ON djkombu_message (visible);
CREATE UNIQUE INDEX djkombu_message_bc4c5ddc
  ON djkombu_message (sent_at);
CREATE UNIQUE INDEX djkombu_message_c80a9385
  ON djkombu_message (queue_id);
CREATE TABLE djkombu_queue
(
  id   INTEGER PRIMARY KEY NOT NULL,
  name TEXT                NOT NULL
);
CREATE UNIQUE INDEX sqlite_autoindex_djkombu_queue_1
  ON djkombu_queue (name);
CREATE TABLE gaga_fileserver
(
  id          INTEGER PRIMARY KEY NOT NULL,
  disk_useage TEXT                NOT NULL,
  smb_status  TEXT                NOT NULL,
  raid_status TEXT                NOT NULL
);
CREATE TABLE gaga_linux_server
(
  id        INTEGER PRIMARY KEY NOT NULL,
  serverip  TEXT                NOT NULL,
  mingcheng TEXT                NOT NULL,
  leixing   TEXT                NOT NULL,
  version   TEXT                NOT NULL
);
CREATE TABLE gaga_name_password
(
  id       INTEGER PRIMARY KEY NOT NULL,
  IP       TEXT                NOT NULL,
  username TEXT                NOT NULL,
  password TEXT                NOT NULL
);
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
);
CREATE TABLE gaga_serverip
(
  id       INTEGER PRIMARY KEY NOT NULL,
  ip       TEXT                NOT NULL,
  useornot TEXT                NOT NULL,
  beizhu   TEXT                NOT NULL
);
CREATE TABLE gaga_user
(
  id       INTEGER PRIMARY KEY NOT NULL,
  username TEXT                NOT NULL,
  password TEXT                NOT NULL,
  realname TEXT                NOT NULL,
  sex      TEXT                NOT NULL,
  email    TEXT                NOT NULL
);
CREATE TABLE gaga_xuqiu
(
  id       INTEGER PRIMARY KEY NOT NULL,
  textarea TEXT                NOT NULL,
  who      TEXT                NOT NULL
);
CREATE TABLE guardian_groupobjectpermission
(
  permission_id   INTEGER NOT NULL,
  object_pk       TEXT    NOT NULL,
  group_id        INTEGER NOT NULL,
  content_type_id INTEGER NOT NULL,
  id              INTEGER PRIMARY KEY
);
CREATE UNIQUE INDEX guardian_groupobjectpermission_83d7f98b
  ON guardian_groupobjectpermission (permission_id);
CREATE UNIQUE INDEX guardian_groupobjectpermission_object_pk__group_id__content_type_id__permission_id
  ON guardian_groupobjectpermission (object_pk, group_id, content_type_id, permission_id);
CREATE UNIQUE INDEX guardian_groupobjectpermission_5f412f9a
  ON guardian_groupobjectpermission (group_id);
CREATE UNIQUE INDEX guardian_groupobjectpermission_37ef4eb4
  ON guardian_groupobjectpermission (content_type_id);
CREATE TABLE guardian_userobjectpermission
(
  permission_id   INTEGER NOT NULL,
  object_pk       TEXT    NOT NULL,
  user_id         INTEGER NOT NULL,
  content_type_id INTEGER NOT NULL,
  id              INTEGER PRIMARY KEY
);
CREATE UNIQUE INDEX guardian_userobjectpermission_83d7f98b
  ON guardian_userobjectpermission (permission_id);
CREATE UNIQUE INDEX guardian_userobjectpermission_object_pk__user_id__content_type_id__permission_id
  ON guardian_userobjectpermission (object_pk, user_id, content_type_id, permission_id);
CREATE UNIQUE INDEX guardian_userobjectpermission_6340c63c
  ON guardian_userobjectpermission (user_id);
CREATE UNIQUE INDEX guardian_userobjectpermission_37ef4eb4
  ON guardian_userobjectpermission (content_type_id);
CREATE TABLE south_migrationhistory
(
  id        INTEGER PRIMARY KEY NOT NULL,
  app_name  TEXT                NOT NULL,
  migration TEXT                NOT NULL,
  applied   TEXT                NOT NULL
);