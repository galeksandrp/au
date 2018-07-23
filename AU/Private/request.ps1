function request( [string]$Url, [int]$Timeout, $Options ) {
    if ([string]::IsNullOrWhiteSpace($url)) {throw 'The URL is empty'}
    $request = [System.Net.WebRequest]::Create($Url)
    if ($Timeout)  { $request.Timeout = $Timeout*1000 }
    if ($Options.Headers) { $Options.Headers.Keys | %{
        # IsRestricted method available only after initializing $request.Headers as WebHeaderCollection
        $request.Headers.add('X-AU', 'Header')
        if ($request.Headers.IsRestricted($_)) {
            $request[$_] = $Options.Headers[$_]
        } else {
            $request.Headers.add($_, $Options.Headers[$_])
        }
        $request.Headers.remove('X-AU')
    } }

    $response = $request.GetResponse()
    $response.Close()
    $response
}
