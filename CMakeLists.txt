# For more information about build system see
# https://docs.espressif.com/projects/esp-idf/en/latest/api-guides/build-system.html
# The following five lines of boilerplate have to be in your project's
# CMakeLists in this exact order for cmake to work correctly
cmake_minimum_required(VERSION 3.16)

include(esp/esp-idf/tools/cmake/project.cmake)
set(EXTRA_COMPONENT_DIRS esp/watchy)
set(COMPONENTS cxx newlib freertos esp_hw_support heap log soc hal esp_rom esp_common esp_system esp_psram spi_flash driver main arduino Watchy)
project(main)
idf_build_set_property(COMPILE_OPTIONS "-fdiagnostics-color=always" APPEND)
idf_build_set_property(COMPILE_OPTIONS "-DARDUINO_WATCHY_V20" APPEND)