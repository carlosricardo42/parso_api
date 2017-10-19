class ApiKey < ApplicationRecord
  validates_presence_of :email
  validates :email, email_format: { message: "is not valid" }

  # Return the object with words and reapeted indexes
  def get_duplicates(array)
    array.each_with_index.group_by{|f,i| f}.each{|k,v| v.map!(&:last)}
    .map { |i,a| {word: i, positions: a} if (a.length >1) }.compact
  end

 # Set the counter for eache request
  def set_requests
    self.update_attribute('requests', self.requests + 1);
  end

  # Return the object  get it from get duplicates
  def find_by_key(data)
    self.set_requests
    return self.get_duplicates(data)
  end
end
