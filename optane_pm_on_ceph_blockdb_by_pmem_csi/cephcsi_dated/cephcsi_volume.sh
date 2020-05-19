#!/bin/bash

# Make sure 64GB+ free space.

#echo "...... Deploy Rook Ceph cluster ......"

kubectl apply -f ./rbac/rbd/
kubectl apply -f ./rbac/cephfs/

echo "...... Deploy Ceph CSI ......"

ceph_mon_ls="$(kubectl exec -ti -n rook-ceph $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') -- bash -c "cat /etc/ceph/ceph.conf | grep mon_host")"
ceph_mon_ls="$(echo $ceph_mon_ls | cut -d "=" -f2)"
ceph_mon_ls="$(echo ${ceph_mon_ls%?})"
echo $ceph_mon_ls
sed -i "s?monitors:.*?monitors: $ceph_mon_ls?" storageclass.yaml

kubectl exec -ti -n rook-ceph $(kubectl -n rook-ceph get pod -l "app=rook-ceph-operator" -o jsonpath='{.items[0].metadata.name}') -- bash -c "ceph -c /var/lib/rook/rook-ceph/rook-ceph.config auth get-or-create-key client.kube mon \"allow profile rbd\" osd \"profile rbd pool=rbd\""

admin_secret="$(kubectl exec -ti -n rook-ceph $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') -- bash -c "ceph auth get-key client.admin|base64")"
kube_secret="$(kubectl exec -ti -n rook-ceph $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') -- bash -c "ceph auth get-key client.kube|base64")"

admin_secret="$(echo ${admin_secret%?})"
kube_secret="$(echo ${kube_secret%?})"
echo $admin_secret
echo $kube_secret

sed -i "s?admin:.*?admin: \"$admin_secret\"?" secret.yaml
sed -i "s?kube:.*?kube: \"$kube_secret\"?" secret.yaml

kubectl apply -f storageclass.yaml
kubectl apply -f secret.yaml
kubectl apply -f pvc.yaml

kubectl apply -f pod.yaml

