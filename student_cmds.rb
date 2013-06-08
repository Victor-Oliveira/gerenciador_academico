require 'fileutils'
require 'tempfile'

class Student_cmds

  def change(input)
    if input.include? " "
      input.gsub!(/ /, "_")
    end
    if input.include? "."
      input.gsub!(/./, "_")
    end
    return input
  end

  def join_course(course)
    course_name = course.name
    input = course_name.downcase
    input = change(input)
    print "> Enter your registry number: "
    registry = gets.chomp
    if !File.exist?("#{input}.txt")
      system("clear")
      puts "> This Course doesn't exists."
      puts "> Enter anything to continue: "
      trash = gets
    else
      if !File.exist?("#{registry}.txt")
        system("clear")
        puts "> This registry doesn't exist."
        puts "> Enter anything to continue: "
        trash = gets
      else
        counter = 0
        File.open("#{registry}.txt") do |txt|
          txt.each_line do |line|
            if (course_name.capitalize == line.chomp)
              counter += 1
            end
          end
        end
        if !(counter == 0)
          system("clear")
          puts "> You've joined this course already."
          puts "> Enter anything to continue: "
          trash = gets
        else
          target = File.open("#{registry}.txt", "a")
          target.write(course_name.capitalize)
          target.write("\n")
          target.close
          system("clear")
          puts "> You joined the '#{course_name.capitalize}' course."
          puts "> Enter anything to continue: "
          trash = gets
        end
      end
    end
  end

  def leave_course(course)
    course_name = course.name
    print "> Enter your registry number: "
    registry = gets.chomp
    if !File.exist?("#{registry}.txt")
      system("clear")
      puts "> This registry doesn't exist."
      puts "> Enter anything to continue: "
      trash = gets
    else
      counter = 0
      File.open("#{registry}.txt") do |txt|
        txt.each_line do |line|
          if (course_name.capitalize == line.chomp)
            counter += 1
          end
        end
      end
      if (counter == 0)
        system("clear")
        puts "You didn't joined this course."
        puts "> Enter anything to continue: "
        trash = gets
      else
      tmp = Tempfile.new("extract")
      open("#{registry}.txt", "r").each do |l|
        tmp << l unless l.chomp == "#{course_name.capitalize}"
      end
        tmp.close
        FileUtils.mv(tmp.path, "#{registry}.txt")
        system("clear")
        puts "> You've left the '#{course_name.capitalize}' course."
      end
      puts "> Enter anything to continue: "
      trash = gets
    end
  end
    
end
