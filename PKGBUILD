# Maintainer: Yasuo Ozu <yasuo@ozu.email>
pkgname=line-latest
pkgver=5.16.2.1932
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
	mkdir -p "${srcdir}/wine"
	export WINEPREFIX="${srcdir}/wine"
	wine LineInst.exe /S &> /dev/null || :
	grep "${srcdir}/wine" -rl "/home/"`whoami`"/.local/share/applications/" | xargs -I{} rm "{}" &>/dev/null
	find "${srcdir}/wine/drive_c/users/"`whoami`"/Local Settings/Application Data/LINE/bin" -maxdepth 1 -type d | tail -n 1 | sed -e 's/^.*\/\([^\/]*\)$/\1/'
}

build() {
	local bindir="${srcdir}/wine/drive_c/users/"`whoami`"/Local Settings/Application Data/LINE/bin"
	local delete_executable=`find "$bindir" -maxdepth 1 -type d | tail -n 1`"/LineUpdater.exe"
	rm "$delete_executable"
	cp "${srcdir}/wine/drive_c/windows/rundll.exe" "$delete_executable"
	cp -r "$bindir" "${srcdir}/bin"
	: > "${srcdir}/bin/update_log.txt"
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
