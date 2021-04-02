# build phase 
FROM node:alpine AS node
RUN apk add yarn
FROM node as builder
WORKDIR /app   
COPY package.json .
COPY yarn.lock .
RUN yarn install
COPY . .

RUN yarn build


# run phase 
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html