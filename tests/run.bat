@echo off

set DIR=%~dp0.
set workspace=%DIR%\workspace

if exist "%workspace%" rmdir /Q /S "%workspace%"
mkdir "%workspace%"
cd "%workspace%"

call npm init -y
call npm install --save "%DIR%\.."
cls

set PATH=%workspace%\node_modules\.bin;%PATH%

call bonjour --help                           >"1-help.txt"
call bonjour --version                        >"2-version.txt"
call bonjour --services                       >"3-discover-flag-services.txt"
call bonjour --services   -v                  >"3-discover-flag-services.verbose.txt"
call bonjour --printers                       >"4-discover-flag-printers.txt"
call bonjour --printers   -v                  >"4-discover-flag-printers.verbose.txt"
call bonjour --chromecast                     >"5-discover-flag-Chromecasts.txt"
call bonjour --chromecast -v                  >"5-discover-flag-Chromecasts.verbose.txt"

set params_string_name="_airplay._tcp.local"
set params=%params_string_name%
call bonjour --discover %params%              >"6-discover-string-AppleTVs.txt"
call bonjour --discover %params% -v           >"6-discover-string-AppleTVs.verbose.txt"

rem :: discover all services, filter results by the string "googlecast" (which occurs in fully qualified domain names belonging to Chromecast devices), fold results by fqdn
set params_JSON={"name":"_services._dns-sd._udp.local","filter":"googlecast","key":"fqdn","type":"PTR"}
set params_JSON=%params_JSON:"=""%
set params_JSON="%params_JSON%"
set params=%params_JSON%
call bonjour --discover %params%              >"7-discover-json-Chromecasts.txt"
call bonjour --discover %params% -v           >"7-discover-json-Chromecasts.verbose.txt"

cls
echo press Ctrl+C to end monitoring..
echo (then press y+Enter to confirm the action)
call bonjour --monitor                        >"8-monitor-packets.txt"
