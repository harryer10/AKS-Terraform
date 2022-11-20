#### Parameters

$keyvaultname = "aks-harryer10-cluster-kv"
$location = "southeastasia"
$keyvaultrg = "aks-harryer10-rg"
$sshkeysecret = "akssshpubkey"
$spnclientid = "996bbb48-b268-4b01-a45c-7b4ccbb2961b"
$clientidkvsecretname = "spn-id"
$spnclientsecret = "i-t8Q~4D1vu6k0bwICZdHIGTOmtiTnjrdx5FpaqL"
$spnkvsecretname = "spn-secret"
$spobjectID = "996bbb48-b268-4b01-a45c-7b4ccbb2961b"
$userobjectid = "996bbb48-b268-4b01-a45c-7b4ccbb2961b"


#### Create Key Vault

New-AzResourceGroup -Name $keyvaultrg -Location $location

New-AzKeyVault -Name $keyvaultname -ResourceGroupName $keyvaultrg -Location $location

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -UserPrincipalName $userobjectid -PermissionsToSecrets get,set,delete,list

#### create an ssh key for setting up password-less login between agent nodes.

ssh-keygen  -f ~/.ssh/id_rsa_terraform


#### Add SSH Key in Azure Key vault secret

$pubkey = cat ~/.ssh/id_rsa_terraform.pub

$Secret = ConvertTo-SecureString -String $pubkey -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $sshkeysecret -SecretValue $Secret


#### Store service principal Client id in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientid -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $clientidkvsecretname -SecretValue $Secret


#### Store service principal Secret in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientsecret -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $spnkvsecretname -SecretValue $Secret


#### Provide Keyvault secret access to SPN using Keyvault access policy

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -ServicePrincipalName $spobjectID -PermissionsToSecrets Get,Set
