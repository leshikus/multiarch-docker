FROM ubuntu:latest AS builder
RUN apt-get update && apt-get install -y make gcc && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY c-app/*.c c-app/Makefile .
RUN make

FROM scratch

COPY --from=builder /app/main /usr/bin/main
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /tmp /tmp

ENTRYPOINT ["/usr/bin/main"]
