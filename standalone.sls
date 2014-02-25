{# This standalone file will be called with Full mode via top.sls.
   When called directly full mode is disabled, to run faster with
   less states.
#}
{# The drupal.jinja macros gives us everything (apache or nginx, php, postgresql or mysql 
# with the install_drupal_project macro
#}
{% import "makina-states/projects/drupal.jinja" as base with context %}

{# ------- SETTINGS -------------#}
{# Here define your project base git sources #}
{# This example links directly to the github example project #}
{# Chances are that the final project will be a gitorious project #}
{% set pre = 'makinacorpus' %}
{% set gitname = 'drupal-example' %}
{% set url = 'ssh://git@gitorious.makina-corpus.net/{0}/{1}.git'.format(pre, gitname) %}

{# This "name" will be used pretty everywhere,
# avoid dots, spaces and such, use a short identifier for the project #}
{% set name = 'drupalexample' %}

{# Domain name of the project #}
{% set domain = 'drupal.example.com' %}
{# Some other default projects settings could be given on the macros calls below #}

{# ------- COMPONENTS --------------------#}
{# define the do() macro, what will happen when we run? #}
{% macro do(full=False,init=False) %}
{# Note that :
# - you MUST choose apache OR nginx
# - you MUST use php_fpm with nginx but you could set False for Apache to use mod_php
# - you MUST choose between MySQL OR PostgreSQL
# - for Apache you SHOULD NOT use htaccess but it's available
# - There's A LOT of SETTINGS available in the drupal.jinja macro
#}
{{ base.install_drupal_project(name,
                               url=url, 
                               salt_branch='salt', 
                               project_branch='master', 
                               domain=domain,
                               domains=['otherdrupaldomain.bar.com'],
                               profile='standard'
                               use_nginx=False,
                               use_apache=True,
                               use_htaccess=False,
                               use_phpfpm=True,
                               use_mysql=True,
                               use_postgresql=False,
                               full=full,
                               init=init,
                               make=make) }}
{% endmacro %}
{# ------- RUN! --------------------#}
{{ do(full=False, init=False) }}
