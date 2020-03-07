#!/bin/bash

if [[ "$1" == "0" ]]; then
    kubectl apply -f common.yaml
    kubectl apply -f operator.yaml
    kubectl apply -f mon-pv.yaml
    kubectl apply -f mon-sc.yaml
    kubectl apply -f hdd-pv.yaml
    kubectl apply -f hdd-sc.yaml
    kubectl apply -f nvme-pv.yaml
    kubectl apply -f nvme-sc.yaml
    kubectl apply -f cluster-on-pvc.yaml
    kubectl apply -f toolbox.yaml
else
    kubectl delete -f common.yaml --grace-period=0 --force
    kubectl delete -f operator.yaml --grace-period=0 --force
    kubectl delete -f cluster-on-pvc.yaml --grace-period=0 --force
    kubectl delete -f nvme-sc.yaml --grace-period=0 --force
    kubectl delete -f nvme-pv.yaml --grace-period=0 --force
    kubectl delete -f hdd-sc.yaml --grace-period=0 --force
    kubectl delete -f hdd-pv.yaml --grace-period=0 --force
    kubectl delete -f mon-sc.yaml --grace-period=0 --force
    kubectl delete -f mon-pv.yaml --grace-period=0 --force
    kubectl delete -f toolbox.yaml --grace-period=0 --force
fi
