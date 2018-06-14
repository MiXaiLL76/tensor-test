#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import os 
from zipfile import *

zip_file = sys.argv[1]
tmp = "tmp/"

if os.path.exists(zip_file) == False:                    # Проверка существования файла
    sys.exit("Файл "+zip_file+" не найден. ")           # Выход с ошибкой

if is_zipfile(zip_file) == False:                    # Проверка существования файла
    sys.exit("Файл "+zip_file+" не ZIP. ")           # Выход с ошибкой

z = ZipFile(zip_file, 'r')
for name in z.namelist(): 
    z.extract(name,tmp)
    os.rename(tmp+name,tmp+name.decode('cp866'))
z.close()

os.rename(tmp+"test/dir",tmp+"test/dir1")


