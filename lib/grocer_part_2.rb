require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item_hash| #iterating through original cart

    coupons.each do |coupon_details| #iterating through given coupons
      if item_hash[:item] == coupon_details[:item] #comparing both arrays and the key [:item]
        if item_hash[:count] >= coupon_details[:num] #checking to is greater than [:num]
          item_hash[:count] -= coupon_details[:num] #reduces value of count by num see if [:count]
          #adds hash to cart including coupon details
          cart << {item: "#{item_hash[:item]} W/COUPON", 
          price: coupon_details[:cost] / coupon_details[:num], 
          clearance: item_hash[:clearance], 
          count: coupon_details[:num]} 
        end
      end
    end
  end
  return cart #returns the updated cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item_hash| #iterates through original cart
    if item_hash[:clearance] == true #checks to see if 
      item_hash[:price] = (item_hash[:price] * 0.8).round(2)
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
  new_consolidated_cart = consolidate_cart(cart)
  apply_coupons(new_consolidated_cart, coupons)
  apply_clearance(new_consolidated_cart)
  
  cost = []
  
  new_consolidated_cart.each do |item_hash|
    cost << item_hash[:price] * item_hash[:count]
  end
  
  total_cost = cost.reduce do |grand_total, item_cost|
    grand_total + item_cost
  end

  if total_cost > 100
    total_cost *= 0.9
  end
  
  total_cost
end
