#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import os 



if os.path.exists(sys.argv[1]):
    print ("'"+sys.argv[1]+"' удалён.")                    
else: 
    print ("'"+sys.argv[1]+"' не найден в директории "+dir)

print(len(sys.argv))