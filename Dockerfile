# Use a lightweight Linux base
FROM debian:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    nodejs \
    npm \
    procps \
    ca-certificates \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# 2. Instalar watchexec manualmente desde GitHub
RUN curl -L https://github.com/watchexec/watchexec/releases/download/v1.25.1/watchexec-1.25.1-x86_64-unknown-linux-gnu.tar.xz -o watchexec.tar.xz \
    && tar -xf watchexec.tar.xz \
    && mv watchexec-1.25.1-x86_64-unknown-linux-gnu/watchexec /usr/local/bin \
    && rm watchexec.tar.xz \
    && rm -rf watchexec-1.25.1-x86_64-unknown-linux-gnu

# Install Lamdera CLI
RUN curl https://static.lamdera.com/bin/lamdera-1.3.2-linux-x86_64 -o /usr/local/bin/lamdera \
    && chmod a+x /usr/local/bin/lamdera

WORKDIR /app

# 4. Copiar nuestro script de reinicio y darle permisos
COPY restart-lamdera.sh .
RUN chmod +x restart-lamdera.sh

# Copy project files
COPY . .

# Install dependencies if using npm/yarn
# RUN npm install

EXPOSE 3000

CMD ["sh", "-c", "tail -f /dev/null"]

