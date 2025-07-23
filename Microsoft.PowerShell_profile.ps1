Clear-Host

$ENV:GIT_CONFIG_GLOBAL="$HOME/.config/gitconfig/gitconfig"
$ENV:STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml"

$separator = if ($IsWindows) { ";" } else { ":" }
$ENV:PATH += $ENV:PATH + $separator + "$HOME/.cargo/bin"

function Load-Module {
	param(
		[Parameter(Mandatory=$true)]
		[string]$Name
	)
	if (-not (Get-Module -ListAvailable -Name $Name)) {
			Install-Module -Name $Name -Scope CurrentUser -Force
	}
}

Load-Module PSFzf
Load-Module PSReadLine
Load-Module nvm


#PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# ps-nvm
# Install-NodeVersion 21
Set-NodeVersion 21

# Starship
Invoke-Expression (&starship init powershell)

# Load Work Env:
if (Test-Path $HOME/scripts/env.ps1) {
	Import-Module $HOME/scripts/env.ps1
} else {
	Write-Host "env.ps1 not loaded"
}
