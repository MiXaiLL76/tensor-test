#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys 
import os 
import time
import datetime

def unix_time(str):
    return time.mktime(datetime.datetime.strptime(str, "%d.%m.%Y %H:%M:%S").timetuple())

if os.path.exists(sys.argv[1]) == False:
    sys.exit("Файл "+sys.argv[1]+" не  найден. ")


f = open(sys.argv[1], 'r')
for line in f:
    line_arr = line.split(" | ")
    processing = unix_time(line_arr[1]) - unix_time(line_arr[0])
    print(processing)