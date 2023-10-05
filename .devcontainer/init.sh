#!/bin/bash
export ESP32CC=$(which xtensa-esp32-elf-gcc)
export ESP32CXX=$(which xtensa-esp32-elf-g++)
sed -i 's|"compilerPath".*|"compilerPath"\: "'"$ESP32CXX"'",|' .vscode/c_cpp_properties.json
sed -i 's|"C".*|"C"\: "'"$ESP32CC"'",|' .vscode/cmake-kits.json
sed -i 's|"CXX".*|"CXX"\: "'"$ESP32CXX"'"|' .vscode/cmake-kits.json
./tool_box.sh clean
./tool_box.sh init
