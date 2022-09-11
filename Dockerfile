# Build Stage
FROM node:lts-alpine as build-stage
WORKDIR /watchtower
COPY app/github-watchtower/package*.json ./
RUN npm install
COPY app/github-watchtower .
RUN npm run build

# Production Deployment Stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /watchtower/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]