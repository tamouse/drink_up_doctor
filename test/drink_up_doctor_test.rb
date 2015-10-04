require 'test_helper'

class DrinkUpDoctorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DrinkUpDoctor::VERSION
  end

  def test_that_it_builds_a_new_site
    run_in_tmpdir do |dir|
      ::DrinkUpDoctor::NewSite.start(%w[percy])
      assert File.exist? "percy"
    end
  end
end
