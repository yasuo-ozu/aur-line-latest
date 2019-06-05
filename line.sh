#!/bin/bash
unset WINEPREFIX
#export WINEPREFIX="${HOME}/Documents/aur-line-latest/src/wine"

if [ ! -d "${HOME}/.wine" ]; then
	wineboot -i
fi

BASEDIR="${HOME}/.wine/drive_c/users/`whoami`/Local Settings/Application Data/LINE"
SRCDIR="/usr/share/LINE"

#if [ ! -d "${BASEDIR}" ]; then
	rm -rf "${BASEDIR}"
	mkdir -p "${BASEDIR}"
	#ln -snf "${SRCDIR}/bin" "${BASEDIR}/bin"
	cp -r "${SRCDIR}/bin" "${BASEDIR}/bin"
	mkdir -p "${HOME}/.line/Cache"
	mkdir -p "${HOME}/.line/Data"
	ln -snf "${HOME}/.line/Cache" "${BASEDIR}/" 
	ln -snf "${HOME}/.line/Data" "${BASEDIR}/" 
#fi

if grep "LINE Corporation" "${HOME}/.wine/user.reg"; then
	echo "Registry is already written."
else
	echo "Writing registry..."
	VERSION=`find "/usr/share/LINE/bin" -maxdepth 1 -type d | tail -n 1 | sed -e 's/^.*\/\([^\/]*\)$/\1/'`
	cat "/usr/share/LINE/user.reg" | sed -e 's/\$\$USER\$\$/'`whoami`'/g' | sed -e 's/\$\$VERSION\$\$/'$VERSION'/g' >> "${HOME}/.wine/user.reg"
fi

wine 'C:\users\'`whoami`'\Local Settings\Application Data\LINE\bin\LineLauncher.exe'
