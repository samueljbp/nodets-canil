FROM node:18.12.1-alpine AS BUILDER

RUN npm install -g npm@9.6.6
RUN npm install -g typescript

WORKDIR /app
COPY ["./package.json", "./package-lock.json", "/app/"]
RUN  npm install --legacy-peer-deps

FROM node:18.12.1-alpine

WORKDIR /app
COPY --from=BUILDER ["/app/node_modules", "/app/node_modules"]
COPY ./dist/ /app/dist/
COPY ./public/ /app/public/
EXPOSE 4000
ENTRYPOINT ["node", "./dist/server.js"]