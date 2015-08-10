require 'spec_helper'

describe 'binary_copy' do
  before do
    install_extension
  end

  it "should copy data binary from country" do
    query("CREATE TABLE before (a country)")
    query("INSERT INTO before values ('de'),('us'),('es'),('de'),('zz')")
    query("CREATE TABLE after (a country)")
    query("COPY before TO '/tmp/tst' WITH (FORMAT binary)")
    query("COPY after FROM '/tmp/tst' WITH (FORMAT binary)")
    query("SELECT * FROM after").should match \
      ['de'],
      ['us'],
      ['es'],
      ['de'],
      ['zz']
  end
end
