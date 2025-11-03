#==============================================================================#
# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER    #
# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES  #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.   #
#                                                                              #
# Copyright (C) 2024 COOLORANGE S.r.l.                                         #
#==============================================================================#

# Autodesk Platform Services - Model Derivative

# Function for posting a translation job
function Add-TranslationJob($urn64, $region = "US"){
    $body = @{
        "input" = @{
            "urn" = $urn64
            "formats" = @{
                "type" = "svf2"
                "views" = "2d"
            }
        }
        "output" = @{
            "formats" = [Array]@(@{"type" = "svf2"})
        }
    } | ConvertTo-Json -Depth 100 -Compress

    $parameters = @{
        "Uri"     = "https://developer.api.autodesk.com/modelderivative/v2/designdata/job"
        "Method"  = "Post"
        "ContentType" = "application/json"
        "Authorization" = $ApsConnection.Headers
        "Body" = $body
    }    

    $response = Invoke-RestMethod @parameters
    Write-Verbose "Successfully posted translation job!"
    return $response
}

function Get-JobManifest($urn64, $region = "US"){
    $parameters = @{
        "Uri"     = "https://developer.api.autodesk.com/modelderivative/v2/designdata/$urn64/manifest"
        "Method"  = "Get"
        "Region" = $region
        "Authorization" = $ApsConnection.Headers
    }    

    $response = Invoke-RestMethod @parameters
    Write-Verbose "Successfully obtained job manifest"
    return $response
}

function Get-ModelData($urn64, $region = "US"){
    $parameters = @{
        "Uri"     = "https://developer.api.autodesk.com/modelderivative/v2/designdata/$urn64/metadata"
        "Method"  = "Get"
        "Region" = $region
        "Authorization" = $ApsConnection.Headers
    }    

    $response = Invoke-RestMethod @parameters
    Write-Verbose "Successfully obtained model data"
    return $response
}

function Get-ModelProperties($urn64, $modelGUID, $region = "US"){
    $parameters = @{
        "Uri"     = " https://developer.api.autodesk.com/modelderivative/v2/designdata/$urn/metadata/$modelGuid/properties"
        "Method"  = "Get"
        "Region" = $region
        "Authorization" = $ApsConnection.Headers
    }    

    $response = Invoke-RestMethod @parameters
    Write-Verbose "Successfully obtained model properties"
    return $response
}
