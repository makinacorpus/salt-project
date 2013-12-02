{% import "makina-projects/ckan/_macros/config.jinja" as c with context %}
{% set id = 'ckan' %}
{{id}}:
  group.present:
    - name: {{ id }}
    - system: True
  user.present:
    - name: {{ id}}
    - require:
        - group: {{ id }}
    - fullname: {{ id }} user
    - createhome: True
    - shell: /bin/bash
    - home: {{c.project_root}}
    - gid_from_name: True
    - remove_groups: False
    - optional_groups:
      - {{ id }}
      - editor
