{% import "makina-projects/ckan/_macros/config.jinja" as c with context %}
# keep project code up to date
{% set includes=[] %}
{% set roles = pillar.get('makina.roles', []) %}
{% if 'db' in roles or roles == [] %}
{% set dummy=includes.append('makina-projects.' + c.name +'.db')%}
{% endif %}

{% if includes %}
include:
  {% for i in includes %}- {{i}}
  {% endfor %}
{% endif %}

{{c.name}}-checkout-project:
  cmd.run:
    - name: |
            if [[ ! -d "{{c.project_root}}/.git" ]];then
              git clone -b {{c.project_branch}} {{c.url}} {{c.project_root}};
            fi;
            cd "{{c.project_root}}";
            branch="$(git symbolic-ref -q --short HEAD)";
            if [[ -z "$branch" ]];then
                git checkout {{c.project_branch}};
            fi;
            git branch --set-upstream-to=origin/{{c.project_branch}} {{c.project_branch}}
            git pull origin {{c.project_branch}};
            exit 0

# run project
{{c.name}}-run-project:
  cmd.run:
    - name: {{c.project_root}}/project.sh
    - require:
      - cmd: {{c.name}}-checkout-project


