FROM node:16-slim

WORKDIR /root/2048-game

COPY ["./package*.json", "./"]

ARG PORT=8080

RUN npm install --include=dev
COPY . .

RUN npm run

ENTRYPOINT npm start

EXPOSE $PORT
