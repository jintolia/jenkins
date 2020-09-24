#!/bin/bash
ssh -i mykey -o StrictHostKeyChecking=no root@192.168.0.20 'yum install nmap'
