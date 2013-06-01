# Programa ainda incompleto. Ainda é necessário fazer funções para criação e gerenciamento de cursos/turmas, e consertar o sistema de login e criação de usuário.

require_relative 'list_user.rb'
require_relative 'user.rb'
#require_relative 'archives.rb'


class Main

  def initialize
    @user_list = List_user.new
    @current_user = nil

    @methods = [
      "exit",
      "login",
      "create_student",]
  end

  def archives_exists
    if !File.exist?("admin.txt")
      File.new("admin.txt", "w")
      puts "> Since it's your first time using Academic Manager, you will need to create an admin to your system."
      create_admin
    end
    if !File.exist?("course.txt")
      File.new("course.txt", "w")
    end
    if !File.exist?("subject.txt")
      File.new("subject.txt", "w")
    end
    if !File.exist?("professor.txt")
      File.new("professor.txt", "w")
    end
    if !File.exist?("student.txt")
      File.new("student.txt", "w")
    end
  end

  def login
    print "Enter your login: "
    login = gets
    print "Enter your password: "
    pw = gets
    @current_user = @user_list.sign_in(User.new({login: login, pw: pw}))
  end

  def create_student
    print "> Enter your name: "
    name = gets
    print "> Enter your graduation: "
    graduation = gets
    print "> Enter your academic registry: "
    registry = gets
    print "> Now enter your account's login: "
    login = gets.chomp
    print "> And your password: "
    pw = gets.chomp
    target = File.open("student.txt", "a")
    target.write(name)
    target.write(graduation)
    target.write(registry)
    target.write(login)
    target.write(".")
    target.write(pw)
    print "> Your account has been created, #{name}"
  end

  def create_admin
    print "> Enter your name: "
    name = gets
    print "> Enter your login: "
    login = gets.chomp
    print "> Enter your password: "
    pw = gets.chomp
    target = File.open("admin.txt", "a")
    target.write(name)
    target.write(login)
    target.write(".")
    target.write(pw)
    print "> Your admin account has been created, #{name}"
  end

  def menu
    puts "> Select and option:"
    puts "> 1 - Login"
    puts "> 2 - Create an user"
    puts "> 0 - Exit"
  end

  def main
    archives_exists
    puts "> Academic Manager"
    menu
    option = gets.to_i
    loop{
      self.send(@methods[option])
      menu
      option = gets.to_i}
  end

end

system = Main.new
system.main
