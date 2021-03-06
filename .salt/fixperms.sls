{% set cfg = opts['ms_project'] %}
{# export macro to callees #}
{% set ugs = salt['mc_usergroup.settings']() %}
{% set locs = salt['mc_locations.settings']() %}
{% set cfg = opts['ms_project'] %}
{{cfg.name}}-restricted-perms:
  file.managed:
    - name: {{cfg.project_dir}}/global-reset-perms.sh
    - mode: 750
    - user: {% if not cfg.no_user%}{{cfg.user}}{% else -%}root{% endif %}
    - group: {{cfg.group}}
    - contents: |
            #!/usr/bin/env bash
            if [ -e "{{cfg.pillar_root}}" ];then
            "{{locs.resetperms}}" -q "${@}" \
              --dmode '0770' --fmode '0770' \
              --user root --group "{{ugs.group}}" \
              --users root \
              --groups "{{ugs.group}}" \
              --paths "{{cfg.pillar_root}}";
            fi
            if [ -e "{{cfg.project_root}}" ];then
            {{locs.resetperms}} -q\
              -u {{cfg.user}} -g {{cfg.group}}\
              --path "{{cfg.data.ftp_root}}"\
              {% for userdef in cfg.data.users%}{% for usr, udata in userdef.items() %} --users {{usr}}:rwx{% endfor%}{% endfor%}\
              --fmode 770 --dmode 770\
              --users {{cfg.user}}:rwx\
              --groups editor:rwx\
              --groups {{salt['mc_apache.settings']().httpd_user}}:rwx;
            "{{locs.resetperms}}" "${@}" -q\
              --dmode '0770' --fmode '0770'  \
              --paths "{{cfg.project_root}}" \
              --paths "{{cfg.data_root}}" \
              --users www-data \
              --users {% if not cfg.no_user%}{{cfg.user}}{% else -%}root{% endif %} \
              --groups {{cfg.group}} \
              --user {% if not cfg.no_user%}{{cfg.user}}{% else -%}root{% endif %} \
              --group {{cfg.group}};
              chmod o+x "{{cfg.data.ftp_root}}" "{{cfg.data.rftp_root}}"
            fi
  cmd.run:
    - name: {{cfg.project_dir}}/global-reset-perms.sh
    - cwd: {{cfg.project_root}}
    - user: root
    - watch:
      - file: {{cfg.name}}-restricted-perms

{{cfg.name}}-fixperms:
  file.managed:
    - name: /etc/cron.d/{{cfg.name.replace('.', '_')}}-fixperms
    - user: root
    - mode: 744
    - contents: |
                {{cfg.data.cron_periodicity}} root {{cfg.project_dir}}/global-reset-perms.sh

