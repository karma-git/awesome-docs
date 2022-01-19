FROM alpine:3.14

RUN apk add --no-cache \
    python3~=3.9.5 \
    py3-pip~=20.3.4 \
  && pip install --no-cache-dir \
  mkdocs==1.2.3 \
  mkdocs-mermaid2-plugin~=0.5 \
  mkdocs-material~=8.1 \
  pygments~=2.11.2

RUN addgroup --gid 10001 app \
  && adduser \
    --uid 10001 \
    --home /home/app \
    --shell /bin/ash \
    --ingroup app \
    --disabled-password \
    app

COPY ./ /home/app

WORKDIR /home/app

USER app

# BUILD STATIC
# RUN mkdocs build

EXPOSE 8080

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr", "0.0.0.0:8080"]
