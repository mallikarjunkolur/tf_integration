variable "resource_group_name" {
type = string
default = "az-tf-rg"
}

variable "resource_group_location" {
type =string
default ="west us"
}

variable "vnet_name" {
type = string
default = "az-tf-vnet"
}

variable "address_space" {
type = list(string)
default = ["10.0.0.0/16"]
}

variable "subnet" {
type = list(object({
		name = string
		address = list(string)
	}))
default = [
	  {
		name = "subnet1"
		address = ["10.0.1.0/24"]
	  },
	  {
                name = "subnet2"
                address = ["10.0.2.0/24"]
          }
]
}

variable "nic" {
type = string
default = "az-tf-nic"
}


