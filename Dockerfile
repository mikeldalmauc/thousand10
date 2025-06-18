# Use a lightweight Linux base
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash curl ca-certificates watchexec

# Install Lamdera CLI
RUN curl https://static.lamdera.com/bin/lamdera-1.3.2-linux-x86_64 -o /usr/local/bin/lamdera \
    && chmod a+x /usr/local/bin/lamdera

WORKDIR /app

# Copy project files
COPY . .

# Install dependencies if using npm/yarn
# RUN npm install

EXPOSE 3000

CMD ["sh", "-c", "tail -f /dev/null"]

