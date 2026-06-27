FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Added python-is-python3 to fix the 'python' command not found error
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    unzip \
    python-is-python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the zip file into the container
COPY main.zip .

# 1. Unzip the file
# 2. Upgrade pip
# 3. Install requirements
# 4. Set permissions
RUN unzip -o main.zip && \
    rm main.zip && \
    python3 -m pip install --upgrade pip && \
    if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi && \
    chmod -R 755 /app

# Port 5000 as requested
EXPOSE 5000

CMD ["python3", "app.py"]
