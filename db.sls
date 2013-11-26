{% import "makina-projects/ckan/config.sls" as c with context %}
{% import "makina-states/services/db/postgresql.sls" as pgsql with context %}
{{ pgsql.postgresql_base() }}
{% for name, dbdata in c.ckanData['dbs'].items() %}
{% set db_name = dbdata['db_name'] %}
{% set db_tablespace = dbdata['db_tablespace'] %}
{% set db_user = dbdata['db_user'] %}
{% set db_password = dbdata['db_password'] %}
{{ pgsql.postgresql_db(db_name, tablespace=db_tablespace) }}
{{ pgsql.postgresql_user(db_user,
                         db_password,
                         groups=['{0}_owners'.format(db_name)]) }}
{% endfor %}
