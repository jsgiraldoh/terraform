# Create a new SSH key
resource "digitalocean_ssh_key" "default-4" {
  name       = "default-4"
  public_key = file("ssh/default-4.pub")
}

# Create a linux-1
resource "digitalocean_droplet" "linux-1" {
  # ...
  image  = "centos-7-x64"
  name   = "linux-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default-4.fingerprint}"]
  user_data = file("user_data_app.sh")
}