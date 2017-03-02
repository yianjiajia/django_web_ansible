"""
Django settings for django_web project.

For more information on this file, see
https://docs.djangoproject.com/en/1.6/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.6/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
import djcelery
from django.utils.translation import ugettext
BASE_DIR = os.path.dirname(os.path.dirname(__file__))
import sys
reload(sys)
sys.setdefaultencoding('gbk')

ALLOWED_HOSTS = '*'

DESKTOP_CORE_ROOT=os.path.dirname(__file__)
sys.path.insert(0, os.path.join(DESKTOP_CORE_ROOT, 'apps'))

ANSIBLE_PROJECTS_ROOT = os.path.join(DESKTOP_CORE_ROOT,'..','..', 'projects')
ACCOUNT_PROFILE_ROOT = os.path.join(DESKTOP_CORE_ROOT,'..','..', 'cretential')
TMP_FILE = os.path.join(DESKTOP_CORE_ROOT, 'tmp')
ADMINS = (
# ('Your Name', 'your_email@example.com'),
)
DEBUG=True
MANAGERS = ADMINS

ugettext = lambda s:s
LANGUAGES =(
    ('en',ugettext('English')),
    ('zh-cn',ugettext('Chinese')),
)

LANGUAGE_COOKIE_NAME = 'django_language'

DEFAULT_CHARSET='utf-8'

SITE_ID = 1

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.6/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '*a=*nsyy-f8+&jb$t1)%!u3dge8t-9nk0n0p4rx+bsa46u^y^i'

# SECURITY WARNING: don't run with debug turned on in production!


TEMPLATE_DEBUG = False
STATIC_ROOT = 'D:\WORKSPACE\django_web_ansible\static'
STATICFILES_DIRS = (
    ('css',os.path.join(STATIC_ROOT,'css').replace('\\','/') ),
    ('img',os.path.join(STATIC_ROOT,'img').replace('\\','/') ),
    ('js',os.path.join(STATIC_ROOT,'js').replace('\\','/') ),
    ('ext',os.path.join(STATIC_ROOT,'ext').replace('\\','/') ),
    # Put strings here, like "/home/html/static" or "C:/www/django/static".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    )

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    )

# Application definition

INSTALLED_APPS = (
    'django_admin_bootstrapped',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'gaga',
    'service',
    'django_web.pagination',
#    # Uncomment the next line to enable admin documentation:
#    'django.contrib.admindocs',
    #'south',
    'kombu.transport.django',
    'djcelery',
    'apps.ansible',
    'apps.account',
    'guardian',

)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.locale.LocaleMiddleware',
	'django_web.middleware.AjaxMiddleware',
	'django_web.middleware.LoginAndPermissionMiddleware',
	'django_web.middleware.ExceptionMiddleware',
	'django.middleware.transaction.TransactionMiddleware',
	'django_web.pagination.middleware.PaginationMiddleware',
)

ROOT_URLCONF = 'django_web.urls'

WSGI_APPLICATION = 'django_web.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases
'''DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
        #'NAME': 'py_test',                      # Or path to database file if using sqlite3.
        'NAME': 'apexit',
        # The following settings are not used with sqlite3:
        #'USER': 'root',
        #'PASSWORD': '',
        'USER': 'root',
        'PASSWORD': '111111',
        'HOST': '192.168.0.35',
        'PORT': '3306',
    }
}'''
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
		'ATOMIC_REQUESTS': True
    }
}
# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/


TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = True
LOGIN_URL = '/accounts/login/'

#Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.6/howto/static-files/



# URL prefix for static files.
# Example: "http://example.com/static/", "http://static.example.com/"
#STATIC_ROOT = os.path.join(BASE_DIR, 'static')
STATIC_URL = '/static/'


#STATICFILES_DIRS = (
#   os.path.join(BASE_DIR,'static'),
#)

TEMPLATE_DIRS = ('django_web/templates', 'html')
LOCALE_PATHS = (
    os.path.join(DESKTOP_CORE_ROOT, 'locale' ),
)
AUTHENTICATION_BACKENDS = (
    #'desktop.core.auth.backend.LdapBackend',
    'django.contrib.auth.backends.ModelBackend',
    'guardian.backends.ObjectPermissionBackend',
    )
TEMPLATE_CONTEXT_PROCESSORS  = (
    "django.contrib.auth.context_processors.auth",
    "django.core.context_processors.debug",
    "django.core.context_processors.i18n",
    "django.core.context_processors.media",
    "django.core.context_processors.static",
    "django.core.context_processors.tz",
    "django.contrib.messages.context_processors.messages",
	"django.core.context_processors.request"
)

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        },
        'simple': {
            'format': '%(levelname)s %(message)s'
        },
    },
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        },
        'console':{
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'simple'
        },
        'file_handler': {
            'level': 'DEBUG',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': 'E:\workspace\django_web_ansible/server.log',
            'formatter': 'simple'
        },
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
            },
        'desktop': {
            'handlers': ['file_handler'],
            'level': 'DEBUG',
            'propagate': True,
        }
    }
}

if 'djcelery' in INSTALLED_APPS:
    import djcelery
    djcelery.setup_loader()
BROKER_URL = 'django://'
CELERY_TASK_SERIALIZER = 'json'
CELERY_RESULT_SERIALIZER = 'json'
CELERY_TRACK_STARTED = True
CELERYD_TASK_TIME_LIMIT = 600
CELERYD_TASK_SOFT_TIME_LIMIT = 540
CELERYBEAT_SCHEDULER = 'djcelery.schedulers.DatabaseScheduler'
CELERYBEAT_MAX_LOOP_INTERVAL = 60
CELERYD_POOL = 'celery.concurrency.threads:TaskPool'


ANONYMOUS_USER_ID = -1
 # User settings
from django_web.internal.settings_local import *

