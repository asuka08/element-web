# # Builder
# FROM --platform=$BUILDPLATFORM node:20 as builder

# # Support custom branches of the react-sdk and js-sdk. This also helps us build
# # images of element-web develop.
# # ARG USE_CUSTOM_SDKS=false
# # ARG REACT_SDK_REPO="https://github.com/matrix-org/matrix-react-sdk.git"
# # ARG REACT_SDK_BRANCH="master"
# # ARG JS_SDK_REPO="https://github.com/matrix-org/matrix-js-sdk.git"
# # ARG JS_SDK_BRANCH="master"

# RUN apt-get update && apt-get install -y git dos2unix

# WORKDIR /src

# COPY . /src
# RUN dos2unix /src/scripts/docker-link-repos.sh && bash /src/scripts/docker-link-repos.sh
# RUN yarn --network-timeout=200000 install

# RUN dos2unix /src/scripts/docker-package.sh && bash /src/scripts/docker-package.sh

# Copy the config now so that we don't create another layer in the app image
# RUN cp /src/config.azure.json /src/webapp/config.json



# App
# FROM --platform=linux/amd64 nginx:alpine-slim
FROM --platform=linux/amd64 nginx@sha256:e3dd8f3abfcc0450c96d61b58c3e05b3b4fdeb0680c155aa3246f9be4b80343a

COPY ./webapp /app
COPY ./config.azure.json /app/config.json
COPY ./cona.config.azure.json /app/cona.config.json

# Override default nginx config
COPY /nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /usr/share/nginx/html \
  && ln -s /app /usr/share/nginx/html
