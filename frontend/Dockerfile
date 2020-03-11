FROM node:13.8.0-alpine3.11

WORKDIR /frontend
COPY . .

EXPOSE 8000

RUN npm install
CMD ["npm", "start"]