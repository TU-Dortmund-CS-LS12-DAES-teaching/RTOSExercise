idf_component_register( SRCS "src/JSON.cpp" "src/JSONVar.cpp"
    INCLUDE_DIRS "src"
    REQUIRES arduino)
target_compile_options(${COMPONENT_LIB} PRIVATE -Wno-error=uninitialized)
project(ArduinoJSON)