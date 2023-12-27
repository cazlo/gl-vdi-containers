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

x_server_in_container="--xc" # empty string to not use this
network="bridge" # bridge, none, or already existing docker network name
SHELL=/bin/bash
run-x11docker-xfce-rocky:
	x11docker  --backend docker --desktop \
	 --weston-xwayland \
	 --network=$(network) \
	 $(x_server_in_container) \
	 --share='/dev/kfd' --gpu \
	 --share='~/.phoronix-test-suite' \
	 --composite \
	 x11docker/xfce-rocky

run-x11docker-xfce:
	x11docker  --backend docker --desktop \
	 --weston-xwayland \
	 --network=$(network) \
	 $(x_server_in_container) \
	 --share='/dev/kfd' --gpu \
	 --share='~/.phoronix-test-suite' \
	 --composite \
	 x11docker/xfce

run-x11docker-gnome:
	x11docker  --backend docker --desktop \
	 --weston-xwayland \
	 --network=$(network) \
	 $(x_server_in_container) \
	 --share='/dev/kfd' --gpu \
	 --share='~/.phoronix-test-suite' \
	 --init=systemd \
	 x11docker/gnome

# ~16 second, only GPU
# ./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP
# ~20 second, GPU+GPU
# ./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP+CPU
# runs OK in VNC and x11docker on 22.04 + 7900xt
# in VNC can run this command at same time as virtualgl accelerated blender GUI, but saw at least 1 driver crash because of this