# Create a new SSH key
resource "digitalocean_ssh_key" "default-6" {
  name       = "default-6"
  public_key = file("ssh/default-6.pub")
}

# Create a docker
resource "digitalocean_droplet" "docker" {
  # ...
  image  = "centos-7-x64"
  name   = "docker"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default-6.fingerprint}"]
  user_data = file("user_data_app.sh")
}