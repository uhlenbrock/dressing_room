class ThemeController < ActionController::Base
  
  caches_page :stylesheets, :javascripts, :images
  
  def stylesheets
    render_theme_item(:stylesheets, params[:filename], 'text/css; charset=utf-8')
  end

  def javascripts
    render_theme_item(:javascripts, params[:filename], 'text/javascript; charset=utf-8')
  end

  def images
    render_theme_item(:images, params[:filename])
  end
  
  def error
    render :nothing => true, :status => 404
  end

  private
  
    def current_theme
      @current_theme ||= Theme.find(params[:theme])
    end

    def render_theme_item(type, file, mime = nil)
      mime ||= mime_for(file)
      if file.split(%r{[\\/]}).include?("..")
        return (render :nothing => true, :status => 404)
      end

      src = current_theme.path + "/#{type}/#{file}"
      return (render :nothing => true, :status => 404) unless File.exists? src

      send_file(src, :type => mime, :disposition => 'inline', :stream => false)
    end

    def mime_for(filename)
      case filename.downcase
      when /\.js$/
        'text/javascript'
      when /\.css$/
        'text/css'
      when /\.gif$/
        'image/gif'
      when /(\.jpg|\.jpeg)$/
        'image/jpeg'
      when /\.png$/
        'image/png'
      when /\.swf$/
        'application/x-shockwave-flash'
      else
        'application/binary'
      end
    end
    
end