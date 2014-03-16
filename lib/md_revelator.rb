require "md_revelator/version"
require "md_revelator/default"

module Md

  module Revelator

    class << self
      def reveal!(input_file, output_dir, version=1)
        case version
        when 1
          #do simple replace
          require "md_revelator/simple_revelator"
          SimpleRevelator.do_reveal(input_file, output_dir)
        when 2
          require "md_revelator/redcarpet_revelator"
          Redcarpet_Revelator.do_reveal(input_file, output_dir)
        end
      end
    end
  end
end