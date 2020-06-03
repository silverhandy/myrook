#!/bin/bash

if [[ "$1" == "local-cockroach" ]]; then
    kubectl apply -f ./cockroachdb/cockroachdb-statefulset-local.yaml
    kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "local-rook-csi-cockroach" ]]; then
    kubectl apply -f ./rook/common.yaml
    kubectl apply -f ./rook/operator.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-local.yaml
    kubectl apply -f ./rook/toolbox.yaml
    #kubectl apply -f ./rook/cephcsi-storageclass.yaml
    #kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    #kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "meta-rook-csi-cockroach" ]]; then
    kubectl apply -f ./rook/common.yaml
    kubectl apply -f ./rook/operator.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-meta.yaml
    kubectl apply -f ./rook/toolbox.yaml
    kubectl apply -f ./rook/cephcsi-storageclass.yaml
    kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "wal-rook-csi-cockroach" ]]; then
    kubectl apply -f ./rook/common-latest.yaml
    kubectl apply -f ./rook/operator-wal.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-wal.yaml
    kubectl apply -f ./rook/toolbox.yaml
    #kubectl apply -f ./rook/cephcsi-storageclass.yaml
    #kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    #kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "roc-rook-csi-cockroach" ]]; then
    kubectl apply -f ./rook/common.yaml
    kubectl apply -f ./rook/operator.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-roc.yaml
    kubectl apply -f ./rook/toolbox.yaml
    kubectl apply -f ./rook/cephcsi-storageclass.yaml
    kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    kubectl apply -f ./cockroachdb/cluster-init.yaml

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
