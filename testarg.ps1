Param(
	[string]$arg1
)

if ($PSBoundParameters.ContainsKey('arg1')) {
	Write-Host "The first argument is $($PSBoundParameters['arg1']))"
	$DIRECTORY=$arg1
} else {
	Write-Host "No arguments passed..."
	$DIRECTORY="default_folder"
}

# mkdir $DIRECTORY
# Write-Host "Create a ""public"" folder, and create an ""index.html"" file inside it."
Set-Content -Path scripts\\testcontent.txt -Value "test\ntesting"