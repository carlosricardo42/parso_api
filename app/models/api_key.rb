class ApiKey < ApplicationRecord
  validates_presence_of :email
  validates :email, email_format: { message: "is not valid" }

  def get_duplicates(array)
    array.each_with_index.group_by{|f,i| f}.each{|k,v| v.map!(&:last)}
    .map { |i,a| {word: i, positions: a} if (a.length >1) }.compact
  end

  def set_requests
    self.update_attribute('requests', self.requests + 1);
  end
end
