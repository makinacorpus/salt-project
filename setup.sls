{% import "config.sls" as c with context %}
# keep salt code up to date
checkout-salt:
  git.latest:
    - name: {{c.url}}
    - target: {{c.s}}
    - rev: origin/{{c.n}}-salt

# copy our local git tree to save bandwith
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
