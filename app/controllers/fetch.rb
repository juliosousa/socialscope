Socialscopeme::App.controllers :fetch do

  post :index do

    #ap params


    #break

    agent = Mechanize.new

    ##Colocar apenas o nome da página
    @link_page = params['url'].split('/')[3]
    ##Não mexer
    # csv = CSV.new(open("files/2017/links_#{@link_page}.csv", 'wb'))
    # csv << %w(CREATED LINK LIKES COMMENTS)

    @count = 0

    #TODO: Criar um atenticador para API do Facebook
    #O token abaixo nao tem validade, pode ser utilizado futuramente em producao.
    @graph = Koala::Facebook::API.new("EAALQhxGV2qYBALElsXTLBIROBjTFvFYRTnI01ajJoCyghZCHZAdcpSi5Iu8sD3xgCDKHCxQuiA4Ea09sdmO9qTHfFY06ZAicC0Ln7skQBoZCYCn9cSPYOWl7EiZAKvGO3a1WylmFpR6c2MiM4ONFdPGHVWZAePUTgZD")
    @limit = 0
    if current_account == nil
      @limit = 20
    elsif
      @limit = 99
    end
    page = @graph.get_connection(@link_page, 'posts',{
        limit: @limit,
        fields: ['likes.limit(0).summary(true)','comments.limit(0).summary(true)']
      })

    @posts = Array.new
      page.each do |photo|
        # ap 'Link: '+get_link(photo['id']) + '; Likes: ' + photo['likes']['summary']['total_count'].to_s
        photo['link'] = get_link(photo['id'])
        @count = @count+1
        # ap @count
        # begin
        #   if photo['comments']['summary']['total_count'] != nil
        #     csv << [photo['created_time'], get_link(photo['id']), photo['likes']['summary']['total_count'], photo['comments']['summary']['total_count']]
        #   end
        # rescue Exception => e
        #   ap e
        # end
        @posts << photo

      end

    # csv.close
    ap @posts
    render 'fetch/index'
  end
end
