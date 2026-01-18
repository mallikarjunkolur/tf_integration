resource "azurerm_resource_group" "rg" {
name = var.resource_group_name
location = var.resource_group_location
}

resource "azurerm_virtual_network" "vnet" {
name = var.vnet_name
resource_group_name = azurerm_resource_group.rg.name
location = azurerm_resource_group.rg.location
address_space = var.address_space
}

resource "azurerm_subnet" "subnet" {
count = length(var.subnet)
name = var.subnet[count.index].name
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = var.subnet[count.index].address
}

resource "azurerm_network_security_group" "nsg" {
  name                = "az-tf-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "az-tf-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku 		      = "Standard"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "nic" {
name = var.nic
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name

 ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[0].id
    private_ip_address_allocation = "Dynamic"
	public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_ssh_public_key" "sshk" {
  name                = "sshk"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  public_key          = file("sshkey.pub")
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "az-tf-linux"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
tags = {
    env = "dev"
  }

  lifecycle {
    ignore_changes = [tags]
  }
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("sshkey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
