resource "azurerm_databricks_workspace" "databricksWokspace" {
  name                = "${var.suffix}${var.workspaceName}"
  resource_group_name = azurerm_resource_group.genericRG.name
  location            = azurerm_resource_group.genericRG.location
  sku                 = "trial"

  custom_parameters {
    virtual_network_id  = azurerm_virtual_network.genericVNet.id
    private_subnet_name = azurerm_subnet.dbSubnets["privateDB"].name
    public_subnet_name  = azurerm_subnet.dbSubnets["publicDB"].name
    no_public_ip        = false

    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.dataBricksNSGAssociation["privateDB"].id
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.dataBricksNSGAssociation["publicDB"].id
  }

  tags = var.tags
}

provider "databricks" {
  host                        = azurerm_databricks_workspace.databricksWokspace.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.databricksWokspace.id
}

data "databricks_node_type" "smallest" {
  local_disk = true
  category   = "General Purpose"

  depends_on = [azurerm_databricks_workspace.databricksWokspace]
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true

  depends_on = [azurerm_databricks_workspace.databricksWokspace]
}

# Create Databricks Cluster
resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "Shared Autoscaling"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 25
  autoscale {
    min_workers = 1
    max_workers = 2
  }
}

# Create initial Databricks notebook
resource "databricks_notebook" "ddl" {
  source = "../notebooks/tfms.py"
  path   = "/Shared/TFMS"
}

resource "databricks_notebook" "stdds" {
  source = "../notebooks/stdds.py"
  path   = "/Shared/STDDS"
}

resource "databricks_notebook" "tbfm" {
  source = "../notebooks/tbfm.py"
  path   = "/Shared/TBFM"
}
