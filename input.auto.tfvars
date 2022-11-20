aks_vnet_name = "aksvnet"

sshkvsecret = "akssshpubkey"

clientidkvsecret = "spn-id"

spnkvsecret = "spn-secret"

vnetcidr = ["10.0.0.0/24"]

subnetcidr = ["10.0.0.0/25"]

keyvault_rg = "aks-harryer10-rg"

keyvault_name = "aks-harryer10-cluster-kv"

azure_region = "southeastasia"

resource_group = "aks-harryer10-cluster-rg"

cluster_name = "aks-harryer10-cluster"

dns_name = "aks-harryer10-cluster"

admin_username = "aksuser"

kubernetes_version = "1.21.7"

agent_pools = {
      name            = "pool1"
      count           = 2
      vm_size         = "Standard_D2_v2"
      os_disk_size_gb = "30"
    }
