<p align="center">
<img src="https://github.com/hostmatic/PSHueServerCheck/blob/main/logo.jpg" alt="PSHueServerCheck" style="margin: 20px 0;">
</p>

*PSHueServerCheck*

## About
I wanted to have my Philips Hue LED Light strip light up red, whenever there was a problem with my servers or with the network.
I could not find anything using the latest Philips Hue API v2 and Powershell, so i decided to make it myself. 

## Current Features

- ✅Can check basic ICMP
- ✅Can perform TCP port validation
- ✅Can check Minecraft Bedrock status (Thanks to https://mcsrvstat.us - Go and donate)

## Planned Features

- ⌛Check Virtual Disk status (Raspberry Pi is missing WSman)
- ⌛Reset automatically when status changes back
- ⌛Pulsing red animation???

## Getting Started

1) Get the Philips Hue light ID and your username
2) Prepare an Raspberry Pi and install pwsh and the Test-TCPConnection module
3) Create a crontab job (sudo crontab -e)
4) Adjust values in .ps1 script

## Preview

<img src="https://github.com/hostmatic/PSHueServerCheck/blob/main/preview.gif">

## Support

- None
