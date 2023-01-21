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
    
    $response = (Invoke-RestMethod @restMethodParams).choices.text
    1..[System.Console]::WindowWidth | % { Write-Host '-' -NoNewline -ForegroundColor Green } 
    Write-Host "$response`n" -ForegroundColor Green
    1..[System.Console]::WindowWidth | % { Write-Host '-' -NoNewline -ForegroundColor Green } 
}

Set-Alias -Name 'ask' -Value 'Invoke-TextCompletion'
Export-ModuleMember -Function 'Invoke-TextCompletion', 'PrintWithBorder' -Alias 'ask'

