# LINE package for Arch Linux X86-64

## Including

- Latest LINE for Windows binary (runnable on wine)
- Desktop menu entry

## How to Install

```bash
$ makepkg
$ sudo pacman -U *.tar.xz
```

in makepkg, you have to follow the LINE installer manually with your mouse.
It is only for creating package file. Your system will not changed with the installer.

## Note

- DO NOT change install path in the installer.
- The wine program will create files in `~/.wine`.

