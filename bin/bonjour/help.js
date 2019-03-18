const help = `
usage:
======
bonjour <options>

options:
========
"-h"
"--help"
    Print all command-line options.

"-v"
"--version"
    Print version number.

"-s"
"--services"
    Discover services.

"-p"
"--printers"
    Discover printer devices.

"-c"
"--chromecast"
    Discover Chromecast devices.

"-d <service name>"
"--discover <service name>"
    Discover devices identified by service name.

"-d <params JSON Object>"
"--discover <params JSON Object>"
    Discover devices matching the 'params' JSON Object.

"-m"
"--monitor"
    Monitor all mDNS/DNS-SD packets.
`

module.exports = help
