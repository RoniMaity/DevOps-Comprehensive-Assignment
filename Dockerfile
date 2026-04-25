FROM node:20-alpine AS build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY backend/package*.json ./
RUN npm install
COPY backend/ ./
COPY --from=build /app/frontend/dist ./frontend/dist
EXPOSE 80
ENV PORT=80
CMD ["node", "server.js"]