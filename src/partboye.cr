require "phreak"
require "yaml"
shard = YAML.parse(File.read("./shard.yml"))

module Partboye
  Phreak.parse! do |partboye|
    partboye.banner = "A psuedo partition manager."

    partboye.bind(short_flag: 'v', long_flag: "version",
      description: "Shows the version of Partboye.") do
      puts shard["version"]
    end
  end
end
