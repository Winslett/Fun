guard 'rspec', :version => 2 do
  watch(%r{^spec/unit/.+_spec\.rb$})
  watch(%r{^spec/integration/.+_spec\.rb$})

  watch(%r{^models/(.+)\.rb$})       { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')       { "spec" }
  watch('twilio_mongo_bootstrap.rb') { "spec" }
end

