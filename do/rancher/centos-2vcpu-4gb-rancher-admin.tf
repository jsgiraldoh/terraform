# Create a new SSH key
resource "digitalocean_ssh_key" "default-1" {
  name       = "default-1"
  public_key = file("ssh/default-1.pub")
}

# Create a centos-2vcpu-4gb-rancher-admin
resource "digitalocean_droplet" "centos-2vcpu-4gb-rancher-admin-2" {
  # ...
  image  = "centos-7-x64"
  name   = "centos-2vcpu-4gb-rancher-admin-2"
  region = "nyc1"
  size   = "s-2vcpu-4gb"
  ssh_keys = ["${digitalocean_ssh_key.default-1.fingerprint}"]
  user_data = file("user_data_app.sh")
}