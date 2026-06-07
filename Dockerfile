FROM python:3.10-slim

# 禁用缓冲区，方便查看日志
ENV PYTHONUNBUFFERED=1
# 关键：禁用浏览器沙箱（Docker 容器内必须）
ENV PLAYWRIGHT_SKIP_BROWSER_SANDBOX=1

# 安装 Camoufox 运行所需的系统依赖（解决 libgtk-3.so.0 等错误）
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    libgtk-3-0 \
    libnss3 \
    libx11-xcb1 \
    libasound2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 安装 Camoufox Python 包（它会自动安装 playwright-core 等）
RUN pip install --no-cache-dir camoufox

# 关键步骤：在镜像构建期间下载 Camoufox 浏览器（固化到镜像层，避免运行时下载失败）
# 这一步会自动识别宿主架构（arm64），下载正确的浏览器二进制
RUN python -m camoufox fetch

# 暴露服务端口（camoufox run 默认使用 9377）
EXPOSE 9377

# 启动命令：使用 xvfb 创建虚拟显示器，运行 camoufox 服务
CMD ["sh", "-c", "xvfb-run --auto-servernum python -m camoufox run --port ${CAMOFOX_PORT:-9377} --host ${CAMOFOX_HOST:-0.0.0.0}"]
