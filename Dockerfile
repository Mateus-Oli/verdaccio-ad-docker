FROM node:alpine

ENV NODE_ENV=production

RUN mkdir -p /verdaccio/storage /verdaccio/conf

RUN addgroup -S verdaccio && \
    adduser -S -G verdaccio verdaccio && \
    chown -R verdaccio:verdaccio /verdaccio

WORKDIR /verdaccio

RUN npm i -g verdaccio verdaccio-activedirectory

ENV PORT=4873 \
    CONFIG=/verdaccio/conf/config.yml \
    BASIC=\$authenticated \
    SCOPED=\$authenticated \
    PROXY=https://registry.npmjs.org \
    WEB_ENABLE=true \
    WEB_TITLE=Verdaccio

EXPOSE ${PORT}
VOLUME /verdaccio/storage
COPY --chown=verdaccio ./config/verdaccio.yml ${CONFIG}

USER verdaccio

CMD node -e 'require("fs").writeFileSync("'${CONFIG}'", require("fs").readFileSync("'${CONFIG}'", "utf8").replace(/\$\{([A-Z|_]+)\}/g, (_, x) => process.env[x] || ""))' && \
    verdaccio --config ${CONFIG}
