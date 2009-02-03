module DressingRoomController

  def self.included(base)
    base.extend(ClassMethods)
    base.helper DressingRoomHelper
  end

  module ClassMethods

    def theme(theme_name)
      if theme = Theme.find(theme_name)
        write_inheritable_attribute 'theme', theme
        self.view_paths = ::ActionController::Base.view_paths.dup.unshift(ActionView::Template::Path.new("#{theme.path}/views"))
      end
    end
    
  end
  
end