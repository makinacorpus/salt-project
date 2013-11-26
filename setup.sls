{% import "makina-projects/ckan/_macros/config.jinja" as c with context %}

# bootstrap the minimum for salt
include:
    - makina-states.setups.salt

# keep the project saltstack tree up to date
{{c.name}}-checkout-salt:
  cmd.run:
    - name: |
            branch="$(git symbolic-ref -q --short HEAD)";
            if [[ ! -d "{{c.salt_root}}/.git" ]];then
              git clone -b {{c.salt_branch}} {{c.url}} {{c.salt_root}};
            fi;
            cd "{{c.salt_root}}";
            if [[ -z "$branch" ]];then
              git checkout {{c.salt_branch}};
            fi;
            git branch --set-upstream-to=origin/{{c.salt_branch}} {{c.salt_branch}}
            git pull origin {{c.salt_branch}};
            exit 0
    - require:
      - git: salt-git
    - require_in:
      - cmd: salt-dirs-perms

# be sure to have code updated before salt master restart

# copy our local git tree to save bandwidth
{{c.name}}-checkout-code:
  file.directory:
    - name: {{c.project_root}}
    - makedirs: true
    - require:
      - cmd: {{c.name}}-checkout-salt
  cmd.run:
    - name: rsync -az --exclude="refs/heads/*" "{{c.salt_root}}/.git/" "{{c.project_root}}/.git/"
    - require:
      - cmd: {{c.name}}-checkout-salt
      - file: {{c.name}}-checkout-code
    - require_in:
      - cmd: salt-dirs-perms
