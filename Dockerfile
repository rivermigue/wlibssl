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

ENV WINEPREFIX=/root
ENV WINEDLLOVERRIDES=vcruntime140_1,vcruntime140=n;mscoree,mshtml,explorer.exe,winemenubuilder.exe,services.exe,playplug.exe=d
ENV WINEDEBUG=-all
USER 1000:1000
