#!/bin/bash

# chnroute
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' -o /tmp/chnroute.txt && {
    grep ipv4 /tmp/chnroute.txt | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' >chnroute.txt
}

upstream_url="https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf"

wget -O accelerated-domains.china.conf "$upstream_url" || {
    echo "Failed to download from $upstream_url"
    exit 1
}

echo "*.cn" >china-list.txt
awk -F '/' '{print "*."$2}' <accelerated-domains.china.conf >>china-list.txt

echo '
# upstream servers
10.2.3.1
https://1.1.1.1/dns-query
https://8.8.8.8/dns-query

# jm33.me
[/jm33.me/]https://1.1.1.1/dns-query

# connectivity test
[/msftconnecttest.com/]https://1.12.12.12/dns-query
[/msftncsi.com/]https://1.12.12.12/dns-query
# [/googleapis.com/]https://1.12.12.12/dns-query
# [/gstatic.com/]https://1.12.12.12/dns-query
# [/google.cn/]https://1.12.12.12/dns-query
# [/googleapis.cn/]https://1.12.12.12/dns-query

# CN domains
[/cn/]https://1.12.12.12/dns-query

# my domains
[/jm33.local/]127.0.0.1

# Apple domains
[/a1.mzstatic.com/]https://1.12.12.12/dns-query
[/a2.mzstatic.com/]https://1.12.12.12/dns-query
[/a3.mzstatic.com/]https://1.12.12.12/dns-query
[/a4.mzstatic.com/]https://1.12.12.12/dns-query
[/a5.mzstatic.com/]https://1.12.12.12/dns-query
[/adcdownload.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/adcdownload.apple.com/]https://1.12.12.12/dns-query
[/appldnld.apple.com/]https://1.12.12.12/dns-query
[/appldnld.g.aaplimg.com/]https://1.12.12.12/dns-query
[/appleid.cdn-apple.com/]https://1.12.12.12/dns-query
[/apps.apple.com/]https://1.12.12.12/dns-query
[/apps.mzstatic.com/]https://1.12.12.12/dns-query
[/cdn-cn1.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cdn-cn2.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cdn-cn3.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cdn-cn4.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cdn.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cdn1.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cdn2.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cdn3.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cdn4.apple-mapkit.com/]https://1.12.12.12/dns-query
[/cds-cdn.v.aaplimg.com/]https://1.12.12.12/dns-query
[/cds.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/cds.apple.com/]https://1.12.12.12/dns-query
[/cl1-cdn.origin-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/cl1.apple.com/]https://1.12.12.12/dns-query
[/cl2-cn.apple.com/]https://1.12.12.12/dns-query
[/cl2.apple.com.edgekey.net.globalredir.akadns.net/]https://1.12.12.12/dns-query
[/cl2.apple.com/]https://1.12.12.12/dns-query
[/cl3-cdn.origin-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/cl3.apple.com/]https://1.12.12.12/dns-query
[/cl4-cdn.origin-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/cl4-cn.apple.com/]https://1.12.12.12/dns-query
[/cl4.apple.com/]https://1.12.12.12/dns-query
[/cl5-cdn.origin-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/cl5.apple.com/]https://1.12.12.12/dns-query
[/clientflow.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/clientflow.apple.com/]https://1.12.12.12/dns-query
[/configuration.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/configuration.apple.com/]https://1.12.12.12/dns-query
[/cstat.apple.com/]https://1.12.12.12/dns-query
[/dd-cdn.origin-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/download.developer.apple.com/]https://1.12.12.12/dns-query
[/gs-loc-cn.apple.com/]https://1.12.12.12/dns-query
[/gs-loc.apple.com/]https://1.12.12.12/dns-query
[/gsp10-ssl-cn.ls.apple.com/]https://1.12.12.12/dns-query
[/gsp11-cn.ls.apple.com/]https://1.12.12.12/dns-query
[/gsp12-cn.ls.apple.com/]https://1.12.12.12/dns-query
[/gsp13-cn.ls.apple.com/]https://1.12.12.12/dns-query
[/gsp4-cn.ls.apple.com.edgekey.net.globalredir.akadns.net/]https://1.12.12.12/dns-query
[/gsp4-cn.ls.apple.com.edgekey.net/]https://1.12.12.12/dns-query
[/gsp4-cn.ls.apple.com/]https://1.12.12.12/dns-query
[/gsp5-cn.ls.apple.com/]https://1.12.12.12/dns-query
[/gsp85-cn-ssl.ls.apple.com/]https://1.12.12.12/dns-query
[/gspe19-cn-ssl.ls.apple.com/]https://1.12.12.12/dns-query
[/gspe19-cn.ls-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/gspe19-cn.ls.apple.com/]https://1.12.12.12/dns-query
[/gspe21-ssl.ls.apple.com/]https://1.12.12.12/dns-query
[/gspe21.ls.apple.com/]https://1.12.12.12/dns-query
[/gspe35-ssl.ls.apple.com/]https://1.12.12.12/dns-query
[/iadsdk.apple.com/]https://1.12.12.12/dns-query
[/icloud-cdn.icloud.com.akadns.net/]https://1.12.12.12/dns-query
[/icloud.cdn-apple.com/]https://1.12.12.12/dns-query
[/images.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/images.apple.com.edgekey.net.globalredir.akadns.net/]https://1.12.12.12/dns-query
[/images.apple.com/]https://1.12.12.12/dns-query
[/init-p01md-lb.push-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/init-p01md.apple.com/]https://1.12.12.12/dns-query
[/init-p01st-lb.push-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/init-p01st.push.apple.com/]https://1.12.12.12/dns-query
[/init-s01st-lb.push-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/init-s01st.push.apple.com/]https://1.12.12.12/dns-query
[/iosapps.itunes.g.aaplimg.com/]https://1.12.12.12/dns-query
[/iphone-ld.apple.com/]https://1.12.12.12/dns-query
[/is1-ssl.mzstatic.com/]https://1.12.12.12/dns-query
[/is1.mzstatic.com/]https://1.12.12.12/dns-query
[/is2-ssl.mzstatic.com/]https://1.12.12.12/dns-query
[/is2.mzstatic.com/]https://1.12.12.12/dns-query
[/is3-ssl.mzstatic.com/]https://1.12.12.12/dns-query
[/is3.mzstatic.com/]https://1.12.12.12/dns-query
[/is4-ssl.mzstatic.com/]https://1.12.12.12/dns-query
[/is4.mzstatic.com/]https://1.12.12.12/dns-query
[/is5-ssl.mzstatic.com/]https://1.12.12.12/dns-query
[/is5.mzstatic.com/]https://1.12.12.12/dns-query
[/itunes-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/itunes.apple.com/]https://1.12.12.12/dns-query
[/itunesconnect.apple.com/]https://1.12.12.12/dns-query
[/mesu-cdn.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/mesu-china.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/mesu.apple.com/]https://1.12.12.12/dns-query
[/music.apple.com/]https://1.12.12.12/dns-query
[/ocsp-lb.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/ocsp.apple.com/]https://1.12.12.12/dns-query
[/oscdn.apple.com/]https://1.12.12.12/dns-query
[/oscdn.origin-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/pancake.apple.com/]https://1.12.12.12/dns-query
[/pancake.cdn-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/phobos.apple.com/]https://1.12.12.12/dns-query
[/prod-support.apple-support.akadns.net/]https://1.12.12.12/dns-query
[/reserve-prime.apple.com/]https://1.12.12.12/dns-query
[/s.mzstatic.com/]https://1.12.12.12/dns-query
[/stocks-sparkline-lb.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/store.apple.com.edgekey.net.globalredir.akadns.net/]https://1.12.12.12/dns-query
[/store.apple.com.edgekey.net/]https://1.12.12.12/dns-query
[/store.apple.com/]https://1.12.12.12/dns-query
[/store.storeimages.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/store.storeimages.cdn-apple.com/]https://1.12.12.12/dns-query
[/support-china.apple-support.akadns.net/]https://1.12.12.12/dns-query
[/support.apple.com/]https://1.12.12.12/dns-query
[/swcatalog-cdn.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/swcatalog.apple.com/]https://1.12.12.12/dns-query
[/swcdn.apple.com/]https://1.12.12.12/dns-query
[/swcdn.g.aaplimg.com/]https://1.12.12.12/dns-query
[/swdist.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/swdist.apple.com/]https://1.12.12.12/dns-query
[/swscan-cdn.apple.com.akadns.net/]https://1.12.12.12/dns-query
[/swscan.apple.com/]https://1.12.12.12/dns-query
[/updates-http.cdn-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/updates-http.cdn-apple.com/]https://1.12.12.12/dns-query
[/updates.cdn-apple.com/]https://1.12.12.12/dns-query
[/valid.apple.com/]https://1.12.12.12/dns-query
[/valid.origin-apple.com.akadns.net/]https://1.12.12.12/dns-query
[/www.apple.com.edgekey.net.globalredir.akadns.net/]https://1.12.12.12/dns-query
[/www.apple.com.edgekey.net/]https://1.12.12.12/dns-query
[/www.apple.com/]https://1.12.12.12/dns-query

# Chinese domains
' >upstream-dns.txt

awk -F '/' '{print "[/"$2"/]https:\/\/1.12.12.12\/dns-query"}' <accelerated-domains.china.conf >>upstream-dns.txt

# commit
git config user.name "github-actions"
git config user.email "github-actions@users.noreply.github.com"
git add .
git commit -a -m "Updated by Github Actions"
git push
