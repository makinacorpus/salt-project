{% import "makina-states/projects/ckan.jinja" as base with context %}
{% set pre = 'makinacorpus' %}
{% set name = 'ckan-project' %}
{% set url = 'ssh://git@github.com/{0}/salt-project.git'.format(pre, name) %}
{% set domain = 'ckan.foobar.com' %}
{% macro do(full=False) %}
{{ base.install_phpfpm_project(name,
                               url=url,
                               salt_branch='ckan-salt',
                               project_branch='ckan-project',
                               domain=domain,
                               domains=['otherckan.bar.com'], full=full) }}
{% endmacro %}
{{ do(full=False) }}
