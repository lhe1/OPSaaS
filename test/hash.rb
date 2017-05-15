#!/usr/bin/ruby

lei = {
  "id" => "5112",
  "group" => "devops",
  "info" => {
    "name" => "Lei He",
    "age" => 30
  }
}

puts lei['id']
puts lei['group']
puts lei['info'].inspect
puts lei['info']['name']
