---
name: pathfinder-interceptor
description: "Skill-Pathfinder 的系统级拦截 Hook。在每次模型推理前自动注入任务拦截规则，确保操作类任务必须先搜索可用 Skill。"
homepage: https://github.com/hu4891/Skill-Pathfinder
---

# Pathfinder Interceptor Hook

本 Hook 在每次 Agent 会话的 `before_prompt_build` 事件中自动向系统提示词注入「强制拦截序列」规则。

## 功能
- 在模型推理前，自动通过 `prependSystemContext` 注入拦截指令
- 不依赖 Agent "读懂" SKILL.md，由平台在底层硬性注入
- 与 SKILL.md 中的文字指令 + Memory 写入 + Bootstrap 文件形成四重保障

## 安装
本 Hook 随 Skill-Pathfinder 一起分发。执行 `[AGENT POST-INSTALL HOOK]` 时会自动安装到 `~/.openclaw/hooks/` 目录。

手动安装：
```bash
cp -r hooks/pathfinder-interceptor ~/.openclaw/hooks/
openclaw hooks enable pathfinder-interceptor
```
