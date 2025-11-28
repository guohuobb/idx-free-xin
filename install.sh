#!/bin/bash

##########################################
# 1. 安装 UUID 依赖并生成 UUID
##########################################

npm install uuid
export UUID=$(node -e "const { v4: uuidv4 } = require('uuid'); console.log(uuidv4());")
echo "Generated UUID: $UUID"


##########################################
# 2. 哪吒参数 + 固定隧道参数（已为你填好）
##########################################

# --- 哪吒（已填写） ---
export NEZHA_SERVER="cc.sssss.qzz.io:80"
export NEZHA_KEY="T4RbI87SfRzp2ZYCLuoXra58Z8hrJtPe"

# --- 固定隧道（已填写） ---
export ARGO_DOMAIN="xccc.6.d.8.b.0.d.0.0.1.0.a.2.ip6.arpa"
export ARGO_AUTH="eyJhIjoiNTY2M2Q3YmY0M2NmZGU1MDYzMjhmNjZmMDJmM2RhMDAiLCJ0IjoiZTE3ZWI4ZGYtNWY4Mi00MzdmLWJiN2YtODNlODhiM2FhMjRmIiwicyI6Ik5qWmlNREF4WVRVdFpXRTVOaTAwT0dGaExXSXlPV1l0TlRoaU1HWmlNMk14WWpZdyJ9"

# --- 其他配置（保留） ---
export NAME="idx"
export CFIP="www.visa.com.tw"
export CFPORT=443
export CHAT_ID=""
export BOT_TOKEN=""
export UPLOAD_URL=


##########################################
# 3. 启动固定 Argo 隧道
##########################################

if [[ -n "$ARGO_AUTH" ]]; then
    echo "==== 安装 cloudflared ===="
    wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
    chmod +x cloudflared

    echo "==== 启动固定 Argo 隧道 ===="
    nohup ./cloudflared tunnel run --token "$ARGO_AUTH" >/dev/null 2>&1 &

    sleep 2
    echo "Argo 隧道已后台运行"
else
    echo "未配置 ARGO_AUTH，跳过固定隧道"
fi


##########################################
# 4. 启动哪吒探针
##########################################

if [[ -n "$NEZHA_SERVER" && -n "$NEZHA_KEY" ]]; then
    echo "==== 安装哪吒探针 ===="
    wget -O nezha-agent https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_amd64
    chmod +x nezha-agent

    echo "==== 启动哪吒探针 ===="
    nohup ./nezha-agent -s "$NEZHA_SERVER" -p "$NEZHA_KEY" >/dev/null 2>&1 &

    sleep 2
    echo "哪吒探针已后台运行"
else
    echo "未填写哪吒参数，跳过启动"
fi


##########################################
# 5. 执行主 sb.sh 节点脚本
##########################################

echo "==== 开始执行主 sb.sh 部署脚本 ===="
bash <(curl -Ls https://main.ssss.nyc.mn/sb.sh)
