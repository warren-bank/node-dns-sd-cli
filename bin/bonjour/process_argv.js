const grep_argv = require('./grep_argv')

const path = require('path')
const fs   = require('fs')

const argv_flags = {
  "--help":           {bool: true},
  "--version":        {bool: true},
  "--verbose":        {bool: true},

  "--services":       {bool: true},  // --discover '_services._dns-sd._udp.local'
  "--printers":       {bool: true},  // --discover '_printer._tcp.local'
  "--chromecast":     {bool: true},  // --discover '_googlecast._tcp.local'

  "--monitor":        {bool: true},
  "--discover":       {}
}

const argv_flag_aliases = {
  "--help":           ["-h"],
  "--version":        ["-V"],
  "--verbose":        ["-v"],
  "--services":       ["-s"],
  "--printers":       ["-p"],
  "--chromecast":     ["-c"],
  "--monitor":        ["-m"],
  "--discover":       ["-d"]
}

const get_merged_argv_flags = function(){
  let argv_flags_merged = {...argv_flags}
  let key, flag_opts, aliases, alias

  for (key in argv_flag_aliases){
    flag_opts = argv_flags[key]
    aliases   = argv_flag_aliases[key]

    if ((flag_opts instanceof Object) && (Array.isArray(aliases))){
      for (alias of aliases){
        argv_flags_merged[alias] = flag_opts
      }
    }
  }

  return argv_flags_merged
}

const normalize_argv_vals = function(){
  if (! argv_vals instanceof Object) return

  let key, argv_val, aliases, alias

  for (key in argv_flag_aliases){
    argv_val = argv_vals[key]
    aliases  = argv_flag_aliases[key]

    if ((!argv_val) && (Array.isArray(aliases))){
      for (alias of aliases){
        argv_val = argv_vals[alias]
        if (argv_val) {
          argv_vals[key] = argv_val
          break
        }
      }
    }
  }
}

let argv_vals
try {
  argv_vals = grep_argv(get_merged_argv_flags(), true)

  normalize_argv_vals()
}
catch(e) {
  console.log('ERROR: ' + e.message)
  process.exit(0)
}

if (argv_vals["--help"]) {
  const help = require('./help')
  console.log(help)
  process.exit(0)
}

if (argv_vals["--version"]) {
  const data = require('../../package.json')
  console.log(data.version)
  process.exit(0)
}

if (!argv_vals["--monitor"] && !(argv_vals["--discover"] || argv_vals["--services"] || argv_vals["--printers"] || argv_vals["--chromecast"])) {
  console.log('ERROR: Service name is required for discovery')
  process.exit(0)
}

if (!argv_vals["--monitor"]) {
  if (argv_vals["--discover"]) {
    try {
      argv_vals["--discover"] = JSON.parse(argv_vals["--discover"])
    }
    catch(err) {
      argv_vals["--discover"] = {name: argv_vals["--discover"]}
    }
  }
  else {
    argv_vals["--discover"] = {}
  }

  if (argv_vals["--services"]) {
    argv_vals["--discover"].name = '_services._dns-sd._udp.local'
  }
  if (argv_vals["--printers"]) {
    argv_vals["--discover"].name = '_printer._tcp.local'
  }  if (argv_vals["--chromecast"]) {
    argv_vals["--discover"].name = '_googlecast._tcp.local'
  }
}

module.exports = argv_vals
