
class Head
  include Mongoid::Document
  include Mongoid::Alize

  if SpecHelper.mongoid_4?
    include Mongoid::Attributes::Dynamic
  end

  field :size, type: Integer
  field :weight

  # to whom it's attached
  belongs_to :person

  # in whose possession it is
  belongs_to :captor, :class_name => "Person", :inverse_of => :heads

  # who'd otherwise like to possess it
  has_and_belongs_to_many :wanted_by, :class_name => "Person", :inverse_of => :wants

  # who it sees
  has_many :sees, :class_name => "Person", :inverse_of => :seen_by

  # a relation with no inverse
  has_many :admirer, :class_name => "Person", :inverse_of => nil

  # a polymorphic one-to-one relation
  belongs_to :nearest, :polymorphic => true

  # a polymorphic one-to-many relation
  has_many :below_people, :class_name => "Person", :as => :above

  def density
    "low"
  end

  # example of one way to handling attribute selection
  # for polymorphic associations or generally using the proc fields option
  def alize_fields(inverse)
    if inverse.is_a?(Person)
      [:name, :location]
    else
      [:id]
    end
  end
end

# explicit mock object class due to this issue - https://github.com/btakita/rr/issues/44
class MockObject
  def to_ary
    nil
  end
end


class Person
  include Mongoid::Document
  include Mongoid::Alize

  if SpecHelper.mongoid_4?
    include Mongoid::Attributes::Dynamic
  end

  field :name, type: String
  field :created_at, type: Time

  if SpecHelper.mongoid_3? || SpecHelper.mongoid_4?
    field :my_date, type: Date
    field :my_datetime, type: DateTime
  end

  # the attached head
  has_one :head

  # the heads taken from others
  has_many :heads, :class_name => "Head", :inverse_of => :captor

  # the heads wanted from others
  has_and_belongs_to_many :wants, :class_name => "Head", :inverse_of => :wanted_by

  # the only head that is watching
  belongs_to :seen_by, :class_name => "Head", :inverse_of => :sees

  # a polymorphic one-to-one relation
  has_one :nearest_head, :class_name => "Head", :as => :nearest

  # a polymorphic one-to-many relation
  belongs_to :above, :polymorphic => true

  def location
    "Paris"
  end

  # example of one way to handling attribute selection
  # for polymorphic associations or generally using the proc fields option
  def alize_fields(inverse)
    if inverse.is_a?(Head)
      [:size]
    else
      [:id]
    end
  end
end

