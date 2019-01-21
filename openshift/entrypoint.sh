#!/bin/bash

sed -i 's/ROOTPASSWORD/$1/g' /etc/my.cnf.d/server.cnf=