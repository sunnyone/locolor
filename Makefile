all:
	install -d build
	carton exec perl munsell2rgb.pl < file > build/sunnyone.soc
