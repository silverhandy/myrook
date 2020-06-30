#!/bin/bash

if [[ "$1" == "local-cockroach" ]]; then
    kubectl apply -f ./cockroachdb/cockroachdb-statefulset-local.yaml
    kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "local-rook-csi" ]]; then
    kubectl apply -f ./rook/common.yaml
    kubectl apply -f ./rook/operator.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-local.yaml
    kubectl apply -f ./rook/toolbox.yaml
    kubectl apply -f ./rook/cephcsi-storageclass.yaml
    #kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    #kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "block-db-rook-csi" ]]; then
    kubectl apply -f ./rook/common.yaml
    kubectl apply -f ./rook/operator.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-meta.yaml
    kubectl apply -f ./rook/toolbox.yaml
    kubectl apply -f ./rook/cephcsi-storageclass.yaml
    kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "block-wal-rook-csi" ]]; then
    kubectl apply -f ./rook/common-latest.yaml
    kubectl apply -f ./rook/operator-wal.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-wal.yaml
    kubectl apply -f ./rook/toolbox.yaml
    #kubectl apply -f ./rook/cephcsi-storageclass.yaml
    #kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    #kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "block-db-wal-rook-csi" ]]; then
    kubectl apply -f ./rook/common-latest.yaml
    kubectl apply -f ./rook/operator-wal.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-wal.yaml
    kubectl apply -f ./rook/toolbox.yaml
    #kubectl apply -f ./rook/cephcsi-storageclass.yaml
    #kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    #kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "roc-rook-csi" ]]; then
    kubectl apply -f ./rook/common.yaml
    kubectl apply -f ./rook/operator.yaml
    kubectl apply -f local-pv.yaml
    kubectl apply -f local-sc.yaml
    kubectl apply -f ./rook/cluster-on-pvc-roc.yaml
    kubectl apply -f ./rook/toolbox.yaml
    #kubectl apply -f ./rook/cephcsi-storageclass.yaml
    #kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    #kubectl apply -f ./cockroachdb/cluster-init.yaml

else
    echo "Please make the right choice ~"
fi


if [[ "$1" == "cockroachdb-local" ]]; then
    kubectl apply -f ./cockroachdb/cockroachdb-statefulset-local.yaml
    kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "cockroachdb-rook-csi" ]]; then
    kubectl apply -f ./cockroachdb/cockroachdb-statefulset-cephcsi.yaml
    kubectl apply -f ./cockroachdb/cluster-init.yaml

elif [[ "$1" == "hammerdb-local" ]]; then
    kubectl apply -f ./hammerdb/hammerdb-statefulset-local.yaml

elif [[ "$1" == "hammerdb-local" ]]; then
    kubectl apply -f ./hammerdb/hammerdb-statefulset-cephcsi.yaml

else
    echo "Please make the right choice ..."
fi
