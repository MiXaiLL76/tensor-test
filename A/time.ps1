$file = "test.log"
$k = 5

Get-Date -Format "yyyy-mm-dd HH:mm:ss" | Out-File $file                     # Запись в файл #2018-06-13 16:11:41

for ($i = 0; $i -lt $k; $i++) {
    $file_data = (Get-Content $file)                                        # Чтение из файла
    $date = [datetime]::ParseExact($file_data, "yyyy-mm-dd HH:mm:ss", $null)# Формат даты из файла.
    $h = [int]$date.toString("HH")                                          # Часы
    
    if ($h -lt 12) {
        # Если Часы ($h) меньше 12
        Write-Output $file_data                                             # Вывод данных из файла на экран
    }
    else {
        Copy-Item $file ($file + ".bak1")
        Get-Date -Format "yyyy-mm-dd HH:mm:ss" | Out-File $file             # Запись в файл
    }
}