$searchClass = "wikitable" <# in this example we parse all elements of class "banana" but you can use any class name you wish #>
$myURI = "https://de.wikipedia.org/wiki/The_Mentalist/Episodenliste" <# replace url.com with any website you want to scrape from #>

$req = Invoke-Webrequest -URI $myURI
$tables = $req.ParsedHtml.getElementsByClassName($searchClass)
$list = New-Object Collections.Generic.List[String]

foreach ($table in $tables) {
  $trs = $table.getElementsByTagName("tr")
  for ($i = 1; $i -lt $trs.length; $i += 2) {
    $tds = $trs[$i]
    $boldTags = $tds.getElementsByTagName("b")
    foreach ($boldTag in $boldTags) {
      $list.Add($boldTag.innerText())
    }
  }
}

Write-Host $list.Count.ToString()
