# Multiarch Docker Example

## How to verify the remote image?
Check Validate step
* buildx itself does not load the image into the docker, we inspect buildx cache to get the hash
* we pull the image from the registry and get another hash
* we compare the hashes

## How to build for multiple architectures?
Check PLATFORMS entries in the [`build.yml`](.github/workflows/build.yml)
### Cross-compiling
* Faster
* Does not need fully emulated environment
### QEMU Emulation
* Debugging natively is simpler
* Possible to run tests
* Dependencies easier to install

## CI/CD
Please check [`build.yml`](.github/workflows/build.yml)

## Pros and Cons of Squashing Layers in Docker

Squashing layers in a Docker image refers to merging multiple image layers into a single or fewer layers.

### Squashing
* Removes redundant intermediate layers: smaller images, quicker loads and pulls
* overlayfs can produce I/O errors under stress load

### No squashing
* Enables layer caching: quicker debug and development
* Allows reusing popular basic layers e.g. ubuntu

Multi-stage builds are often a better alternative than squashing for reducing final image size while keeping caching benefits. They also allow fine tuning of the distribution.
