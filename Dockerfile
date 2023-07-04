FROM node:16-alpine as builder

# Add new user
USER node

# Create folder for app
RUN mkdir -p /home/node/app

WORKDIR '/home/node/app'

COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .

RUN npm run build

# Set up web server
FROM nginx
COPY --from=builder "/home/node/app/build" "/usr/share/nginx/html"
# No need to startup nginx, is happening by default for this image