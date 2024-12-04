set positional-arguments

# List available commands when no command provided
default:
  @just --list

#@bootstrap *args='':
#  pdm run ansible-playbook site.yml -e "upgrade=True devsec=True" $@
#
#@devkinsta *args='':
#  pdm run ansible-playbook devkinsta.yml -e "upgrade=True devsec=True" $@

@test_local_setup:
  /usr/bin/time -p pdm run ansible localhost -m setup

@test_fact_caching:
  /usr/bin/time -p pdm run ansible-playbook -i inventories/local.ini ansible_facts.yml

@check *args='':
  pdm run ansible-playbook --check site.yml -e "upgrade=False devsec=False" $@

@upgrade *args='':
  pdm run ansible-playbook upgrade.yml -i inventories/local.ini $@

@upgrade-prod *args='':
  pdm run ansible-playbook upgrade.yml -i inventories/production.ini $@

@bootstrap *args='':
  pdm run ansible-playbook site.yml -i inventories/local.ini -e "upgrade=True devsec=True" $@

@bootstrap-prod *args='':
  pdm run ansible-playbook site.yml -i inventories/production.ini -e "upgrade=True devsec=True" $@

@run *args='':
  pdm run ansible-playbook -i inventories/local.ini site.yml $@

@run-prod *args='':
  pdm run ansible-playbook -i inventories/production.ini site.yml $@

@install_requirements:
  pdm run ansible-galaxy install -r requirements.yml

@install_requirements_force:
  pdm run ansible-galaxy install -r requirements.yml --force

@update_templates *args='':
  pdm run ansible-playbook templates.yml -i inventories/templates.ini --limit templates $@
