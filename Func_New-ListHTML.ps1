function New-ListHTML {
    param (
        [Parameter(Mandatory)]
        $Data,
        $HeaderName,
        $ParamName,
        [Parameter(Mandatory)]
        $SavePath
    )
    
    # Составляем html форматирование
    $head = @'
        <style>
            body { background-color:#dddddd;
                font-family:Tahoma;
	            font-size:12pt; }
                td, th { border:1px solid black;
                    border-collapse:collapse; }
                th { color:white;
                    background-color:black; }
                table, tr, td, th { padding: 2px; margin: 0px }
                table { margin-left:50px; }
        </style> 
'@
    
    # Формируем строку с данными
    $HTMLs = $Data 
    $Set = foreach ($HTML in $HTMLs) {
        
        # Делаем привязку к имени ПК (у меня во всех скриптах есть имя ПК - поэтому буду разделять на него)
        $PC = $HTML.ComputerName

        # Конвертируем данные в хтмл формат 
        $HTML | ConvertTo-Html -As LIST -Fragment –PreContent "<h2>$ParamName $PC</h2>" | Out-String
    } 
    
    # Формируем общий вывод данных и сохраняем в файл
    ConvertTo-HTML -head $head -PostContent $Set -PreContent "<h1>$HeaderName</h1>" | out-file -FilePath $SavePath
}