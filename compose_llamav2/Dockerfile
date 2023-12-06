FROM nvidia/cuda:12.2.0-devel-ubuntu22.04
RUN apt update
RUN apt install -y python3.10 pip python3-neovim python3.10-venv sudo curl gh git exuberant-ctags virtualenv
RUN virtualenv /venv
ENV PATH="/venv/bin:$PATH"
RUN pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121
RUN pip3 install accelerate ipython numpy matplotlib sentencepiece
RUN pip3 uninstall -y ninja && pip3 install ninja
ENV FLASH_ATTENTION_FORCE_BUILD=TRUE
RUN pip3 install transformers==4.31.0 sentencepiece ninja flash-attn protobuf --no-build-isolation git+https://github.com/HazyResearch/flash-attention.git#subdirectory=csrc/rotary  
# install neovim
RUN pip3 install "fschat[model_worker,webui]"
RUN pip3 install neovim-remote
RUN pip3 install pudb

# add contents to /app directory
ADD . /app
RUN cd /app/setup_h100 && bash setup_nodejs.sh && bash setup_neovim.sh
RUN apt install -y screen

# give users ability to access /root/venv
RUN chmod -R o=u /venv
WORKDIR /app
