FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy project files
COPY . .

# 1. Upgrade pip
# 2. Unzip main.zip
# 3. Fix permissions for execution and writing
# 4. Install python dependencies
RUN python3 -m pip install --upgrade pip && \
    unzip -o main.zip && \
    chmod -R 755 /app && \
    pip3 install -r requirements.txt

EXPOSE 5000

# Execute the application
CMD ["python3", "app.py"]
