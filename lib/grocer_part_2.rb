require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  cart.each do |cart_hash|
    coupons.each do |coupon_hash|
      if cart_hash[:item] == coupon_hash[:item]
        #if the cart and the coupon have the same item, then we want to create a new item in the cart that is "item w/ coupon"
        #but we only want to do that IF there are enough of that item in the cart. so only if the count of that item is equal to or greater than the number of items the coupon applies to
      
        if cart_hash[:count] >= coupon_hash[:num]
          #we also want to update the value of cart_hash[:count] so that if we had 3 avocados to start with and used the coupon for 2 avocados, we'll now have 1 avocado at regular price
        cart_hash[:count] -= coupon_hash[:num]
        #since cart is an array, we can shovel in the creation of the new w/ coupon item
        cart << { item: "#{cart_hash[:item]} W/COUPON", price: coupon_hash[:cost]/coupon_hash[:num], clearance: cart_hash[:clearance], count: coupon_hash[:num]}
        
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #iterate through the cart array to get each hash of cart items
  cart.each do |cart_hash|
    #if the item is on clearance
    if cart_hash[:clearance] == true
      #then we will multiply it by 0.8, which makes it 20% off. and round to two decimal points
      cart_hash[:price] = (cart_hash[:price] * 0.8).round(2)
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
  
  #creating a new cart that is consolidated, by calling consolidate cart
  consolidated_cart = consolidate_cart(cart)
  # calling apply_coupons and apply_clearance to our consolidated cart
  apply_coupons(consolidated_cart, coupons)
  apply_clearance(consolidated_cart)

  # creating a grand total, and accumulating it by iterating through the consolidated cart and multiplying each item Hash's price by its count
  grand_total = 0
  consolidated_cart.each do |item_hash|
      value = item_hash[:price] * item_hash[:count]
      grand_total += value
  end
  
  #it the carts total is over 100$, the customer gets an additional 10% off
  if grand_total > 100
    grand_total *= 0.9
  end

  grand_total

end
