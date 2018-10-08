Param(
    [string] [Parameter(Mandatory=$true, HelpMessage="Install Vim Config")]$InstallVim_y_n,
    [string] [Parameter(Mandatory=$true, HelpMessage="Space for Spacemacs, Custom for Custom settings")]$InstallEmacs_Space_Custom
)

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    $identity.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}

function Check-ReturnCode {
    Param(
        [int]$returnCode
    )
    if($returnCode -eq 0) {
        Write-Progress "Done"
    } else {
        Write-Error "Error"
    }
}

$PWD = (Get-Item -Path ".\").FullName
$git = 'C:\Program Files\Git\bin\git.exe'

if (!(Test-IsAdmin)) {
    throw "Please run this script with admin priviliges"
}

if (!(Test-Path $git)) {
    throw "git not found at $($git). Please install and try again"
}

Write-Output "Assuming $PWD as root directory for dot_files repository"

function Install-VimConfig {
    if (!(Test-Path $HOME\_vimrc)) {
        Write-Output "Linking .vimrc"
        cmd /c mklink $HOME\_vimrc $PWD\.vimrc
        Check-ReturnCode $?
    }

    New-Item -ItemType Directory -Force -path $HOME\vimfiles

    Write-Output "Installing vundle"
    New-Item -ItemType Directory -Force -path $HOME\vimfiles\bundle
    & $git clone "https://github.com/VundleVim/Vundle.vim.git" $HOME\vimfiles\bundle\Vundle.vim
    Check-ReturnCode $?

    New-Item -ItemType Directory -Force -path $HOME\vimfiles\colors
    & $git clone "https://github.com/anuragpeshne/wombat256.vim" $HOME\AppData\Local\Temp\wombat
    Move-Item -path $HOME\AppData\Local\Temp\wombat\colors/* -Destination $HOME\vimfiles\colors
}

function Install-Emacs {
    if ($InstallEmacs_Space_Custom -eq 'Space' ) {
        Write-Progress "Clonning Spacemacs"
        & $git clone "https://github.com/syl20bnr/spacemacs" $HOME\AppData\Roaming\.emacs.d
        Check-ReturnCode $?
        Write-Progress "Linking .spacemacs"
        cmd /c mklink $HOME\AppData\Roaming\.spacemacs $PWD\.spacemacs
        Check-ReturnCode $?
    } elseif ($InstallEmacs_Space_Custom -eq 'Custom') {
        Write-Progress "Linking .emacs.d"
        cmd /c mklink $HOME\AppData\Roaming\.spacemacs $PWD\.spacemacs
        Check-ReturnCode $?
    }
}

if ($InstalVim_y_n -eq 'y') {
    Install-VimConfig
}

Install-Emacs
