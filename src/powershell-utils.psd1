@{
    # Script module associated with this manifest.
    ModuleToProcess   = 'powershell-utils.psm1'

    # Version number of this module
    ModuleVersion     = '0.0.1'

    # ID used to uniquely identity this module
    GUID              = '7f4120cd-b09b-4b85-aeea-e9a317771012'

    # Author of this module
    Author            = 'Maarten Kools'

    # Copyright statement of this module
    Copyright         = '(c) 2017 Maarten Kools and contributors'

    # Descripton of the functionality provided by this module
    Description       = 'Provides an assortment of utility functions'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '4.0'

    # Functions to export from this module
    FunctionsToExport = @(
        'Start-AdamServices',
        'Restart-AdamServices',
        'Stop-AdamServices'
    )

    # Cmdlets to export from this module
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport   = @('??')

    # Private data to pass to the module specified in RootModule/ModuleToProcess.
    # This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('services', 'adam')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/mkools-vg/powershell-utils/blob/v0.0.1/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/mkools-vg/powershell-utils'
        }
    }
}