class Author < ActiveRecord::Base

  has_many :articles
  accepts_nested_attributes_for :articles, :allow_destroy=>true

end
