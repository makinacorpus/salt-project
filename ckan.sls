{% import "makina-states/_macros/salt.jinja" as saltmac with context %}
{% import "makina-projects/ckan/_macros/config.jinja" as c with context %}
{% import "makina-states/services/java/tomcat7.sls" as tomcat with context %}
{% import "makina-states/services/java/solr4.sls" as solr with context %}

{% set user=data.user %}

include:
  - makina-projects.ckan.common

ckan-settings:
  file.managed:
    - name: {{c.project_root}}/etc/settings-local.cfg
    - user: {{user}}
    - group: {{saltmac.group}}
    - defaults:
      {% for k in data %}
      - {{k}}: {{data.get(k)|yaml}}
      {% endfor %}
      - sqlalchemy_url: {{data.sqlalchemy_url % data['dbs']['default']}}

ckan-buildout:
  buildout.installed:
    - name: {{c.project_root}}
    - config: buildout-{{c.default_env}}.cfg
    - runas: {{user}}

