class Usuario < Account
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :fb_token, :type => String
  field :plano, :type => String
  field :fb_password, :type => Boolean
  field :fb_id, :type => String
  field :fb_link, :type => String


  # field :name,             :type => String
  # field :surname,          :type => String
  # field :email,            :type => String
  # field :crypted_password, :type => String
  # field :role,             :type => String

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
