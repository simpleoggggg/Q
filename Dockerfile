FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN python3 -m pip install --upgrade pip && \
    if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi && \
    chmod -R 755 /app

# Expose the new port
EXPOSE 3522

CMD ["python3", "app.py"]
