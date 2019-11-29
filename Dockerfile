# stage 1
FROM node:10 as build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY . .
RUN npm run build

# stage 2
FROM nginx:alpine
COPY --from=build /usr/src/app/build/ /usr/share/nginx/html
COPY default.template /etc/nginx/conf.d/default.template
ENV PORT 8080
CMD sh -c "envsubst \"`env | awk -F = '{printf \" \\\\$%s\", $1}'`\" < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
