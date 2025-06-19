FROM node:20-alpine

WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install all dependencies
RUN npm install

# Copy source code
COPY . .

# Build the TypeScript code
RUN npm run build

# Ensure the build directory exists
RUN ls -la build/ || echo "Build directory missing"

# Make CLI executable if it exists
RUN test -f build/cli.js && chmod +x build/cli.js || true

EXPOSE 3000

# Start the SSE server (most common for MCP)
CMD ["node", "build/index-sse-http.js"]
