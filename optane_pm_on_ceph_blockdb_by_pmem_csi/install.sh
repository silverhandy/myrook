#!/bin/bash

node_name="$(kubectl get node -o jsonpath='{.items[0].metadata.name}')"

#if [[ "$1" == "0" ]]; then
    echo "Install ipmctl and ndctl ..."

    echo "Install cfssl tools ..."

    echo "Create AppDirect Goal ..."
    sudo ipmctl create -f -goal PersistentMemoryType=AppDirect

    echo "Setup certificates ..."
    ./setup-ca-kubernetes.sh

    echo "Label the cluster node that provide persistent memory ..."
    kubectl label node $node_name storage=pmem

    echo "PMEM-CSI plugin for LVM ..."
    kubectl create -f pmem-csi-direct.yaml

    kubectl apply -f common.yaml
    kubectl apply -f operator.yaml
    kubectl apply -f pmem-volume.yaml
    kubectl apply -f cluster-on-pvc.yaml
    kubectl apply -f toolbox.yaml

    #kubectl apply -f cephcsi-storageclass.yaml
    #kubectl apply -f cephcsi-pvc.yaml
    #kubectl apply -f cephcsi-pod.yaml

