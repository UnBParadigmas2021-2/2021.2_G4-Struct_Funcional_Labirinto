FROM node:16.8.0-alpine

WORKDIR /app

RUN npm install create-elm-app -g

CMD elm-app start
