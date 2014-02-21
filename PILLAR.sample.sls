{% set password = 's3cr3t' %}
ckan-default-settings:
  dbs:
    default:
      db_password: {{password}}

makina-states.services.java.tomcat7:
  users:
    admin:
      password: {{password}}
      roles': ['admin', 'manager']

makina-states.services.java.solr4:
  dbs:
    default:
      db_password: {{password}}
