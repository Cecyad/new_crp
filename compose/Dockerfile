FROM alpine:latest

# Install awscli
RUN apk --update add python3 py3-pip bash git curl && \
    pip install pymsteams && \
    apk --purge -v del

# Install terraform
COPY --from=hashicorp/terraform:latest /bin/terraform /usr/local/bin/terraform
