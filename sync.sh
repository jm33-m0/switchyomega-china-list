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

echo '# upstream servers
https://9.9.9.9/dns-query
https://1.1.1.1/dns-query
https://8.8.8.8/dns-query

# jm33.me
[/jm33.me/]https://1.1.1.1/dns-query

# connectivity test
[/msftconnecttest.com/]114.114.114.114
[/msftncsi.com/]114.114.114.114
# [/googleapis.com/]114.114.114.114
# [/gstatic.com/]114.114.114.114
# [/google.cn/]114.114.114.114
# [/googleapis.cn/]114.114.114.114

# CN domains
[/cn/]114.114.114.114

# my domains
[/jm33.local/]127.0.0.1

# fuck China bing
[/bing.com/]https://1.1.1.1/dns-query
[/msn.com/]https://1.1.1.1/dns-query

# Apple domains
[/a1.mzstatic.com/]114.114.114.114
[/a2.mzstatic.com/]114.114.114.114
[/a3.mzstatic.com/]114.114.114.114
[/a4.mzstatic.com/]114.114.114.114
[/a5.mzstatic.com/]114.114.114.114
[/adcdownload.apple.com.akadns.net/]114.114.114.114
[/adcdownload.apple.com/]114.114.114.114
[/appldnld.apple.com/]114.114.114.114
[/appldnld.g.aaplimg.com/]114.114.114.114
[/appleid.cdn-apple.com/]114.114.114.114
[/apps.apple.com/]114.114.114.114
[/apps.mzstatic.com/]114.114.114.114
[/cdn-cn1.apple-mapkit.com/]114.114.114.114
[/cdn-cn2.apple-mapkit.com/]114.114.114.114
[/cdn-cn3.apple-mapkit.com/]114.114.114.114
[/cdn-cn4.apple-mapkit.com/]114.114.114.114
[/cdn.apple-mapkit.com/]114.114.114.114
[/cdn1.apple-mapkit.com/]114.114.114.114
[/cdn2.apple-mapkit.com/]114.114.114.114
[/cdn3.apple-mapkit.com/]114.114.114.114
[/cdn4.apple-mapkit.com/]114.114.114.114
[/cds-cdn.v.aaplimg.com/]114.114.114.114
[/cds.apple.com.akadns.net/]114.114.114.114
[/cds.apple.com/]114.114.114.114
[/cl1-cdn.origin-apple.com.akadns.net/]114.114.114.114
[/cl1.apple.com/]114.114.114.114
[/cl2-cn.apple.com/]114.114.114.114
[/cl2.apple.com.edgekey.net.globalredir.akadns.net/]114.114.114.114
[/cl2.apple.com/]114.114.114.114
[/cl3-cdn.origin-apple.com.akadns.net/]114.114.114.114
[/cl3.apple.com/]114.114.114.114
[/cl4-cdn.origin-apple.com.akadns.net/]114.114.114.114
[/cl4-cn.apple.com/]114.114.114.114
[/cl4.apple.com/]114.114.114.114
[/cl5-cdn.origin-apple.com.akadns.net/]114.114.114.114
[/cl5.apple.com/]114.114.114.114
[/clientflow.apple.com.akadns.net/]114.114.114.114
[/clientflow.apple.com/]114.114.114.114
[/configuration.apple.com.akadns.net/]114.114.114.114
[/configuration.apple.com/]114.114.114.114
[/cstat.apple.com/]114.114.114.114
[/dd-cdn.origin-apple.com.akadns.net/]114.114.114.114
[/download.developer.apple.com/]114.114.114.114
[/gs-loc-cn.apple.com/]114.114.114.114
[/gs-loc.apple.com/]114.114.114.114
[/gsp10-ssl-cn.ls.apple.com/]114.114.114.114
[/gsp11-cn.ls.apple.com/]114.114.114.114
[/gsp12-cn.ls.apple.com/]114.114.114.114
[/gsp13-cn.ls.apple.com/]114.114.114.114
[/gsp4-cn.ls.apple.com.edgekey.net.globalredir.akadns.net/]114.114.114.114
[/gsp4-cn.ls.apple.com.edgekey.net/]114.114.114.114
[/gsp4-cn.ls.apple.com/]114.114.114.114
[/gsp5-cn.ls.apple.com/]114.114.114.114
[/gsp85-cn-ssl.ls.apple.com/]114.114.114.114
[/gspe19-cn-ssl.ls.apple.com/]114.114.114.114
[/gspe19-cn.ls-apple.com.akadns.net/]114.114.114.114
[/gspe19-cn.ls.apple.com/]114.114.114.114
[/gspe21-ssl.ls.apple.com/]114.114.114.114
[/gspe21.ls.apple.com/]114.114.114.114
[/gspe35-ssl.ls.apple.com/]114.114.114.114
[/iadsdk.apple.com/]114.114.114.114
[/icloud-cdn.icloud.com.akadns.net/]114.114.114.114
[/icloud.cdn-apple.com/]114.114.114.114
[/images.apple.com.akadns.net/]114.114.114.114
[/images.apple.com.edgekey.net.globalredir.akadns.net/]114.114.114.114
[/images.apple.com/]114.114.114.114
[/init-p01md-lb.push-apple.com.akadns.net/]114.114.114.114
[/init-p01md.apple.com/]114.114.114.114
[/init-p01st-lb.push-apple.com.akadns.net/]114.114.114.114
[/init-p01st.push.apple.com/]114.114.114.114
[/init-s01st-lb.push-apple.com.akadns.net/]114.114.114.114
[/init-s01st.push.apple.com/]114.114.114.114
[/iosapps.itunes.g.aaplimg.com/]114.114.114.114
[/iphone-ld.apple.com/]114.114.114.114
[/is1-ssl.mzstatic.com/]114.114.114.114
[/is1.mzstatic.com/]114.114.114.114
[/is2-ssl.mzstatic.com/]114.114.114.114
[/is2.mzstatic.com/]114.114.114.114
[/is3-ssl.mzstatic.com/]114.114.114.114
[/is3.mzstatic.com/]114.114.114.114
[/is4-ssl.mzstatic.com/]114.114.114.114
[/is4.mzstatic.com/]114.114.114.114
[/is5-ssl.mzstatic.com/]114.114.114.114
[/is5.mzstatic.com/]114.114.114.114
[/itunes-apple.com.akadns.net/]114.114.114.114
[/itunes.apple.com/]114.114.114.114
[/itunesconnect.apple.com/]114.114.114.114
[/mesu-cdn.apple.com.akadns.net/]114.114.114.114
[/mesu-china.apple.com.akadns.net/]114.114.114.114
[/mesu.apple.com/]114.114.114.114
[/music.apple.com/]114.114.114.114
[/ocsp-lb.apple.com.akadns.net/]114.114.114.114
[/ocsp.apple.com/]114.114.114.114
[/oscdn.apple.com/]114.114.114.114
[/oscdn.origin-apple.com.akadns.net/]114.114.114.114
[/pancake.apple.com/]114.114.114.114
[/pancake.cdn-apple.com.akadns.net/]114.114.114.114
[/phobos.apple.com/]114.114.114.114
[/prod-support.apple-support.akadns.net/]114.114.114.114
[/reserve-prime.apple.com/]114.114.114.114
[/s.mzstatic.com/]114.114.114.114
[/stocks-sparkline-lb.apple.com.akadns.net/]114.114.114.114
[/store.apple.com.edgekey.net.globalredir.akadns.net/]114.114.114.114
[/store.apple.com.edgekey.net/]114.114.114.114
[/store.apple.com/]114.114.114.114
[/store.storeimages.apple.com.akadns.net/]114.114.114.114
[/store.storeimages.cdn-apple.com/]114.114.114.114
[/support-china.apple-support.akadns.net/]114.114.114.114
[/support.apple.com/]114.114.114.114
[/swcatalog-cdn.apple.com.akadns.net/]114.114.114.114
[/swcatalog.apple.com/]114.114.114.114
[/swcdn.apple.com/]114.114.114.114
[/swcdn.g.aaplimg.com/]114.114.114.114
[/swdist.apple.com.akadns.net/]114.114.114.114
[/swdist.apple.com/]114.114.114.114
[/swscan-cdn.apple.com.akadns.net/]114.114.114.114
[/swscan.apple.com/]114.114.114.114
[/updates-http.cdn-apple.com.akadns.net/]114.114.114.114
[/updates-http.cdn-apple.com/]114.114.114.114
[/updates.cdn-apple.com/]114.114.114.114
[/valid.apple.com/]114.114.114.114
[/valid.origin-apple.com.akadns.net/]114.114.114.114
[/www.apple.com.edgekey.net.globalredir.akadns.net/]114.114.114.114
[/www.apple.com.edgekey.net/]114.114.114.114
[/www.apple.com/]114.114.114.114

# Chinese domains
' >upstream-dns.txt

grep -v "^#" accelerated-domains.china.conf | awk -F '/' '{print "[/"$2"/]114.114.114.114"}' >>upstream-dns.txt

# commit
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git remote add gh-token "https://${{ secrets.GITHUB_TOKEN }}@github.com/google-github-actions/release-please-action.git"
git add .
git commit -a -m "Updated by Github Actions"
git push
