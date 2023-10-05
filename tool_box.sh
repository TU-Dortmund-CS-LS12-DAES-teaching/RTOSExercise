#!/bin/bash

init(){
  #git submodule add -b release/v4.4 https://github.com/espressif/esp-idf.git
  # git submodule update --init --recursive
  # cd /opt/esp/esp-idf || exit 1
  # ./install.sh esp32
  # cd ..
  . /opt/esp/esp-idf/export.sh
  idf.py build
}

build(){
  . /opt/esp/esp-idf/export.sh
  idf.py build
  # cp build/compile_commands.json compile_commands.json
}

flash(){
  . /opt/esp/esp-idf/export.sh
  idf.py -p /dev/ttyUSB0 flash
}

monitor(){
  . /opt/esp/esp-idf/export.sh
  idf.py -p /dev/ttyUSB0 monitor
}

case $1 in
i | init | config)
  init
  ;;
b | build)
  build
  ;;
f | flash)
  flash
  ;;
m | monitor)
  monitor
  ;;
bf)
  build
  flash
  ;;
clean)
  rm -rf build
  ;;
help)
  . /opt/esp/esp-idf/export.sh
  idf.py build help
  ;;
*)
  if [ $1 ]; then
    echo "Unknown argument: $1"
  fi
  echo "Script to init, build and flash the Watchy:"
  echo "  i | init                   Init esp-idf and build it."
  echo "  b | build                  Build the project."
  echo "  f | flash                  Load the build file to Watchy."
  echo "  m | monitor                Attaches to serial port of the Watchy. (Exit with Ctrl+T -> Ctrl+X)"
  echo "  clean                      Removes build folder."
  echo "  help                       Print idf.py help."
  exit
  ;;
esac
