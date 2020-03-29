require 'daru'

class Check < Thor
    desc "is_file File", "Checks if the file exists"
    method_option :read, :aliases => "-r", :desc => "Reads the file if found"
    def isFile(file)
        # puts(file.split(".")[1]=="csv")
        read_file = options[:read]
        if File.file?(file)
            puts "File #{file} does exist"
        else
            puts "File #{file} does NOT exist"
        end
        if read_file and file.split(".")[1] == "csv"
            puts("...and it's a CSV file:")
            df = Daru::DataFrame.from_csv file
            df.each_row do |line|
                puts(line.to_h)
            end
        elsif read_file
            puts("...and it reads:")
            text = File.open(file).read
            text.each_line do |line|
                puts(line)
            end
        end
    end
end