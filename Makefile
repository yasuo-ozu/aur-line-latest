.PHONY:	pkg clean
pkg:	PKGBUILD
	makepkg -f
clean:
	rm -rf src pkg
	rm -f *.tar.xz LineInst.exe
