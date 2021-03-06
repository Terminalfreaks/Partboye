require "phreak"
require "yaml"
shard = YAML.parse(File.read("./shard.yml"))
table = YAML.parse(File.read("./src/table.yml"))

running = false

module Partboye
  Phreak.parse! do |partboye|
    partboye.banner = "A psuedo partition manager."

    partboye.bind(short_flag: 'v', long_flag: "version",
      description: "Shows the version of Partboye.") do
      puts "Partboye v#{shard["version"]}"
    end

    partboye.bind(word: "help", short_flag: 'h', long_flag: "help",
      description: "Shows commands for Partboye.") do
      puts partboye
    end

    partboye.default do
      puts "You here to see the Partboye? Welcome. (Partboye v#{shard["version"]})"
      puts "This isn't a real functional partition manager. You aren't really modifying anything."
      puts "But it's slightly fun right? The help command might have what you need.\n"

      running = true
    end
  end

  pb = Phreak.create_parser do |partboye|
    partboye.bind(word: "list") do
      partition_table = table["partitiontable"].as_h
      partition_list = [] of String
      partition_table.each do |k, v|
        partition_list.push("Partition #{k} - #{v}")
      end
      puts partition_list.join("\n")
    end

    partboye.bind(word: "exit") do
      puts "Goodbye..."
      puts " "
      exit
    end

    partboye.unrecognized_args do |a|
      puts "#{a} is a unknown command. Check the help command."
    end
  end
end

while running
  printf "> "
  line = gets || ""

  pb.parse(line.split(" "))
end
