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
Copy-Item "Perfil.code-profile" -Destination "$configDir\Code\User\settings.json"

Write-Host "Configuración copiada exitosamente"

$responseFonts = Read-Host "¿Deseas instalar las fuentes? (S/N)"
if ($responseFonts -eq "S") {
    Write-Host "Instalando fuentes..."

    $fontsFolder = ".\fonts"
    $systemFontsFolder = "$env:windir\Fonts"
    $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

    if (Test-Path $fontsFolder) {
        Get-ChildItem -Path $fontsFolder | ForEach-Object {
            $fontName = $_.Name
            $fontPath = $_.FullName
            
            Copy-Item $fontPath -Destination $systemFontsFolder
            
            $registryValue = "$fontName"
            New-ItemProperty -Path $registryPath -Name $fontName.Replace(".*","") -Value $registryValue -PropertyType String -Force
        }
        Write-Host "Fuentes instaladas exitosamente"
    } else {
        Write-Host "No se encontró la carpeta de fuentes"
    }
}

Write-Host "Setup completado exitosamente"

Write-Host "Presiona Enter para terminar..."
Pause