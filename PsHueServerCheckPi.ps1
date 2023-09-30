$global:HueStatus = 0

function ICMPTest {
    Write-Output "Performing basic ICMP network test"
        $server = "<Server1>", "<Server2>" #Replace with your servername(s)
        $i = 0
        $total = $server.Count
    
        $server | ForEach-Object {
            Write-Progress -Activity "Checking connectivity" -Status "Checking $_ connectivity" -PercentComplete (($i / $total) * 100)
            if (Test-Connection -ComputerName $_ -Count 1 -Quiet) {
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
    
        $connection = Test-TCPConnection -ComputerName $ServerName -Port $PortNumber
    
        if ($connection.IsConnected) {
            Write-Output "$ServerName service running on port $PortNumber is online"
        }
        else {
            Write-Output "Service using $PortNumber on $ServerName is offline"
                $global:HueStatus = 1
        }
    }
    
    Test-ServerConnectivity -ServerName "<Server1>" -PortNumber 80 #Replace with your servername
    Test-ServerConnectivity -ServerName "<Server2>" -PortNumber 443 #Replace with your servername
    
    function Minecraft {
        $Statuscode = Invoke-WebRequest -URI https://api.mcsrvstat.us/bedrock/simple/<server1.contoso.com> | Select-Object -ExpandProperty Statuscode #Replace with your bedrock server address
        Write-Output "Checking Minecraft server status"
        if ($Statuscode -eq "200") {
            Write-Output "Minecraft service running on port 19132 is online"
        } else {
            Write-Output "Service using 19132 on Minecraft is offline - API working?"
            $global:HueStatus = 1
        }
    }
    Minecraft

#Turn Hue strip red if there is a problem with any of the server checks
if ($HueStatus -eq "1") {
    
    $lightNumber = 18 # Replace with your light number
    $bridgeIP = "<bridgeIP>" # Replace with your bridge IP address
    $username = "<username>" # Replace with your username

    # Set the light state to red
    $body = @{ "on" = $true; "hue" = 65535; "sat" = 254 }
    Invoke-RestMethod -Uri "http://$bridgeIP/api/$username/lights/$lightNumber/state" -Method PUT -Body ($body | ConvertTo-Json)
}
