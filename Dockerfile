FROM ubuntu:latest AS builder
RUN apt-get update && apt-get install -y make gcc && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY c-app/*.c c-app/Makefile .
RUN make

FROM ubuntu:latest
RUN apt-get update && apt-get install -y libc6 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/main /usr/bin/main

ENTRYPOINT ["/usr/bin/main"]
