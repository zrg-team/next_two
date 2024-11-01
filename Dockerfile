FROM node:18.17.0-alpine

COPY . /app

WORKDIR /app

RUN yarn build

EXPOSE 80