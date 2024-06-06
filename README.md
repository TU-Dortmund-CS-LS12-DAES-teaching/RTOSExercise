# Setup Linux

- Make sure you have the [required dependencies](https://docs.espressif.com/projects/esp-idf/en/v5.1.4/esp32/get-started/linux-macos-setup.html#for-linux-users) installed. A starting point of debian packages would be
  `git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0`
- Run the local installation script
  `./local_setup.sh`
- In order to flash the project, your user needs permissions to access the device. Consider adding your user to the dialout group: `sudo usermod -a -G dialout $USER`

# Setup macOS

- Make sure the [required dependencies](https://docs.espressif.com/projects/esp-idf/en/v5.1.4/esp32/get-started/linux-macos-setup.html#for-macos-users) are installed. If you use HomeBrew, they can be installed with:
  `brew install cmake ninja dfu-util`
- You need a Python 3 interpreter, for example, you can use the bundled Python 3.9 interpreter (on macOS Sonoma). If your bundled Python version is Python 2, [install a Python 3 interpreter](https://docs.espressif.com/projects/esp-idf/en/v5.1.4/esp32/get-started/linux-macos-setup.html#installing-python-3), for example with HomeBrew.
- Run the local installation script
  `./local_setup.sh`
