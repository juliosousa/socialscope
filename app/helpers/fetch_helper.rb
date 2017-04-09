# Helper methods defined here can be accessed in any controller or view in the application

module Socialscopeme
  class App
    module FetchHelper
      def get_link(id)
        return "https://www.facebook.com/#{@link_page}/posts/#{id.split('_')[1]}"
      end

      
    end

    helpers FetchHelper
  end
end
