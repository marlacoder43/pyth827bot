# Python asosiy image tanlaymiz
FROM python:3.10-slim

# Kerakli tizim paketlarini o'rnatamiz
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Ishchi papkani yaratamiz
WORKDIR /app

# Avval requirements.txt ni ko'chiramiz (agar mavjud bo'lsa)
COPY requirements.txt .

# Python paketlarini o'rnatamiz
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install telethon

# Barcha fayllarni ko'chiramiz (bot.zip bundan mustasno)
COPY . .

# Agar bot.zip fayli bo'lsa, uni ochamiz
RUN if [ -f bot.zip ]; then unzip bot.zip && rm bot.zip; fi

# Botni ishga tushiramiz
CMD ["python", "main.py"]
