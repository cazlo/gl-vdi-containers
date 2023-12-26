build-vnc-container:
	docker build -t rocky-xfce-vnc -f vnc-container/docker-headless-vnc-container/Dockerfile.rocky-xfce-vnc .

build-run-vnc-container:
	docker-compose -f vnc-container/docker-headless-vnc-container/docker-compose.yml up --build