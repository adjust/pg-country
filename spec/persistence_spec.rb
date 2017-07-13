require 'spec_helper'

describe 'persistence' do
  before do
    install_extension
  end

  it 'should persist countries' do
    query("CREATE TABLE country_test AS SELECT 'de'::country, 1 as num")
    query("INSERT INTO country_test(num) VALUES(3);")
    query("SELECT * FROM country_test").should match  'de',  1
    query("UPDATE country_test SET num = 2")
    query("SELECT * FROM country_test").should match  'de',  2
  end
end
