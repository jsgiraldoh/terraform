# Create a new SSH key
resource "digitalocean_ssh_key" "default-5" {
  name       = "default-5"
  public_key = file("ssh/default-5.pub")
}

# Create a haproxy
resource "digitalocean_droplet" "haproxy" {
  # ...
  image  = "centos-7-x64"
  name   = "haproxy"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default-5.fingerprint}"]
  user_data = file("user_data_app.sh")
}