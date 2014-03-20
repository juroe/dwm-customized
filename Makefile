# customized dwm Makefile
# juroe

default: build

require-root:
	@if [ "$$(id -u)" '!=' '0' ]; then (echo 'You must be root for this action.'; exit 1); fi

build:
	$(MAKE) clean
	$(MAKE) checkout
	$(MAKE) replace-dwm-config
	$(MAKE) inject-patch-systray

clean:
	@-rm -rf dwm
	@-rm -rf dmenu

checkout:
	git clone http://git.suckless.org/dwm
	git clone http://git.suckless.org/dmenu 

inject-patch-systray:
	wget http://dwm.suckless.org/patches/dwm-6.1-systray.diff -P ./dwm
	cd ./dwm && patch -p1 < dwm-6.1-systray.diff

install: require-root
	$(MAKE) -C ./dwm
	$(MAKE) -C ./dwm install
	$(MAKE) -C ./dmenu
	$(MAKE) -C ./dmenu install

replace-dwm-config:
	@cp config.h ./dwm

