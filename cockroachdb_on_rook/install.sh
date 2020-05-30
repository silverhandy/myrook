#!/bin/bash

if [[ "$1" == "rook-local" ]]; then
    kubectl apply -f ./rook/common.yaml
    kubectl apply -f ./rook/operator.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-local.yaml
    kubectl apply -f ./rook/toolbox.yaml
    kubectl apply -f ./rook/cephcsi-storageclass.yaml
    kubectl apply -f cockroachdb-statefulset.yaml
    kubectl apply -f cluster-init.yaml

elif [[ "$1" == "shutdown" ]]; then
    #kubectl delete -f local-pv.yaml --grace-period=0 --force
    #kubectl delete -f local-sc.yaml --grace-period=0 --force
    kubectl delete -f ./rook/toolbox.yaml --grace-period=0 --force
    kubectl delete -f ./rook/cluster-on-pvc-local.yaml --grace-period=0 --force
    kubectl delete -f ./rook/operator.yaml --grace-period=0 --force
    kubectl delete -f ./rook/common.yaml --grace-period=0 --force
else
    echo "Please make the right choice ~"
fi
