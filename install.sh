#!/bin/bash

npm install uuid

# 使用 Node.js 脚本生成 UUID 并赋值给环境变量
export UUID=$(node -e "const { v4: uuidv4 } = require('uuid'); console.log(uuidv4());")

# 调试输出：确认 UUID 已生成
echo "Generated UUID: $UUID"

# --- 哪吒探针配置 ---
export NEZHA_SERVER="z.kkkk.hidns.co:80"          # 哪吒面板域名。v1 填写形式：nezha.xxx.com:8008；v0 填写形式：nezha.xxx.com
export NEZHA_PORT=""            # v1 哪吒不要填写这个。v0 哪吒 agent 端口，端口为 {443, 8443, 2096, 2087, 2083, 2053} 之一时开启 TLS
export NEZHA_KEY="ZPRVZUoCu50Wz0ZiL4mSf2zZelRDh1K5"             # v1 哪吒的 NZ_CLIENT_SECRET 或 v0 哪吒 agent 密钥

# --- Argo 隧道配置 ---
export ARGO_DOMAIN="tw.a.0.f.f.0.d.0.0.1.0.a.2.ip6.arpa"           # Argo 域名，留空即启用临时隧道
export ARGO_AUTH="eyJhIjoiNzU4ZTRhMjEyNDE1NjM0NThiYWY3YmYxZDBmMDI0NWQiLCJ0IjoiNzg1ZGQxNWYtMjhmNi00ZjdiLWFmYWQtZTlmMDcyYzk1YTRkIiwicyI6Ill6aGtObVZpWWpndE5UWmtNUzAwTkdabUxXRTNNekF0WmpZd01UWmlNR1UwT0RGaiJ9"             # Argo Token 或 json，留空即启用临时隧道

# --- 其他配置 ---
export NAME="idx"               # 节点名称
export CFIP="www.visa.com.tw" # 优选 IP 或优选域名
export CFPORT=443               # 优选 IP 或优选域名对应端口
export ENCODED_CHAT_ID="Nzg4NjI4NDQwMA=="
export CHAT_ID=$(echo "$ENCODED_CHAT_ID" | base64 --decode)               # Telegram Chat ID
export ENCODED_BOT_TOKEN="NzY2OTI1ODk0NTpBQUdOVGQ4NjI1T3k2aDNvV044ZW4xRWZEbjJaWTBCanBIYw=="
export BOT_TOKEN=$(echo "$ENCODED_BOT_TOKEN" | base64 --decode)             # Telegram Bot Token。需要同时填写 Chat ID 才会推送节点到 Telegram
export UPLOAD_URL=              # 节点自动推送到订阅器，需要填写部署 merge-sub 项目后的首页地址，例如：https://merge.eooce.ggff.net

# --- 执行主部署脚本 ---
# 这会下载并执行远程的 sb.sh 脚本，并使用上面设置的环境变量
bash <(curl -Ls https://main.ssss.nyc.mn/sb.sh)
