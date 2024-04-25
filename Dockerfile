FROM node:20 AS base 

WORKDIR /app

COPY package*.json ./

RUN npm i

COPY . .

RUN npm run build


FROM node:20 AS production

WORKDIR /app

COPY --from=base /app/package*.json /app

RUN npm install --only=production

COPY --from=base /app/index.js /app/index.js

EXPOSE 1337

ENV PORT=1337

CMD ["node", "index.js"]


FROM node:20 as development

WORKDIR /app

COPY package*.json /app

RUN npm i

COPY . /app

RUN npm run develop