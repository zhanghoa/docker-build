FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1
ENV PLAYWRIGHT_SKIP_BROWSER_SANDBOX=1

# 安装系统依赖，解决 libgtk-3.so.0 等错误
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    libgtk-3-0 \
    libnss3 \
    libx11-xcb1 \
    libasound2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir camoufox

# 在构建时下载浏览器（避免运行时下载失败）
RUN python -m camoufox fetch

EXPOSE 9377
CMD ["sh", "-c", "xvfb-run --auto-servernum python -m camoufox run --port ${CAMOFOX_PORT:-9377} --host ${CAMOFOX_HOST:-0.0.0.0}"]
