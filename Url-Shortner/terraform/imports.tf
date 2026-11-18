# Subnet
import {
  to = azurerm_subnet.default
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/virtualNetworks/vm-test-vnet/subnets/default"
}

# Network Security Group
import {
  to = azurerm_network_security_group.main
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/networkSecurityGroups/vm-test-nsg"
}

# VM Public IP
import {
  to = azurerm_public_ip.vm
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/publicIPAddresses/vm-test-publicip"
}

# NAT Public IP
import {
  to = azurerm_public_ip.nat
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/publicIPAddresses/nat-pip"
}



# Network Interface
import {
  to = azurerm_network_interface.main
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/networkInterfaces/vm-test121"
}




# SSH Public Key
import {
  to = azurerm_ssh_public_key.main
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Compute/sshPublicKeys/vm-test"
}

# VM Extension
import {
  to = azurerm_virtual_machine_extension.vm_access
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/VM-TEST_GROUP/providers/Microsoft.Compute/virtualMachines/vm-test/extensions/enablevmAccess"
}

# NAT Gateway
import {
  to = azurerm_nat_gateway.main
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/natGateways/my-secure-nat-gw"
}

# NAT Gateway - Public IP Association
import {
  to = azurerm_nat_gateway_public_ip_association.main
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/natGateways/my-secure-nat-gw|/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/publicIPAddresses/nat-pip"
}

# NIC - NSG Association
import {
  to = azurerm_network_interface_security_group_association.main
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/networkInterfaces/vm-test121|/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/networkSecurityGroups/vm-test-nsg"
}

# Subnet - NAT Gateway Association
import {
  to = azurerm_subnet_nat_gateway_association.main
  id = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/vm-test_group/providers/Microsoft.Network/virtualNetworks/vm-test-vnet/subnets/default"
}