require "erb"
require "fileutils"

module Md::Revelator
  class SimpleRevelator

      class << self
        def do_reveal(input_file, output_dir)
          simple_revelator = SimpleRevelator.new
          simple_revelator.load input_file
          simple_revelator.render output_dir
        end
      end

      SECTION_REGEX = /^(\+{3,}|={3,})$/

      def initialize
        @metadata = Md::Revelator.default
        @sections = []
      end


      def load(input_file)

        File.open(input_file, 'r') do |file|
          load_metadata file
          load_sections file
        end
      end

      def render(output_dir)
        template = "#{File.dirname(__FILE__)}/reveal_index.erb"
        index = ERB.new(File.read(template))
        output = index.result(binding)
        if @metadata[:ref] == 'local'
          reveal_js = "#{File.dirname(__FILE__)}/../../reveal.js-2.6.1/*"
          FileUtils.cp_r(Dir.glob(reveal_js) , output_dir)
        end
        File.open("#{output_dir}/index.html", 'w') {|file| file.write(output)}
      end


      private 


      def load_metadata(file)
        #find the metadatas
          pre2 = pre1 = nil
          line = file.gets
          until section_end?(pre2, pre1, line)
            k, v = line.strip.split(":", 2).map{|one| one.strip}

            #load metadata
            if k && v && @metadata.include?(k.to_sym) && \
              (Md::Revelator.no_enum_configs.include?(k.to_sym) \
                or Md::Revelator.send("#{k}s".to_sym).include?(v))

              @metadata.merge!({ k.to_sym => v})
            end

            pre2, pre1, line = pre1, line, file.gets
          end
      end

      def load_sections(file)
        last_mark = nil
        is_start = true
        #load sections
        until last_mark.nil? && !is_start
          is_start = false
          data = read_until(file){|pre2, pre1, line| section_end?(pre2, pre1, line)}
          if data[-1].nil?
            markdown = data[0...-1].join.strip
            mark = nil
          else
            markdown = data[0...-2].join.strip
            mark = data[-2][0]
          end
          
          if last_mark == mark or mark.nil?

            if @sections.last.is_a? Array
              @sections.last << markdown 
            else
              @sections << markdown 
            end
            
          else
            if @sections.empty? or @sections.last.is_a? Array
              @sections << markdown
            else
              @sections << [markdown]
            end
          end
          last_mark = mark
        end
      end

      def section_end?(pre2, pre1, line)
         line.nil? or (line.strip.empty? && !pre2.nil? && pre2.strip.empty? && pre1.strip =~ SECTION_REGEX)
      end

      def read_until(file, &blk)

        data = []
        line = file.gets
        until yield data[-2], data[-1], line
          data << line
          line = file.gets
        end
        data << line
        data
      end

  end
end