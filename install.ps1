# Script de Instalacion y Actualizacion Automatica para dkript-governance (Windows PowerShell)
[CmdletBinding()]
param(
    [string]$RepoUrl = "https://github.com/dkript-web/Dkript-Governance.git"
)

$ErrorActionPreference = "Stop"

$cyan = "Cyan"
$green = "Green"
$yellow = "Yellow"
$red = "Red"

Write-Host "==========================================================" -ForegroundColor $cyan
Write-Host " [Dkript] Instalador Oficial Dkript Governance & Subagents " -ForegroundColor $cyan
Write-Host "==========================================================" -ForegroundColor $cyan

$targetDir = Join-Path -Path $HOME -ChildPath ".gemini\config\plugins\dkript-governance"

# Verificar si Git esta instalado
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) {
    Write-Host "[!] Error: 'git' no esta instalado o no se encuentra en el PATH." -ForegroundColor $red
    Write-Host "Por favor instala Git desde https://git-scm.com/ e intentalo de nuevo." -ForegroundColor $yellow
    exit 1
}

try {
    if (Test-Path $targetDir) {
        Write-Host "[i] Plugin detectado en: $targetDir" -ForegroundColor $yellow
        if (Test-Path (Join-Path $targetDir ".git")) {
            Write-Host "[>] Actualizando ultima version desde repositorio remoto..." -ForegroundColor $cyan
            git -C $targetDir fetch origin main
            git -C $targetDir reset --hard origin/main
        } else {
            Write-Host "[!] El directorio existe sin repositorio Git. Sincronizando..." -ForegroundColor $yellow
            $tempDir = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath "dkript-gov-temp-$(Get-Random)"
            git clone --depth 1 $RepoUrl $tempDir
            Copy-Item -Path "$tempDir\*" -Destination $targetDir -Recurse -Force
            if (Test-Path "$tempDir\.git") {
                Copy-Item -Path "$tempDir\.git" -Destination $targetDir -Recurse -Force
            }
            Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    } else {
        Write-Host "[>] Instalando plugin en: $targetDir..." -ForegroundColor $green
        $parentDir = Split-Path -Parent $targetDir
        if (-not (Test-Path $parentDir)) {
            New-Item -ItemType Directory -Force -Path $parentDir | Out-Null
        }
        git clone $RepoUrl $targetDir
    }

    # Habilitar plugin si agy.exe esta disponible
    if (Get-Command "agy.exe" -ErrorAction SilentlyContinue) {
        Write-Host "[>] Habilitando plugin en Antigravity CLI..." -ForegroundColor $cyan
        & agy plugin enable dkript-governance 2>$null
    }

    Write-Host ""
    Write-Host "[OK] Instalacion y sincronizacion completada exitosamente." -ForegroundColor $green
    Write-Host "[OK] Subagentes: php-reviewer, database-reviewer, a11y-architect, build-error-resolver" -ForegroundColor $cyan
    Write-Host "[OK] Reglas de gobernanza Dkript activas en tu entorno global." -ForegroundColor $cyan
}
catch {
    $msg = $_.Exception.Message
    Write-Host "[!] Error durante la instalacion: $msg" -ForegroundColor $red
    exit 1
}
