#!/bin/bash

upstream_url="https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf"

wget -O accelerated-domains.china.conf "$upstream_url" || {
    echo "Failed to download from $upstream_url"
    exit 1
}

echo "*.cn" >china-list.txt
awk -F '/' '{print "*."$2}' <accelerated-domains.china.conf >>china-list.txt
