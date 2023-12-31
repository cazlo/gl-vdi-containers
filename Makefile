
############## vnc container pipeline

####################### base image
build-rocky-gpu-container:
	$(MAKE) -j 3 \
 		build-rocky-amd-gpu-container \
 		build-rocky-intel-gpu-container \
 		build-rocky-nvidia-gpu-container

build-rocky-amd-gpu:
	env BUILDKIT_PROGRESS=plain docker build -t rocky-amd-gpu -f vnc-container/docker-headless-vnc-container/Dockerfile.rocky-amd-gpu .

build-rocky-intel-gpu:
	env BUILDKIT_PROGRESS=plain docker build -t rocky-intel-gpu -f vnc-container/docker-headless-vnc-container/Dockerfile.rocky-intel-gpu .

build-rocky-nvidia-gpu:
	env BUILDKIT_PROGRESS=plain docker build -t rocky-nvidia-gpu -f vnc-container/docker-headless-vnc-container/Dockerfile.rocky-nvidia-gpu .

####################### Running VNC images
build-run-vnc-xfce-rocky-amdgpu:
	env BUILDKIT_PROGRESS=plain docker compose -f vnc-container/docker-headless-vnc-container/docker-compose.yml \
		run --service-ports --rm --build vnc-xfce-rocky-amdgpu

build-run-vnc-xfce-rocky-nvidiagpu:
	env BUILDKIT_PROGRESS=plain docker compose -f vnc-container/docker-headless-vnc-container/docker-compose.yml \
		run --service-ports --rm --build vnc-xfce-rocky-nvidiagpu


####################### Running XPRA images
build-run-xpra-xfce-rocky-amdgpu:
	env BUILDKIT_PROGRESS=plain docker compose -f vnc-container/docker-headless-vnc-container/docker-compose.yml \
		run --service-ports --rm --build xpra-xfce-rocky-amdgpu

build-run-xpra-xfce-rocky-intelgpu:
	env BUILDKIT_PROGRESS=plain docker compose -f vnc-container/docker-headless-vnc-container/docker-compose.yml \
		run --service-ports --rm --build xpra-xfce-rocky-intelgpu



############### x11docker pipeline

build-x11docker-all:
	$(MAKE) -j 4 \
		build-x11docker-xfce-server \
		build-x11docker-xfce-rocky \
		build-x11docker-xfce \
		build-x11docker-gnome
build-x11docker-xfce-server:
	export BUILDKIT_PROGRESS=plain && cd x11docker && \
	pushd x11docker-xserver && docker build -t x11docker/xserver . && popd
build-x11docker-xfce-rocky:
	export BUILDKIT_PROGRESS=plain && cd x11docker && \
	pushd x11docker-xfce-rocky && docker build -t x11docker/xfce-rocky . && popd
build-x11docker-xfce:
	export BUILDKIT_PROGRESS=plain && cd x11docker && \
	pushd x11docker-xfce && docker build -t x11docker/xfce . && popd
build-x11docker-gnome:
	export BUILDKIT_PROGRESS=plain && cd x11docker && \
	pushd x11docker-gnome && docker build -t x11docker/gnome . && popd

x_server_in_container=--xc # empty string to not use this
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
# only runs ok on mobile chip (780M) with blender 4.1 alpha or patch at https://projects.blender.org/blender/blender/pulls/113696 (see also https://wiki.blender.org/wiki/Reference/Release_Notes/4.1/Cycles)