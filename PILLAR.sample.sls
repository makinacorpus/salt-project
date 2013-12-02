{% set password = 's3cr3t' %}
ckan-default-settings:
  dbs:
    default:
      db_password: {{password}}

tomcat7-default-settings:
  users:
    admin:
      password: {{password}}
      roles': ['admin', 'manager']

solr4-default-settings:
  dbs:
    default:
      db_password: {{password}}
