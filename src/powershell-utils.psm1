Function Assert-Elevation {
    [Security.Principal.WindowsPrincipal] $Identity = [Security.Principal.WindowsIdentity]::GetCurrent()            
    If (-not ($Identity.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
        throw "This cmdLet requires an elevated PowerShell prompt"
    }
}

Function Get-AdamServices {
    param(
        [Parameter(Mandatory = $false)]
        [string]$Version
    )

    switch ($Version) {
        "5.4" {
            return @(
                "ADAM 5.4.0.0 Indexer Service",
                "ADAM 5.4.0.0 Maintenance Service",
                "ADAM 5.4.0.0 Media Engine Host Service (32-bit)",
                "ADAM 5.4.0.0 Media Engine Host Service (64-bit)",
                "ADAM 5.4.0.0 Synchronization Service",
                "ADAM 5.4.0.0 Service"
            )
        }

        "6.0" {
            return @(
                "ADAM 6.0.0.0 Indexer Service",
                "ADAM 6.0.0.0 Maintenance Service",
                "ADAM 6.0.0.0 Synchronization Service",
                "AdamContentModeling60",
                "elasticsearch-service-x64",
                "ADAM 6.0.0.0 Service"
            )
        }

        default {
            return @()
        }
    }
}

Function Start-AdamServices {
    param(
        [Parameter(Mandatory = $false)]
        [ValidateSet("5.4", "6.0")]
        [string]$Version
    )

    Assert-Elevation

    if (-not $Version) {
        Start-AdamServices -Version "5.4"
        Start-AdamServices -Version "6.0"
    }
    else {
        $services = Get-AdamServices -Version $Version
        [array]::Reverse($services)

        foreach ($serviceName in $services) {
            $service = Get-Service -Name $serviceName
            if (-not $service) {
                Write-Warning "Cannot find the service $serviceName"
                continue
            }

            if ($service.Status -eq "Stopped") {
                Start-Service -Name $serviceName
            }
        }
    }    
}

Function Restart-AdamServices {
    param(
        [Parameter(Mandatory = $false)]
        [ValidateSet("5.4", "6.0")]
        [string]$Version
    )

    Assert-Elevation

    if (-not $Version) {
        Restart-AdamServices -Version "5.4"
        Restart-AdamServices -Version "6.0"
    }
    else {
        $services = Get-AdamServices -Version $Version
        [array]::Reverse($services)

        foreach ($serviceName in $services) {
            $service = Get-Service -Name $serviceName
            if (-not $service) {
                Write-Warning "Cannot find the service $serviceName"
                continue
            }

            if ($service.Status -eq "Stopped") {
                Start-Service -Name $serviceName
            }
            elseif ($service.Status -eq "Running") {
                Restart-Service -Name $serviceName -Force
            }
        }
    }    
}

Function Stop-AdamServices {
    param(
        [Parameter(Mandatory = $false)]
        [ValidateSet("5.4", "6.0")]
        [string]$Version
    )

    Assert-Elevation

    if (-not $Version) {
        Stop-AdamServices -Version "5.4"
        Stop-AdamServices -Version "6.0"
    }
    else {
        $services = Get-AdamServices -Version $Version

        foreach ($serviceName in $services) {
            $service = Get-Service -Name $serviceName
            if (-not $service) {
                Write-Warning "Cannot find the service $serviceName"
                continue
            }            

            if ($service.Status -eq "Running") {
                Stop-Service -Name $serviceName
            }
        }
    }    
}

Export-ModuleMember -Function Start-AdamServices
Export-ModuleMember -Function Restart-AdamServices
Export-ModuleMember -Function Stop-AdamServices