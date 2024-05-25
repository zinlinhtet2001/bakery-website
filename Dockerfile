FROM node:lts-alpine3.19 AS builder
WORKDIR /home/app
COPY package.json ./package.json
RUN npm install -y
COPY . .
EXPOSE 3000

#--------------------------------------

FROM node:lts-alpine3.19
WORKDIR /home/app
COPY --from=builder /home/app/package*.json ./
COPY --from=builder /home/app/node_modules ./node_modules
COPY --from=builder /home/app/views ./views
COPY --from=builder /home/app/app.js ./app.js
COPY --from=builder /home/app/public ./public