FROM node:18-alpine as build

WORKDIR /app
ADD . /app
RUN npm install
RUN npm run build-prod

FROM nginx:1.21-alpine
COPY --from=build /app/dist/browser /app
COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]