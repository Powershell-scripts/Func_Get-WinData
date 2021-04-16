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