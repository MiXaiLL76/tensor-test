#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import shutil 
import os
import time
from os import listdir

def rem_dir(dir,file):                                          # Функция удаление папок/файлов
    try:
        path=os.path.join(dir,file)                             # Полный путь к файлу
        if os.path.exists(path):                                # Проверка существования папки/файла
            if os.path.isdir(path):                             # файл является папокй
                shutil.rmtree(path)                             # Удаление папки
            elif os.path.isfile(path):                          # файл
                os.remove(path)                                 # Удаление файла
            #print ("'"+file+"' удалён.")                       # Вывод информации
        else: 
            print ("'"+file+"' не найден в директории "+dir)    # Файл не найден
    except OSError, e:
        print ("Error: %s - %s." % (e.filename,e.strerror))     # Ошибки

def update_types(dir,files_type):                               # Функция рекурсивно просчитывает все расширения в папках и подпапках
    for file in listdir(dir):
        path=os.path.join(dir,file)                             # Путь к файлу/папке
        if os.path.isdir(path):
            type_name = "dir"                                   # Тип папки
            update_types(path,files_type)                       # Рекурсивный запрос
        elif os.path.isfile(path):
            filename, type_name = os.path.splitext(path)        # Выделение типа файла
        try:
            files_type[type_name]                               # Проверка на существования индекса
            files_type[type_name]+=1                            # Добавление 
        except KeyError:
            files_type.update({type_name : 1})                  # Если такого индекса нет, то создаём его

def update_progress(i,lenLi):                                   # Функция прогрес бара
    sys.stdout.write('\r')                                      # Переход к началу строки
    part = float(i)/(lenLi-1)                                   # Часть-длинна
    symbols_num = int(30 * part)                                # Кол-во символов
    sys.stdout.write("[%-30s] %3.2f%%" % ('='*symbols_num, part*100))
    sys.stdout.flush()                                          # Обновление экрана

if os.path.exists(sys.argv[1]) == False:                        # Проверка на существования директории
    sys.exit("Директория "+sys.argv[1]+" не найдена. ")         # Выход с ошибкой

files_type = {}                                                 # Массив с типами файлов
update_types(sys.argv[1],files_type)                            # Сбор данных о типах файлов
files = listdir(sys.argv[1])                                    # Файлы из текущей папки
progress = 0                                                    # Изначальное положение прогрес бара
print("Удаление всех файлов из каталога "+sys.argv[1])
for file in files:
    rem_dir(sys.argv[1],file)                                   # Удаление файла/папки
    update_progress(progress,len(files))                        # Обновление прогресс бара
    progress+=1                                                 # Добавление значения к прогрес бару
    #time.sleep(0.2)                                            # Для того, чтобы увидеть прогрес бар, можно поставить задержку.
print("")
for key in files_type.keys():                                   # Вывод данных о типах файлов и их количестве.
    print("Файлов с типом `"+key+"` удалено "+str(files_type[key])+".")
    