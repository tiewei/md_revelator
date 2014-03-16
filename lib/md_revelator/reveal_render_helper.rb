module Md::Revelator

  module RevealRenderHelper

    def render_html(sections)
      """<!doctype html>
<html lang=\"en\">
#{render_head}
#{render_body(sections)}
</html>"""
    end

    private

    def render_body(sections)
      """
  <body>
    <div class=\"reveal\">
      <div class=\"slides\">
    #{sections}
      </div>\n    </div>
    #{render_js}
  </body>"""
    end

    def render_js
      """<script src=\"lib/js/head.min.js\"></script>
    <script src=\"js/reveal.min.js\"></script>
    <script>
        Reveal.initialize({
        controls: true,
        progress: true,
        center: true,
        theme: '#{metadata[:theme]}', 
        transition: '#{metadata[:transition]}',
        transitionSpeed: '#{metadata[:transitionSpeed]}',
        autoSlide: #{metadata[:autoSlide]},
        backgroundTransition: '#{metadata[:backgroundTransition]}',
        dependencies: [
          { src: 'lib/js/classList.js', condition: function() { return !document.body.classList; } },
          { src: 'plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
          { src: 'plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
          { src: 'plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
          { src: 'plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
          { src: 'plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } }
        ]
      });
    </script>"""
    end

    def render_head
      """  <head>
    <meta charset=\"utf-8\">
    <title>#{metadata[:title]}</title>
    <meta name=\"description\" content=\"#{metadata[:description]}\">
    <meta name=\"author\" content=\"#{metadata[:author]}\">

    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />
    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black-translucent\" />

    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\">

    <link rel=\"stylesheet\" href=\"css/reveal.min.css\">
    <link rel=\"stylesheet\" href=\"css/theme/#{metadata[:theme]}.css\" id=\"theme\">

    <!-- For syntax highlighting -->
    <link rel=\"stylesheet\" href=\"lib/css/zenburn.css\">

    <!--[if lt IE 9]>
    <script src=\"lib/js/html5shiv.js\"></script>
    <![endif]-->
  </head>"""

    end

  end



end