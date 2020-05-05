require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  
  #		{:item => "AVOCADO", :num => 2, :cost => 5.00},
  coupons.each do |coupon_item|
    # puts coupon_item
    # check the cart for that item
    current_item = find_item_by_name_in_collection(coupon_item[:item], cart)
    
    # if it exists and there is enough to qualify for the coupon
    if current_item && current_item[:count] >= coupon_item[:num]
      # puts current_item
      # puts coupon_item
      
      # initialize incrementor
      num_of_coupon_items = 0
        # if the item exists, check that the count >= num (from coupon)
        # and keep doing it until the count < num
      while current_item[:count] >= coupon_item[:num] do
          # remove that number from the count in regular in cart
        current_item[:count] -= coupon_item[:num]
        num_of_coupon_items += coupon_item[:num]
        
        # puts "cart #{cart}"
      end
      # format it correctly and add it to the cart
      final_coupon_price = coupon_item[:cost] / num_of_coupon_items
        cart << {:item => "#{coupon_item[:item]} W/COUPON", :price => final_coupon_price, :clearance => current_item[:clearance], :count => num_of_coupon_items}
        
      # if current_item[:count] == 0
        # cart.delete(current_item)
      # end
      
    end
  end
  cart
end
  

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.map do |grocery_item|
    if grocery_item[:clearance]
      grocery_item[:price] = (grocery_item[:price] * 0.8).round(2)
    end
  end
  cart
  
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  # step by step
  # consolidated = consolidate_cart(cart)
  # coupons_applied = apply_coupons(consolidated, coupons)
  # clearance_applied = apply_clearance(coupons_applied)
  
  #all in one step
  couponed_and_clearanced_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  
  total_cost = 0
  couponed_and_clearanced_cart.map do |grocery_item|
    total_cost += grocery_item[:price] * grocery_item[:count]
  end
  if total_cost > 100
    (total_cost *= 0.9).round(2)
  end
  total_cost
end
