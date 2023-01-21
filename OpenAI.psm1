function Invoke-TextCompletion { 

    [CmdletBinding()]
    Param(
        [string]$Prompt,
        [string]$Temperature,
        [string]$ApiKey = "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",
        [string]$Model = 'text-davinci-003',
        [Int32]$MaxTokens = 4000
    )
    
    $restMethodParams = @{
        Method  = "Post"
        Uri     = "https://api.openai.com/v1/engines/$Model/completions"
        Body    = @{
                        prompt = $Prompt
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

