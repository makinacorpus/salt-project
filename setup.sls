{% import "config.sls" as c with context %}

# bootstrap the minimum for salt
include:
    - makina-states.setup

# keep the project saltstack tree up to date
checkout-salt:
  git.latest:
    - name: {{c.url}}
    - target: {{c.s}}
    - rev: origin/{{c.n}}-salt
    - require:
# be sure to have code updated before salt master restart
        - git: salt-git

# copy our local git tree to save bandwidth
checkout-code:
  file.directory:
    - name: {{c.p}}
    - makedirs: true
    - require:
      - git: checkout-salt
  cmd.run:
    - name: rsync -az {{c.s}}/.git/ {{c.p}}/.git/
    - require:
      - git: checkout-salt
      - file: checkout-code
