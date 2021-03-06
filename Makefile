    .PHONY: test test-yaml test-sigmac
test: test-yaml test-sigmac

test-yaml:
	yamllint rules

test-sigmac:
	rm -f .coverage
	coverage run -a --include=tools/* tools/sigmac.py -l
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -t es-qs rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -t kibana rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -t xpack-watcher rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -t splunk rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -t logpoint rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/elk-windows.yml -t es-qs rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/elk-linux.yml -t es-qs rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/elk-windows.yml -t kibana rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/elk-linux.yml -t kibana rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/elk-windows.yml -t xpack-watcher rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/elk-linux.yml -t xpack-watcher rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/elk-defaultindex.yml -t xpack-watcher rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/splunk-windows-all.yml -t splunk rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -c tools/config/logpoint-windows-all.yml -t logpoint rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -t grep rules/ > /dev/null
	coverage run -a --include=tools/* tools/sigmac.py -rvdI -t fieldlist rules/ > /dev/null
	coverage run -a --include=tools/*  tools/sigmac.py -t xpack-watcher -O output=plain -O es=es -O foobar rules/windows/builtin/win_susp_failed_logons_single_source.yml > /dev/null
	! coverage run -a --include=tools/*  tools/sigmac.py -t xpack-watcher -O output=foobar -O es=es -O foobar rules/windows/builtin/win_susp_failed_logons_single_source.yml > /dev/null
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs tests/not_existing.yml > /dev/null
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs tests/invalid_yaml.yml > /dev/null
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs tests/invalid_sigma-no_identifiers.yml > /dev/null
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs tests/invalid_sigma-no_condition.yml > /dev/null
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs tests/invalid_sigma-invalid_identifier_reference.yml > /dev/null
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs tests/invalid_sigma-invalid_aggregation.yml > /dev/null
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs tests/invalid_sigma-wrong_identifier_definition.yml > /dev/null
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs rules/windows/builtin/win_susp_failed_logons_single_source.yml
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs -o /not_possible rules/windows/sysmon/sysmon_mimikatz_detection_lsass.yml
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs -c not_existing rules/windows/sysmon/sysmon_mimikatz_detection_lsass.yml 
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs -c tests/invalid_yaml.yml rules/windows/sysmon/sysmon_mimikatz_detection_lsass.yml
	! coverage run -a --include=tools/* tools/sigmac.py -t es-qs -c tests/invalid_config.yml rules/windows/sysmon/sysmon_mimikatz_detection_lsass.yml
	! coverage run -a --include=tools/* tools/sigmac.py -rvI -c tools/config/elk-defaultindex.yml -t kibana rules/ > /dev/null
	coverage report --fail-under=90
