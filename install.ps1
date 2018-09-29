function Test-IsAdmin {
    $identity = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    $identity.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}

if (!(Test-IsAdmin)){
    throw "Please run this script with admin priviliges"
}

$PWD=(Get-Item -Path ".\").FullName

Write-Output "Assuming $PWD as root directory for dot_files repository"

Write-Output "Linking .vimrc" 
cmd /c mklink $HOME\_vimrc $PWD\.vimrc
Write-Output "Done"