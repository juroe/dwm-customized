# customized dwm Makefile
# juroe

require-root:
	@if [ "$$(id -u)" '!=' '0' ]; then (echo 'You must be root for this action.'; exit 1); fi

install: require-root
	git clone http://git.suckless.org/dwm
	cp headers/config.h ./dwm
	wget http://dwm.suckless.org/patches/dwm-6.1-systray.diff -P ./dwm
	cd ./dwm && patch -p1 < dwm-6.1-systray.diff
	make -C ./dwm
	git clone http://git.suckless.org/dmenu 
	make -C ./dmenu
	make -C ./dmenu install
	$(MAKE) clean

clean:
	@-rm -rf dwm
	@-rm -rf dmenu
