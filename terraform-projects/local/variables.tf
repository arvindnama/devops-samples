variable "filename" {
  default = [
    "/Users/arvindnama/pet1.txt",
    "/Users/arvindnama/pet2.txt",
    "/Users/arvindnama/pet3.txt"
  ]
  type = set(string)
}


variable "prefixes" {
  type    = list(string)
  default = ["abc", "def"]
}

variable "file-content" {
  type = map(string)
  default = {
    "statement1" = "value 1"
    "statement2" = "value 2"
  }
}

variable "content" {
  default = "We love pets blah blah blah"
  type    = string
}

variable "prefix" {
  default = "Mrs"
  type    = string
}

variable "separator" {
  default = "."
  type    = string
}

variable "length" {
  default = "2"
  type    = number
}

variable "bella" {
  type = object({
    name    = string
    color   = string
    age     = number
    food    = list(string)
    fav_pet = bool
  })
  default = {
    name    = "bella"
    color   = "brown"
    age     = 7
    food    = ["f", "a"]
    fav_pet = true
  }
}


variable "kitty" {
  type    = tuple([string, number, bool])
  default = ["bat", 7, true]
}

