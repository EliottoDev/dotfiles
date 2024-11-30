if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Write-Host @"
[38;2;255;85;85m  _____ _ _       _   _      ____             
[38;2;80;250;123m | ____| (_) ___ | |_| |_ __|  _ \  _____   __
[38;2;239;250;120m |  _| | | |/ _ \| __| __/ _` | | | |/ _ \ \ /
[38;2;189;147;249m | |___| | | (_) | |_| || (_| | |_| |  __/\ V /
[38;2;255;121;198m |_____|_|_|\___/ \__|\__\__,_|____/ \___| \_/
[0m

Comenzando el setup de tu sistema...
"@

$response = Read-Host "¿Deseas instalar los programas? (S/N)"
if ($response -eq "S") {
    $wingetInstallations = {
        "Docker.DockerDesktop"  ,
        "Neovim.Neovim"         ,
        "RARLab.Winrar"         ,
        "GoLang.Go"             ,
        "Github.cli"            ,
        "Alacritty.Alacritty"   ,
        "Nushell.Nushell"       ,
        "Rustlang.Rustup"       ,
        "Notion.Notion"         ,
        "Python.Python.3.10"    ,
        "Starship.Starship"     ,
        "Fastfetch.Fastfetch"
    }
    
    foreach ($wingetInstallation in $wingetInstallations) {
        Write-Host "Instalando $wingetInstallation"
        winget install --id $wingetInstallation
    }
    
    Write-Host "Paquetes instalados exitosamente"
}


Write-Host "Copiando archivos de configuración"

# Crear directorios de configuración
$configDir = "$env:USERPROFILE\.config"
$devDir = "$env:USERPROFILE\dev"

New-Item -ItemType Directory -Force -Path $configDir
New-Item -ItemType Directory -Force -Path "$configDir\alacritty"
New-Item -ItemType Directory -Force -Path "$configDir\fastfetch"
New-Item -ItemType Directory -Force -Path "$configDir\nushell"
New-Item -ItemType Directory -Force -Path $devDir

# Copiar archivos de configuración
Copy-Item "alacritty.toml" -Destination "$configDir\alacritty\alacritty.toml"
Copy-Item "config.jsonc" -Destination "$configDir\fastfetch\config.jsonc" 
Copy-Item "config.nu" -Destination "$configDir\nushell\config.nu"

Write-Host "Configuración copiada exitosamente"

Pause