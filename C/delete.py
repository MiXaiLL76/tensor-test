#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import shutil 
import os
import time
from os import listdir

def rem_dir(dir,file):                                      # Функция удаление папок/файлов
    try:
        path=os.path.join(dir,file)
        if os.path.exists(path):                                # Проверка существования папки/файла
            if os.path.isdir(path):
                shutil.rmtree(path)                                 # Удаление стандартной утилитой
            elif os.path.isfile(path):
                os.remove(path)
            #print ("'"+file+"' удалён.") 
        else: 
            print ("'"+file+"' не найден в директории "+dir)# Файл не найден
    except OSError, e:
        print ("Error: %s - %s." % (e.filename,e.strerror)) # Ошибки

def update_progress(i,lenLi):
    sys.stdout.write('\r')
    part = float(i)/(lenLi-1)
    symbols_num = int(30 * part)
    sys.stdout.write("[%-30s] %3.2f%%" % ('='*symbols_num, part*100))
    sys.stdout.flush()

if os.path.exists(sys.argv[1]) == False:
    sys.exit("Директория "+sys.argv[1]+" не найдена. ")

files = listdir(sys.argv[1])




progress = 0
print("Удаление всех файлов из каталога "+sys.argv[1])
for file in files:
    rem_dir(sys.argv[1],file)
    update_progress(progress,len(files))
    progress+=1
    #time.sleep(0.2)
print("")
    