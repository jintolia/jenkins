#!/bin/bash -x
pwd
ls -la .
ssh -i mykey -v "root@192.168.0.20" 'yum install nmap'
