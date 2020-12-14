
Push-Location $PSScriptRoot;
    Import-Module .\Modules\Setup.psm1;
    Write-Warning "$($Global:AppJson.RepoName) uses Microsoft.PowerShell_profile.ps1 script.  Continuing will erase the script."
    $Answer = Read-Host -Prompt "Continue(y/n)?"
    if($Answer -ne "y"){Write-Warning "Exiting...";return;}
    Write-Host "`nInitializing setup`n";
    _InitProfile;
    _InitConfig;
Pop-Location;