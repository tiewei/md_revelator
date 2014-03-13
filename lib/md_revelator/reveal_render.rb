require "redcarpet"

module Redcarpet::Render
  class RevealRender < Base

      def hrule
        "</section>\n<section>\n"
      end

      def doc_footer
        "</section>\n"
      end

      def doc_header
        "<section>\n"
      end
  
      # def preprocess(full_document)
      #   #get config
      #   #add head
      # end

      # def postprocess(full_document)
      #   #add foot
      # end

      def entity(text)
        # binding.pry
        text
      end

      def normal_text(text)
        # binding.pry
        text
      end

  end
end