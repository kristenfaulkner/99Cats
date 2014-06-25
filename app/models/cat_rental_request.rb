class CatRentalRequest < ActiveRecord::Base
  validates :status, presence: true
  # validate :overlapping_approved_requests
  
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
         ", self.start_date, self.end_date, self.cat_id, self.id
      ])
  end
  
  def overlapping_approved_requests
    p overlapping_requests # ||
#     overlapping_requests.where(:status => "APPROVED") == []
  end
end


# "SELECT
#    *
#  FROM
#    cat_rental_requests as c1
#  JOIN
#    cat_rental_requests as c2
#  ON
#    c1.cat_id = c2.cat_id
#  WHERE
#    (c1.start_date BETWEEN c2.start_date AND c2.end_date
#  OR
#    c2.start_date BETWEEN c1.start_date AND c1.end_date)
#  AND
#    c1.id != c2.id
#    "