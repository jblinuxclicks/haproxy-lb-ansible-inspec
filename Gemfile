source "https://rubygems.org"

# gem "inspec", path: "../../."

group :test do
  gem "bundler", "~> 2.0"
  gem "minitest", "~> 5.5"
  gem "rake", ["~> 12.3", ">= 12.3.3"]
  gem "simplecov", "~> 0.10"
end

group :integration do
  gem "test-kitchen", "~> 1.4"
  gem "kitchen-ansible"
  gem "kitchen-vagrant"
  gem "kitchen-inspec"
  gem "concurrent-ruby", "~> 1.0"
end
