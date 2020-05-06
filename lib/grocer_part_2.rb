require_relative './part_1_solution.rb'


def apply_coupons(cart, coupons)
  coupons.each do |coupon_item|
    #storing current item in order to be able to access values within cart without looping into it
    current_item = find_item_by_name_in_collection(coupon_item[:item], cart)
    #if current coupon item is inside cart
    if current_item && current_item[:count] >= coupon_item[:num]
      #add coupon item to cart and update values accordingly
      cart.push({:item => "#{coupon_item[:item]} W/COUPON", 
      :price => coupon_item[:cost]/coupon_item[:num].to_f, :clearance => current_item[:clearance],
      :count => coupon_item[:num]})
      #add if statement?
       current_item[:count] = current_item[:count] - coupon_item[:num]
    end
  end
  pp cart
end

#Example case used for apply_coupons
coupon_cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => true, :count => 2},
  {:item => "APPLE",    :price => 2.00, :clearance => false, :count => 1}
]

coupons = [
  {:item => "AVOCADO", :num => 4, :cost => 5.00}
]

apply_coupons(coupon_cart, coupons)

# # expected result - modify cart array to
# [
#   {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
#   {:item => "KALE", :price => 3.00, :clearance => false, :count => 1},
#   {:item => "APPLE", :price => 2.00, :clearance => false, :count => 1},
#   {:item => "AVOCADO W/COUPON", :price => 2.50, :clearance => true, :count => 2},
#   {:item => "KALE W/COUPON", :price => 1:00, :clearance => true, :count => 1}
# ]



def apply_clearance(cart)
#returns new Array where every unique item in the original is present but with its price 
#reduced by 20% if its :clearance value is true
  cart.each do |cart_item|
    if cart_item[:clearance] == true
      cart_item[:price] = (cart_item[:price] * 0.8).round(2)
    end
  end
  cart
end

#example used for apply_clearance
#input
cart = [
  {:item => "PEANUT BUTTER", :price => 3.00, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 4.50, :clearance => true,  :count => 1}
]
#output
[
  {:item => "PEANUT BUTTER", :price => 2.40, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 3.60, :clearance => true,  :count => 1}
]

# apply_clearance(cart)

def checkout(cart, coupons)
  # inputs:
  # Array: a collection of item Hashes
  # Array: a collection of coupon Hashes
  #output
  # Float: a total of the cart

  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  clearance_applied = apply_clearance(coupons_applied)

  total = 0.00
    clearance_applied.each do |cart_item|
      total += (cart_item[:price] * cart_item[:count].to_f)
  end
  if total > 100.00
    total = total * 0.90
  end
  total
end

unconsolidated_cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "KALE", :price => 3.00, :clearance => false}
]

# checkout(unconsolidated_cart, coupons)