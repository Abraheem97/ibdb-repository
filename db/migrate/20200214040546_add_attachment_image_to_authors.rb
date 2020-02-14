class AddAttachmentImageToAuthors < ActiveRecord::Migration[5.2]
  def self.up
    change_table :authors do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :authors, :image
  end
end
