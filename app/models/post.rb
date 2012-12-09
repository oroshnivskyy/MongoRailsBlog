class Post
  include MongoMapper::Document

  key :title, String, :required => true
  key :author, String, :required => true
  key :body, String, :required => true
  key :permalink, String, :required => true
  key :tags, Array
  timestamps!

  validates_presence_of :title, :author, :body, :permalink

  before_save :update_tags

  private

  def update_tags
    @tags = @tags[0].split()
  end
end
