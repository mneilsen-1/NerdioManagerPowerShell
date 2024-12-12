Function Get-NmeDesktopImage {
	<#

	.SYNOPSIS

	Get list of all desktop images.

	.DESCRIPTION

	Get list of all desktop images. 

	This function calls the /api/v1/desktop-image endpoint of the NME REST API, using the get method.




	#>

	[CmdletBinding()]
	Param(

	)
	Set-NmeAuthHeaders
	Try {
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image$Querystring" -Method get -Headers $script:AuthHeaders -ContentType 'application/json'
		$Result.PSObject.TypeNames.Insert(0, 'NmeDesktopImageRestModel')
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function Get-NmeDesktopImageScheduledTask {
	<#

	.SYNOPSIS

	Get scheduled tasks for desktop image.

	.DESCRIPTION

	Get scheduled tasks for desktop image. 

	This function calls the /api/v1/desktop-image/{subscriptionId}/{resourceGroup}/{name}/schedule endpoint of the NME REST API, using the get method.


	.PARAMETER SubscriptionId

	The id (guid) of the subscription where this desktopimage resides

	.PARAMETER ResourceGroup

	The Azure resource group where the desktopimage resides

	.PARAMETER Name

	The name of the desktopimage

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$SubscriptionId,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$ResourceGroup,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$Name
	)
	Set-NmeAuthHeaders
	Try {
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/$SubscriptionId/$ResourceGroup/$Name/schedule$Querystring" -Method get -Headers $script:AuthHeaders -ContentType 'application/json'
		$Result.PSObject.TypeNames.Insert(0, 'NmeDesktopImageScheduleRestModel')
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'subscriptionId' -NotePropertyValue $subscriptionId -erroraction 'SilentlyContinue'}
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'resourceGroup' -NotePropertyValue $resourceGroup -erroraction 'SilentlyContinue'}
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'name' -NotePropertyValue $name -erroraction 'SilentlyContinue'}
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function Start-NmeDesktopImageScript {
	<#

	.SYNOPSIS

	Run script on desktop image VM.

	.DESCRIPTION

	Run script on desktop image VM. 

	This function calls the /api/v1/desktop-image/{subscriptionId}/{resourceGroup}/{name}/script endpoint of the NME REST API, using the post method.


	.PARAMETER SubscriptionId

	The id (guid) of the subscription where this desktopimage resides

	.PARAMETER ResourceGroup

	The Azure resource group where the desktopimage resides

	.PARAMETER Name

	The name of the desktopimage

	.PARAMETER NmeRunCustomScriptOnVmRestModel

	Requires an NmeRunCustomScriptOnVmRestModel object, as generated by the New-NmeRunCustomScriptOnVmRestModel command.

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$SubscriptionId,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$ResourceGroup,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$Name,
		[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$True)][ValidateScript({if ($_.PSObject.TypeNames -contains "NmeRunCustomScriptOnVmRestModel"){$true} else{throw " is not a NmeRunCustomScriptOnVmRestModel object."}})]$NmeRunCustomScriptOnVmRestModel
	)
	Set-NmeAuthHeaders
	Try {
		$json = $NmeRunCustomScriptOnVmRestModel | ConvertTo-Json -Depth 20
		Write-Debug 'json:'
		Write-Debug $json
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/$SubscriptionId/$ResourceGroup/$Name/script$QueryString" -Method post -Headers $script:AuthHeaders -ContentType 'application/json' -body $json
		Write-Verbose ($result | out-string)
		$Result.PSObject.TypeNames.Insert(0, 'NmeResponseWithJob')
		$Result | Add-Member -NotePropertyName 'subscriptionId' -NotePropertyValue $subscriptionId -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'resourceGroup' -NotePropertyValue $resourceGroup -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'name' -NotePropertyValue $name -erroraction 'SilentlyContinue'
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function New-NmeDesktopImageScriptScheduleV2 {
	<#

	.SYNOPSIS

	Schedule script execution on desktop image VM.

	.DESCRIPTION

	Schedule script execution on desktop image VM. 

	This function calls the /api/v1/desktop-image/{subscriptionId}/{resourceGroup}/{name}/script/schedule-v2 endpoint of the NME REST API, using the post method.


	.PARAMETER SubscriptionId

	The id (guid) of the subscription where this desktopimage resides

	.PARAMETER ResourceGroup

	The Azure resource group where the desktopimage resides

	.PARAMETER Name

	The name of the desktopimage

	.PARAMETER NmeScheduleRunCustomScriptOnVmRestModel_POST

	Requires an NmeScheduleRunCustomScriptOnVmRestModel_POST object, as generated by the New-NmeScheduleRunCustomScriptOnVmRestModel_POST command.

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$SubscriptionId,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$ResourceGroup,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$Name,
		[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$True)][ValidateScript({if ($_.PSObject.TypeNames -contains "NmeScheduleRunCustomScriptOnVmRestModel_POST"){$true} else{throw " is not a NmeScheduleRunCustomScriptOnVmRestModel_POST object."}})]$NmeScheduleRunCustomScriptOnVmRestModel_POST
	)
	Set-NmeAuthHeaders
	Try {
		$json = $NmeScheduleRunCustomScriptOnVmRestModel_POST | ConvertTo-Json -Depth 20
		Write-Debug 'json:'
		Write-Debug $json
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/$SubscriptionId/$ResourceGroup/$Name/script/schedule-v2$QueryString" -Method post -Headers $script:AuthHeaders -ContentType 'application/json' -body $json
		Write-Verbose ($result | out-string)
		$Result.PSObject.TypeNames.Insert(0, 'NmeResponseWithJob')
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'subscriptionId' -NotePropertyValue $subscriptionId -erroraction 'SilentlyContinue'}
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'resourceGroup' -NotePropertyValue $resourceGroup -erroraction 'SilentlyContinue'}
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'name' -NotePropertyValue $name -erroraction 'SilentlyContinue'}
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function Get-NmeDesktopImageScriptScheduleV2Id {
	<#

	.SYNOPSIS

	Get scheduled script execution job params for desktop image.

	.DESCRIPTION

	Get scheduled script execution job params for desktop image. 

	This function calls the /api/v1/desktop-image/{subscriptionId}/{resourceGroup}/{name}/script/schedule-v2/{scheduleId} endpoint of the NME REST API, using the get method.


	.PARAMETER SubscriptionId

	The id (guid) of the subscription where this desktopimage resides

	.PARAMETER ResourceGroup

	The Azure resource group where the desktopimage resides

	.PARAMETER Name

	The name of the desktopimage

	.PARAMETER ScheduleId

	Id of Schedule

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$SubscriptionId,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$ResourceGroup,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$Name,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][int]$ScheduleId
	)
	Set-NmeAuthHeaders
	Try {
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/$SubscriptionId/$ResourceGroup/$Name/script/schedule-v2/$ScheduleId$Querystring" -Method get -Headers $script:AuthHeaders -ContentType 'application/json'
		$Result.PSObject.TypeNames.Insert(0, 'NmeScheduleRunCustomScriptOnVmRestModel_GET')
		$Result | Add-Member -NotePropertyName 'subscriptionId' -NotePropertyValue $subscriptionId -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'resourceGroup' -NotePropertyValue $resourceGroup -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'name' -NotePropertyValue $name -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'scheduleId' -NotePropertyValue $scheduleId -erroraction 'SilentlyContinue'
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function Set-NmeDesktopImageScriptScheduleV2Id {
	<#

	.SYNOPSIS

	Update scheduled script execution on desktop image VM.

	.DESCRIPTION

	Update scheduled script execution on desktop image VM. 

	This function calls the /api/v1/desktop-image/{subscriptionId}/{resourceGroup}/{name}/script/schedule-v2/{scheduleId} endpoint of the NME REST API, using the put method.


	.PARAMETER SubscriptionId

	The id (guid) of the subscription where this desktopimage resides

	.PARAMETER ResourceGroup

	The Azure resource group where the desktopimage resides

	.PARAMETER Name

	The name of the desktopimage

	.PARAMETER ScheduleId

	Id of Schedule

	.PARAMETER NmeScheduleRunCustomScriptOnVmRestModel_POST

	Requires an NmeScheduleRunCustomScriptOnVmRestModel_POST object, as generated by the New-NmeScheduleRunCustomScriptOnVmRestModel_POST command.

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$SubscriptionId,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$ResourceGroup,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$Name,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][int]$ScheduleId,
		[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$True)][ValidateScript({if ($_.PSObject.TypeNames -contains "NmeScheduleRunCustomScriptOnVmRestModel_POST"){$true} else{throw " is not a NmeScheduleRunCustomScriptOnVmRestModel_POST object."}})]$NmeScheduleRunCustomScriptOnVmRestModel_POST
	)
	Set-NmeAuthHeaders
	Try {
		$json = $NmeScheduleRunCustomScriptOnVmRestModel_POST | ConvertTo-Json -Depth 20
		Write-Debug 'json:'
		Write-Debug $json
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/$SubscriptionId/$ResourceGroup/$Name/script/schedule-v2/$ScheduleId$QueryString" -Method put -Headers $script:AuthHeaders -ContentType 'application/json' -body $json
		Write-Verbose ($result | out-string)
		$Result.PSObject.TypeNames.Insert(0, 'NmeResponseWithJob')
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'subscriptionId' -NotePropertyValue $subscriptionId -erroraction 'SilentlyContinue'}
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'resourceGroup' -NotePropertyValue $resourceGroup -erroraction 'SilentlyContinue'}
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'name' -NotePropertyValue $name -erroraction 'SilentlyContinue'}
		$Result | ForEach-Object {$_ | Add-Member -NotePropertyName 'scheduleId' -NotePropertyValue $scheduleId -erroraction 'SilentlyContinue'}
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function Remove-NmeDesktopImageScriptScheduleV2Id {
	<#

	.SYNOPSIS

	Delete scheduled script execution job for desktop image.

	.DESCRIPTION

	Delete scheduled script execution job for desktop image. 

	This function calls the /api/v1/desktop-image/{subscriptionId}/{resourceGroup}/{name}/script/schedule-v2/{scheduleId} endpoint of the NME REST API, using the delete method.


	.PARAMETER SubscriptionId

	The id (guid) of the subscription where this desktopimage resides

	.PARAMETER ResourceGroup

	The Azure resource group where the desktopimage resides

	.PARAMETER Name

	The name of the desktopimage

	.PARAMETER ScheduleId

	Id of Schedule

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$SubscriptionId,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$ResourceGroup,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$Name,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][int]$ScheduleId
	)
	Set-NmeAuthHeaders
	Try {
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/$SubscriptionId/$ResourceGroup/$Name/script/schedule-v2/$ScheduleId$Querystring" -Method delete -Headers $script:AuthHeaders -ContentType 'application/json'
		$Result.PSObject.TypeNames.Insert(0, 'NmeResponseWithJob')
		$Result | Add-Member -NotePropertyName 'subscriptionId' -NotePropertyValue $subscriptionId -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'resourceGroup' -NotePropertyValue $resourceGroup -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'name' -NotePropertyValue $name -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'scheduleId' -NotePropertyValue $scheduleId -erroraction 'SilentlyContinue'
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function New-NmeDesktopImageSetAsImageTask {
	<#

	.SYNOPSIS

	Power off and set as image.

	.DESCRIPTION

	Power off and set as image. 

	This function calls the /api/v1/desktop-image/{subscriptionId}/{resourceGroup}/{name}/set-as-image endpoint of the NME REST API, using the post method.


	.PARAMETER SubscriptionId

	The id (guid) of the subscription where this desktopimage resides

	.PARAMETER ResourceGroup

	The Azure resource group where the desktopimage resides

	.PARAMETER Name

	The name of the desktopimage

	.PARAMETER NmeSetAsImageRequest

	Requires an NmeSetAsImageRequest object, as generated by the New-NmeSetAsImageRequest command.

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$SubscriptionId,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$ResourceGroup,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$Name,
		[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$True)][ValidateScript({if ($_.PSObject.TypeNames -contains "NmeSetAsImageRequest"){$true} else{throw " is not a NmeSetAsImageRequest object."}})]$NmeSetAsImageRequest
	)
	Set-NmeAuthHeaders
	Try {
		$json = $NmeSetAsImageRequest | ConvertTo-Json -Depth 20
		Write-Debug 'json:'
		Write-Debug $json
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/$SubscriptionId/$ResourceGroup/$Name/set-as-image$QueryString" -Method post -Headers $script:AuthHeaders -ContentType 'application/json' -body $json
		Write-Verbose ($result | out-string)
		$Result.PSObject.TypeNames.Insert(0, 'NmeResponseWithJob')
		$Result | Add-Member -NotePropertyName 'subscriptionId' -NotePropertyValue $subscriptionId -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'resourceGroup' -NotePropertyValue $resourceGroup -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'name' -NotePropertyValue $name -erroraction 'SilentlyContinue'
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function Get-NmeDesktopImageSetAsImageScheduleV2 {
	<#

	.SYNOPSIS

	Get scheduled "Set as image" job params for desktop image.

	.DESCRIPTION

	Get scheduled "Set as image" job params for desktop image. 

	This function calls the /api/v1/desktop-image/{subscriptionId}/{resourceGroup}/{name}/set-as-image/schedule-v2/{scheduleId} endpoint of the NME REST API, using the get method.


	.PARAMETER SubscriptionId

	The id (guid) of the subscription where this desktopimage resides

	.PARAMETER ResourceGroup

	The Azure resource group where the desktopimage resides

	.PARAMETER Name

	The name of the desktopimage

	.PARAMETER ScheduleId

	Id of Schedule

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$SubscriptionId,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$ResourceGroup,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string]$Name,
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][int]$ScheduleId
	)
	Set-NmeAuthHeaders
	Try {
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/$SubscriptionId/$ResourceGroup/$Name/set-as-image/schedule-v2/$ScheduleId$Querystring" -Method get -Headers $script:AuthHeaders -ContentType 'application/json'
		$Result.PSObject.TypeNames.Insert(0, 'NmeDesktopImageSetAsImageScheduleRest')
		$Result | Add-Member -NotePropertyName 'subscriptionId' -NotePropertyValue $subscriptionId -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'resourceGroup' -NotePropertyValue $resourceGroup -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'name' -NotePropertyValue $name -erroraction 'SilentlyContinue'
		$Result | Add-Member -NotePropertyName 'scheduleId' -NotePropertyValue $scheduleId -erroraction 'SilentlyContinue'
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
Function New-NmeDesktopImageCreateFromLibraryTask {
	<#

	.SYNOPSIS

	Create desktop image from Azure library.

	.DESCRIPTION

	Create desktop image from Azure library. 

	This function calls the /api/v1/desktop-image/create-from-library endpoint of the NME REST API, using the post method.


	.PARAMETER NmeCreateImageFromLibraryRequest

	Requires an NmeCreateImageFromLibraryRequest object, as generated by the New-NmeCreateImageFromLibraryRequest command.

	#>

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$True)][ValidateScript({if ($_.PSObject.TypeNames -contains "NmeCreateImageFromLibraryRequest"){$true} else{throw " is not a NmeCreateImageFromLibraryRequest object."}})]$NmeCreateImageFromLibraryRequest
	)
	Set-NmeAuthHeaders
	Try {
		$json = $NmeCreateImageFromLibraryRequest | ConvertTo-Json -Depth 20
		Write-Debug 'json:'
		Write-Debug $json
		$Result = Invoke-RestMethod "$script:NmeUri/api/v1/desktop-image/create-from-library$QueryString" -Method post -Headers $script:AuthHeaders -ContentType 'application/json' -body $json
		Write-Verbose ($result | out-string)
		$Result.PSObject.TypeNames.Insert(0, 'NmeResponseWithJob')
		$Result | CapProps
	}
	Catch {
		$message = ParseErrorForResponseBody($_)
		write-error ($message | out-string)
	}
}
