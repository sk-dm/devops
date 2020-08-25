.PHONY: build, deploy, remoteinstall, update

USER ?= root
TARGET ?= 127.0.0.1
SSHPORT ?= 22
BUILDPATH ?= .
GIT ?= https://github.com/sk-dm/devops/

sync:
	docker build -t howto-bugreport $(BUILDPATH)
	docker save howto-bugreport > $(BUILDPATH)/howto-bugreport.tar
	docker rmi howto-bugreport
deploy:
	scp -P $(SSHPORT) $(BUILDPATH)/howto-bugreport.tar $(USER)@$(TARGET):/tmp/
	rm $(BUILDPATH)/howto-bugreport.tar
	-ssh -p $(SSHPORT) $(USER)@$(TARGET) "docker kill howto-bugreport && docker rm howto-bugreport && docker rmi howto-bugreport"
	ssh -p $(SSHPORT) $(USER)@$(TARGET) "docker load < /tmp/howto-bugreport.tar && rm /tmp/howto-bugreport.tar && docker run -d --name howto-bugreport -p 80:80 howto-bugreport"
remoteinstall:
	ssh-keygen -b 521 -t ecdsa -N "" -f ~/.ssh/id_htlocsrv
	ssh-copy-id -f ~/.ssh/id_htlocsrw.pub -p $(SSHPORT) $(USER)@$(TARGET)
	@apt download $(shell apt-rdepends docker-ce | grep -v "^ ")
	-ssh -p $(SSHPORT) $(USER)@$(TARGET) "mkdir /tmp/pkgs/"
	-scp -P $(SSHPORT) $(BUILDPATH)/*.deb $(USER)@$(TARGET):/tmp/pkgs/
	-ssh -p $(SSHPORT) $(USER)@$(TARGET) "apt install -y /tmp/pkgs/*.deb && rm -rd /tmp/pkgs"
	rm *.deb
update:
	git pull $(GIT) master
	crontab crontab.conf
