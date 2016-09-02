module Slug
  def slug
    self.username.gsub(" ", "-").downcase
  end

  def date_slug
    self.date.strftime("%b-%d-%y")
  end

  def meal_slug
    self.name.gsub(" ", "-").downcase
  end
end

module ClassSlug
  def find_by_slug(name)
    self.all.detect { |n| n.slug == name }
  end

  def find_by_date_slug(day)
    self.all.detect { |d| d.date_slug == day}
  end

  def find_by_meal_slug(meal)
    self.all.detect { |m| m.meal_slug == meal}
  end
end
