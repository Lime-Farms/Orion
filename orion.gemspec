Gem::Specification.new do |spec|
  spec.name = "orion"
  spec.version = "0.1.0"
  spec.date = "2020-11-17"
  spec.summary = "Create and manage Vultr servers"
  spec.description = "A tool for interacting with Vultr from the command-line"
  spec.authors = ["Nicholas Chambers"]
  spec.email = "nchambers@securitea.app"
  spec.files = ["lib/orion.rb"] + Dir["lib/orion/*.rb"]
  spec.executables = ["orion"]
  spec.homepage = "https://github.com/Lime-Farms/Orion"
  spec.license = "MIT"
end
