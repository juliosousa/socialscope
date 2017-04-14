Socialscopeme::App.controllers :fetch do
  
  get :index, map: 'fetch/:page' do
    agent = Mechanize.new

    ##Colocar apenas o nome da página
    @link_page = params[:page]

    ##Não mexer
    # csv = CSV.new(open("files/2017/links_#{@link_page}.csv", 'wb'))
    # csv << %w(CREATED LINK LIKES COMMENTS)
    
    
    @count = 0

    #TODO: Criar um atenticador para API do Facebook
    @graph = Koala::Facebook::API.new("EAACEdEose0cBAMxdV1XU3SZA8ZCNHnZB25oyT5vCIqlbwcUmb8Vv6bMs1O82Wa0G0BRxgrVIcmiZA6tAyswHAeLOJ4s0X8jZC0mtKoqcGnfkZANPGIGfCc73SN1ofwUPGmFRnZAjZAhmZB6eOKt21onYVvwJQ5cG04tVq66OwRC5ydtGhQ5JGbXVa7ytFKfIfL9MZD")
    
    
    page = @graph.get_connection(@link_page, 'posts',{
        limit: 99,
        fields: ['likes.limit(0).summary(true)','comments.limit(0).summary(true)']
      })

    

    until page.next_page.nil?
      page.each do |photo|
        ap 'Link: '+get_link(photo['id']) + '; Likes: ' + photo['likes']['summary']['total_count'].to_s
        
        # @count = @count+1
        # ap @count
        # begin
        #   if photo['comments']['summary']['total_count'] != nil
        #     csv << [photo['created_time'], get_link(photo['id']), photo['likes']['summary']['total_count'], photo['comments']['summary']['total_count']]
        #   end
        # rescue Exception => e
        #   ap e
        # end
      end
      page = page.next_page
    end
    # csv.close
    render 'fetch/index'
  end

  post '/' do
    # @page = Post.new(params[:page])
    # halt 422, serialize(search) unless search.save

    agent = Mechanize.new

    ##Colocar apenas o nome da página
    @link_page = params[:page]

    @psearch = Post.new(@link_page)
    if @psearch.save
      @url = pat(:create_url, :model => "post #{@psearch.id}")
      flash[:success] = pat(:create_success, :model => 'Post')
    else
      @url = pat(:create_url, :model => 'post')
      flash.now[:error] = pat(:create_error, :model => 'Post')
    end

    ##Não mexer
    # csv = CSV.new(open("files/2017/links_#{@link_page}.csv", 'wb'))
    # csv << %w(CREATED LINK LIKES COMMENTS)


    @count = 0

    #TODO: Criar um atenticador para API do Facebook
    @graph = Koala::Facebook::API.new("EAACEdEose0cBAMxdV1XU3SZA8ZCNHnZB25oyT5vCIqlbwcUmb8Vv6bMs1O82Wa0G0BRxgrVIcmiZA6tAyswHAeLOJ4s0X8jZC0mtKoqcGnfkZANPGIGfCc73SN1ofwUPGmFRnZAjZAhmZB6eOKt21onYVvwJQ5cG04tVq66OwRC5ydtGhQ5JGbXVa7ytFKfIfL9MZD")


    page = @graph.get_connection(@link_page, 'posts',{
        limit: 99,
        fields: ['likes.limit(0).summary(true)','comments.limit(0).summary(true)']
    })



    until page.next_page.nil?
      page.each do |photo|
        ap 'Link: '+get_link(photo['id']) + '; Likes: ' + photo['likes']['summary']['total_count'].to_s

        # @count = @count+1
        # ap @count
        # begin
        #   if photo['comments']['summary']['total_count'] != nil
        #     csv << [photo['created_time'], get_link(photo['id']), photo['likes']['summary']['total_count'], photo['comments']['summary']['total_count']]
        #   end
        # rescue Exception => e
        #   ap e
        # end
      end
      page = page.next_page
    end
    # csv.close
    render 'fetch/index'

    # response.headers['Location'] = "#{base_url}/#{search.id}"
    # status 201
  end

end
