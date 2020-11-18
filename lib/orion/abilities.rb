require "json"
require "tty-table"

module Orion
  class Abilities < Command
    def run(json: false, **opts)
      url = Api::url "auth", "info"
      res = Api::get url: url, key: @key

      if json
        puts JSON.dump({
          email: res[:email], name: res[:name], roles: res[:acls]
        })
      else
        entries = {
          header: ["name", "email", "roles"],
          rows: [[res[:name], res[:email], res[:acls].join(", ")]]
        }

        table = TTY::Table.new **entries
        puts table.render :unicode, padding: [0, 1], multiline: true
      end
    end
  end
end
