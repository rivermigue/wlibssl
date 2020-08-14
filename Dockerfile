FROM ubuntu:bionic

RUN apt-get update \
    && apt-get install -y tzdata libcurl4 libssl-dev \
    && rm -r /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y install software-properties-common wget \
    && wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
    && apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' \
    && add-apt-repository ppa:cybermax-dexter/sdl2-backport \
    && apt-get update \
    && apt install -y --install-recommends winehq-stable

ADD multi:babe13f2a5f03ebfe3c1186141a5839f7fa30bfb2ac4509ccd6266936aac34d3 in /root/drive_c/windows/system32/
ENV WINEPREFIX=/root
ENV WINEDLLOVERRIDES=vcruntime140_1,vcruntime140=n;mscoree,mshtml,explorer.exe,winemenubuilder.exe,services.exe,playplug.exe=d
ENV WINEDEBUG=-all
ENV PATH=/bin:/opt/wine/bin
USER 1000:1000
