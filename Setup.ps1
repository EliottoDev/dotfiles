if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

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
    "Python.Python.3.10"
}

foreach ($wingetInstallation in $wingetInstallations) {
    $wingetInstallation
}

Pause