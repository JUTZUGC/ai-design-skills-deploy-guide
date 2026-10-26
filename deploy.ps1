# AI Design Skills 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/elayadesign/ai-design-skills#install
# 更新日期：2026-10-26
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

npx -y skills@latest add https://github.com/elayadesign/ai-design-skills --skill landing-page-design -g -a trae trae-cn -y --copy
npx -y skills@latest add https://github.com/elayadesign/ai-design-skills --skill design-to-motion -g -a trae trae-cn -y --copy
npx -y skills@latest list -g

Write-Host ''

Write-Host '安装完成：重启客户端，直接说「做一个 SaaS 落地页」或「把这张设计做成循环动效」即可触发对应技能'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/elayadesign/ai-design-skills#install'
