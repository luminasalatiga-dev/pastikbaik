# Install Node.js LTS and Vercel CLI on Windows
# Run this from the project root in an elevated PowerShell terminal.

Write-Host "Checking Winget availability..." -ForegroundColor Cyan
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget tidak ditemukan. Silakan install Node.js secara manual dari https://nodejs.org dan jalankan npm install -g vercel." -ForegroundColor Red
    exit 1
}

Write-Host "Installing Node.js LTS..." -ForegroundColor Cyan
winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements

Write-Host "Checking Node.js and npm versions..." -ForegroundColor Cyan
node --version
npm --version

Write-Host "Installing Vercel CLI globally..." -ForegroundColor Cyan
npm install -g vercel

Write-Host "Checking Vercel CLI version..." -ForegroundColor Cyan
vercel --version

Write-Host "Selesai. Jika semua terpasang, jalankan 'vercel --prod' di folder proyek untuk deploy ulang." -ForegroundColor Green
