# Ckan settings
{% set ckanStepOne = salt['grains.filter_by']({
    'dev': {
      'dbs' : {
        'default': {
            'db_name': 'ckan',
            'db_user': 'ckan',
            'db_tablespace': 'pg_default',
            'db_password': 'superS3CR3T',
          },
      },
    },
    'prod': {
    }
  },
  grain='default_env',
  default= 'dev'
) %}
{% set ckanStepTwo = salt['grains.filter_by']({
    'Debian': {
    },
    'RedHat': {
    },
  },
  grain='os_family',
  merge=ckanStepOne
) %}
# FINAL STEP: merge with data from pillar
{% set ckanData=salt['mc_utils.dictupdate'](
  ckanStepTwo ,
  salt['pillar.get']('ckan-default-settings',{})) %}

