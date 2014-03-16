module Md::Revelator

  class << self

    def default
      {
        :theme => "default",
        :transition => "default",
        :autoSlide => 0,
        :transitionSpeed => 'default',
        :backgroundTransition => 'default',
        :ref => 'local',
        :title => 'Presentations generated from markdown by md-revelator',
        :author =>  ENV["USER"],
        :description => ''
      }.clone
    end

    def no_enum_configs
      [:title, :author, :description]
    end

    def themes
      %w(beige sky simple serif night default blood moon solarized).freeze
    end

    def transitions
      %w(default cube page concave zoom linear fade none).freeze
    end 

    def transitionSpeeds
      %w(default fast slow).freeze
    end

    def backgroundTransitions
      %w(default none slide concave convex zoom).freeze
    end

    def refs
      %w(local).freeze
    end

    def fragment_styles
      [ "", "grow", "shrink", "roll-in", "fade-out", "current-visible",
        "highlight-red", "highlight-blue", "highlight-green", 
        "highlight-current-blue", "highlight-current-green","highlight-current-red"].freeze
    end

    def autoSlides
      auto = Object.new
      auto.define_singleton_method(:include?){|args| args>0}
      auto
    end

  end

end