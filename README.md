# Setup Linux

- Make sure you have the required dependencies installed. A starting point of debian packages would be
  ` wget flex bison gperf python3 python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 locales minicom python3-pip clang-format clangd clang-tidy clang git python-is-python3 virtualenv`
- Run the local installation script
  `./local_setup.sh`
- Maybe resource your bashrc
  `source ~/.bashrc`
- Use the manual ESP IDF controls
  `idf.py build`
  `idf.py -p /dev/ttyUSB0 flash`
  `idf.py -p /dev/ttyUSB0 monitor`

# Setup macOS

use bundled python3 environment (python3.9)
