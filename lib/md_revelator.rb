require "md_revelator/version"
require "md_revelator/default"

module Md

  module Revelator

    class << self
      def reveal!(input_file, output_dir, version)
        input, output, version = validate!(input_file, output_dir, version)
        case version.to_i
        when 1
          #do simple replace
          require "md_revelator/simple_revelator"
          SimpleRevelator.do_reveal(input, output)
        when 2
          require "md_revelator/redcarpet_revelator"
          Redcarpet_Revelator.do_reveal(input, output)
        end
      end

      def validate!(input_file, output_dir, version)
        input = File.expand_path input_file
        if File.readable?(input)
          puts "INPUT - #{input}"
        else
          puts "#{input} is not readable"
          exit 1
        end

        output = File.expand_path output_dir

        if File.directory?(output) && File.writable?(output)
          puts "OUTPUT - #{output}"
        else
          puts "#{output} is not a writable folder"
          exit 1
        end

        if %w(1 2).include? version
          puts "VERSION - #{version}"
        else
          puts "version must be in 1 or 2"
          puts "version 1 : using 3 or more '='/'+' to separate slides, \ 
                support vertical slides by using different separations"
          puts "version 2 : using markdown <hr/> to separate slides, \ 
                support fragment with ${style} at the start of <p> <li> <h>"
          exit 1
        end

        return input, output, version
      end
    end
  end
end