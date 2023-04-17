#!/usr/bin/env bash
TODAY_TXT="/tmp/today.txt"

if [[ ! -f "$TODAY_TXT" ]]; then
    touch "$TODAY_TXT"
fi

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $@"
}

restart_phddns() {
    phddns restart
    sleep 2
    phddns status
}

phddns enable
sleep 2

while true
do
    if [[ `date +%e` != "$(cat "$TODAY_TXT")" ]]; then
        log "This is a new day."
        date +%e > "$TODAY_TXT"
        restart_phddns
    fi

    if ! (ps -e | grep -q 'phtunnel'); then
        log "phtunnel is not running"
        restart_phddns
    fi

    sleep 5m
done
