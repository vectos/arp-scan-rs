cargo install cross --git https://github.com/cross-rs/cross

## ARM64
cross build --release --target aarch64-unknown-linux-gnu
docker build -f Dockerfile.amd64 -t markdj/arp-scan-rs:amd64 .
docker push markdj/arp-scan-rs:amd64


## X86
cross build  --release --target x86_64-unknown-linux-gnu
docker build -f Dockerfile.arm64 -t markdj/arp-scan-rs:arm64 .
docker push markdj/arp-scan-rs:arm64


## Finalize

docker manifest create markdj/arp-scan-rs:latest \
    --amend markdj/arp-scan-rs:amd64 \
    --amend markdj/arp-scan-rs:arm64

# Push the multi-architecture manifest
docker manifest push markdj/arp-scan-rs:latest