# frozen_string_literal: true

class Person
  include Mongoid::Document
  include Mongoid::Suicide

  field :username, type: String
  field :age, type: Integer, default: '100'
end
