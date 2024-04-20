FROM ubuntu as build

RUN apt update
RUN apt install wget -y
ARG TIP=2024-04-17-03-30
ARG TARBALL="factor-linux-x86-64-${TIP}.tar.gz"
WORKDIR "/opt"
RUN wget https://downloads.factorcode.org/linux-x86-64/${TARBALL}
RUN tar -xzvf ${TARBALL}

FROM ubuntu as run

COPY --from=build /opt/factor /opt/factor
RUN mv /bin/factor /bin/coreutils-factor \
    && ln -s /opt/factor/factor /bin/factor

CMD ["factor", "-run=listener"]
