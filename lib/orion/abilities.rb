require "json"
require "tty-table"

module Orion
  class Abilities < Command
    def initialize(key: nil)
      @key = key
    end

    def run(json: false, **opts)
      url = Api::url "auth", "info"
      res = Api::get(url: url, key: @key)

      data = JSON.parse res.body, symbolize_names: true

      if json
        data.merge({ success: true })
      else
        entries = {
          header: ["name", "email", "roles"],
          rows: [[data[:name], data[:email], data[:acls].join(", ")]]
        }

        table = TTY::Table.new **entries
        puts table.render :unicode, padding: [0, 1], multiline: true
      end
    end
  end
end
