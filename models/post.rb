class Post
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>

  field :url, :type => String
  field :description, :type => String
  field :likes, :type => Integer
  field :comments, :type => Integer
  field :shares, :type => Integer
  

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
