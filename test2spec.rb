data = $stdin.read

data.gsub! /class (.*)Test < ActiveSupport::TestCase/, 'describe \1 do'

while(m = data.match /(^\s+)should(_not)?_(belong_to|have_one|have_many|allow_mass_assignment_of) (:.+)/)
  replace = []
  m[4].split(/,\s+/).each do |key|
    replace.push "#{m[1]}it { should#{m[2]} #{m[3]} #{key} }"
  end
  data.gsub! m[0], replace.join("\n")
end

data.gsub! /setup do/, 'before :each do'

#data.gsub! /assert_equal ([^,]+), (.*)/, '(\2).should == \1'
data.gsub! /assert_equal ([^,]+), (.*)/, '\2.should == \1'

data.gsub! /(\s+)should "/, '\1it "should '
puts data
