#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import os 


if os.path.exists(sys.argv[1]) == False:
    print ("Файл "+sys.argv[1]+" не  найден. ")
    sys.exit("Файл "+sys.argv[1]+" не  найден. ")

print(len(sys.argv))