$global:HueStatus = 0

function ICMPTest {
    Write-Output "Performing basic ICMP network test"    
        $server = "Server1", "Server2"
        $i = 0
        $total = $server.Count
    
        $server | ForEach-Object {
            Write-Progress -Activity "Checking connectivity" -Status "Checking $_ connectivity" -PercentComplete (($i / $total) * 100)
            if (Test-Connection -ComputerName $_ -Count 5) {
                Write-Output "$_ is online" 
            }
            else {
                Write-Output "$_ is offline" 
                    $global:HueStatus = 1
            }
            $i++
        }
    }
    ICMPTest
    function Test-ServerConnectivity {
        param (
            [string]$ServerName,
            [int]$PortNumber
        )
    
        $connection = Test-TCPConnection -ComputerName $ServerName -Port $PortNumber -Timeout 10000
    
        if ($connection.IsConnected) {
            Write-Output "Checking $ServerName server functionality"
            Write-Output "$ServerName service running on port $PortNumber is online" 
        }
        else {
            #Write-Output "Connection to $ServerName on port $PortNumber failed."
            Write-Output "Service using $PortNumber on $ServerName is offline" 
                $global:HueStatus = 1
        }
    }
    
    Test-ServerConnectivity -ServerName "Server1" -PortNumber 32400
    Test-ServerConnectivity -ServerName "Server2" -PortNumber 8080
    
    function Minecraft {
        $Statuscode = Invoke-WebRequest -URI https://api.mcsrvstat.us/bedrock/simple/<server1.contoso.com> | Select-Object -ExpandProperty Statuscode
        Write-Output "Checking Minecraft server functionality"
        if ($Statuscode -eq "200") {
            Write-Output "Minecraft service running on port 19132 is online" 
        } else {
            Write-Output "Service using 19132 on Minecraft is offline - API working?" 
            $global:HueStatus = 1
        }
    }
    Minecraft

#Turn Hue strip red if there is a problem with any of the server checks
if ($global:HueStatus -eq "1") {
    
    $lightNumber = 18 # Replace with your light number
    $bridgeIP = "BridgeIP" # Replace with your bridge IP address
    $username = "Username" # Replace with your Philips Hue API username

    # Set the light state to red
    #https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-7.3
    $body = @{ "on" = $true; "hue" = 65535; "sat" = 254 }
    Invoke-RestMethod -Uri "http://$bridgeIP/api/$username/lights/$lightNumber/state" -Method PUT -Body ($body | ConvertTo-Json)
}
