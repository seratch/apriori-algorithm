# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
end

