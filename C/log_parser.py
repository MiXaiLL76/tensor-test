#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import os 
import time
import datetime

def unix_time(str):                                         # Превращение в unixtime
    return time.mktime(datetime.datetime.strptime(str, "%d.%m.%Y %H:%M:%S").timetuple())

def avg(numbers):                                           # Функция для среднего значения
    return float(sum(numbers)) / max(len(numbers), 1)

def nlogn_median(l):                                        # https://habr.com/post/346930/
    l = sorted(l)                                          
    if len(l) % 2 == 1:                                     
        return l[len(l) / 2]                                
    else:
        return 0.5 * (l[len(l) / 2 - 1] + l[len(l) / 2])

if os.path.exists(sys.argv[1]) == False:                    # Проверка существования файла
    sys.exit("Файл "+sys.argv[1]+" не  найден. ")           # Выход с ошибкой

processing_arr = []                                         # Массив с временем выполнения
error_req = 0                                               # Кол-во запросов с ошибкой
files = {}                                                  # Запрошеные файлы

f = open(sys.argv[1], 'r')                                  # Читаем файл
for line in f:                                              # Построчно считываем
    line_arr = line.split(" | ")                            # Разбиваем на массив
    processing = unix_time(line_arr[1]) - unix_time(line_arr[0])
    processing_arr.append(processing)                       # Добавляем время обработки в массив
    if int(line_arr[3]) >= 400:                             # Код ошибки
        error_req+=1
    elif line_arr[4].find("error") != -1:                   # Ищем ошибку в теле
        error_req+=1

    try:
        files[line_arr[2]]                                  # Проверяем есть ли такой файл в массиве
        files[line_arr[2]]+=1
    except KeyError:
        files.update({line_arr[2] : 1})                     # При отсутствии, добавляем

print("Всего запросов: "+str(len(processing_arr))+".")      # Вывод......
print("")
print("Время обработки сервером: ")
print(" Min: "+str(min(processing_arr)))
print(" Max: "+str(max(processing_arr)))
print(" Avg: "+str(avg(processing_arr)))
print(" Median: "+str(nlogn_median(processing_arr)))
print("")
print("Процент ошибочных запросов: "+str(error_req/float(len(processing_arr))*100)+"%.")
print("")
print("Всего запрошено страниц: "+str(len(files))+".")

                                                            # Вывод по страницам.
for key in files.keys():
    print("Страница `"+key+"` запрошена "+str(files[key])+" раз.")