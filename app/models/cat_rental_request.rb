class CatRentalRequest < ActiveRecord::Base
  validates :status, presence: true
  validate :overlapping_approved_requests
  
  belongs_to(:cat)
  
  def overlapping_requests
    CatRentalRequest.find_by_sql([
      "SELECT
         *
       FROM
         cat_rental_requests
       WHERE
         (? BETWEEN start_date AND end_date
       OR
         ? BETWEEN start_date AND end_date)
       AND
         cat_id = ?
       AND
         id != ?
      AND status = 'APPROVED'
         ", self.start_date, self.end_date, self.cat_id, self.id
      ])
  end
  
  def overlapping_approved_requests
    unless overlapping_requests.empty?
      errors.add(:overlap, "Overlapping Approved Rentals")
    end
  end
end

