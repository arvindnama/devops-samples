
resource "local_file" "pet" {
  filename        = each.value
  for_each        = var.filename
  content         = "My fav pet is ${random_pet.my-pet.id}"
  file_permission = "0777"
  lifecycle {
    create_before_destroy = true
  }
}

resource "local_file" "animals" {
  filename = "/Users/arvindnama/animals.txt"
  content  = data.local_file.dog.content
}

data "local_file" "dog" {
  filename = "/Users/arvindnama/dog.txt"
}

resource "random_pet" "my-pet" {
  prefix    = var.prefix
  separator = var.separator
  length    = var.length
}

output "pet-name" {
  value = random_pet.my-pet.id
}

output "pets" {
  value     = local_file.pet
  sensitive = true
}
