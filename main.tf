resource "azurerm_resource_group" "RS1" {
  name      = "Secondresource"
  location  = "East US"
}

# Create virtual network
resource "azurerm_virtual_network" "Vnet2" {
  name                = "Secondvnet2"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RS1.location
  resource_group_name = azurerm_resource_group.RS1.name
}

# Create subnet
resource "azurerm_subnet" "Subnet2" {
  name                 = "secondsubnet"
  resource_group_name  = azurerm_resource_group.RS1.name
  virtual_network_name = azurerm_virtual_network.Vnet2.name
  address_prefixes     = ["10.0.1.0/24"]
}


# Create network interface
resource "azurerm_network_interface" "Network2" {
  name                = "Secondnetwork"
  location            = azurerm_resource_group.RS1.location
  resource_group_name = azurerm_resource_group.RS1.name

  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = azurerm_subnet.Subnet2.id
    private_ip_address_allocation = "Dynamic"

  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "main" {
  name                  = "myVM3"
  location              = azurerm_resource_group.RS1.location
  resource_group_name   = azurerm_resource_group.RS1.name
  network_interface_ids = [azurerm_network_interface.Network2.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "hostname"
  admin_username                  = "Govardhan@235"
  admin_password                  = "Govardhan@235"


  disable_password_authentication = false

tags = {
  enviroment = "staging"
}
}
