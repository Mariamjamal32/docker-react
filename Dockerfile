FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .

# do not need to perform volume mappings as in prod, there will be no changes inside the base code
RUN npm run build 

# from statements are markers of starting a new phase/step in building a project
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
