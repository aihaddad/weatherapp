FROM node:13.8.0-alpine3.11

WORKDIR /backend
COPY . .

EXPOSE 9000

RUN npm ci
CMD ["npm", "start"]