#!/bin/bash
# Skill-Pathfinder Hook 安装脚本
# 将拦截 Hook 从 Skill 目录复制到 OpenClaw 全局 hooks 目录
# 
# 用法：bash scripts/install-hook.sh
# 幂等设计：重复执行不会产生副作用

HOOK_NAME="pathfinder-interceptor"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_DIR="$SKILL_DIR/hooks/$HOOK_NAME"

# 检查源目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
  echo "[!] 未找到 Hook 源目录: $SOURCE_DIR"
  echo "[!] 跳过 Hook 安装。"
  exit 0
fi

# 自动探测 OpenClaw hooks 目录
if [ -d "$HOME/.openclaw/hooks" ]; then
  TARGET_BASE="$HOME/.openclaw/hooks"
elif [ -d "$HOME/.config/openclaw/hooks" ]; then
  TARGET_BASE="$HOME/.config/openclaw/hooks"
else
  # 尝试创建默认目录
  TARGET_BASE="$HOME/.openclaw/hooks"
  mkdir -p "$TARGET_BASE" 2>/dev/null
  if [ ! -d "$TARGET_BASE" ]; then
    echo "[!] 未找到 OpenClaw hooks 目录，且无法创建。"
    echo "[!] 拦截功能将依赖 SKILL.md 中的文字指令和 Bootstrap 文件。"
    exit 0
  fi
fi

TARGET_DIR="$TARGET_BASE/$HOOK_NAME"

# 幂等安装：如果已存在则先移除旧版
if [ -d "$TARGET_DIR" ]; then
  echo "[*] Hook '$HOOK_NAME' 已存在，更新中..."
  rm -rf "$TARGET_DIR"
fi

# 复制 Hook 文件
cp -r "$SOURCE_DIR" "$TARGET_DIR"

if [ $? -eq 0 ]; then
  echo "[+] Hook '$HOOK_NAME' 已成功安装到 $TARGET_DIR"
  echo "[+] 请执行以下命令激活："
  echo "    openclaw hooks enable $HOOK_NAME"
else
  echo "[!] Hook 安装失败，请手动复制。"
  exit 1
fi
