#!/bin/bash
# Sets up the development environment: clones ESP-IDF v5.1.4 and all required
# Arduino/Watchy libraries into esp/, then applies compatibility patches.
# Prerequisites: git, Python 3

thispath=$(realpath .)

mkdir esp
cd esp
git clone --depth 1 --branch v5.5.2 --recursive https://github.com/espressif/esp-idf.git 

mkdir watchy
cd watchy
git clone --depth 1 --branch 1.17.4 https://github.com/adafruit/Adafruit_BusIO.git
git clone --depth 1 --branch 1.12.5 https://github.com/adafruit/Adafruit-GFX-Library.git
git clone --depth 1 --branch 3.3.7 https://github.com/espressif/arduino-esp32.git arduino && \
    cd arduino && \
    git submodule update --init --recursive && cd ..
git clone https://github.com/arduino-libraries/Arduino_JSON.git && \
    cd Arduino_JSON && \
    git reset --hard e3ff157fdac3256be6cb04dd45d207d0f6ef535b && cd ..
git clone --depth 1 --branch 3.1.2 https://github.com/JChristensen/DS3232RTC.git
git clone --depth 1 --branch 1.6.8 https://github.com/ZinggJM/GxEPD2.git
git clone --depth 1 --branch 3.2.1 https://github.com/arduino-libraries/NTPClient.git
git clone --depth 1 --branch 1.0.3 https://github.com/orbitalair/Rtc_Pcf8563.git
git clone --depth 1 --branch v1.6.1 https://github.com/PaulStoffregen/Time.git
git clone --depth 1 --branch v1.4.15 https://github.com/sqfmi/Watchy.git
git clone --depth 1 --branch v2.0.17 https://github.com/tzapu/WiFiManager.git

cd $thispath
cp patches/Arduino_JSON.cmake esp/watchy/Arduino_JSON/CMakeLists.txt
cp patches/DS3232RTC.cmake esp/watchy/DS3232RTC/CMakeLists.txt
cp patches/GxEPD2.cmake esp/watchy/GxEPD2/CMakeLists.txt
cp patches/NTPClient.cmake esp/watchy/NTPClient/CMakeLists.txt
cp patches/Rtc_Pcf8563.cmake esp/watchy/Rtc_Pcf8563/CMakeLists.txt
cp patches/Time.cmake esp/watchy/Time/CMakeLists.txt
cp patches/Watchy.cmake esp/watchy/Watchy/CMakeLists.txt

sed -i'' -e '9s/.*/                       REQUIRES arduino)/' esp/watchy/Adafruit_BusIO/CMakeLists.txt
sed -i'' -e '3368s/%5d/%5ld/' esp/watchy/WiFiManager/WiFiManager.cpp

cd $thispath/esp/esp-idf/
chmod +x install.sh 
./install.sh esp32s3
. ./export.sh