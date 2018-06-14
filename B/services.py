#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys  
from os import listdir

if len (sys.argv) < 2:
    print("Кол-во аргументов не верно.")
    exit

dir=sys.argv[1]+""
min_ver=sys.argv[2]
min_ver_arr=min_ver.split(".")

print("Dir: "+dir)
print("Min version: "+min_ver)

for file in listdir(dir):
    file=file.split("_")
    name=file[0]
    ver=file[1]
    print(file)