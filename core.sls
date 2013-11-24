{% import "makina-projects/ckan/config.sls" as c with context %}
# keep project code up to date
{% set roles = pillar.get('makina.roles', [] %}
{% if roles == [] %}
{% endif %}

include:
  {% if 'db' in roles or roles == []%}- makina-states.services.postgresql{% endif %}

# makina-states.services.postgresql will provide states to attach to:
#  - ckan-makina-postgresql-database
#  - ckan-makina-postgresql-user

{{c.n}}-checkout-project:
  cmd.run:
    - name: |
            if [[ ! -d "{{c.p}}/.git" ]];then
              git clone -b {{c.project_branch}} {{c.url}} {{c.p}};
            fi;
            cd "{{c.p}}";
            branch="$(git symbolic-ref -q --short HEAD)";
            if [[ -z "$branch" ]];then
                git checkout {{c.project_branch}};
            fi;
            git pull origin {{c.project_branch}};
            exit 0

# run project
{{c.n}}-run-project:
  cmd.run:
    - name: {{c.p}}/project.sh
    - require:
      - cmd: {{c.n}}-checkout-project


