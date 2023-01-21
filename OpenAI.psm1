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
    $border = "`n$([string]::new('-', [System.Console]::WindowWidth))"
    $response = "$((Invoke-RestMethod @restMethodParams).choices.text)`n"
    Write-Host "$border$response$border`n" -ForegroundColor Green

    $saveData = [PSCustomObject]@{
        Prompt = $Prompt
        Answer = $response
        CreatedDate = Get-Date
    }

    $sql_params = @{
        ServerInstance  = 'WKSP000D71A6\SQL'
        TableName       = 'QuestionAnswer'
        DatabaseName    = 'ChatGPT'
        SchemaName      = 'dbo'
        Force           = $true
    }

    $saveData | Write-SqlTableData @sql_params
}

Set-Alias -Name 'ask' -Value 'Invoke-TextCompletion'
Export-ModuleMember -Function 'Invoke-TextCompletion', 'PrintWithBorder' -Alias 'ask'

