#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
workspace="${DIR}/workspace"

[ -d "$workspace" ] && rm -rf "$workspace"
mkdir "$workspace"
cd "$workspace"

npm init -y
npm install --save "${DIR}/.."
clear

PATH="${workspace}/node_modules/.bin:${PATH}"

bonjour --help                           >"1-help.txt"
bonjour --version                        >"2-version.txt"
bonjour --services                       >"3-discover-flag-services.txt"
bonjour --services   -v                  >"3-discover-flag-services.verbose.txt"
bonjour --printers                       >"4-discover-flag-printers.txt"
bonjour --printers   -v                  >"4-discover-flag-printers.verbose.txt"
bonjour --chromecast                     >"5-discover-flag-Chromecasts.txt"
bonjour --chromecast -v                  >"5-discover-flag-Chromecasts.verbose.txt"

params_string_name='_airplay._tcp.local'
params="$params_string_name"
bonjour --discover "$params"             >"6-discover-string-AppleTVs.txt"
bonjour --discover "$params" -v          >"6-discover-string-AppleTVs.verbose.txt"

# discover all services, filter results by the string "googlecast" (which occurs in fully qualified domain names belonging to Chromecast devices), fold results by fqdn
params_JSON='{"name":"_services._dns-sd._udp.local","filter":"googlecast","key":"fqdn","type":"PTR"}'
params="$params_JSON"
bonjour --discover "$params"             >"7-discover-json-Chromecasts.txt"
bonjour --discover "$params" -v          >"7-discover-json-Chromecasts.verbose.txt"

clear
echo press Ctrl+C to end monitoring..
bonjour --monitor                        >"8-monitor-packets.txt"
