<#
.Synopsis
    Resolves IP Addresses and Hostnames
.Description
    Uses ARP.EXE and [System.Net.Dns]::GetHostByAddress()
.Notes
    Takes a while to get address by hostname but successfully resolves it
#>
Import-Module $($PSScriptRoot + "\..\Modules\xProUtilities.psm1");
[Object[]]$Table = ARP.EXE -a;
[bool]$key = $false;
for($i = 3;$i -lt $Table.Length;$i++)
{
    if($key){break;}
    $str = "";
    for($n = 2;$n -lt 14;$n++)
    {
        $str += $Table[$i][$n];
    }
    try
    {
        Write-Host "`nHostename: " -ForegroundColor Cyan -NoNewline;
        Write-Host "$([System.Net.Dns]::GetHostByAddress($str.Replace(' ', '')).Hostname)";
        Write-Host "IP: " -ForegroundColor Cyan -NoNewline;
        write-Host "$($str)" -ForegroundColor Yellow;
    }
    catch [System.Management.Automation.MethodInvocationException]
    {
        Write-Host "Hostename: " -ForegroundColor Cyan -NoNewline;
        Write-Host "Cannot resolve Hostname" -ForegroundColor Yellow;
        Write-Host "IP: " -ForegroundColor Cyan -NoNewline;
        Write-Host "$($str)" -ForegroundColor Yellow;
    }
    catch 
    {
        $Global:LogHandler.WriteError($_);
        break;
    }
    $key = Test-KeyPress -Key Q; # test key
}