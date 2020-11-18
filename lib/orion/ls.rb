require "ipaddr"

module Orion
  class Ls < Command
    def run(json: false, **opts)
      url = Api::url "server", "list"
      res = Api::get url: url, key: @key

      servers = res.map do |_, server|
        cidr = IPAddr.new(server[:netmask_v4]).to_i.to_s(2).count(?1)

        status = if server[:status] == "pending"
          "building"
        elsif server[:status] == "active"
          if server[:power_status] == "running"
            if server[:server_state] == "installingbooting"
              "booting up"
            elsif server[:server_state] == "ok"
              "online"
            end
          else
            "offline"
          end
        else
          server[:status]
        end

        [server[:label], {
          os: server[:os], status: status, ip: "#{server[:main_ip]}/#{cidr}",
          location: server[:location], ram: server[:ram], disk: server[:disk],
          cpu: server[:vcpu_count]
        }]
      end.to_h

      if json
        puts JSON.dump(servers)
      else
        table = TTY::Table.new header: [
          "label", "status", "os", "ip", "location", "ram", "disk", "cpu"
        ]

        servers.each do |label, data|
          table << [
            label, data[:status], data[:os], data[:ip], data[:location],
            data[:ram], data[:disk], data[:cpu]
          ]
        end

        puts table.render :unicode, padding: [0, 1], multiline: true
      end
    end
  end
end
