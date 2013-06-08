class Both_users_cmds

  def change(input)
    if input.include? " "
      input.gsub!(/ /, "_")
    end
    if input.include? "."
      input.gsub!(/./, "_")
    end
    return input
  end

  def courses_list
    i = 1
    if File.zero?("courses.txt")
      system("clear")
      puts "> There is no courses yet."
      puts "> Enter anything to continue: "
      trash = gets
    else
      system("clear")
      puts "> Courses' list:"
      File.open("courses.txt") do |txt|
        txt.each_line do |line|
          puts "> #{i} - #{line}"
          i += 1
        end
      end
    end
    puts "> Enter anything to continue: "
    trash = gets
  end

  def subjects_list(course)
    course_name = course.name
    input = course_name.downcase
    input = change(input)
    if !File.exist?("#{input}.txt")
      system("clear")
      puts "> This Course doesn't exists."
      puts "> Enter anything to continue: "
      trash = gets
    else
      i = 0;
      File.open("#{input}.txt") do |txt|
        txt.each_line do |line|
          i += 1
        end
      end
      if (i == 1)
        system("clear")
        puts "> There is no subjects in '#{course_name.capitalize}' yet."
        puts "> Enter anything to continue: "
        trash = gets
      else
        j = 1
        File.open("#{input}.txt") do |txt|
          txt.each_line do |line|
            if (j == 1)
              puts "> Course: #{line}"
            else
              puts "> Subject #{j-1}: #{line}"
            end
            j += 1
            end
            puts "> Enter anything to continue: "
            trash = gets
          end
        end
      end
    end

end
