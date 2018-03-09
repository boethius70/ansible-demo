param($username, $password, $projectName) 

try
{
	if (!$projectName) {
	    $projectName = 'idontcare'
	}

	if($projectName -eq "ansible-windows") 
	{
		$path = 'OU=Servers,DC=fd,DC=local'
	}
	else
	{
		$path = 'OU=QAServers,OU=Computers,OU=Servers,DC=fd,DC=local'
	}
	$secPass = ConvertTo-SecureString $password -AsPlainText -Force
	$credential = New-Object System.Management.Automation.PSCredential($username, $secPass)

	Add-Computer  -ComputerName $ENV:COMPUTERNAME -Credential $credential -OUPath $path -DomainName fd.local
}
catch
{
	Write-Host "Failed to join domain"
	Write-Host $_
	return -1
}
