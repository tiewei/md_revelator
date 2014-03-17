require "redcarpet"
require "yaml"
require "md_revelator/reveal_render_helper"

module Md::Revelator

  class RevealRender < Redcarpet::Render::HTML

    include Md::Revelator::RevealRenderHelper

    def self.fragments_regex
      Md::Revelator.fragment_styles.join('|').gsub("-","\\-")
    end

    METADATA_PATTEN = /\A(---\s*\n.*?\n?)^(---\s*$\n?)/m
    FRAGMENT = /^\$(#{fragments_regex})\s/
    ESCAPES_FRAGMENT = '\$'
    FRAGMENT_TAG_START = /(<(p|li|h[1-6]))>/i


    attr_reader :metadata

    def initialize
      super
      @metadata = Md::Revelator.default
    end

    def paragraph(text)
      style, data = parse_fragment_tag(text)
      return data.empty? ? "" : "<p#{fragment_class(style)}>#{data}</p>"
    end

    def list_item(text, list_type)
      style, data = parse_fragment_tag(text)
      return data.empty? ? "" : "<li#{fragment_class(style)}>#{data}</li>"
    end

    def header(text, header_level, anchor)
      style, data = parse_fragment_tag(text)
      return data.empty? ? "" : \
        "<h#{header_level}#{fragment_class(style)}>#{data}</h#{header_level}>\n"
    end

    def doc_header
      "<section>\n"
    end

    def doc_footer
      "</section>\n"
    end

    def hrule
      "</section>\n<section>\n"
    end

    def block_code(code, language)
      return code.empty? ? "" : \
        "<pre><code data-trim contenteditable>\n#{code}\n</code></pre>"
    end

    def block_quote(quote)
      return quote.empty? ? "" : \
      "<blockquote>\n#{quote}</blockquote>\n"
    end

    def preprocess(full_document)
      if full_document =~ METADATA_PATTEN
        content = $'
        raw_meta = YAML.load($1)
        load_metadata(raw_meta)
        return content
      else
        return full_document
      end
    end

    def postprocess(full_document)
      if @metadata[:ref] == 'local'
            @metadata[:cdn] = '' 
      else
        @metadata[:cdn] << '/' unless @metadata[:cdn].end_with? "/"
      end
      render_html(full_document)
    end

    private

    def load_metadata(raw_meta)
        if !raw_meta.nil?  && raw_meta.is_a?(Hash)
          raw_meta.each_pair do |k,v|
            if @metadata[k.to_sym] && (Md::Revelator.no_enum_configs.include?(k.to_sym) \
              or Md::Revelator.send("#{k}s".to_sym).include?(v))
              @metadata[k.to_sym] = v
            end
          end
        end
    end

    def parse_fragment_tag(raw_text)
      text = raw_text.strip
      if text =~ FRAGMENT
        text = $'
        style = $1
        return style, text
      else
        text = text[1..-1] if text.start_with? ESCAPES_FRAGMENT
        return nil, text
      end
    end

    def fragment_class(style)
      style ? " class=\"fragment #{style}\"" : ""
    end

  end
end
