#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import shutil 
import os
from os import listdir

def rem_dir(dir,file):                                      # Функция удаление папок/файлов
    try:
        
        if os.path.exists(os.path.join(dir,file)):          # Проверка существования папки/файла
            shutil.rmtree(os.path.join(dir,file))           # Удаление стандартной утилитой
            print ("'"+file+"' удалён.")                    # Инфо
        else: 
            print ("'"+file+"' не найден в директории "+dir)# Файл не найден
    except OSError, e:
        print ("Error: %s - %s." % (e.filename,e.strerror)) # Ошибки

if len (sys.argv) < 2:                                      # Проверка на 2 введенных аргумента
    print("Кол-во аргументов не верно.")                    
    exit                                                    # Выход из программы

dir=sys.argv[1]+""                                          # Директория заданная пользователем
min_ver=sys.argv[2]                                         # Версия заданная пользователем
min_ver_arr=map(int, min_ver.split("."))                    # Версия преобразованная в map
            
print("Dir: "+dir)
print("Min version: "+min_ver)

for file in listdir(dir):                                   # Перебор всех файлов в папке dir
    filea=file.split("_")                                   # Разделение файла на имя_версия
    name=filea[0]                                           # Имя
    ver=filea[1]                                            # Версия
    ver_arr=map(int, ver.split("."))                        # Версия в map

    max_len=max(len(ver_arr),len(min_ver_arr))              # Вычисляем какой массив версии длиннее. Заданный пользователем,
                                                            # или полученый из файла.
    i = 0
    while i < max_len:                                      # Перебор массивов до максимального элемента
        try:
            ver_arr[i]                                      # Проверка существования элемента
        except IndexError:
            ver_arr.insert(i,0)                             # Добавление элемента, если его нет. (3.7 = 3.7.0.0.0.0)

        try:
            min_ver_arr[i]                                  # Проверка существования элемента
        except IndexError:
            min_ver_arr.insert(i,0)                         # Добавление элемента, если его нет.

        ver_arr[i]=ver_arr[i]-min_ver_arr[i]                # Разница версияй. проверка
        if ver_arr[i] > 0:                                  # Если разница в версиях положительная до первого отрицательного
            break                                           # --> Версия больше и выходим из проверки
        elif ver_arr[i] < 0:                                # А если отрицательная, то тоже выходим ведь даже если дальше положительно 
            rem_dir(dir,file)                               # либо 0, это не имеет смысла
            break
        i = i + 1                                           # Перебор элементов массива
    #print(file,ver_arr)
       