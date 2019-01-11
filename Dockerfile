FROM golang:1.11-alpine

ENV GORELEASER_VERSION 0.96.0
ENV GITHUBRELEASE_VERSION 0.7.2

# Install git
RUN apk update && \
    apk add --no-cache git rpm gcc libc-dev openssh bash make

# Get goreleaser
RUN wget -O goreleaser.tar.gz "https://github.com/goreleaser/goreleaser/releases/download/v${GORELEASER_VERSION}/goreleaser_Linux_x86_64.tar.gz" && \
    tar xf goreleaser.tar.gz && \
    mv goreleaser /usr/local/bin && \
    rm goreleaser.tar.gz

# Get github-release
RUN wget -O github-release.tar.bz2 "https://github.com/aktau/github-release/releases/download/v${GITHUBRELEASE_VERSION}/linux-amd64-github-release.tar.bz2" && \
    tar xf github-release.tar.bz2 && \
    mv bin/linux/amd64/github-release /usr/local/bin && \
    rm -rf bin && \
    rm github-release.tar.bz2

WORKDIR /go/src/github.com/cloudradar-monitoring/frontman
CMD ["goreleaser", "--snapshot", "--rm-dist"]
