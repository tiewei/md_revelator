require "md_revelator/reveal_render"

module Md::Revelator

  class Redcarpet_Revelator
    def self.do_reveal(input_file, output_dir)
      input = File.read(input_file)
      extends = {:no_intra_emphasis => true, :fenced_code_blocks=>true}
      render = Md::Revelator::RevealRender.new
      output = Redcarpet::Markdown.new(render, extends).render(input)
      if render.metadata[:ref] == 'local'
        reveal_js = "#{File.dirname(__FILE__)}/../../reveal.js-2.6.1/*"
        FileUtils.cp_r(Dir.glob(reveal_js) , output_dir)
      end
      output_name = File.basename(input_file, File.extname(input_file))
      File.open("#{output_dir}/#{output_name}.html", "w"){|f| f.write output}
      return "#{output_dir}/#{output_name}.html"
    end
  end
end