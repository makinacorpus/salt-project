{# This top file will run the standalone version in Full mode for highstates #}
{% import "makina-projects/drupal-project/standalone.sls" as base with context %}
{% set name = base.name %}
{% set url = base.url %}
{% set domain = base.domain %}
{{ base.do(full=True) }}
