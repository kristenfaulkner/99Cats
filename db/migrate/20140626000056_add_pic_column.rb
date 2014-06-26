class AddPicColumn < ActiveRecord::Migration
  def change
    add_column :cats, :image_url, :string, :default => "http://scienceblogs.com/gregladen/files/2012/12/Beautifull-cat-cats-14749885-1600-1200.jpg"
  end
end
