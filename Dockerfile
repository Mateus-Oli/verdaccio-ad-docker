FROM node:alpine

ENV NODE_ENV=production
RUN npm i -g verdaccio verdaccio-activedirectory

RUN mkdir -p /verdaccio/storage /verdaccio/conf

RUN addgroup -S verdaccio && \
    adduser -S -G verdaccio verdaccio && \
    chown -R verdaccio:verdaccio /verdaccio

USER verdaccio
WORKDIR /verdaccio
VOLUME /verdaccio

ENV PORT=4873 \
    CONFIG=/verdaccio/conf/config.yml \
    BASIC=\$authenticated \
    SCOPED=\$authenticated \
    PROXY=https://registry.npmjs.org \
    WEB_ENABLE=true \
    WEB_TITLE=Verdaccio

COPY --chown=verdaccio ./config/verdaccio.yml ${CONFIG}

CMD node -e 'require("fs").writeFileSync("'${CONFIG}'", require("fs").readFileSync("'${CONFIG}'", "utf8").replace(/\$\{([A-Z|_]+)\}/g, (_, x) => process.env[x] || ""))' && \
    verdaccio --config ${CONFIG}
