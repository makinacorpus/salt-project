{% import  "makina-projects/ckan/default.sls" as defaults with context %}
{% set url="https://github.com/makinacorpus/salt-project.git" %}
{% set n='ckan' %}
{% set root='/srv/projects' %}
{% set s = root + '/' + n + '/salt' %}
{% set p = root + '/' + n + '/project' %}
{% set salt_branch = n + "-salt" %}
{% set project_branch = n + "-project" %}
{% set ckanData = defaults.ckanData %}
