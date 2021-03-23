# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.163.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ARG TERRAFORM_VERSION
ARG TFSEC_VERSION

ENV TERRAFORM_VERSION=0.14.8
ENV TFSEC_VERSION=0.38.4

ARG YQ_BINARY
ARG YQ_VERSION

ENV YQ_BINARY=yq_linux_arm64
ENV YQ_VERSION=v4.6.2

ENV LBC_VERSION=v2.0.0

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    curl \
    python3 \
    python3-pip \
    jq \
    gettext \
    bash-completion \
    moreutils \
    wget \
    make

RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"  && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv  terraform /bin/terraform

RUN curl -Lso tfsec https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64 && \
    chmod +x tfsec && \
    mv tfsec /bin/tfsec

RUN curl --silent --location -o /usr/local/bin/kubectl \
   https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.11/2020-09-18/bin/linux/amd64/kubectl && \
   chmod +x /usr/local/bin/kubectl

RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY} -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq

RUN pip3 install --upgrade awscli && hash -r

RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp  &&\
    mv -v /tmp/eksctl /usr/local/bin

RUN kubectl completion bash >>  ~/.bash_completion &&\
    bash /etc/profile.d/bash_completion.sh
    # . ~/.bash_completion

RUN echo 'export LBC_VERSION="v2.0.0"' >>  ~/.bash_profile
# .  ~/.bash_profile

RUN eksctl completion bash >> ~/.bash_completion &&\
    bash /etc/profile.d/bash_completion.sh
# . ~/.bash_completion
