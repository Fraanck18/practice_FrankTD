# Estamos usando Java 17 como base para practicar 
FROM node:18-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /app

COPY index.js .

EXPOSE 3000

# Por ahora solo mantenemos el contenedor vivo
CMD ["node", "index.js"]
