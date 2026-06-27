FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the zip file into the container
COPY main.zip .

# 1. Unzip the file to extract app.py and other files
# 2. Upgrade pip
# 3. Install requirements if present
# 4. Set permissions
RUN unzip -o main.zip && \
    rm main.zip && \
    python3 -m pip install --upgrade pip && \
    if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi && \
    chmod -R 755 /app

EXPOSE 3522

CMD ["python3", "app.py"]
