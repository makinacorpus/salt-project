{# This init file can be called to run the 
# drush make
# drush install
# And wipeout any existing database data.
# So as the names implies, it's an init-only thing
#}
{% import "makina-projects/drupal-project/standalone.sls" as base with context %}
{{ base.init(full=True, init=True) }}
