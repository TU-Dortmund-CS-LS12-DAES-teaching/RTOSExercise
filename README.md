# Setup

- Install Docker
- Add yourself to the docker group to build/run the container
``` sudo usermod -a -G docker $USER ```
- Add yourself to the dialout group for USB device access
``` sudo usermod -a -G dialout $USER ```
- Install Visual Studio Code to use the Dev Container

# Local Setup (Alternative)

- If you do no want to use docker and the devcontainer, you can also perform a local installation.
- Make sure you have the required dependencies installed. A starting point of debian packages would be
``` wget flex bison gperf python3 python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 locales minicom python3-pip clang-format clangd clang-tidy clang ```
- Run the local installation script
``` ./local_setup.sh ```
- Maybe resource your bashrc
``` source ~/.bashrc ```
- Use the manual ESP IDF controls
``` idf.py build ```
``` idf.py -p /dev/ttyUSB0 flash ```
``` idf.py -p /dev/ttyUSB0 monitor ```