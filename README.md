### [bonjour](https://github.com/warren-bank/node-dns-sd-cli)

Bonjour (DNS-SD) discovery/monitor command line tool.

#### Installation:

```bash
npm install --global @warren-bank/node-dns-sd-cli
```

#### Summary:

* adds a light-weight CLI wrapper around the library: ["node-dns-sd"](https://github.com/futomi/node-dns-sd)

#### Usage:

```bash
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
```

#### Documentation:

* [shape of `params` JSON Object](https://github.com/futomi/node-dns-sd#DnsSd-discover-method)
* [common service strings](common-service-strings.md)

#### Example:

* [this test script](https://github.com/warren-bank/node-dns-sd-cli/blob/master/tests/run.sh) is a good introduction

#### Legal:

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
