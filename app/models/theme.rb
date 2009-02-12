class Theme
  
  alias_attribute :to_s, :name
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
    
  def path
    "#{Theme.themes_root}/#{name}"
  end  
    
  # Find a theme, given the theme name
  def self.find(name)
    theme = self.new(name) 
    if self.installed_themes.include?(theme.path)
      return theme
    else
      raise ThemeNotFound, "#{name} was not found in #{Theme.themes_root}"
    end
  end

  def self.themes_root
    "#{Rails.root}/themes"
  end
  
  def self.installed_themes
    @installed_themes ||= search_theme_directory
  end

  def self.search_theme_directory
    glob = "#{themes_root}/[a-zA-Z0-9]*"
    Dir.glob(glob).select do |file|
      File.readable?("#{file}/about.markdown")
    end.compact
  end
  
end

class ThemeError < StandardError; end
class ThemeNotFound < ThemeError; end