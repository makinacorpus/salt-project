{% import "makina-projects/ckan/config.sls" as c with context %}

# bootstrap the minimum for salt
include:
    - makina-states.setups.salt

# keep the project saltstack tree up to date
{{c.n}}-checkout-salt:
  cmd.run:
    - name: |
            branch="$(git symbolic-ref -q --short HEAD)";
            if [[ ! -d "{{c.s}}/.git" ]];then
              git clone -b {{c.salt_branch}} {{c.url}} {{c.s}};
            fi;
            cd "{{c.s}}";
            if [[ -z "$branch" ]];then
              git checkout {{c.salt_branch}};
            fi;
            git pull origin {{c.salt_branch}};
            exit 0
    - require:
      - git: salt-git
    - require_in:
      - cmd: salt-dirs-perms

# be sure to have code updated before salt master restart

# copy our local git tree to save bandwidth
{{c.n}}-checkout-code:
  file.directory:
    - name: {{c.p}}
    - makedirs: true
    - require:
      - cmd: {{c.n}}-checkout-salt
  cmd.run:
    - name: rsync -az "{{c.s}}/.git/" "{{c.p}}/.git/"
    - require:
      - cmd: {{c.n}}-checkout-salt
      - file: {{c.n}}-checkout-code
    - require_in:
      - cmd: salt-dirs-perms
