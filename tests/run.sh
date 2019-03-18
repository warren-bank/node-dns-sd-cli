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
bonjour --services                       >"3-discovery-services.txt"
bonjour --printers                       >"4-discovery-printers.txt"
bonjour --chromecast                     >"5-discovery-chromecast.txt"
bonjour --discover "_airplay._tcp.local" >"6-discovery-appletv.txt"

clear
echo press Ctrl+C to end monitoring..
bonjour --monitor                        >"7-monitor-packets.txt"
