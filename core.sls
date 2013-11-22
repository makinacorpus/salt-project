{% import "makina-projects/ckan/config.sls" as c with context %}
# keep project code up to date
checkout-code:
  git.latest:
    - name: {{c.url}}
    - target: {{c.p}}
    - rev: origin/{{c.n}}-project
     
# run project
run-project:
  cmd.run:
    - name: /srv/projects/ckan/project/project.sh
    - require:
      - git: checkout-code

