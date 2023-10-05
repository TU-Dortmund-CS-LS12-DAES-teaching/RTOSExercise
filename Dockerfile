# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.241.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use ubuntu-22.04 or ubuntu-18.04 on local arm64/Apple Silicon): ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="ubuntu-22.04"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create a new user with home dir and bash as default shell
#RUN useradd -ms /bin/bash $USER

# Change to home folder
#WORKDIR /workspaces/${USER}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
        && apt-get -y install --no-install-recommends --fix-missing \
        wget flex bison gperf python3 python3-venv cmake ninja-build \
        ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 locales \
        minicom python3-pip clang-format clangd clang-tidy clang

#Configure locales
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN bash -c "locale-gen"

# Give our non root user the groups necessary for udev
# Fix for host dialout GID being different to dialout GID in ubuntu container
COPY devcontainer.env /tmp/.env
RUN export $(cat /tmp/.env | xargs) && groupmod -g $DIALOUT_GID dialout
RUN rm /tmp/.env
RUN usermod -a -G dialout $USERNAME
RUN usermod -a -G plugdev $USERNAME

# install dependencies
RUN mkdir -p /opt/esp
WORKDIR /opt/esp
RUN git clone --depth 1 --branch v4.4.5 --recursive https://github.com/espressif/esp-idf.git 
# watchy dependencies
RUN mkdir -p /opt/esp/watchy
WORKDIR /opt/esp/watchy
# clone fixed versions of watchy dependencies
RUN git clone --depth 1 --branch 1.14.2 https://github.com/adafruit/Adafruit_BusIO.git
RUN git clone --depth 1 --branch 1.11.7 https://github.com/adafruit/Adafruit-GFX-Library.git
RUN git clone --depth 1 --branch 2.0.10 https://github.com/espressif/arduino-esp32.git arduino && \
    cd arduino && \
    git submodule update --init --recursive && cd ..
RUN git clone --depth 1 --branch 0.2.0 https://github.com/arduino-libraries/Arduino_JSON.git
RUN git clone --depth 1 --branch 2.0.1 https://github.com/JChristensen/DS3232RTC.git
RUN git clone --depth 1 --branch 1.5.2 https://github.com/ZinggJM/GxEPD2.git
RUN git clone --depth 1 --branch 3.2.1 https://github.com/arduino-libraries/NTPClient.git
RUN git clone --depth 1 --branch 1.0.3 https://github.com/orbitalair/Rtc_Pcf8563.git
RUN git clone --depth 1 --branch v1.6.1 https://github.com/PaulStoffregen/Time.git
RUN git clone --depth 1 --branch v1.4.7 https://github.com/sqfmi/Watchy.git
RUN git clone --depth 1 --branch v2.0.16-rc.2 https://github.com/tzapu/WiFiManager.git
# add missing CMakeLists.txt
COPY cmakelists/Arduino_JSON.cmake /opt/esp/watchy/Arduino_JSON/CMakeLists.txt
COPY cmakelists/DS3232RTC.cmake /opt/esp/watchy/DS3232RTC/CMakeLists.txt
COPY cmakelists/GxEPD2.cmake /opt/esp/watchy/GxEPD2/CMakeLists.txt
COPY cmakelists/NTPClient.cmake /opt/esp/watchy/NTPClient/CMakeLists.txt
COPY cmakelists/Rtc_Pcf8563.cmake /opt/esp/watchy/Rtc_Pcf8563/CMakeLists.txt
COPY cmakelists/Time.cmake /opt/esp/watchy/Time/CMakeLists.txt
COPY cmakelists/Watchy.cmake /opt/esp/watchy/Watchy/CMakeLists.txt
# fix Adafruit-GFX 1.11.5 fonts include errors
# WORKDIR /opt/esp/watchy/Adafruit-GFX-Library/Fonts
# RUN for f in *.h; do sed -i '1s/^/#include <gfxfont.h>\n/' $f; done
# fix watchy revision global config setting
WORKDIR /opt/esp/watchy/Watchy/src
RUN sed -i '12s/.*/#endif/' config.h && sed -i '48s/.*//' config.h
RUN chown -R $USERNAME:$USERNAME /opt/esp
USER $USERNAME
WORKDIR /opt/esp/esp-idf
RUN bash -c "./install.sh esp32"
RUN bash -c ". ./export.sh"

RUN echo "alias get_idf='. /opt/esp/esp-idf/export.sh'" >> $HOME/.bashrc
RUN echo "get_idf" >> $HOME/.bashrc

#ARG UNAME=vscode
#ARG UID=1000
#ARG GID=1000

#RUN echo ${UID}
#RUN echo ${GID}
#RUN echo ${UNAME}

#RUN groupadd -g $GID -o $UNAME
#RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME



#Set user groups
# RUN gpasswd -a $UNAME dialout
# Post install in workspace
#USER $UNAME
#WORKDIR /home/$UNAME
#Install ESP32 IDF
#RUN mkdir esp
#WORKDIR /home/$UNAME/esp
#RUN bash -c "git clone --recursive https://github.com/espressif/esp-idf.git --branch release/v4.4"
#WORKDIR /home/$UNAME/esp/esp-idf
#RUN bash -c "./install.sh esp32"

#WORKDIR /home/$UNAME
#RUN echo "alias get_idf='. $HOME/esp/esp-idf/export.sh'" >> .bashrc
#RUN echo "get_idf" >> .bashrc
