## Mongoid::EmbeddedDenorm

**Mongoid denormalization via embedded models**

# WORK IN PROGRESS

![Stay Classy](https://cloud.githubusercontent.com/assets/27655/3567255/3d2382f4-0b14-11e4-87f7-954e7fd35ecb.jpg)

### Comparison with Mongoid::Alizé

Mongoid::EmbeddedDenorm is inspired by @dzello's fantastic [Mongoid::Alizé](https://github.com/dzello/mongoid_alize) gem. Alizé supports the full gamut of denormalization methods (push/pull/bidirectional), however it saves denormalized model data as nested hashes (or arrays of hashes). This has the following drawbacks:

* One cannot code methods into the denormalized `Hash` objects as if they were regular models.

* Mongoid's default demongoization is used on the denormalized Hash, which does not preserve `DateTime` vs. `Date`, `String` vs. `Symbol`, etc. due to ambiguities between mapping MongoDB types to Ruby types.

* Parts of the Alizé gem code are in practice duplicating Mongoid's built-in embedded document functionality. This adds extra complexity and testing overhead to the gem.

While I contributed several PRs to Alizé, ultimately I felt that a clean-slate rewrite would be most useful, as (at least in my case) if I could denormalize via embedded documents, I would never again use Alizé's Hash-based denormalization.


### Usage

```ruby
class Appointment  
  include Mongoid::Document

  field :date,    type: Time
  field :status,  type: Symbol
  field :reason,  type: String
  # other fields...

  belongs_to :customer
end

class Customer
  include Mongoid::Document
  include Mongoid::Alize

  field :name,  type: String

  has_many :appointments

  embedded_denorm :appointments, as: :denorm_appointments do

    # you can set custom extensions specific to your denormalized models
    # just like with normal embedded objects
    def on_date(date)
      where(date: date)
    end

    def late_count
      @target.select { |a| a.late? }
    end
  end
end

class DenormAppointment
  include Mongoid::Document

  # EmbeddedDenorm will automatically detect the overlapping fields
  # by name, and set only those ones
  field :date,    type: Time
  field :status,  type: Symbol

  # you can define custom methods on your denormalized objects  
  def late?
    status == :late
  end

  embedded_in :customer
end
```
