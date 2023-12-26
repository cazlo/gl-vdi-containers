build-vnc-container:
	docker build -t rocky-xfce-vnc -f vnc-container/docker-headless-vnc-container/Dockerfile.rocky-xfce-vnc .

build-run-vnc-container:
	docker-compose -f vnc-container/docker-headless-vnc-container/docker-compose.yml up --build

build-x11docker-all:
	cd x11docker && \
	pushd x11docker-gnome && docker build -t x11docker/gnome . && popd && \
	pushd x11docker-xfce && docker build -t x11docker/xfce . && popd && \
	pushd x11docker-xfce-rocky && docker build -t x11docker/xfce-rocky . && popd && \
	pushd x11docker-xserver && docker build -t x11docker/xserver . && popd