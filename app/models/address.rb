class Address < ActiveRecord::Base

  attr_accessible :street, :city, :state, :zip, :apt
  has_many :residents, class_name: :person, through: :person, source: :residence

  def apartment
    case apt
    when /^\d+[[:alpha:]]?$/ # For a string of digits without "Apartment" or "Unit" in the prefix
      "##{apt}"
    when /^\w$/ # For single letter apartment numbers
      "##{apt}"
    else # Otherwise, just use whatever they put
      apt
    end
  end

  def full
    if street.to_s.empty? or city.to_s.empty?
      ""
    else
    "#{street}, #{apartment}, #{city}, #{state}, #{zip}".gsub(/( ,)+/, "").strip.sub(/,$/, "")
    end
  end

  def value_for_field field_name
    case field_name
    when "Street"
      street
    when "City"
      city
    when "State"
      state
    when "Zip"
      zip
    when "Apt"
      apartment
    when ""
      full
    else
      ""
    end
  end

end
