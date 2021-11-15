# frozen_string_literal: true

require_relative "lib/TwitterOfBabel/version"

Gem::Specification.new do |spec|
  spec.name          = "TwitterOfBabel"
  spec.version       = TwitterOfBabel::VERSION
  spec.authors       = ["Andre LaFleur"]
  spec.email         = ["cincospenguinos@gmail.com"]

  spec.summary       = "A reinterpretation of the Borgesian Library of Babel for Twitter"
  spec.description   = <<~STR
    Every imaginable tweet is encapsulated in this code. Give an address, and get the tweet corresponding to it.
    Be warned, however: there is much folly and little wisdom in its cooridors.
  STR
  spec.homepage      = "https://www.github.com/cincospenguinos/TwitterOfBabel"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/cincospenguinos/TwitterOfBabel"
  spec.metadata["changelog_uri"] = "https://www.github.com/cincospenguinos/TwitterOfBabel/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "twitter", "~> 7.0"
end
