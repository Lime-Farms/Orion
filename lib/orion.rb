module Orion
  NAME = "Orion".freeze
  VERSION = "0.1.0".freeze
end

# backend utilities
require "orion/api"
require "orion/cmd"
require "orion/error"

# frontend commands
require "orion/abilities"
require "orion/ls"
