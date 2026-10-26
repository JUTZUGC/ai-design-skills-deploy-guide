# AI Design Skills 一键安装指南

> 第三方部署指南 · 非 AI Design Skills 官方仓库。官方项目：[elayadesign/ai-design-skills](https://github.com/elayadesign/ai-design-skills)
> 内容来自官方文档（2026-10-26）。项目迭代快，请以[官方文档](https://github.com/elayadesign/ai-design-skills#install)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用手动拷文件，让百度搭子把两个设计技能装好，之后一句话就能出页面或动效。

⚠️ 这是 Agent 技能集合（两个独立技能），不是软件，没有网页界面。需要能读 `SKILL.md` 的客户端；官方安装方式是手动拷贝技能目录，本项目没有 npm 包。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/ai-design-skills-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会用 Skills CLI 把两个设计技能都装到 Trae / Trae CN 的全局目录，再列一遍确认，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## AI Design Skills 是什么？

AI Design Skills 是开源的两个面向 Agent 的设计技能：落地页生成与设计动效（协议：MIT，<img src="https://img.shields.io/github/stars/elayadesign/ai-design-skills?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

两个设计技能：`landing-page-design` 从需求问到页面结构、转化文案与整套视觉规范；`design-to-motion` 把静态设计做成逐帧精确的循环动效，导出 MP4 与 GIF。

- `landing-page-design`：问答式 intake → 页面结构 → 文案 → 视觉系统（字体 / 间距 / 圆角 / 动效）
- `design-to-motion`：静态稿 → 循环动效，导出 MP4 与 800×500 GIF
- 官方安装：把 `skills/<name>` 拷进 `.claude/skills`（Cursor 用 rules，Codex 用 `AGENTS.md`）
- 设计变量集中在一节，改完整个技能跟着变
- 可 fork 后改字体、配色、间距做本地化

（来源：[官方仓库](https://github.com/elayadesign/ai-design-skills)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 7.1k stars | MIT 开源，更新频繁 |
| 两个技能互补 | 一个做页面，一个做动效 |
| 安装方式透明 | 本质就是 SKILL.md，能手动拷 |
| 设计变量集中 | 改一节就能换整套风格 |
| 跨客户端 | Claude Code、Cursor、Codex、Windsurf 都能用 |

| 需要注意 | 说明 |
|---|---|
| 没有 npm 包 | 不能一条命令装全部，要逐技能装 |
| 技能数量少 | 目前只有两个 |
| 效果依赖模型 | 模型弱时视觉规范执行不到位 |
| 动效导出要工具链 | MP4 / GIF 依赖执行环境 |
| 文档偏简洁 | 没有中文说明 |

> 以上基于官方文档与社区反馈整理（2026-10-26），以官方最新文档为准。

## 快速部署（官方方式）

```bash
npx -y skills@latest add https://github.com/elayadesign/ai-design-skills --skill landing-page-design -g -a trae trae-cn -y --copy
npx -y skills@latest add https://github.com/elayadesign/ai-design-skills --skill design-to-motion -g -a trae trae-cn -y --copy
npx -y skills@latest list -g
```

部署步骤来源：[https://github.com/elayadesign/ai-design-skills#install](https://github.com/elayadesign/ai-design-skills#install)

## 验证状态

| 场景 | 状态 |
|---|---|
| landing-page-design 全局安装到 Trae（隔离 HOME） | 已验证 2026-10-26 |
| design-to-motion 全局安装到 Trae（隔离 HOME） | 已验证 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

不含 MCP，是纯 markdown 技能集合。本仓库的 MCP 只提供安装步骤与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-26）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\ai-design-skills-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后：怎么用

两个技能对应两类需求，直接用自然语言说：

- 「做一个 AI 笔记工具的落地页，偏极简，主色深绿」→ 触发 `landing-page-design`
- 「把这张首页截图做成循环动效，导出 MP4 和 GIF」→ 触发 `design-to-motion`

### 两个技能分别做什么

| 技能 | 输入 | 输出 |
|---|---|---|
| `landing-page-design` | 一句需求 | 页面结构、转化文案、完整视觉规范与页面代码 |
| `design-to-motion` | 静态设计稿 | 循环动效，MP4 + 800×500 GIF |

### 想改设计风格

每个技能的字体、配色、间距、动效都集中在文件底部一节，fork 后改那一节即可，其余规则会自动跟随。

> 非 Trae 客户端：把 `skills/<name>/SKILL.md` 拷到对应规则目录（Cursor 用 `.cursor/rules`，Codex 用 `AGENTS.md`，Windsurf 用 `.windsurfrules`）。

## 常见坑

- 一次只能装一个技能：`--skill` 要分别指定，别指望装整个仓库
- 装完看不到：Skills CLI 默认装 Trae / Trae CN，其它客户端改 `-a`
- `-g` 不带 `-a` 会装到所有客户端，遇到不支持全局安装的会整条失败
- 客户端不读 SKILL.md：改成对应规则文件（AGENTS.md / .windsurfrules / .cursor/rules）
- 生成的页面像模板：需求里写清受众、行业、品牌色和参考站
- 要 MP4 导出：确认执行环境有视频导出能力，否则只能拿到动画代码

## 免责声明

本仓库为第三方指南，与 AI Design Skills 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-26），项目迭代快，请以[官方文档](https://github.com/elayadesign/ai-design-skills#install)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
