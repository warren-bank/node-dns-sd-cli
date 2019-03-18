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
bonjour --printers                       >"4-discover-flag-printers.txt"
bonjour --chromecast                     >"5-discover-flag-Chromecasts.txt"

params_string_name='_airplay._tcp.local'
bonjour --discover "$params_string_name" >"6-discover-string-AppleTVs.txt"

# discover all services, filter results by the string "googlecast" (which occurs in fully qualified domain names belonging to Chromecast devices), fold results by fqdn
params_JSON='{"name":"_services._dns-sd._udp.local","filter":"googlecast","key":"fqdn","type":"PTR"}'
bonjour --discover "$params_JSON"        >"7-discover-json-Chromecasts.txt"

clear
echo press Ctrl+C to end monitoring..
bonjour --monitor                        >"8-monitor-packets.txt"
