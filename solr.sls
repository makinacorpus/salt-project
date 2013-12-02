# {# How did i made the core sole configuration:
# cp /srv/solr/4/home/default/conf/
# cp -rf /srv/solr/4/home/default/ /srv/projects/ckan/salt/files/ckan_default
# cp -rf /srv/projects/ckan/project/src/ckan/ckan/config/solr/schema-2.0.xml files/ckan_default/conf/schema.xml
# #}

{% import "makina-states/_macros/salt.jinja" as saltmac with context %}
{% import "makina-projects/ckan/_macros/config.jinja" as c with context %}
{% import "makina-states/services/java/tomcat7.sls" as tomcat with context %}
{% import "makina-states/services/java/solr4.sls" as solr with context %}

include:
  - makina-projects.ckan.common
  - makina-states.services.java.solr4

{% macro ckan_register_solr(siteid) %}
{{siteid}}-solr-core:
  file.recurse:
    - order: 100
    - source: salt://makina-projects/ckan/files/solr/ckan_default/
    - template: jinja
    - name: {{solr.home_dir}}/{{siteid}}
    - user: {{tomcat.data['tomcat_user']}}
    - group: {{saltmac.group}}
    - core_name: {{siteid}}
    - require:
      - file: solr-default-core-{{solr.v}}
{{solr.register_core(siteid, solr.home_dir + "/" + siteid) }}
{% endmacro %}
{% for site in c.data['sites'] %}
{{ ckan_register_solr(site['name']) }}
{% endfor %}
