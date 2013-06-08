require_relative 'list_user.rb'
require_relative 'user.rb'
require_relative 'menu.rb'
require_relative 'course.rb'
require_relative 'subject.rb'
require_relative 'admin_cmds.rb'
require_relative 'student_cmds.rb'
require_relative 'both_users_cmds.rb'

class Main

  def initialize
    @user_list = List_user.new
    @user_admin = nil
    @user_student = nil
    @course = nil
    @subject = nil
    @admin = Admin_cmds.new
    @student = Student_cmds.new
    @both = Both_users_cmds.new

    @methods =
      ["exit",
       "login",
       "register_student"]
  end

  def create_admin
    if !File.exist?("admin.txt")
      File.new("admin.txt", "w")
      puts "> Since it's your first time using Academic Manager, you will need to create an admin to your system."
      print "> Enter your name: "
      name = gets
      print "> Enter your login: "
      login = gets
      print "> Enter your password: "
      pw = gets
      target = File.open("admin.txt", "a")
      target.write(name)
      target.write(login)
      target.write(pw)
      target.close
    if !File.exist?("courses.txt")
      File.new("courses.txt", "w")
    end
  end

  def register_student
    if !File.exist?("student.txt")
      File.new("student.txt", "w")
    end
    print "> Enter your name: "
    name = gets
    print "> Enter your password: "
    pw = gets
    i = 0
    registry = Random.new
    registry = registry.rand(1...101)
    puts "> #{name.capitalize.chomp}, your registry number is: #{registry}."
    target = File.open("student.txt", "a")
    target.write(registry)
    target.write("\n")
    target.close
    File.new("#{registry}.txt", "w")
    target = File.open("#{registry}.txt", "a")
    target.write(registry)
    target.write("\n")
    target.write(name)
    target.write(pw)
    target.close
  end

  def login
      system("clear")
      puts "> Choose one login option bellow:"
      puts "> 1 - Login as Admin"
      puts "> 2 - Login as Student"
      print "  "
      option = gets.chomp
      option.downcase!
      case option
      when "1"
        system("clear")
        print "> Enter your login: "
        login = gets
        print "> Enter your password: "
        password = gets
        @user_admin = @user_list.adm_sign_in(User.new({login: login, password: password}))
        if (@user_admin == login)
          while option != 0
            system("clear")
            admin_menu
            option = gets.to_i
            case option
              when 1
                print "> Enter the course's name that you wanna create: "
                course_name = gets.chomp
                @course = @admin.create_course(Course.new({name: course_name}))
              when 2
                print "> Enter the course's name that you wanna delete: "
                course_name = gets.chomp
                @course = @admin.delete_course(Course.new({name: course_name}))
              when 3
                print "> Enter the course that you wanna add a subject: "
                course_name = gets.chomp
                print "> Enter the subject's name that you want to add: "
                subject = gets.chomp
                @subject = @admin.add_subject(Subject.new({course: course_name, name: subject}))
              when 4
                print "> Enter the course that you wanna delete a subject: "
                course_name = gets.chomp
                print "> Enter the subject's name that you want to delete: "
                subject = gets.chomp
                @subject = @admin.delete_subject(Subject.new({course: course_name, name: subject}))
              when 5
                @both.courses_list
              when 6
                print "> Enter the course that you wanna know the subjects: "
                course_name = gets.chomp
                @course = @both.subjects_list(Course.new({name: course_name}))
            end
          end
        end
      when "2"
        system("clear")
        print "> Enter your registry number: "
        registry = gets
        print "> Enter your password: "
        password = gets
        @user_student = @user_list.std_sign_in(User.new({registry: registry, password: password}))
        if (@user_student == registry)
        while option != 0
          system("clear")
          student_menu
          option = gets.to_i
          case option
           when 1
             print "> Enter the course's name that you wanna join: "
             course_name = gets.chomp
             @course = @student.join_course(Course.new({name: course_name}))
           when 2
             print "> Enter the course's name that you wanna leave: "
             course_name = gets.chomp
             @course = @student.leave_course(Course.new({name: course_name}))
           when 3
             @both.courses_list
           when 4
             print "> Enter the course that you wanna know the subjects: "
             course_name = gets.chomp
             @course = @both.subjects_list(Course.new({name: course_name}))             
           end
        end
   end
      else
        system("clear")
        puts "> Invalid option."
        puts "> Enter anything to continue: "
        trash = gets
      end
    system("clear")
    end
  end

  def main
    system("clear")
    create_admin
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
