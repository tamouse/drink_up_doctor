require "thor"

require "drink_up_doctor/version"
require "drink_up_doctor/new_site"

module DrinkUpDoctor
  class Base < Thor
    register(DrinkUpDoctor::NewSite, 'new', 'new', 'create a new Jekyll web site')
  end
end
