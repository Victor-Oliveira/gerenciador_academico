require_relative 'user.rb'

class List_user

  def adm_sign_in(user)
    i = 1
    login = " ", password = " ", name = " "
    File.open("admin.txt") do |txt|
      txt.each_line do |line|
        if (i == 1)
          name = line
        elsif (i == 2)
          login = line
        else
          password = line
        end
        i += 1
        end
    end
    if(user.login == login) and (user.password == password)
      system("clear")
      puts "> Hi #{name.chomp}, welcome."
      puts "> Enter anything to continue: "
      trash = gets
      return user.login
    else
      system("clear")
      puts "> Invalid login or password."
      puts "> Enter anything to continue: "
      trash = gets
    end
  end

  def std_sign_in(user)
    i = 1
    registry = " ", login = " ", password = " ", name = " "
    puts "#{user.registry}"
    if !File.exist?("#{user.registry.chomp}.txt")
      puts "> Invalid user."
    else
      File.open("#{user.registry.chomp}.txt") do |txt|
        txt.each_line do |line|
          if (i == 1)
            registry = line
          elsif (i == 2)
            name = line
          elsif (i == 3)
            password = line
          end
          i += 1
          end
      end
      if (user.registry == registry) and (user.password == password)
        system("clear")
        puts "> Hi #{name.chomp}, welcome."
        puts "> Enter anything to continue: "
        trash = gets
        return user.registry
      else
        system("clear")
        puts "> Invalid registry or password."
        puts "> Enter anything to continue: "
        trash = gets
      end
    end
  end

end
