ifdef ZERORISCY_PULP
MAKE_FLAGS?= ZERORISCY_PULP=1
else
ifdef ZERORISCY
MAKE_FLAGS?= ZERORISCY=1
else
ifdef MICRORISCY
MAKE_FLAGS?= MICRORISCY=1
else
ifdef RISCY_FPU
MAKE_FLAGS?= RISCY_FPU=1
else
MAKE_FLAGS?=
endif
endif
endif
endif


.PHONY: build

build:
	if [ ! -e ri5cy_gnu_toolchain ]; then git clone https://github.com/pulp-platform/ri5cy_gnu_toolchain; fi
	cd lisc-toolchain && tar mcvfz lisc_tools_delta.tar.gz * && cp lisc_tools_delta.tar.gz $(CURDIR)/ri5cy_gnu_toolchain
	cd origin-toolchain && tar mcvfz lisc_origin-toolchain_delta.tar.gz * && cp lisc_origin-toolchain_delta.tar.gz $(CURDIR)/ri5cy_gnu_toolchain
	cp Makefile.lisc $(CURDIR)/ri5cy_gnu_toolchain/Makefile
	cd $(CURDIR)/ri5cy_gnu_toolchain && make $(MAKE_FLAGS)
	
install:
	cp -rf ./ri5cy_gnu_toolchain/install/bin .
	cd ./bin; \
	FILES=$$(ls); \
	for var in $$FILES; do \
		mv -f $$var `echo "$$var" | sed 's/^..../lisc/'`; done

clean:
	rm -rf ./bin
