FROM nvidia/cuda:12.2.0-devel-ubuntu22.04
RUN apt update
RUN apt install -y python3.10 pip python3-neovim
RUN pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121
RUN pip install transformers accelerate ipython numpy matplotlib sentencepiece
