FROM base/devel:latest

RUN pacman \
      --noconfirm \
      --refresh \
      --sync \
      --sysupgrade && \
    pacman \
      --noconfirm \
      --sync \
      binutils \
      curl \
      fakeroot \
      gcc \
      jq \
      make \
      openssl \
      patch \
      pkg-config \
      cmake \
      meson \
      sudo && \
    pacman \
      --sync \
      --clean \
      --noconfirm

RUN useradd --create-home builduser && \
    echo 'builduser ALL=(ALL) NOPASSWD: ALL' \
    | EDITOR='tee -a' visudo

USER builduser
WORKDIR /home/builduser

COPY build-repo packages.txt /home/builduser/
