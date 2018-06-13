#!/bin/bash

file='test.log'
k=5

echo $(date  +%Y-%m-%d\ %H:%M:%S) > $file           # Запись в файл #2018-06-13 16:11:41

for ((i=0; i < $k; i++))                            # Повторять K раз.
do
    file_data=$(< $file)                            # Чтение из файла

    date=(${file_data// / })                        # Разбор данных из файла на массив

    time=(${date[1]//:/ })                          # Время на массив
    h=${time[0]}                                    # Часы
    m=${time[1]}                                    # Минуты
    s=${time[2]}                                    # Секунды

    date=${date[0]}                                 # Дата из файла

    if (( $h < 12 )); then                          # Если Часы ($h) меньше 12
        echo $file_data                             # Вывод данных из файла на экран
    else
        cp $file $file'.bak'
        echo $(date  +%Y-%m-%d\ %H:%M:%S) > $file   # Запись в файл
    fi
done