@echo %TIME:~0,8% - Обновляем дату сборки>>%LOG_FILE%         

if "%3"=="HAND_AVTO" goto NO_KOMPIL

@echo *** Обновляем дату сборки ***

attrib -r "%WORK_DIR%\Core\sbis-lib\resources\version.h"
"%WORK_DIR%\Core\muzzle\VersionIncrementer.exe" --dateupdate "%WORK_DIR%\Core\sbis-lib\resources\version.h"

xcopy "%WORK_DIR%\history.txt" "%DESTINATION%"        /Y /R
xcopy "%WORK_DIR%\history.txt" "%PROG_DESTINATION%"   /Y /R

path %ProgramFiles(x86)%\Microsoft Visual Studio 10.0\Common7\IDE\;%path%
"%CLC_EXE%" "%WORK_DIR%\Core\sbis\sbis_jinnee\sbis_all.sln"

: Ночную версию необходимо собирать с режимом _DEBUG,
: чтобы отлавливать часть глюков.
: Для этого переопределим файл redefiner.h файлом с включеным режимом _DEBUG


@echo %TIME:~0,8% - начало компиляции Sbis-All>>%LOG_FILE%
del "%START_DIR%\FullBuild.txt"
devenv "%WORK_DIR%\Core\sbis\sbis_jinnee\sbis_all.sln" %BUILD_MODE% %BUILD_CONF% /out "%START_DIR%\FullBuild.txt"
@echo %TIME:~0,8% - закончена компиляция Sbis-All>>%LOG_FILE%

@echo %TIME:~0,8% - начало сборки pdb-файлов для Sbis-All>>%LOG_FILE%
start /D "C:\Program Files\Debugging Tools for Windows (x64)" symstore.exe add /f "%WORK_DIR%\*" /s "c:\Symbols" /t sbis /r /o
@echo %TIME:~0,8% - сборка pdb-файлов для Sbis-All закончена>>%LOG_FILE%

if not exist "%WORK_DIR%\Core\sbis-lib\Release\sbis-lib.dll"                    	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\muzzle\Release\muzzle.dll"                       		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\sbis\Release.dll\sbis.dll"                                goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\sbis\Release.pro\sbispro.dll"                  		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\sbis\sbis.exe"                               		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\jinnee\Release\jinnee.exe"                                goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Buh\Accounting\Release\accounting.dll"                         goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Buh\warehouse\Release\warehouse.dll"                           goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Carry\WarehouseCenter\Release\whcenter.dll"                    goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Carry\TradeControl\Release\tradectrl.dll"                      goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Buh\ZPL\Release\zpl.dll"                                       goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EnterADM\PersonnelAdm\Release\PersonnelAdm.dll"                goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Buh\Capital\Release\capital.dll"                               goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EnterADM\Cargo\Release\Cargo.dll"                              goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EDO\DocFlow\Release\docflow.dll"                               goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Buh\budget\Release\budget.dll"                                 goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EnterAdm\ServiceCenter\Release\ServiceCenter.dll"              goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Carry\Identdrv\Release\IdentDrv.dll"                           goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"              goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\sbis-crypto.dll"          goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\sbis-img\Sbis2_Release\sbis-img300.dll"                   goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\ESign\Release\esign.dll"                                    goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\EO\Release\eo.dll"                                          goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\EO-NP\Release\eo-np.dll"                                    goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EnterADM\frm\Release\frm.dll"                                  goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EnterADM\frp\Release\frp.dll"                                  goto COMPILATION_FAILED
if not exist "%WORK_DIR%\CRM\AutoInformer\Release\AutoInformer.dll"                     goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\Licensing\Release\Licensing.dll"  "                    goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\msfo\Release\msfo.dll"                                 goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\Sbis-graph\Release\Sbis-graph.dll"                        goto COMPILATION_FAILED
if not exist "%WORK_DIR%\CNV\cnv20\Release\cnv20.dll"                                   goto COMPILATION_FAILED
if not exist "%WORK_DIR%\CNV\cnv19\Release\cnv19.dll"                                   goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\LicensesServer\Release\SBIS-LicServ.exe"               goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\Sbis_update_backup\Sbis_update_backup.exe"             goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\run\Release.exe\run.exe"                               goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Carry\logistics\Release\logistics.dll"                         goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Carry\retail\Release\retail.dll"                               goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Carry\TradeDrv\Release\TradeDrv.dll"               		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EnterADM\planing\Release\planing.dll"       			goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EnterADM\echeckpoint\Release\echeckpoint.dll"   		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\MuzzleServer\Release\MuzzleServer.exe"	              	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\UB\Release\UB.dll"       					goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\sbis-loader\Release\loader.exe"                        goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\sbis-loader\Interface.dll"                           	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\EONPMonitoring\Release\monitoring.dll"                 goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\EOMonitoring\Release\EOMonitoring.pdll"                goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EDO\reglaments\Release\reglaments.dll"  			goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\sbis-xml\Release\sbis-xml.dll"                      	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\sbis-rpc\sbis-rpc.dll"                       	 	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\sbis-rpc-client\sbis-rpc-client.dll"       			goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\sbis-communication\Release\sbis-communication.dll"   	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\eo-transport\Release\eo-transport.dll"    			goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Core\SBIS\Модули\Вызов удаленных процедур\sbis-swift-client.dll"	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\sbis-report-reader\Release\sbis-report-reader.lib"   	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\sbis-report-reader\Release\sbis-report-reader.dll"   	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EDO\shipment\Release\shipment.dll"				goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EDO\edo-converter\Release\edo-converter.dll"			goto COMPILATION_FAILED

if not exist "%WORK_DIR%\Conso\conso\Release\conso.dll"			  		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\sbis-screenshot\Release\sbis-screenshot.dll"		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\sbis-screenshot-tray-util\Release\sbis-screenshot-tray-util.exe"	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Presto\PrestoCaloric\Release\PrestoCaloric.dll"		goto COMPILATION_FAILED

if "%1"=="NIGHT" (
@echo %TIME:~0,8% - Начата сборка документации>>%LOG_FILE% 
    if "%2" == "DAY" (
       start c:\Autodocumentation\_bin\doxygen.day.cmd
    ) else (
       start c:\Autodocumentation\_bin\doxygen.night.cmd
    )
@echo %TIME:~0,8% - Закончена сборка документации>>%LOG_FILE% 
)

del /Q "%WORK_DIR%\sbis\Модули\sbis\muzzle-tests.dll"
del /Q "%WORK_DIR%\sbis\Модули\sbis\sbis-tests.dll"     

:NO_KOMPIL


echo %DATE:~0,2%.%DATE:~3,2%.%DATE:~8,2% > "%LOCAL_DIR%\BUILD_DATE.txt"

@echo *** Копируем exe/dll/splash ***

xcopy "%WORK_DIR%\Core\sbis\sbis.exe"                            "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis\sbis.dll"                            "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                    "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis\sbis.splash"                         "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                        "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\muzzle\7-zip32.dll"                       "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis\msvcr100.dll"                  	 "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis\msvcp100.dll"                  	 "%PROG_DESTINATION%" /Y /R

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"		"%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   		"%PROG_DESTINATION%\*.*" /Y /R /S
xcopy "%WORK_DIR%\crypto-libs.ini"   						"%PROG_DESTINATION%\crypto-libs" /Y /R

xcopy "%WORK_DIR%\Core\sbis-img\Sbis2_Release\sbis-img300.dll"   		"%PROG_DESTINATION%\*.*" /Y /R /S
xcopy "%WORK_DIR%\Core\muzzle\dll\msxml3r.dll"                   "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\muzzle\dll\msxml3.dll"                    "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\muzzle\dll\msxml6r.dll"                   "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\muzzle\dll\msxml6.dll"                    "%PROG_DESTINATION%" /Y /R

xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"                    "%PROG_DESTINATION%" /Y /R

xcopy "%WORK_DIR%\Service\FSynchro\Release\fsynchro.exe" 			"%PROG_DESTINATION%" /R /Y
xcopy "%WORK_DIR%\Service\FSynchro\fsynchro.ini"         			"%PROG_DESTINATION%" /R /Y
xcopy "\\sbis-dev\Programmers\СБиС_2\Прочее\GDIplus\gdiplus.dll"     		"%PROG_DESTINATION%" /R /Y
xcopy "\\sbis-dev\Programmers\СБиС_2\Прочее\CryptoTun\CryptoTun.dll" 		"%PROG_DESTINATION%" /R /Y
xcopy "\\sbis-dev\Programmers\СБиС_2\Прочее\help\Tensor-Help.exe" 		"%PROG_DESTINATION%" /R /Y


@echo *** Копируем Модули ***

xcopy "%WORK_DIR%\Core\sbis\Модули\sbis\Sbis-graph.dll"           "%PROG_DESTINATION%\Модули\sbis\*.*"                  /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\sbispro\sbispro.dll"                "%PROG_DESTINATION%\Модули\sbispro\*.*"               /S /R /Y

xcopy "%WORK_DIR%\Core\sbis\Модули\sbispro\*.*"        	"%PROG_DESTINATION%\Модули\sbispro\*.*"    /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Просмотрщик\*.*"    	"%PROG_DESTINATION%\Просмотрщик\*.*"    /S /R /Y


@echo *** Копируем Модули Бухгалтерия ***

xcopy "%WORK_DIR%\Core\sbis\Модули\Бухгалтерский учет\accounting.dll"      "%PROG_DESTINATION%\Модули Бухгалтерия\Бухгалтерский учет\*.*"       /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Складской учет\warehouse.dll"           "%PROG_DESTINATION%\Модули Бухгалтерия\Складской учет\*.*"           /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Зарплата и кадры\zpl.dll"               "%PROG_DESTINATION%\Модули Бухгалтерия\Зарплата и кадры\*.*"         /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Основные средства\capital.dll"          "%PROG_DESTINATION%\Модули Бухгалтерия\Основные средства\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Бюджетный учет\budget.dll"              "%PROG_DESTINATION%\Модули Бухгалтерия\Бюджетный учет\*.*"           /S /R /Y

@echo *** Копируем Модули CRM ***

xcopy "%WORK_DIR%\Core\sbis\Модули\CRM\CRM.dll"                         "%PROG_DESTINATION%\Модули CRM\CRM\*.*"                      /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Автоинформатор\AutoInformer.dll"     "%PROG_DESTINATION%\Модули CRM\Автоинформатор\*.*"           /S /R /Y

xcopy "%WORK_DIR%\CRM\CRM\Модули\*.*"                       "%PROG_DESTINATION%\Модули CRM\*.*" /S /R /Y
xcopy "%WORK_DIR%\CRM\AutoInformer\Модули\*.*"   	        "%PROG_DESTINATION%\Модули CRM\*.*" /S /R /Y

@echo *** Копируем Модули Carry ***

xcopy "%WORK_DIR%\Core\sbis\Модули\Складской центр\whcenter.dll"           	"%PROG_DESTINATION%\Модули Carry\Складской центр\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Розница\retail.dll"                 		"%PROG_DESTINATION%\Модули Carry\Розница\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\торговля и логистика\logistics.dll"     	"%PROG_DESTINATION%\Модули Carry\торговля и логистика\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\торговля и логистика\TradeCtrl.dll"     	"%PROG_DESTINATION%\Модули Carry\торговля и логистика\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Оборудование\TradeDrv.dll"     		"%PROG_DESTINATION%\Модули Carry\Оборудование\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Оборудование\IdentDrv.dll"     		"%PROG_DESTINATION%\Модули Carry\Оборудование\*.*"   /S /R /Y

@echo *** Копируем модули Presto ***
xcopy "%WORK_DIR%\Presto\PrestoCaloric\Release\PrestoCaloric.dll"      	     "%PROG_DESTINATION%\Модули Presto\Presto Калорийность\*.*"          /R /Y

@echo *** Копируем Модули Управление предприятием ***

xcopy "%WORK_DIR%\Core\sbis\Модули\Бюджетирование\frp.dll"                 "%PROG_DESTINATION%\Модули Управление предприятием\Бюджетирование\*.*"         /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Путевые листы\cargo.dll"                "%PROG_DESTINATION%\Модули Управление предприятием\Путевые листы\*.*"          /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Сервисный центр\ServiceCenter.dll"      "%PROG_DESTINATION%\Модули Управление предприятием\Сервисный центр\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Управление персоналом\PersonnelAdm.dll" "%PROG_DESTINATION%\Модули Управление предприятием\Управление персоналом\*.*"  /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Управление финансами\frm.dll"           "%PROG_DESTINATION%\Модули Управление предприятием\Управление финансами\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Управление проектами\planing.dll"       "%PROG_DESTINATION%\Модули Управление предприятием\Управление проектами\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Электронная проходная\ECheckpoint.dll"  "%PROG_DESTINATION%\Модули Управление предприятием\Электронная проходная\*.*"  /S /R /Y


@echo *** Копируем Модули ЭДО ***  

xcopy "%WORK_DIR%\Core\sbis\Модули\Электронный документооборот\EDO.dll"           "%PROG_DESTINATION%\Модули ЭДО\Электронный документооборот\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Регламенты документооборота\reglaments.dll"    "%PROG_DESTINATION%\Модули ЭДО\Регламенты документооборота\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Документооборот\docflow.dll"                   "%PROG_DESTINATION%\Модули ЭДО\Документооборот\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Запросы ФССП\fssp.dll"			     "%PROG_DESTINATION%\Модули ЭДО\Запросы ФССП\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Документы отгрузки\shipment.dll"		     "%PROG_DESTINATION%\Модули ЭДО\Документы отгрузки\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\edo-converter\Release\edo-converter.dll"		     "%PROG_DESTINATION%\Модули ЭДО\Преобразователь документов\*.*"        /S /R /Y


@echo *** Копируем Модули прочие ***

xcopy "%WORK_DIR%\Core\sbis\Модули\Лицензирование\licensing.dll"           "%PROG_DESTINATION%\Модули прочие\Лицензирование\*.*"              /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\МСФО\Msfo.dll"                          "%PROG_DESTINATION%\Модули прочие\МСФО\*.*"                        /S /R /Y

@echo *** Копируем Модули ЭлО ***

xcopy "%WORK_DIR%\Core\sbis\Модули\Электронная отчетность\eo.dll"          "%PROG_DESTINATION%\Модули ЭлО\Электронная отчетность\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Электронная подпись\sbis-report-reader.dll"  "%PROG_DESTINATION%\Модули ЭлО\Электронная подпись\*.*"   /S/Y /R
xcopy "%WORK_DIR%\Core\sbis\Модули\Электронная подпись\esign.dll"          "%PROG_DESTINATION%\Модули ЭлО\Электронная подпись\*.*"      /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Электронная подпись\eo-transport.dll"   "%PROG_DESTINATION%\Модули ЭлО\Электронная подпись\*.*"      /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Налогоплательщик\eo-np.dll"             "%PROG_DESTINATION%\Модули ЭлО\Налогоплательщик\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\уполномоченная бухгалтерия\UB.dll"      "%PROG_DESTINATION%\Модули ЭлО\Уполномоченная бухгалтерия\*.*"          /S /R /Y

copy /y "%WORK_DIR%\Service\sbis-loader\loader.exe"                           "%PROG_DESTINATION%\Модули прочие\СБиС мониторинг\SbisMon.exe_"
copy /y "%WORK_DIR%\Service\sbis-loader\Interface.dll"                        "%PROG_DESTINATION%\Модули прочие\СБиС мониторинг\Interface.dll_"
copy /y "%WORK_DIR%\Service\sbis-loader\Интерфейс.rs"                         "%PROG_DESTINATION%\Модули прочие\СБиС мониторинг\Интерфейс.rs_"
copy /y "%WORK_DIR%\Service\EONPMonitoring\monitoring.dll"                    "%PROG_DESTINATION%\Модули прочие\СБиС мониторинг\monitoring.dll_"
copy /y "%WORK_DIR%\Core\jinnee\DeltaFile.dll"                             "%PROG_DESTINATION%\Модули прочие\СБиС мониторинг\DeltaFile.dll_"
md "%PROG_DESTINATION%\Модули ЭлО\Налогоплательщик\Мониторинг"
copy /y "%WORK_DIR%\Service\EOMonitoring\Release\EOMonitoring.pdll"           "%PROG_DESTINATION%\Модули Эло\Налогоплательщик\Мониторинг\EOMonitoring.pdll"
	
xcopy "%WORK_DIR%\EO\sbis-rpc\sbis-rpc.dll"					"%PROG_DESTINATION%\Модули ЭлО\Вызов удаленных процедур\*.*"       /R /Y
xcopy "%WORK_DIR%\EO\sbis-rpc-client\sbis-rpc-client.dll"				"%PROG_DESTINATION%\Модули ЭлО\Вызов удаленных процедур\*.*"       /R /Y
xcopy "%WORK_DIR%\EO\sbis-communication\release\sbis-communication.dll"		"%PROG_DESTINATION%\Модули ЭлО\Вызов удаленных процедур\*.*"       /R /Y
xcopy "%WORK_DIR%\Core\SBIS\Модули\Вызов удаленных процедур\sbis-swift-client.dll"	"%PROG_DESTINATION%\Модули ЭлО\Вызов удаленных процедур\*.*"       /R /Y

xcopy "I:\СБиС_2\Прочее\CrptInst\cryptopro.iss"					"%PROG_DESTINATION%\Модули ЭлО\Электронная отчетность\Настройки\*.*"       /R /Y

@echo *** Копируем Модули Консолидированная отчетность ***

xcopy "%WORK_DIR%\Conso\conso\Release\conso.dll"			"%PROG_DESTINATION%\Модули Консолидированная отчетность\Консолидированная отчетность\*.*"       /R /Y

@echo *** Создаём каталоги jinnee и cnv19 ***

xcopy "%WORK_DIR%\Core\jinnee\jinnee.exe"                   	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\Джинн.rs"                     	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\DeltaFile.dll"                	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                   	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"               	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%PROG_DESTINATION%\Модули\sbis\Базовые ресурсы.rs" 	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv20\cnv20.dll"                     	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv20\cnv.ini"                       	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv20\readme.txt"                    	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv20\*.dic"                         	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv20\*.1"                           	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv20\*.2"                           	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\7-zip32.dll"                  	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\msvcr100.dll"             	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\msvcp100.dll"             	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\sbis.dll"                       	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\sbispro\sbispro.dll"     	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv20\Таблицы конвертации\*.*"       	"%PROG_DESTINATION%\jinnee\Таблицы конвертации\*.*" /R /Y /E
xcopy "\\sbis-dev\Programmers\СБиС_2\Прочее\GDIplus\gdiplus.dll"           "%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"               	"%PROG_DESTINATION%\jinnee\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\jinnee\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\jinnee\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\jinnee\*.*" /Y /R /S

xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"                       	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\jinnee.exe"                           	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\Джинн.rs"                             	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                           	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                       	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%PROG_DESTINATION%\Модули\sbis\Базовые ресурсы.rs"         	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv19\cnv19.dll"                             	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv19\cnv.ini"                               	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv19\*.rs"                                  	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv19\*.dic"                                 	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv19\*.1"                                   	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv19\*.2"                                   	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\7-zip32.dll"                          	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv19\msvcr100.dll"                     		"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv19\msvcp100.dll"                     		"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\sbis.dll"                               	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\sbispro\sbispro.dll"             	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "\\sbis-dev\Programmers\СБиС_2\Прочее\GDIplus\gdiplus.dll"        "%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Складской учет\warehouse.dll"    	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\Модули\Зарплата и кадры\zpl.dll"        	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Buh\Accounting\Release\accounting.dll"	       	"%PROG_DESTINATION%\cnv19\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\cnv19\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\cnv19\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\cnv19\*.*" /Y /R /S

@echo *** Создаем Автозапуск ***

xcopy "%WORK_DIR%\Service\Run\Run.exe"               			"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y
xcopy "%WORK_DIR%\Service\Run\msvcr100.dll"    				"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y
xcopy "%WORK_DIR%\Service\Run\msvcp100.dll"    				"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\7-zip32.dll"        			"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"         			"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"         			"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y
xcopy "\\sbis-dev\Programmers\СБиС_2\Прочее\GDIplus\gdiplus.dll" 	"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y
xcopy "%PROG_DESTINATION%\Модули\sbis\Базовые ресурсы.rs"  		"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y
xcopy "%WORK_DIR%\Service\Run\Модули"                			"%PROG_DESTINATION%\Автозапуск\Модули\*.*" /S /R /Y
xcopy "%WORK_DIR%\Service\Run\Run.rs"                			"%PROG_DESTINATION%\Автозапуск\Модули\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"                		"%PROG_DESTINATION%\Автозапуск\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\Автозапуск\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\Автозапуск\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\Автозапуск\*.*" /Y /R /S

@echo *** Создаем Сервер лицензий ***

xcopy "%WORK_DIR%\Service\LicensesServer\sbis-LicServ.exe"      "%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                      	"%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                  	"%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"                  	"%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y
xcopy "%WORK_DIR%\Service\LicensesServer\msvcr100.dll"          "%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y
xcopy "%WORK_DIR%\Service\LicensesServer\msvcp100.dll"          "%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\7-zip32.dll"                    	"%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y
xcopy "\\sbis-dev\Programmers\СБиС_2\Прочее\GDIplus\gdiplus.dll"              "%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y
xcopy "\\sbis-dev\Programmers\СБиС_2\Прочее\Драйвера\КлючЗащиты\InstDrv.exe"  "%PROG_DESTINATION%\Сервер лицензий\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\Сервер лицензий\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\Сервер лицензий\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\Сервер лицензий\*.*" /Y /R /S


@echo *** Копируем Файлы Сервер удаленного вызова процедур ***

md "%PROG_DESTINATION%\Сервер удаленного вызова процедур"

xcopy "%WORK_DIR%\EO\sbis-rpc-service\sbis-rpc-service.dll"              "%PROG_DESTINATION%\Сервер удаленного вызова процедур\*.*" /R /Y
xcopy "%WORK_DIR%\EO\sbis-rpc\sbis-rpc.dll"                              "%PROG_DESTINATION%\Сервер удаленного вызова процедур\*.*" /R /Y

@echo *** Копируем Файлы MuzzleServer *** 

xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                                    	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                                 	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%PROG_DESTINATION%\Модули\sbis\Базовые ресурсы.rs"                	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%PROG_DESTINATION%\Модули\sbis\Базовые ресурсы.rs"                	"%PROG_DESTINATION%\MuzzleServer\Ресурсы сервера\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\MuzzleServer.exe"                      	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\Stop MuzzleServer.cmd"                 	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\Uninstall MuzzleServer.cmd"            	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\Start MuzzleServer.cmd"                	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\Install MuzzleServer.cmd"              	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\Show Icon.cmd"                         	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\MuzzleServer.ini"                      	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\ReadMe.html"                           	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Service\MuzzleServer\MuzzleServer.rs"                       	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"                    		"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R
xcopy "%WORK_DIR%\Service\MuzzleServer\msvcr100.dll"                    	"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R
xcopy "%WORK_DIR%\Service\MuzzleServer\msvcp100.dll"                    	"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R
xcopy "I:\СБиС_2\Прочее\GDIplus\gdiplus.dll"              			"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R /S

@echo *** Копируем файлы автотестирования ***

md "%PROG_DESTINATION%\Автотестирование\Общее\DB"

xcopy "%PROG_DESTINATION%\Модули\sbis\*.*"               "%PROG_DESTINATION%\Автотестирование\Общее\Модули\sbis\*.*" /S /R /Y
xcopy "%PROG_DESTINATION%\jinnee\*.*"                    "%PROG_DESTINATION%\Автотестирование\Общее\jinnee\*.*" /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\sbis.exe"                         "%PROG_DESTINATION%\Автотестирование\Общее\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\sbis.dll"                         "%PROG_DESTINATION%\Автотестирование\Общее\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                     "%PROG_DESTINATION%\Автотестирование\Общее\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                 "%PROG_DESTINATION%\Автотестирование\Общее\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\Автотестирование\Общее\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\Автотестирование\Общее\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\Автотестирование\Общее\*.*" /Y /R /S

xcopy "%WORK_DIR%\Core\sbis\install\ini\*.*"                  "%PROG_DESTINATION%\ini\*.*" /Y /R /S
xcopy "%WORK_DIR%\Core\sbis\install\*.ini"                    "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis\install\ЗапуститьНаСервере.bat"   "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis\install\ОбновитьКлиента.bat"      "%PROG_DESTINATION%" /Y /R

xcopy "%WORK_DIR%\Core\sbis\install\Сборка дистрибутива для партнеров\*.*" "%PROG_DESTINATION%\Сборка дистрибутива для партнеров\*.*" /S /R /Y

@echo *** Формируем SbisSDK ***

xcopy "%WORK_DIR%\Service\SbisSDK\*.*"                         "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Release.dll\sbis.lib"           "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Release.pro\sbispro.lib"        "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Include\*.h"                    "%PROG_DESTINATION%\SbisSDK\SbisInc\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Include.pro\*.h"                "%PROG_DESTINATION%\SbisSDK\SbisProInc\*.*"     /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\Resources\*.h"                  "%PROG_DESTINATION%\SbisSDK\SbisInc\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\muzzle\Release\muzzle.lib"           "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Core\muzzle\dll\*.dll"                    "%PROG_DESTINATION%\SbisSDK\dll\*.*"            /S /R /Y
xcopy "%WORK_DIR%\Core\muzzle\Include\*.h"                  "%PROG_DESTINATION%\SbisSDK\MuzzleInc\*.*"      /S /R /Y
xcopy "%WORK_DIR%\Core\muzzle\Resources\*.h"                "%PROG_DESTINATION%\SbisSDK\MuzzleInc\*.*"      /S /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\Release\sbis-lib.lib"       "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\Include\*.h"                "%PROG_DESTINATION%\SbisSDK\SbisLibInc\*.*"     /S /R /Y
xcopy "%WORK_DIR%\Core\sbis-crypto\Release\sbis-crypto.lib" "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Core\sbis-crypto\Include\*.h"             "%PROG_DESTINATION%\SbisSDK\SbisCryptoInc\*.*"  /S /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\Resources\*.h"              "%PROG_DESTINATION%\SbisSDK\SbisLibInc\*.*"     /S /R /Y
xcopy "%WORK_DIR%\EnterADM\cargo\Release\cargo.lib"             "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\EnterADM\cargo\Include\*.h"                   "%PROG_DESTINATION%\SbisSDK\CargoInc\*.*"       /S /R /Y
xcopy "%WORK_DIR%\EnterADM\cargo\Resources\*.h"                 "%PROG_DESTINATION%\SbisSDK\CargoInc\*.*"       /S /R /Y
xcopy "%WORK_DIR%\Buh\capital\Release\capital.lib"         "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Buh\capital\Include\*.h"                 "%PROG_DESTINATION%\SbisSDK\CapitalInc\*.*"     /S /R /Y
xcopy "%WORK_DIR%\Buh\capital\Resource\*.h"                "%PROG_DESTINATION%\SbisSDK\CapitalInc\*.*"     /S /R /Y
xcopy "%WORK_DIR%\Buh\warehouse\Release\warehouse.lib"     "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Buh\warehouse\Include\*.h"               "%PROG_DESTINATION%\SbisSDK\WarehouseInc\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Buh\zpl\Release\zpl.lib"                 "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Buh\zpl\Include\*.h"                     "%PROG_DESTINATION%\SbisSDK\ZplInc\*.*"         /S /R /Y
xcopy "%CLC_EXE%"			     "%PROG_DESTINATION%\SbisSDK\*.*"                /S /R /Y

xcopy "%WORK_DIR%\Service\SbisAddOns\*.*"                  "%PROG_DESTINATION%\SbisAddOns\*.*"           /S /R /Y

@echo *** Копируем Sbis_update_backup.exe ***

xcopy "%WORK_DIR%\Service\Sbis_update_backup\Sbis_update_backup.exe" "%PROG_DESTINATION%\Обслуживание базы данных\*.*" /R /Y

xcopy "%WORK_DIR%\Service\sbis-screenshot-tray-util\Release\sbis-screenshot-tray-util.exe"     		"%PROG_DESTINATION%\cfs\*.*" 	    /R /Y
xcopy "%WORK_DIR%\Service\sbis-screenshot\Release\sbis-screenshot.dll" 				    	"%PROG_DESTINATION%\cfs\*.*" 	    /R /Y
xcopy "%WORK_DIR%\Service\sbis-screenshot-tray-util\screenshot-tray-util.ini"     			"%PROG_DESTINATION%\cfs\*.*" 	    /R /Y

@goto :EOF


:COMPILATION_FAILED
@echo.
@echo ****************************************************
@echo Ошибка при сборке одного из проектов!!!
@echo ****************************************************
@goto ERRORS

:ERRORS
if "%1"=="NIGHT" NET SHARE "%PUT%"="%LOCAL_DIR%" /GRANT:Все,READ
msg * /server:tf-pundikai /v /time:0 "Ошибки при сборке " %VERSION%%NUM% "!!!"
@echo %TIME:~0,8% - сборка завершилась с ошибками>>%LOG_FILE%
@echo.
@echo.
@echo ****************************************************
@echo Какие-то траблы случились!!!
@echo ****************************************************
@echo 
@echo 
@echo 
@@exit /b 1