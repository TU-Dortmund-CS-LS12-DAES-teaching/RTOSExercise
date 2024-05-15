#!/bin/bash

thispath=$(realpath .)

cp CMakeLists.txt.local CMakeLists.txt

mkdir esp
cd esp
git clone --depth 1 --branch v4.4.5 --recursive https://github.com/espressif/esp-idf.git 

mkdir watchy
cd watchy
git clone --depth 1 --branch 1.14.2 https://github.com/adafruit/Adafruit_BusIO.git
git clone --depth 1 --branch 1.11.7 https://github.com/adafruit/Adafruit-GFX-Library.git
git clone --depth 1 --branch 2.0.10 https://github.com/espressif/arduino-esp32.git arduino && \
    cd arduino && \
    git submodule update --init --recursive && cd ..
git clone --depth 1 --branch 0.2.0 https://github.com/arduino-libraries/Arduino_JSON.git
git clone --depth 1 --branch 2.0.1 https://github.com/JChristensen/DS3232RTC.git
git clone --depth 1 --branch 1.5.2 https://github.com/ZinggJM/GxEPD2.git
git clone --depth 1 --branch 3.2.1 https://github.com/arduino-libraries/NTPClient.git
git clone --depth 1 --branch 1.0.3 https://github.com/orbitalair/Rtc_Pcf8563.git
git clone --depth 1 --branch v1.6.1 https://github.com/PaulStoffregen/Time.git
git clone --depth 1 --branch v1.4.7 https://github.com/sqfmi/Watchy.git
git clone --depth 1 --branch v2.0.16-rc.2 https://github.com/tzapu/WiFiManager.git

cd $thispath
cp cmakelists/Arduino_JSON.cmake esp/watchy/Arduino_JSON/CMakeLists.txt
cp cmakelists/DS3232RTC.cmake esp/watchy/DS3232RTC/CMakeLists.txt
cp cmakelists/GxEPD2.cmake esp/watchy/GxEPD2/CMakeLists.txt
cp cmakelists/NTPClient.cmake esp/watchy/NTPClient/CMakeLists.txt
cp cmakelists/Rtc_Pcf8563.cmake esp/watchy/Rtc_Pcf8563/CMakeLists.txt
cp cmakelists/Time.cmake esp/watchy/Time/CMakeLists.txt
cp cmakelists/Watchy.cmake esp/watchy/Watchy/CMakeLists.txt

cd esp/watchy/Watchy/src
sed -i '12s/.*/#endif/' config.h && sed -i '48s/.*//' config.h

cd ../../..
cd esp-idf
chmod +x install.sh
./install.sh 
. ./export.sh