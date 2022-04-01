# Create a new SSH key
resource "digitalocean_ssh_key" "default-3" {
  name       = "default-3"
  public_key = file("ssh/default-3.pub")
}

# Create a centos-1vcpu-1gb-rancher-worker
resource "digitalocean_droplet" "centos-1vcpu-1gb-rancher-worker" {
  # ...
  image  = "centos-7-x64"
  name   = "centos-1vcpu-1gb-rancher-worker-2"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default-3.fingerprint}"]
  user_data = file("user_data_app.sh")
}