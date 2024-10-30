resource "azurerm_resource_group" "twrg" { # alias name only for terraform!
  name     = var.azure_rg_name
  location = var.azure_location
  tags     = local.tags
}

# Create virtual network
resource "azurerm_virtual_network" "twvnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.twrg.location
  resource_group_name = azurerm_resource_group.twrg.name
  address_space       = ["10.30.0.0/16"]
  tags                = local.tags
  #   dns_servers         = ["10.0.0.4", "10.0.0.5"]
  #   subnet {
  #     name             = var.virtual_subnet1_name
  #     address_prefixes = ["10.30.1.0/24"] # must be included of address space of virtual network
  #   }
}

# can also be exlcuded from virtual network (better practice)  

resource "azurerm_subnet" "twsubnet" {
  name                 = var.virtual_subnet1_name
  resource_group_name  = azurerm_resource_group.twrg.name
  virtual_network_name = azurerm_virtual_network.twvnet.name
  address_prefixes     = ["10.30.1.0/24"]
}

resource "azurerm_public_ip" "twpip" {
  name                    = var.public_ip_name
  location                = azurerm_resource_group.twrg.location
  resource_group_name     = azurerm_resource_group.twrg.name
  allocation_method       = "Static" # or "Dynamic"
  idle_timeout_in_minutes = 30

  tags = local.tags
}

resource "azurerm_network_security_group" "twnsg" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.twrg.location
  resource_group_name = azurerm_resource_group.twrg.name
  tags                = local.tags

  # can also be exlcuded from here (better practice)  
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_interface" "twnic" {
  name                = var.network_nic_name
  location            = azurerm_resource_group.twrg.location
  resource_group_name = azurerm_resource_group.twrg.name

  ip_configuration {
    name                          = "twnicipconfiguation"
    subnet_id                     = azurerm_subnet.twsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.twpip.id
  }
}

#Connect a network interface to a nsg
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.twnic.id
  network_security_group_id = azurerm_network_security_group.twnsg.id
}


resource "azurerm_windows_virtual_machine" "twvm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.twrg.name
  location            = azurerm_resource_group.twrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.twnic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
