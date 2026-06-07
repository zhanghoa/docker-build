# 使用极致精简的 Bookworm Slim 基础镜像
FROM node:20-bookworm-slim

ENV NODE_ENV=production
ENV PLAYWRIGHT_SKIP_BROWSER_SANDBOX=1

# 【瘦身核心 1】将更新、安装、清理压缩在同一个 RUN 指令中
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    xauth \
    libgtk-3-0 \
    libnss3 \
    libx11-xcb1 \
    libasound2 \
    libdbus-glib-1-2 \
    libgbm1 \
    fonts-liberation \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

WORKDIR /app

# 【瘦身核心 2】仅安装 Node.js 生产依赖
COPY package*.json ./
RUN npm ci --omit=dev \
    && npm cache clean --force

# 通过 Buildkit 外部挂载解压内核
ARG ARCH=aarch64
RUN --mount=type=bind,source=dist,target=/dist \
    mkdir -p /root/.cache/camoufox \
    && (unzip -q /dist/camoufox-${ARCH}.zip -d /root/.cache/camoufox || true) \
    && chmod -R 755 /root/.cache/camoufox \
    # ==============================================================
    # 【Bug 免疫补丁】拦截 Node.js 的错误环境变量，强行注入正确的 DISPLAY
    # ==============================================================
    && mv /root/.cache/camoufox/camoufox-bin /root/.cache/camoufox/camoufox-bin-real \
    && echo '#!/bin/sh' > /root/.cache/camoufox/camoufox-bin \
    && echo 'export DISPLAY=:99' >> /root/.cache/camoufox/camoufox-bin \
    && echo 'exec /root/.cache/camoufox/camoufox-bin-real "$@"' >> /root/.cache/camoufox/camoufox-bin \
    && chmod +x /root/.cache/camoufox/camoufox-bin

# 拷贝剩余的服务端源码
COPY . .

EXPOSE 9377

# ==============================================================
# 【启动命令修正】在后台启动一个干净的虚拟显示器，避开 Node 程序的残缺逻辑
# ==============================================================
CMD ["sh", "-c", "Xvfb :99 -screen 0 1280x1024x24 -nolisten tcp & sleep 1 && npm start"]
