class Item < ApplicationRecord
  belongs_to :user

  attachment :image
  enum genre_name: {"Pen": 0,"Notebook": 1 ,"Scissors": 2,"Pins": 3, "Pencilcase": 4,"other": 5 }
end
