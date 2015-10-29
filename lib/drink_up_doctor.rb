require "thor"

require "drink_up_doctor/version"
require "drink_up_doctor/new_site"
require "drink_up_doctor/new_twbs_site"

module DrinkUpDoctor
  class Base < Thor
    register(DrinkUpDoctor::NewSite, 'new', 'new', 'create a new Jekyll web site')
    register(DrinkUpDoctor::NewTwbsSite, 'newtwbs', 'newtwbs', 'create a new Jekyll web site based on HTML5Boilerplate and Twitter Bootstrap')
  end
end
