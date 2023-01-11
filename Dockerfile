FROM node:18-alpine as node

WORKDIR /app
# Installs latest Chromium (92) package.
RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs \
      yarn

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

COPY package*.json ./

COPY ./src ./src

RUN npm install

ARG RAILWAY_STATIC_URL
ARG PUBLIC_URL
ARG PORT

EXPOSE ${PORT}

CMD ["npm", "start"]
