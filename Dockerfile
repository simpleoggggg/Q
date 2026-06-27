FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

# 1. Upgrade pip
# 2. Unzip main.zip
# 3. Check for requirements.txt before installing
# 4. Set permissions
RUN python3 -m pip install --upgrade pip && \
    unzip -o main.zip && \
    if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi && \
    chmod -R 755 /app

EXPOSE 8030

CMD ["python3", "app.py"]
