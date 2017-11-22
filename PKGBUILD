# Maintainer: Yasuo Ozu <yasuo@ozu.email>
pkgname=line-latest
pkgver=67021904
pkgrel=1
epoch=
pkgdesc="instant messenger"
arch=("x86_64")
url=""
license=('custom')
groups=()
depends=("wine")
makedepends=("netcat" "gendesk" "wget")
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=
source=("https://scdn.line-apps.com/client/win/new/LineInst.exe" "line.sh" "user.reg")
md5sums=('SKIP' 'SKIP' 'SKIP')

prepare() {
	wget -O "${pkgname}.png" "https://lh3.googleusercontent.com/l-ZZOFGyeKYz3stUbxTECHYnXcRD66C9g0tjiWA_okVIxZyb0E7_esU8LRpq_0LFCu8Y=w300" 
	gendesk -f --pkgname "$pkgname" --pkgdesc "$pkgdesc" --name="LINE" --exec="line"
}

pkgver() {
	(
		/bin/echo -ne "HEAD /client/win/new/LineInst.exe HTTP/1.1\r\n"
		/bin/echo -ne "Host: scdn.line-apps.com\r\n"
		/bin/echo -ne "Connection: Close\r\n"
		/bin/echo -ne "User-Agent: Mozilla/5.0 (X11; Linux x86_64) Chrome\r\n"
		/bin/echo -ne "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8\r\n"
		/bin/echo -ne "Accept-Encoding: gzip, deflate\r\n"
		/bin/echo -ne "Accept-Language: ja,en-US;q=0.8,en;q=0.6\r\n"
		/bin/echo -ne "\r\n"
	) | nc scdn.line-apps.com 80|sed -ne '/^Content\-Length/p'|sed -e 's/^[^0-9]*\s\([0-9]*\)\s.*$/\1/'
}

build() {
	mkdir -p "${srcdir}/wine"
	export WINEPREFIX="${srcdir}/wine"
	echo "Now I run LINE installer."
	echo "Please install to default directory"
	wine LineInst.exe || :
	sleep 10
	echo "Removing files..."
	grep "${srcdir}/wine" -rl "/home/"`whoami`"/.local/share/applications/" | cat
	grep "${srcdir}/wine" -rl "/home/"`whoami`"/.local/share/applications/" | xargs -I{} rm "{}"
	cp -r "${srcdir}/wine/drive_c/users/"`whoami`"/Local Settings/Application Data/LINE/bin" "${srcdir}/bin"
	: > "${srcdir}/bin/update_log.txt"
	echo "*************************"
	echo "Please right-click on the LINE tray icon"
	echo "and select EXIT."
	echo "*************************"
}

package() {
	mkdir -p "${pkgdir}/usr/share/LINE"
	cp -r "${srcdir}/bin" "${pkgdir}/usr/share/LINE/"
	chmod 0755 -R "${pkgdir}/usr/share"

	install -D -m755 "${srcdir}/line.sh" "${pkgdir}/usr/bin/line"
	install -D -m644 "${srcdir}/user.reg" "${pkgdir}/usr/share/LINE/user.reg"

	# Install desktop entry
	install -Dm644 "$pkgname.desktop" "$pkgdir/usr/share/applications/$pkgname.desktop"
	install -Dm644 "$pkgname.png" "$pkgdir/usr/share/pixmaps/$pkgname.png"
}
