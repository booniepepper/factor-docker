FROM ubuntu as build

RUN apt update
RUN apt install wget -y
ARG TARBALL="factor-linux-x86-64-0.99.tar.gz"
WORKDIR "/opt"
RUN wget https://downloads.factorcode.org/releases/0.99/${TARBALL}
RUN tar -xzvf ${TARBALL}

FROM ubuntu as run

COPY --from=build /opt/factor /opt/factor
RUN mv /bin/factor /bin/coreutils-factor \
    && ln -s /opt/factor/factor /bin/factor

CMD ["factor", "-run=listener"]
