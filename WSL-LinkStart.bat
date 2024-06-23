@echo off
setlocal enabledelayedexpansion

:: 看看我要的IP在不在
wsl -u root ip addr | findstr "192.168.100.101" > nul
if !errorlevel! equ 0 (
    echo wsl ip has set
) else (
    ::不在的话给安排上
    wsl -u root ip addr add 192.168.100.101/24 broadcast 192.168.100.0 dev eth0 label eth0:1
    echo set wsl ip success: 192.168.100.101
)

::windows作为wsl的宿主，在wsl的固定IP的同一网段也给安排另外一个IP
ipconfig | findstr "192.168.100.200" > nul
if !errorlevel! equ 0 (
    echo windows ip has set
) else (
    netsh interface ip add address "vEthernet (WSL)" 192.168.100.200 255.255.255.0
    echo set windows ip success: 192.168.100.200
)