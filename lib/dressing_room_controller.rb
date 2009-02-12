module DressingRoomController

  def self.included(base)
    base.extend(ClassMethods)
    base.helper DressingRoomHelper
  end

  module ClassMethods
    
    def theme(theme_name)
      write_inheritable_attribute :theme_name, theme_name
      include DressingRoomController::InstanceMethods
      proc = Proc.new do |c|
        begin  
          c.view_paths = self.view_paths = ::ActionController::Base.view_paths.dup.unshift(ActionView::Template::Path.new("#{c.current_theme.path}/views"))
        rescue ThemeNotFound
        end
      end
      before_filter(proc)
    end
    
  end
  
  module InstanceMethods
    
    def current_theme
      @current_theme ||= Theme.find(parse_theme)
    end
    
    protected
    
      def parse_theme
        theme_name = self.class.read_inheritable_attribute(:theme_name)
        theme = case theme_name
          when Symbol then send(theme_name)
          when Proc   then theme_name.call(self)
          when String then theme_name
        end
      end
      
  end
  
end