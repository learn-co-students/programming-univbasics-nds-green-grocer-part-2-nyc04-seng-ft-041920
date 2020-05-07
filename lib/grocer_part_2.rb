require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupons.each do |element|
    item = find_item_by_name_in_collection(element[:item], cart)
    if item && item[:count] >= element[:num]
      cart << {
        :item => "#{item[:item]} W/COUPON",
        :price => element[:cost]/element[:num],
        :clearance => item[:clearance],
        :count => element[:num]
      }
      item[:count] -= element[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |element|
    if element[:clearance]
      element[:price] -= element[:price] * 0.20
    end
    element
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart) # the only time you call this :)
  coupon = apply_coupons(cart, coupons)
  totaled = apply_clearance(coupon)

  total = 0
  totaled.each do |product|
    total += product[:price] * product[:count]
    if total > 100
      total -= total * 0.10
    end
  end
  total
end
