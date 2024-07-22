FROM gcr.io/distroless/static:sha256-e9168165836a0e692fbd161177ea950bfc17e3ec476fff726ff7c038e62e5cc8.att

LABEL org.label-schema.description="signer-example Docker Image"
LABEL org.label-schema.name="ghcr.io/synapsecns/sanguine/contrib/signer-example"
LABEL org.label-schema.schema-version="1.0.0"
LABEL org.label-schema.vcs-url="https://github.com/synapsecns/sanguine"
LABEL org.opencontainers.image.source="https://github.com/synapsecns/sanguine"
LABEL org.opencontainers.image.description="signer-example Docker image"

USER nonroot:nonroot

WORKDIR /app
COPY --chown=nonroot:nonroot signer-example /app/signer-example

ENTRYPOINT ["/app/signer-example"]
