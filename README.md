<p align="center">
<img src="https://github.com/hostmatic/PSHueServerCheck/blob/main/logo.jpg" alt="PSHueServerCheck" style="margin: 20px 0;">
</p>

**PSHueServerCheck**

## Current Features

- ✅Can check basic ICMP
- ✅Can perform TCP port validation
- ✅Can check Minecraft Bedrock status

## Planned Features

- ⌛Check Virtual Disk status (Raspberry Pi is missing WSman)
- ⌛Increase timeout values to not get false positives
- ⌛Implement somekind of retry logic

## Getting Started

1) Get the Philips Hue light ID and your username
2) Prepare an Raspberry Pi and install pwsh and the Test-TCPConnection module
3) Create a crontab job (sudo crontab -e)
4) Adjust values in .ps1 script

## Preview

<img src="https://github.com/hostmatic/PSHueServerCheck/blob/main/preview.gif">

## Support

- None
