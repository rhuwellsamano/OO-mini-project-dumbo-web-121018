class Recipe
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @@all << self

  end

  def self.all
    @@all
  end

  def recipe_cards
    RecipeCard.all.select do |card|
      card.recipe == self
    end
  end

  def users
    recipe_cards.collect do |card|
      card.user
    end
  end

  # def recipe_ingredients
  #   RecipeIngredient.all.select do |card|
  #     card.recipe == self
  # end

  def ingredients
    RecipeIngredient.all.select do |ri|
      ri.recipe == self
    end.collect do |x|
      x.ingredient
    end
  end

  def allergens
    ingredients.select do |ingredient|
    Allergens.all.select do |allergen|
      allergen.ingredient == ingredient
    end
  end

  def add_ingredients(array)
    array.each do |ingredient|
      RecipeCard.new (ingredient, self)
    end
  end


  def self.most_popular
    @@all.sort_by do |recipe|
      recipe.recipe_cards.count

    # .select do |card|
    #   card.recipe == self
    # end
    # count  RecipeCard.recipe == self
    end.last
  end

end
