BASEDIR=$(shell pwd)

if test "$1" == ""; then
  echo "Use uma função desejada, "create_jenkins", "delete_jenkins","create_prometheus","delete_prometheus"!"
  exit 1
fi


# install:
# 	kubectl apply \
# 		-f kube-state-metrics/ \
# 		-f node-exporter/ \
# 		-f jenkins/ \
# 		-f prometheus/ \
# 		-f cadvisor/ \
# 		-f ingress
# clean:
# 	kubectl delete \
# 		-f kube-state-metrics/ \
# 		-f node-exporter/ \
# 		-f jenkins/ \
# 		-f prometheus/ \
# 		-f cadvisor/ \
# 		-f ingress/

install_cluster:
	terraform -chdir=$(BASEDIR)/terraform/ init \
	&& terraform -chdir=$(BASEDIR)/terraform/ fmt \
	&& terraform -chdir=$(BASEDIR)/terraform/ validate \
	&& terraform -chdir=$(BASEDIR)/terraform/  plan \
	&& terraform -chdir=$(BASEDIR)/terraform/  apply -auto-approve

$1