function request( [string]$Url, [int]$Timeout, $Options ) {
    if ([string]::IsNullOrWhiteSpace($url)) {throw 'The URL is empty'}
    $request = [System.Net.WebRequest]::Create($Url)
    if ($Timeout)  { $request.Timeout = $Timeout*1000 }
    $Options.Headers | %{$request.Headers.add($_.Name, $_.Value)}

    $response = $request.GetResponse()
    $response.Close()
    $response
}
