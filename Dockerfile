FROM golang:1.6.2

ENV PROJECT_PATH=/go/src/github.com/brocaar/loraserver
ENV PATH=$PATH:$PROJECT_PATH/build

# install tools
RUN go get github.com/golang/lint/golint
RUN go get github.com/kisielk/errcheck
RUN go get github.com/smartystreets/goconvey

# setup work directory
RUN mkdir -p $PROJECT_PATH
WORKDIR $PROJECT_PATH

# copy source code
COPY . $PROJECT_PATH

# build
RUN make build

#CMD ["loraserver"]

# donwload confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

# create paths
RUN mkdir -p /etc/confd/{conf.d,templates}
RUN mkdir -p /etc/lora
RUN mkdir -p /var/log/lora-network-server

# copy scripts into directories
COPY scripts/lora-network-server.tmpl /etc/confd/templates/lora-network-server.tmpl
COPY scripts/lora-network-server.toml /etc/confd/conf.d/lora-network-server.toml
COPY scripts/confd-watch-lora-network-server /usr/local/bin/confd-watch-lora-network-server
COPY scripts/start_lora_server.sh /usr/local/bin/start_lora_server.sh
RUN chmod +x /usr/local/bin/confd-watch-lora-network-server
RUN chmod +x /usr/local/bin/start_lora_server.sh

CMD ["confd-watch-lora-network-server"]
