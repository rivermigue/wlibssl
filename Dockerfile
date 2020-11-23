FROM ubuntu:bionic

RUN apt-get update \
    && apt-get install -y tzdata libcurl4 libssl-dev gnupg ca-certificates \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && rm -r /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y install software-properties-common wget mono-complete mono-vbnc mono-xsp \
    && wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
    && apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' \
    && add-apt-repository ppa:cybermax-dexter/sdl2-backport \
    && apt-get update \
    && apt install -y --install-recommends winehq-stable
    
RUN adduser -u 1000 bedrock
RUN usermod -a -G bedrock bedrock

ENV WINEPREFIX=/home/bedrock
ENV WINEDLLOVERRIDES=vcruntime140_1,vcruntime140=n;mscoree,mshtml,explorer.exe,winemenubuilder.exe,services.exe,playplug.exe=d
ENV WINEDEBUG=-all
USER 1000:1000
