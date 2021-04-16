
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
$HTMLs = $Data 
$Set = foreach ($HTML in $HTMLs) {
    $PC = $HTML.ComputerName
    $HTML | ConvertTo-Html -As LIST -Fragment –PreContent "<h2>OS $PC</h2>" | Out-String
    } 
ConvertTo-HTML -head $head -PostContent $Set -PreContent "<h1>OS Inventory</h1>" | out-file -FilePath C:\temp\windata.html