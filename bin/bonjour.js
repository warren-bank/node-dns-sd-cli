#! /usr/bin/env node

const argv_vals  = require('./bonjour/process_argv')
const mDnsSd     = require('node-dns-sd')

const start_monitor = function() {
  mDnsSd.ondata = (packet) => {
    console.log(JSON.stringify(packet, null, 2))
  }

  mDnsSd.startMonitoring().then(() => {
    console.log('Bonjour monitor started..')
  }).catch((error) => {
    console.error(error)
  })
}

const run_discovery = function(params) {
  mDnsSd.discover(params).then((device_list) => {
    filter_device_list(device_list)
    console.log(JSON.stringify(device_list, null, 2))
  }).catch((error) => {
    console.error(error)
  })
}

const filter_device_list = function(device_list) {
  if (argv_vals["--verbose"])
    return

  for (const device of device_list) {
    delete device.packet
    for (const key in device) {
      if (device[key] === null)
        delete device[key]
    }
  }
}

if (argv_vals["--monitor"]) {
  start_monitor()
}
else {
  run_discovery(argv_vals["--discover"])
}
