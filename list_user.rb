# Arquivo incompleto; sistema de login não está funcionando direito ainda.

class List_user < Hash

  def sign_in(user)
    x = 0
    File.open("student.txt") do |word|
      word.each_line do |line|
        line.split(".")
          if(self[user.login] == line[0]) && (self[user.pw] == line[1])
            puts "> Logged as #{user.login}"
          else
            x = 1
          end
      end
    end
    if x == 1
      puts "> Invalid user"
    end
  end


  def sign_up(user)
    self[user.login] = user
    puts "> User #user.login created."
  end
end
