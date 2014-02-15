namespace :articles do

  APDP_API_URL = "http://apiedepagina.com/api"

  def save_resource post
    author = post['author']
    Author.find_or_create_by(src_id: author['id']) do |_author|
      puts _author.name = author['name']
      puts _author.nickname = author['nickname']
      puts _author.url = author['url']
    end

    Article.find_or_create_by(src_id: post['id']) do |_post|
      puts _post.title = post['title']
      puts _post.title_plain = post['title_plain']
      puts _post.status = post['status']
      puts _post.content = post['content']
      puts _post.excerpt = post['excerpt']
      puts _post.url = post['url']
      puts _post.slug = post['slug']
      puts _post.date = post['date']
      puts _post.modified = post['modified']
      puts _post.author_id = author['id']

      images = post['thumbnail_images']
      puts _post.image_full_url = images['full']['url']
      puts _post.image_medium_url = images['medium']['url']
      puts _post.image_thumbnail_url = images['thumbnail']['url']
    end
  end

  desc "Fetch all Articles"
  task :fetch => :environment do
    puts "[RAKE-INIT] [TASK|articles:fetch]"
    page = 1
    count_total = 1

    while count_total > 0
      res = HTTParty.get "#{APDP_API_URL}/get_posts?page=#{page}"

      if res.code == 200
        page += 1
        count_total = res['count_total']
        posts = res['posts']

        posts.each do |post|
          save_resource post
        end

      else
        puts "[RAKE-ERROR] [STATUS|#{res.code}] [MESSAGE|#{res.message}] [PAGE|#{page}]"
        break
      end

    end

    puts "[RAKE-SUCCESS] [TASK|articles:fetch]"
  end
  # rake articles:fetch

end