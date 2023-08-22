FROM nvidia/cuda:12.2.0-devel-ubuntu22.04
RUN apt update
RUN apt install -y python3.10 pip python3-neovim python3.10-venv
RUN pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121
RUN pip install accelerate ipython numpy matplotlib sentencepiece
RUN apt install -y git
RUN pip install transformers==4.31.0 sentencepiece ninja flash-attn protobuf --no-build-isolation git+https://github.com/HazyResearch/flash-attention.git#subdirectory=csrc/rotary 

# add contents to /app directory
ADD . /app
WORKDIR /app
