class Article < ActiveRecord::Base

  belongs_to :author
  has_many :related_links
  accepts_nested_attributes_for :related_links, :allow_destroy=>true

  def display_name # DISPLAY NAME ON ACTIVE ADMIN
    "#{self.title_plain}"
  end

end
