# trees.ps1
function Show-TreeWithContent {
    param (
        [string]$Path = ".", # Default path is the current directory
        [int]$IndentLevel = 0,
        [string[]]$ExtensionsToDisplayContent = @(".txt", ".py", ".cpp", ".h", ".js", ".json", ".xml", ".ps1", ".md", ".log", ".ini", ".conf", ".html", ".css"), # Extensions whose content will be displayed
        [string[]]$DirectoriesToIgnore = @(".venv", ".env", ".git", ".vscode", "node_modules", "target") # Directories to ignore in the tree output
    )

    $indentPrefix = "│   " * $IndentLevel
    $currentPathInfo = Get-Item -LiteralPath $Path

    # Display the current directory name only at the top level
    if ($IndentLevel -eq 0) {
        Write-Host "$($currentPathInfo.Name)\"
    }

    # Get child items (folders and files), filter ignored directories, then sort folders before files, then by name
    $items = Get-ChildItem -Path $Path | Where-Object {
        if ($_.PSIsContainer) {
            # Ignore directories if their name (lowercase) is in the $DirectoriesToIgnore list
            -not ($DirectoriesToIgnore -contains $_.Name.ToLower())
        } else {
            $true # Include all files for now, extension filtering will happen later
        }
    } | Sort-Object { -not $_.PSIsContainer }, Name

    for ($i = 0; $i -lt $items.Count; $i++) {
        $item = $items[$i]
        $isLastItem = ($i -eq ($items.Count - 1))
        $prefix = if ($isLastItem) { "└───" } else { "├───" }

        if ($item.PSIsContainer) { # It's a directory
            Write-Host "$($indentPrefix)$($prefix)$($item.Name)\"
            # Recursive call for subdirectories
            Show-TreeWithContent -Path $item.FullName -IndentLevel ($IndentLevel + 1) -ExtensionsToDisplayContent $ExtensionsToDisplayContent -DirectoriesToIgnore $DirectoriesToIgnore
        } else { # It's a file
            Write-Host "$($indentPrefix)$($prefix)$($item.Name)"
            # Check if file content should be displayed
            if ($ExtensionsToDisplayContent -contains $item.Extension.ToLower()) {
                Write-Host "$($indentPrefix)│   ----- FILE CONTENT: $($item.Name) -----"
                try {
                    # Read and display the full content of the file, explicitly using UTF8 encoding
                    Get-Content -Path $item.FullName -Encoding UTF8 | ForEach-Object { Write-Host "$($indentPrefix)│   $_" }
                }
                catch {
                    Write-Host "$($indentPrefix)│   [Error reading file: $($_.Exception.Message)]"
                }
                Write-Host "$($indentPrefix)│   ----- END FILE CONTENT -----"
            }
        }
    }
}

# --- Script execution logic ---
# Check if a path argument was passed when the script was run
if ($args.Count -gt 0) {
    $targetPath = $args[0]
    if (Test-Path -LiteralPath $targetPath -PathType Container) {
        Show-TreeWithContent -Path $targetPath
    } else {
        Write-Error "The specified path is not a directory or does not exist: $targetPath"
    }
} else {
    # If no path argument is provided, run for the current directory
    Show-TreeWithContent -Path (Get-Location).Path
}