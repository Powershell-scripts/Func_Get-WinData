function Get-WinData {
    <#
   .SYNOPSIS
   Фильтруем компы и получаем данные об ОС. 

   .DESCRIPTION
   Функция получает список компов в домене и запрашивает данные об ОС. 
   Вывод идет в массив для более легкой обработки данных.

   Получает данные:
   installdate;
   CSName;
   caption;
   status;
   OSArchitecture;
   ProductType;
   SerialNumber;
   Version.

   .PARAMETER -PC
   Принимает string - наименование или часть наименования компа
        
   .EXAMPLE
   Get-WinData 
   Выполняет поиск и формирование массива с данными об ОС по всем компам в домене 

   .EXAMPLE
   Get-WinData -PC SDV 
   Выполняет поиск мащин с именем *SDV* и формирование массива с данными об ОС по полученным компам в домене 

   .NOTES
    Author: @Chentsov_VS
   #>
    param (
        $PC
        )

    if ($null -eq $PC) {
        # Получаем список всех компов
        $PCs = Get-ADComputer -Filter "name -like '*'"
        $PCs = $PCs.name
        }

    else {
        $PCs = Get-ADComputer -Filter "name -like '*$PC*'"
        $PCs = $PCs.name
        }

    if ($PCs.count -gt 1) {
        # С помощью цикла - ищем файл remoteSC.txt
        $Data = foreach ($Name in $PCs) {
        $Sysinfo = invoke-command -computername $Name -scriptblock  {
            $systeminfo = Get-CimInstance -ClassName Win32_OperatingSystem -Property *
            $systeminfo
            }
        $Version = $Sysinfo.Version
        $SerialNumber = $Sysinfo.SerialNumber
        $ProductType = $Sysinfo.ProductType
        $OSArchitecture = $Sysinfo.OSArchitecture
        $status = $Sysinfo.status
        $caption = $Sysinfo.caption
        $CSName = $Sysinfo.CSName
        $installdate = $Sysinfo.installdate

        $DataArray  = [pscustomobject]@{ComputerName = "$Name"; Version = "$Version"; SerialNumber = "$SerialNumber"; ProductType = "$ProductType"; OSArchitecture = "$OSArchitecture"; status = "$status"; caption = "$caption"; CSName = "$CSName"; installdate = "$installdate"}
            }
        }
        
    else {
        $Sysinfo = invoke-command -computername $PCs -scriptblock  {
            $systeminfo = Get-CimInstance -ClassName Win32_OperatingSystem -Property *
            $systeminfo
            }
        $Version = $Sysinfo.Version
        $SerialNumber = $Sysinfo.SerialNumber
        $ProductType = $Sysinfo.ProductType
        $OSArchitecture = $Sysinfo.OSArchitecture
        $status = $Sysinfo.status
        $caption = $Sysinfo.caption
        $CSName = $Sysinfo.CSName
        $installdate = $Sysinfo.installdate

        $DataArray = [pscustomobject]@{ComputerName = "$PCs"; Version = "$Version"; SerialNumber = "$SerialNumber"; ProductType = "$ProductType"; OSArchitecture = "$OSArchitecture"; status = "$status"; caption = "$caption"; CSName = "$CSName"; installdate = "$installdate"}
            }  
            return $DataArray     
        }
