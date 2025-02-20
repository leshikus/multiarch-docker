FROM ubuntu:latest as builder
RUN apt-get update && apt-get install -y gcc libc6-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY hello.c .
RUN gcc -o HelloWorld hello.c

FROM ubuntu:latest
RUN apt-get update && apt-get install -y libc6 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/HelloWorld /HelloWorld
COPY --from=builder /etc/passwd /etc/passwd
RUN mkdir /tmp

ENTRYPOINT ["/HelloWorld"]
