
# Usage
docker compose up


# Purpose
This will successfully bring up a container with access to 3 gpus and run
nvidia-smi On any machine we intend to run gpu jobs, this needs to work.

# Debugging
- You see an error like OCI shim failed. This was fixed on GCP as follows:
  - enabling persistence mode on the gpu (unclear if required, but speeds up calling nvidia-smi)
  - sudo nvidia-ctk runtime configure --runtime=docker
  - systemctl restart docker

# Installation
Please see the [[https://github.com/varun-a10ai/setup_h100]] repo setting up a H100 server running Ubuntu 22.04 to work properly
