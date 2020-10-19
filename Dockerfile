FROM golang:1.15-alpine

ENV GORELEASER_VERSION 0.126.0
ENV GITHUBRELEASE_VERSION 0.7.2
ENV GOLANGCILINT_VERSION 1.17.0


# Install git
RUN apk update && \
    apk add --no-cache git rpm gcc libc-dev openssh bash make curl jq coreutils rsync

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

# Get golangci-lint
RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s "v${GOLANGCILINT_VERSION}"

WORKDIR /go/src/github.com/cloudradar-monitoring/frontman
CMD ["goreleaser", "--snapshot", "--rm-dist"]
