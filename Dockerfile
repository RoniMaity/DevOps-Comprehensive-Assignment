FROM node:20-alpine AS build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

FROM node:20-alpine
RUN npm install -g pm2
WORKDIR /app
COPY backend/package*.json ./
RUN npm install
COPY backend/ ./
COPY --from=build /app/frontend/dist ./frontend/dist
EXPOSE 80
ENV PORT=80
CMD ["pm2-runtime", "server.js"]