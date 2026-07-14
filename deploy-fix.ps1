# Deploy a fresh branch and trigger a Vercel production deployment.
# Run this from the project root in PowerShell.

param(
    [string]$BranchName = "deploy-fix",
    [string]$CommitMessage = "Prepare new branch for clean Vercel deploy"
)

Write-Host "Working folder: $PWD" -ForegroundColor Cyan

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git tidak ditemukan. Silakan install Git terlebih dahulu.";
    exit 1
}

if (-not (Get-Command vercel -ErrorAction SilentlyContinue)) {
    Write-Error "Vercel CLI tidak ditemukan. Instal Node.js dan Vercel CLI dulu, lalu jalankan ulang skrip ini.";
    Write-Host "Untuk install Node.js + Vercel CLI: .\install-node-vercel.ps1" -ForegroundColor Yellow
    exit 1
}

# Commit changes if any
$dirty = git status --short
if ($dirty) {
    Write-Host "Menemukan perubahan lokal. Menambahkan dan meng-commit perubahan." -ForegroundColor Yellow
    git add .
    git commit -m $CommitMessage
} else {
    Write-Host "Tidak ada perubahan lokal; lanjut ke branch." -ForegroundColor Green
}

# Create or switch to branch
if (git show-ref --verify --quiet "refs/heads/$BranchName") {
    Write-Host "Berpindah ke branch '$BranchName'." -ForegroundColor Green
    git checkout $BranchName
} else {
    Write-Host "Membuat branch baru '$BranchName'." -ForegroundColor Green
    git checkout -b $BranchName
}

git push -u origin $BranchName

Write-Host "Memulai deploy Vercel production dari branch '$BranchName'..." -ForegroundColor Cyan
vercel --prod --branch $BranchName
