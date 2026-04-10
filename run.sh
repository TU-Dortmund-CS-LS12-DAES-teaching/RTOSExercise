#!/bin/bash
# Build, flash, and open serial monitor. Run local_setup.sh first.
. ./esp/esp-idf/export.sh
idf.py build flash monitor
