CONTAINER_NAME=netbeans
IMAGE=manzolo/$(CONTAINER_NAME)
APP=netbeans

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo
	@echo "Targets:"
	@echo "  help\t\tPrint this help"
	@echo "  setup\t\tBuild docker images"
	@echo "  run\t\tRun netbeans"
	@echo ""
	@echo "Example: make run"

.PHONY: setup
setup: Dockerfile
	docker image build -t $(IMAGE) .

.PHONY: run
run:
	@echo $(APP)
	docker run -it --rm -v /tmp/.X11-unix/:/tmp/.X11-unix/:ro \
	--name $(CONTAINER_NAME) \
	-v `pwd`/.netbeans:/root/.netbeans \
	-v `pwd`/Workspace:/root/NetBeansProjects/ \
	-e XAUTH=$$(xauth list|grep `uname -n` | cut -d ' ' -f5) -e "DISPLAY" \
       	$(IMAGE) $(APP)
