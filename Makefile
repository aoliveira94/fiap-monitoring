BASEDIR=$(shell pwd)

install:
	kubectl apply \
		-f kube-state-metrics/ \
		-f node-exporter/ \
		-f jenkins/ \
		-f prometheus/ \
		-f cadvisor/ \
		-f ingress
clean:
	kubectl delete \
		-f kube-state-metrics/ \
		-f node-exporter/ \
		-f jenkins/ \
		-f prometheus/ \
		-f cadvisor/ \
		-f ingress/

install_cluster:
	terraform -chdir=$(BASEDIR)/terraform/ init \
	&& terraform -chdir=$(BASEDIR)/terraform/ fmt \
	&& terraform -chdir=$(BASEDIR)/terraform/ validate \
	&& terraform -chdir=$(BASEDIR)/terraform/  plan \
	&& terraform -chdir=$(BASEDIR)/terraform/  apply -auto-approve
