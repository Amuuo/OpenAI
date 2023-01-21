function Invoke-TextCompletion { 

    [CmdletBinding()]
    Param(
        $Prompt      = 'Say this is a test',
        $Temperature = 0.0,
        $ApiKey      = "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",
        $Model       = 'text-davinci-003',
        $MaxTokens   = 4000
    )
    
    $restMethodParams = @{
        Method  = "Post"
        Uri     = "https://api.openai.com/v1/engines/$Model/completions"
        Body    = @{
                        prompt = $Prompt
                        temperature = $Temperature
                        max_tokens = $MaxTokens
                    } | ConvertTo-Json
        Headers = @{
                        Authorization  = "Bearer $ApiKey"
                        "Content-Type" = "application/json"
                    }
    }
    $border = [string]::new('-', [System.Console]::WindowWidth)
    Write-Host "`n$border$((Invoke-RestMethod @restMethodParams).choices.text)`n`n$border`n" -ForegroundColor Green
}

Set-Alias -Name 'ask' -Value 'Invoke-TextCompletion'
Export-ModuleMember -Function 'Invoke-TextCompletion', 'PrintWithBorder' -Alias 'ask'

