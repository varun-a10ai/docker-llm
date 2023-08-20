FROM nvidia/cuda:12.2.0-devel-ubuntu22.04
ADD sources.list /etc/apt/sources.list
RUN apt update
RUN apt install -y python3.10 pip python3-neovim python3.10-venv
RUN pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121
RUN pip install transformers accelerate ipython numpy matplotlib sentencepiece
