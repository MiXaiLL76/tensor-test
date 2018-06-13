@echo %TIME:~0,8% - ��������� ���� ������>>%LOG_FILE%         

if "%3"=="HAND_AVTO" goto NO_KOMPIL

@echo *** ��������� ���� ������ ***

attrib -r "%WORK_DIR%\Core\sbis-lib\resources\version.h"
"%WORK_DIR%\Core\muzzle\VersionIncrementer.exe" --dateupdate "%WORK_DIR%\Core\sbis-lib\resources\version.h"

xcopy "%WORK_DIR%\history.txt" "%DESTINATION%"        /Y /R
xcopy "%WORK_DIR%\history.txt" "%PROG_DESTINATION%"   /Y /R

path %ProgramFiles(x86)%\Microsoft Visual Studio 10.0\Common7\IDE\;%path%
"%CLC_EXE%" "%WORK_DIR%\Core\sbis\sbis_jinnee\sbis_all.sln"

: ������ ������ ���������� �������� � ������� _DEBUG,
: ����� ����������� ����� ������.
: ��� ����� ������������� ���� redefiner.h ������ � ��������� ������� _DEBUG


@echo %TIME:~0,8% - ������ ���������� Sbis-All>>%LOG_FILE%
del "%START_DIR%\FullBuild.txt"
devenv "%WORK_DIR%\Core\sbis\sbis_jinnee\sbis_all.sln" %BUILD_MODE% %BUILD_CONF% /out "%START_DIR%\FullBuild.txt"
@echo %TIME:~0,8% - ��������� ���������� Sbis-All>>%LOG_FILE%

@echo %TIME:~0,8% - ������ ������ pdb-������ ��� Sbis-All>>%LOG_FILE%
start /D "C:\Program Files\Debugging Tools for Windows (x64)" symstore.exe add /f "%WORK_DIR%\*" /s "c:\Symbols" /t sbis /r /o
@echo %TIME:~0,8% - ������ pdb-������ ��� Sbis-All ���������>>%LOG_FILE%

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
if not exist "%WORK_DIR%\Core\SBIS\������\����� ��������� ��������\sbis-swift-client.dll"	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\sbis-report-reader\Release\sbis-report-reader.lib"   	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EO\sbis-report-reader\Release\sbis-report-reader.dll"   	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EDO\shipment\Release\shipment.dll"				goto COMPILATION_FAILED
if not exist "%WORK_DIR%\EDO\edo-converter\Release\edo-converter.dll"			goto COMPILATION_FAILED

if not exist "%WORK_DIR%\Conso\conso\Release\conso.dll"			  		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\sbis-screenshot\Release\sbis-screenshot.dll"		goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Service\sbis-screenshot-tray-util\Release\sbis-screenshot-tray-util.exe"	goto COMPILATION_FAILED
if not exist "%WORK_DIR%\Presto\PrestoCaloric\Release\PrestoCaloric.dll"		goto COMPILATION_FAILED

if "%1"=="NIGHT" (
@echo %TIME:~0,8% - ������ ������ ������������>>%LOG_FILE% 
    if "%2" == "DAY" (
       start c:\Autodocumentation\_bin\doxygen.day.cmd
    ) else (
       start c:\Autodocumentation\_bin\doxygen.night.cmd
    )
@echo %TIME:~0,8% - ��������� ������ ������������>>%LOG_FILE% 
)

del /Q "%WORK_DIR%\sbis\������\sbis\muzzle-tests.dll"
del /Q "%WORK_DIR%\sbis\������\sbis\sbis-tests.dll"     

:NO_KOMPIL


echo %DATE:~0,2%.%DATE:~3,2%.%DATE:~8,2% > "%LOCAL_DIR%\BUILD_DATE.txt"

@echo *** �������� exe/dll/splash ***

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
xcopy "\\sbis-dev\Programmers\����_2\������\GDIplus\gdiplus.dll"     		"%PROG_DESTINATION%" /R /Y
xcopy "\\sbis-dev\Programmers\����_2\������\CryptoTun\CryptoTun.dll" 		"%PROG_DESTINATION%" /R /Y
xcopy "\\sbis-dev\Programmers\����_2\������\help\Tensor-Help.exe" 		"%PROG_DESTINATION%" /R /Y


@echo *** �������� ������ ***

xcopy "%WORK_DIR%\Core\sbis\������\sbis\Sbis-graph.dll"           "%PROG_DESTINATION%\������\sbis\*.*"                  /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\sbispro\sbispro.dll"                "%PROG_DESTINATION%\������\sbispro\*.*"               /S /R /Y

xcopy "%WORK_DIR%\Core\sbis\������\sbispro\*.*"        	"%PROG_DESTINATION%\������\sbispro\*.*"    /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\�����������\*.*"    	"%PROG_DESTINATION%\�����������\*.*"    /S /R /Y


@echo *** �������� ������ ����������� ***

xcopy "%WORK_DIR%\Core\sbis\������\������������� ����\accounting.dll"      "%PROG_DESTINATION%\������ �����������\������������� ����\*.*"       /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\��������� ����\warehouse.dll"           "%PROG_DESTINATION%\������ �����������\��������� ����\*.*"           /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\�������� � �����\zpl.dll"               "%PROG_DESTINATION%\������ �����������\�������� � �����\*.*"         /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\�������� ��������\capital.dll"          "%PROG_DESTINATION%\������ �����������\�������� ��������\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\��������� ����\budget.dll"              "%PROG_DESTINATION%\������ �����������\��������� ����\*.*"           /S /R /Y

@echo *** �������� ������ CRM ***

xcopy "%WORK_DIR%\Core\sbis\������\CRM\CRM.dll"                         "%PROG_DESTINATION%\������ CRM\CRM\*.*"                      /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\��������������\AutoInformer.dll"     "%PROG_DESTINATION%\������ CRM\��������������\*.*"           /S /R /Y

xcopy "%WORK_DIR%\CRM\CRM\������\*.*"                       "%PROG_DESTINATION%\������ CRM\*.*" /S /R /Y
xcopy "%WORK_DIR%\CRM\AutoInformer\������\*.*"   	        "%PROG_DESTINATION%\������ CRM\*.*" /S /R /Y

@echo *** �������� ������ Carry ***

xcopy "%WORK_DIR%\Core\sbis\������\��������� �����\whcenter.dll"           	"%PROG_DESTINATION%\������ Carry\��������� �����\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\�������\retail.dll"                 		"%PROG_DESTINATION%\������ Carry\�������\*.*"                /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\�������� � ���������\logistics.dll"     	"%PROG_DESTINATION%\������ Carry\�������� � ���������\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\�������� � ���������\TradeCtrl.dll"     	"%PROG_DESTINATION%\������ Carry\�������� � ���������\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\������������\TradeDrv.dll"     		"%PROG_DESTINATION%\������ Carry\������������\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\������������\IdentDrv.dll"     		"%PROG_DESTINATION%\������ Carry\������������\*.*"   /S /R /Y

@echo *** �������� ������ Presto ***
xcopy "%WORK_DIR%\Presto\PrestoCaloric\Release\PrestoCaloric.dll"      	     "%PROG_DESTINATION%\������ Presto\Presto ������������\*.*"          /R /Y

@echo *** �������� ������ ���������� ������������ ***

xcopy "%WORK_DIR%\Core\sbis\������\��������������\frp.dll"                 "%PROG_DESTINATION%\������ ���������� ������������\��������������\*.*"         /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\������� �����\cargo.dll"                "%PROG_DESTINATION%\������ ���������� ������������\������� �����\*.*"          /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\��������� �����\ServiceCenter.dll"      "%PROG_DESTINATION%\������ ���������� ������������\��������� �����\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\���������� ����������\PersonnelAdm.dll" "%PROG_DESTINATION%\������ ���������� ������������\���������� ����������\*.*"  /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\���������� ���������\frm.dll"           "%PROG_DESTINATION%\������ ���������� ������������\���������� ���������\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\���������� ���������\planing.dll"       "%PROG_DESTINATION%\������ ���������� ������������\���������� ���������\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\����������� ���������\ECheckpoint.dll"  "%PROG_DESTINATION%\������ ���������� ������������\����������� ���������\*.*"  /S /R /Y


@echo *** �������� ������ ��� ***  

xcopy "%WORK_DIR%\Core\sbis\������\����������� ���������������\EDO.dll"           "%PROG_DESTINATION%\������ ���\����������� ���������������\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\���������� ����������������\reglaments.dll"    "%PROG_DESTINATION%\������ ���\���������� ����������������\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\���������������\docflow.dll"                   "%PROG_DESTINATION%\������ ���\���������������\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\������� ����\fssp.dll"			     "%PROG_DESTINATION%\������ ���\������� ����\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\��������� ��������\shipment.dll"		     "%PROG_DESTINATION%\������ ���\��������� ��������\*.*"        /S /R /Y
xcopy "%WORK_DIR%\Core\edo-converter\Release\edo-converter.dll"		     "%PROG_DESTINATION%\������ ���\��������������� ����������\*.*"        /S /R /Y


@echo *** �������� ������ ������ ***

xcopy "%WORK_DIR%\Core\sbis\������\��������������\licensing.dll"           "%PROG_DESTINATION%\������ ������\��������������\*.*"              /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\����\Msfo.dll"                          "%PROG_DESTINATION%\������ ������\����\*.*"                        /S /R /Y

@echo *** �������� ������ ��� ***

xcopy "%WORK_DIR%\Core\sbis\������\����������� ����������\eo.dll"          "%PROG_DESTINATION%\������ ���\����������� ����������\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\����������� �������\sbis-report-reader.dll"  "%PROG_DESTINATION%\������ ���\����������� �������\*.*"   /S/Y /R
xcopy "%WORK_DIR%\Core\sbis\������\����������� �������\esign.dll"          "%PROG_DESTINATION%\������ ���\����������� �������\*.*"      /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\����������� �������\eo-transport.dll"   "%PROG_DESTINATION%\������ ���\����������� �������\*.*"      /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\����������������\eo-np.dll"             "%PROG_DESTINATION%\������ ���\����������������\*.*"   /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\�������������� �����������\UB.dll"      "%PROG_DESTINATION%\������ ���\�������������� �����������\*.*"          /S /R /Y

copy /y "%WORK_DIR%\Service\sbis-loader\loader.exe"                           "%PROG_DESTINATION%\������ ������\���� ����������\SbisMon.exe_"
copy /y "%WORK_DIR%\Service\sbis-loader\Interface.dll"                        "%PROG_DESTINATION%\������ ������\���� ����������\Interface.dll_"
copy /y "%WORK_DIR%\Service\sbis-loader\���������.rs"                         "%PROG_DESTINATION%\������ ������\���� ����������\���������.rs_"
copy /y "%WORK_DIR%\Service\EONPMonitoring\monitoring.dll"                    "%PROG_DESTINATION%\������ ������\���� ����������\monitoring.dll_"
copy /y "%WORK_DIR%\Core\jinnee\DeltaFile.dll"                             "%PROG_DESTINATION%\������ ������\���� ����������\DeltaFile.dll_"
md "%PROG_DESTINATION%\������ ���\����������������\����������"
copy /y "%WORK_DIR%\Service\EOMonitoring\Release\EOMonitoring.pdll"           "%PROG_DESTINATION%\������ ���\����������������\����������\EOMonitoring.pdll"
	
xcopy "%WORK_DIR%\EO\sbis-rpc\sbis-rpc.dll"					"%PROG_DESTINATION%\������ ���\����� ��������� ��������\*.*"       /R /Y
xcopy "%WORK_DIR%\EO\sbis-rpc-client\sbis-rpc-client.dll"				"%PROG_DESTINATION%\������ ���\����� ��������� ��������\*.*"       /R /Y
xcopy "%WORK_DIR%\EO\sbis-communication\release\sbis-communication.dll"		"%PROG_DESTINATION%\������ ���\����� ��������� ��������\*.*"       /R /Y
xcopy "%WORK_DIR%\Core\SBIS\������\����� ��������� ��������\sbis-swift-client.dll"	"%PROG_DESTINATION%\������ ���\����� ��������� ��������\*.*"       /R /Y

xcopy "I:\����_2\������\CrptInst\cryptopro.iss"					"%PROG_DESTINATION%\������ ���\����������� ����������\���������\*.*"       /R /Y

@echo *** �������� ������ ����������������� ���������� ***

xcopy "%WORK_DIR%\Conso\conso\Release\conso.dll"			"%PROG_DESTINATION%\������ ����������������� ����������\����������������� ����������\*.*"       /R /Y

@echo *** ������ �������� jinnee � cnv19 ***

xcopy "%WORK_DIR%\Core\jinnee\jinnee.exe"                   	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\�����.rs"                     	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\DeltaFile.dll"                	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                   	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"               	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%PROG_DESTINATION%\������\sbis\������� �������.rs" 	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
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
xcopy "%WORK_DIR%\Core\sbis\������\sbispro\sbispro.dll"     	"%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\CNV\cnv20\������� �����������\*.*"       	"%PROG_DESTINATION%\jinnee\������� �����������\*.*" /R /Y /E
xcopy "\\sbis-dev\Programmers\����_2\������\GDIplus\gdiplus.dll"           "%PROG_DESTINATION%\jinnee\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"               	"%PROG_DESTINATION%\jinnee\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\jinnee\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\jinnee\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\jinnee\*.*" /Y /R /S

xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"                       	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\jinnee.exe"                           	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\jinnee\�����.rs"                             	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                           	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                       	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%PROG_DESTINATION%\������\sbis\������� �������.rs"         	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
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
xcopy "%WORK_DIR%\Core\sbis\������\sbispro\sbispro.dll"             	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "\\sbis-dev\Programmers\����_2\������\GDIplus\gdiplus.dll"        "%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\��������� ����\warehouse.dll"    	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\������\�������� � �����\zpl.dll"        	"%PROG_DESTINATION%\cnv19\*.*" /R /Y
xcopy "%WORK_DIR%\Buh\Accounting\Release\accounting.dll"	       	"%PROG_DESTINATION%\cnv19\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\cnv19\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\cnv19\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\cnv19\*.*" /Y /R /S

@echo *** ������� ���������� ***

xcopy "%WORK_DIR%\Service\Run\Run.exe"               			"%PROG_DESTINATION%\����������\*.*" /R /Y
xcopy "%WORK_DIR%\Service\Run\msvcr100.dll"    				"%PROG_DESTINATION%\����������\*.*" /R /Y
xcopy "%WORK_DIR%\Service\Run\msvcp100.dll"    				"%PROG_DESTINATION%\����������\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\7-zip32.dll"        			"%PROG_DESTINATION%\����������\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"         			"%PROG_DESTINATION%\����������\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"         			"%PROG_DESTINATION%\����������\*.*" /R /Y
xcopy "\\sbis-dev\Programmers\����_2\������\GDIplus\gdiplus.dll" 	"%PROG_DESTINATION%\����������\*.*" /R /Y
xcopy "%PROG_DESTINATION%\������\sbis\������� �������.rs"  		"%PROG_DESTINATION%\����������\*.*" /R /Y
xcopy "%WORK_DIR%\Service\Run\������"                			"%PROG_DESTINATION%\����������\������\*.*" /S /R /Y
xcopy "%WORK_DIR%\Service\Run\Run.rs"                			"%PROG_DESTINATION%\����������\������\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"                		"%PROG_DESTINATION%\����������\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\����������\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\����������\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\����������\*.*" /Y /R /S

@echo *** ������� ������ �������� ***

xcopy "%WORK_DIR%\Service\LicensesServer\sbis-LicServ.exe"      "%PROG_DESTINATION%\������ ��������\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                      	"%PROG_DESTINATION%\������ ��������\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                  	"%PROG_DESTINATION%\������ ��������\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-xml\sbis-xml.dll"                  	"%PROG_DESTINATION%\������ ��������\*.*" /R /Y
xcopy "%WORK_DIR%\Service\LicensesServer\msvcr100.dll"          "%PROG_DESTINATION%\������ ��������\*.*" /R /Y
xcopy "%WORK_DIR%\Service\LicensesServer\msvcp100.dll"          "%PROG_DESTINATION%\������ ��������\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\7-zip32.dll"                    	"%PROG_DESTINATION%\������ ��������\*.*" /R /Y
xcopy "\\sbis-dev\Programmers\����_2\������\GDIplus\gdiplus.dll"              "%PROG_DESTINATION%\������ ��������\*.*" /R /Y
xcopy "\\sbis-dev\Programmers\����_2\������\��������\����������\InstDrv.exe"  "%PROG_DESTINATION%\������ ��������\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\������ ��������\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\������ ��������\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\������ ��������\*.*" /Y /R /S


@echo *** �������� ����� ������ ���������� ������ �������� ***

md "%PROG_DESTINATION%\������ ���������� ������ ��������"

xcopy "%WORK_DIR%\EO\sbis-rpc-service\sbis-rpc-service.dll"              "%PROG_DESTINATION%\������ ���������� ������ ��������\*.*" /R /Y
xcopy "%WORK_DIR%\EO\sbis-rpc\sbis-rpc.dll"                              "%PROG_DESTINATION%\������ ���������� ������ ��������\*.*" /R /Y

@echo *** �������� ����� MuzzleServer *** 

xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                                    	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                                 	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%PROG_DESTINATION%\������\sbis\������� �������.rs"                	"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y
xcopy "%PROG_DESTINATION%\������\sbis\������� �������.rs"                	"%PROG_DESTINATION%\MuzzleServer\������� �������\*.*" /R /Y
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
xcopy "I:\����_2\������\GDIplus\gdiplus.dll"              			"%PROG_DESTINATION%\MuzzleServer\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\MuzzleServer\*.*" /Y /R /S

@echo *** �������� ����� ���������������� ***

md "%PROG_DESTINATION%\����������������\�����\DB"

xcopy "%PROG_DESTINATION%\������\sbis\*.*"               "%PROG_DESTINATION%\����������������\�����\������\sbis\*.*" /S /R /Y
xcopy "%PROG_DESTINATION%\jinnee\*.*"                    "%PROG_DESTINATION%\����������������\�����\jinnee\*.*" /S /R /Y
xcopy "%WORK_DIR%\Core\sbis\sbis.exe"                         "%PROG_DESTINATION%\����������������\�����\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis\sbis.dll"                         "%PROG_DESTINATION%\����������������\�����\*.*" /R /Y
xcopy "%WORK_DIR%\Core\muzzle\muzzle.dll"                     "%PROG_DESTINATION%\����������������\�����\*.*" /R /Y
xcopy "%WORK_DIR%\Core\sbis-lib\sbis-lib.dll"                 "%PROG_DESTINATION%\����������������\�����\*.*" /R /Y

xcopy "%WORK_DIR%\Core\sbis-crypto-old\Release\sbis-crypto-old.dll"       	"%PROG_DESTINATION%\����������������\�����\*.*" /Y /R
xcopy "%WORK_DIR%\Core\sbis-crypto2\Release\sbis-crypto2.dll"             	"%PROG_DESTINATION%\����������������\�����\*.*" /Y /R
xcopy "%WORK_DIR%\Core\core-crypto\sbis-crypto\Release\*.dll"   	"%PROG_DESTINATION%\����������������\�����\*.*" /Y /R /S

xcopy "%WORK_DIR%\Core\sbis\install\ini\*.*"                  "%PROG_DESTINATION%\ini\*.*" /Y /R /S
xcopy "%WORK_DIR%\Core\sbis\install\*.ini"                    "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis\install\������������������.bat"   "%PROG_DESTINATION%" /Y /R
xcopy "%WORK_DIR%\Core\sbis\install\���������������.bat"      "%PROG_DESTINATION%" /Y /R

xcopy "%WORK_DIR%\Core\sbis\install\������ ������������ ��� ���������\*.*" "%PROG_DESTINATION%\������ ������������ ��� ���������\*.*" /S /R /Y

@echo *** ��������� SbisSDK ***

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

@echo *** �������� Sbis_update_backup.exe ***

xcopy "%WORK_DIR%\Service\Sbis_update_backup\Sbis_update_backup.exe" "%PROG_DESTINATION%\������������ ���� ������\*.*" /R /Y

xcopy "%WORK_DIR%\Service\sbis-screenshot-tray-util\Release\sbis-screenshot-tray-util.exe"     		"%PROG_DESTINATION%\cfs\*.*" 	    /R /Y
xcopy "%WORK_DIR%\Service\sbis-screenshot\Release\sbis-screenshot.dll" 				    	"%PROG_DESTINATION%\cfs\*.*" 	    /R /Y
xcopy "%WORK_DIR%\Service\sbis-screenshot-tray-util\screenshot-tray-util.ini"     			"%PROG_DESTINATION%\cfs\*.*" 	    /R /Y

@goto :EOF


:COMPILATION_FAILED
@echo.
@echo ****************************************************
@echo ������ ��� ������ ������ �� ��������!!!
@echo ****************************************************
@goto ERRORS

:ERRORS
if "%1"=="NIGHT" NET SHARE "%PUT%"="%LOCAL_DIR%" /GRANT:���,READ
msg * /server:tf-pundikai /v /time:0 "������ ��� ������ " %VERSION%%NUM% "!!!"
@echo %TIME:~0,8% - ������ ����������� � ��������>>%LOG_FILE%
@echo.
@echo.
@echo ****************************************************
@echo �����-�� ������ ���������!!!
@echo ****************************************************
@echo 
@echo 
@echo 
@@exit /b 1