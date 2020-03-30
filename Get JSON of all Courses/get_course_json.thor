require 'daru'

class Getjson < Thor
    desc "sortuniqid File", "Checks if the file exists then sorts it by 'course_id'"
    # method_option :read, :aliases => "-r", :desc => "Reads the file if found"
    def sortuniqid(file)
        # read_file = options[:read]
        if File.file?(file)
            puts "File #{file} does exist"
        else
            puts "File #{file} does NOT exist"
        end
        if file.split(".")[1] == "csv"
            puts("...and it's a CSV file:")
            df = Daru::DataFrame.from_csv(file, headers:true)
            df = df.uniq([:course_id])
            df = df.sort([:course_id], ascending:true)
            df.each_row do |line|
                puts(line.to_h)
            end
        else
            puts "File #{file} isn't a CSV"
        end
    end
end