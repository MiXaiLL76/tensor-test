#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import os 
import shutil 
from zipfile import *
import xml.etree.ElementTree as ET

zip_file = sys.argv[1]                                      # Входящие данные
tmp = "tmp/"                                                # Директория временного хранения

if os.path.exists(zip_file) == False:                       # Проверка существования файла
    sys.exit("Файл "+zip_file+" не найден. ")               # Выход с ошибкой

if is_zipfile(zip_file) == False:                           # Проверка существования файла
    sys.exit("Файл "+zip_file+" не ZIP. ")                  # Выход с ошибкой

z = ZipFile(zip_file, 'r')                                  # Открытие архива 
for name in z.namelist():                                   # Перебор всех элементов массива
    z.extract(name,tmp)                                     # Распаковка элементов массива
    os.rename(tmp+name,tmp+name.decode('cp866'))            # Переименовывание их, в нормальный русский текст
z.close()                                                   # Закрытие массива

os.rename(tmp+"test/dir",tmp+"test/dir1")                   # Действие 1. Переименование директории

tree = ET.parse(tmp+"главный.xml")                          # Открытие XML документа
root = tree.getroot()                                       # Получение его данных

for tag in root.iter('tag'):                                # Проход по всем тегам <tag>
    name = tag.get('name')                                  # Сохранение их значений
    tag.set('name', name+"1")                               # Изменение значений

for tag in root.iter('tag1'):
    name = tag.get('name')
    tag.set('name', name+"1")

tree.write(tmp+"главный.xml","utf-8")                       # Перезапись файла
print("Файл `главный.xml` отредактирован!")                 

tree = ET.parse(tmp+"не совсем главный.xml")
root = tree.getroot()
for tag in root.findall('tag1'):
    name = tag.get('name')
    tag.set('name', name+"1")

tree.write(tmp+"не совсем главный.xml","utf-8")
print("Файл `не совсем главный.xml` отредактирован!")

path, zip_file = os.path.split(zip_file)                    # Получение имени входящего файла. 

z = ZipFile(zip_file, 'w')                                  # Создание нового архива
for root, dirs, files in os.walk(tmp):                      # Список всех файлов и папок в директории tmp
    for file in dirs:
        path = os.path.join(root,file)                      # Запись директории в массив
        z.write(path,path.replace(tmp, ""))
    for file in files:
        path = os.path.join(root,file)                      # Получение пути к файлу
        z.write(path,path.replace(tmp, ""))                 # Запись файла в массив
z.close()

shutil.rmtree(tmp)                                          # Удаление временных файлов

print("Архив `"+zip_file+"` создан в текущей директории.")
