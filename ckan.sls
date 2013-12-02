{% import "makina-states/_macros/salt.jinja" as saltmac with context %}
{% import "makina-projects/ckan/_macros/config.jinja" as c with context %}
{% import "makina-states/services/java/tomcat7.sls" as tomcat with context %}
{% import "makina-states/services/java/solr4.sls" as solr with context %}

include:
  - makina-projects.ckan.common

{% macro ckan_register_solr(siteid) %}
{{solr.register_core(siteid, solr.home_dir + "/" + siteid) }}
{% endmacro %}
{% for site in c.data['sites'] %}
{% endfor %}

ckan-buildout:
  buildout.installed:
    - name: {{c.project_root}}
    - config: buildout- 

