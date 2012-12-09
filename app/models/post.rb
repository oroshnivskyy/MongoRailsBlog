class Post
  include MongoMapper::Document

  key :title, String, :required => true
  key :author, String, :required => true
  key :body, String, :required => true
  key :permalink, String, :required => true
  key :tags, Array
  timestamps!
  belongs_to :user, :foreign_key => :author, :class_name => "User"

  validates_presence_of :title, :author, :body, :permalink

  before_save :tags_to_array

  private

  def tags_to_array
    self.tags = @tags[0].split()
  end
end
