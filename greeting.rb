def greeting
  ARGV.each do |arg|
    puts "Hello, #{arg}!"
  end
  puts "Thanks for trying the Greeting Program!"
end

greeting
