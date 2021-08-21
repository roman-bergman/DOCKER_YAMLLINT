FROM alpine:latest as builder

RUN set -eux \
	&& apk add --no-cache \
		bc \
		py3-pip \
		python3

ARG VERSION
RUN set -eux \
	&& if [ "${VERSION}" = "latest" ]; then \
		pip3 install --no-cache-dir --no-compile yamllint; \
	else \
		MAJOR="$( echo "${VERSION}" | awk -F '.' '{print $1}' )"; \
		MINOR="$( echo "${VERSION}" | awk -F '.' '{print $2}' )"; \
		MINOR="$( echo "${MINOR}+1" | bc )"; \
		pip3 install --no-cache-dir --no-compile "yamllint>=${VERSION},<${MAJOR}.${MINOR}"; \
	fi \
	&& find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
	&& find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf


FROM alpine:latest as production
ARG VERSION

LABEL "maintainer"="roman.bergman <roman.bergman@protonmail.com>"
LABEL "org.opencontainers.image.authors"="roman.bergman <roman.bergman@protonmail.com>"
LABEL "org.opencontainers.image.vendor"="roman.bergman"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.url"="https://github.com/roman-bergman/DOCKER_YAMLLINT"
LABEL "org.opencontainers.image.documentation"="https://github.com/roman-bergman/DOCKER_YAMLLINT"
LABEL "org.opencontainers.image.source"="https://github.com/roman-bergman/DOCKER_YAMLLINT"
LABEL "org.opencontainers.image.ref.name"="yamllint ${VERSION}"
LABEL "org.opencontainers.image.title"="yamllint ${VERSION}"
LABEL "org.opencontainers.image.description"="yamllint ${VERSION}"

RUN set -eux \
	&& apk add --no-cache python3 \
	&& ln -sf /usr/bin/python3 /usr/bin/python \
	&& find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
	&& find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

COPY --from=builder /usr/lib/python3.9/site-packages/ /usr/lib/python3.9/site-packages/
COPY --from=builder /usr/bin/yamllint /usr/bin/yamllint

WORKDIR /opt/data

ENTRYPOINT ["yamllint"]
CMD ["--help"]
