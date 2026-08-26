#!/usr/bin/env bash

hour=$(date +%H) # 01-12
minute=$(date +%M)

icons=(
    "󱑖" # 12
    "󱑋" # 1
    "󱑌" # 2
    "󱑍" # 3
    "󱑎" # 4
    "󱑏" # 5
    "󱑐" # 6
    "󱑑" # 7
    "󱑒" # 8
    "󱑓" # 9
    "󱑔" # 10
    "󱑕" # 11
)

idx=$((10#$hour % 12))

printf '{"text":"%s %s:%s"}\n' "${icons[$idx]}" "$hour" "$minute"
