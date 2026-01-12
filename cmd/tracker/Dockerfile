# Build tracker
FROM golang:1.25.3-trixie AS builder
# Install build essentials for CGO compilation
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /tmp
ENV LIBTENSORFLOW_TGZ=libtensorflow-cpu-linux-x86_64-2.11.0.tar.gz
# Download and extract TensorFlow, then clean up immediately
RUN wget -q --no-check-certificate https://storage.googleapis.com/tensorflow/libtensorflow/$LIBTENSORFLOW_TGZ \
    && tar -C /usr/local -xzf $LIBTENSORFLOW_TGZ \
    && rm -f $LIBTENSORFLOW_TGZ \
    && ldconfig /usr/local/lib
WORKDIR /go/src/github.com/artifacthub/hub
COPY go.* ./
COPY cmd/tracker cmd/tracker
COPY internal internal
WORKDIR /go/src/github.com/artifacthub/hub/cmd/tracker
# Build and clean up build artifacts and caches immediately to save space
RUN CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -o /tracker . \
    && go clean -cache -modcache -testcache \
    && rm -rf /tmp/* /var/tmp/*

# Final stage
FROM debian:trixie-slim
RUN apt-get update \
    && apt-get install -y ca-certificates \
    && groupadd -g 1000 tracker \
    && useradd -u 1000 -g tracker tracker
WORKDIR /tmp
ENV LIBTENSORFLOW_TGZ=libtensorflow-cpu-linux-x86_64-2.11.0.tar.gz
RUN apt-get install -y wget \
    && export LIBTENSORFLOW_TGZ=libtensorflow-cpu-linux-x86_64-2.11.0.tar.gz \
    && wget -q --no-check-certificate https://storage.googleapis.com/tensorflow/libtensorflow/$LIBTENSORFLOW_TGZ \
    && tar -C /usr/local -xzf $LIBTENSORFLOW_TGZ \
    && rm $LIBTENSORFLOW_TGZ \
    && wget -O /usr/local/bin/opm https://github.com/operator-framework/operator-registry/releases/download/v1.60.0/linux-amd64-opm \
    && chmod +x /usr/local/bin/opm \
    && apt-get remove -y wget \
    && ldconfig /usr/local/lib
WORKDIR /home/tracker
COPY ml ./ml
RUN mkdir -p /home/tracker/cmd/tracker
COPY --from=builder /tracker /home/tracker/cmd/tracker/tracker
RUN mkdir -p /home/tracker/.cfg
COPY configs/tracker.yaml /home/tracker/.cfg/tracker.yaml
RUN chown -R 1000:1000 /home/tracker/.cfg /home/tracker
USER 1000
WORKDIR /home/tracker/cmd/tracker
CMD ["./tracker"]
