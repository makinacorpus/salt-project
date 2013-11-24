{% import "makina-projects/ckan/config.sls" as c with context %}
# keep project code up to date
checkout-project:
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
run-project:
  cmd.run:
    - name: {{c.p}}/project.sh
    - require:
      - cmd: checkout-project
