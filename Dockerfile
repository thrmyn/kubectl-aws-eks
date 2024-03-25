FROM amazon/aws-cli:latest
# RUN curl -sL -o /usr/bin/jq https://github.com/jqlang/jq/releases/download/jq-1.6/jq-linux64
COPY jq-linux64 /usr/bin/jq
RUN chmod +x /usr/bin/jq

RUN curl -sL -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl

COPY aws-iam-authenticator_0.6.11_linux_amd64 /usr/bin/aws-iam-authenticator
RUN chmod +x /usr/bin/aws-iam-authenticator
# curl -sL -o /usr/bin/aws-iam-authenticator $(curl -s https://api.github.com/repos/kubernetes-sigs/aws-iam-authenticator/releases/latest | jq -r ' .assets[] | select(.name | contains("linux_amd64")    )' | jq -r '.browser_download_url')  && \
#    chmod +x /usr/bin/aws-iam-authenticator && \

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
