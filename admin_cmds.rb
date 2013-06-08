require 'fileutils'
require 'tempfile'

class Admin_cmds

  def change(input)
    if input.include? " "
      input.gsub!(/ /, "_")
    end
    if input.include? "."
      input.gsub!(/./, "_")
    end
    return input
  end

  def create_course(course)
    course_name = course.name
    input = course_name.downcase
    input = change(input)
    if !File.exist?("#{input}.txt")
      File.new("#{input}.txt", "w")
      target = File.open("#{input}.txt", "a")
      target.write(course_name.capitalize)
      target.write("\n")
      target.close
      target = File.open("courses.txt", "a")
      target.write(course_name.capitalize)
      target.write("\n")
      target.close
      puts "> Course '#{course_name.capitalize}' has been created."
    else
      puts "> This course already exists."
    end
    puts "> Enter anything to continue: "
    trash = gets
  end

  def delete_course(course)
    course_name = course.name
    input = course_name.downcase
    input = change(input)
    if !File.exist?("#{input}.txt")
      puts "> This Course doesn't exists."
    else
      File.delete("#{input}.txt")
      tmp = Tempfile.new("extract")
      open("courses.txt", "r").each do |l|
        tmp << l unless l.chomp == "#{course_name.capitalize}"
      end
      tmp.close
      FileUtils.mv(tmp.path, 'courses.txt')
      puts "> Course '#{course_name.capitalize}' has been deleted."
    end
    puts "> Enter anything to continue: "
    trash = gets
  end

  def add_subject(subject)
    course_name = subject.course
    input = course_name.downcase
    input = change(input)
    if !File.exist?("#{input}.txt")
      puts "> This course doesn't exists."
    else
      subject = subject.name
      counter = 0
      File.open("#{input}.txt") do |txt|
        txt.each_line do |line|
          if (subject.capitalize == line.chomp)
            counter += 1
          end
        end
      end
      if !(counter == 0)
        puts "> This subject already exists in the #{course_name.capitalize}."
      else
        target = File.open("#{input}.txt", "a")
        target.write(subject.capitalize)
        target.write("\n")
        target.close
        puts "> The subject '#{subject.capitalize}' has been added to the course '#{course_name.capitalize}'."
      end
    end
    puts "> Enter anything to continue: "
    trash = gets
  end

  def delete_subject(subject)
    course_name = subject.course
    input = course_name.downcase
    input = change(input)
    if !File.exist?("#{input}.txt")
      puts "> This course doesn't exists."
    else
      subject = subject.name
      tmp = Tempfile.new("extract")
      open("#{input}.txt", "r").each do |l|
        tmp << l unless l.chomp == "#{subject.capitalize}"
      end
      tmp.close
      FileUtils.mv(tmp.path, "#{input}.txt")
      puts "> Subject '#{subject.capitalize}' has been deleted from '#{course_name.capitalize}'."
    end
    puts "> Enter anything to continue: "
    trash = gets
  end

end
