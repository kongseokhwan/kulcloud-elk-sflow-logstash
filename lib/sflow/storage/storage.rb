class SflowStorage
  require 'json'

  def self.eth_type_mapper(eth_type)    
     # TODO : Etyper Typer mapping
     eth_typer_mapper = {
        "1" => "TCPMUX"
        "5" => "RJE"
        "7" => "ECHO"
        18  Message Send Protocol (MSP)
        20  FTP -- Data
        21  FTP -- Control
        22  SSH Remote Login Protocol
        23  Telnet
        25  Simple Mail Transfer Protocol (SMTP)
        29  MSG ICP
        37  Time
        42  Host Name Server (Nameserv)
        43  WhoIs
        49  Login Host Protocol (Login)
        53  Domain Name System (DNS)
        69  Trivial File Transfer Protocol (TFTP)
        70  Gopher Services
        79  Finger
        80  HTTP
        103 X.400 Standard
        108 SNA Gateway Access Server
        109 POP2
        110 POP3
        115 Simple File Transfer Protocol (SFTP)
        118 SQL Services
        119 Newsgroup (NNTP)
        137 NetBIOS Name Service
        139 NetBIOS Datagram Service
        143 Interim Mail Access Protocol (IMAP)
        150 NetBIOS Session Service
        156 SQL Server
        161 SNMP
        179 Border Gateway Protocol (BGP)
        190 Gateway Access Control Protocol (GACP)
        194 Internet Relay Chat (IRC)
        197 Directory Location Service (DLS)
        389 Lightweight Directory Access Protocol (LDAP)
        396 Novell Netware over IP
        443 HTTPS
        444 Simple Network Paging Protocol (SNPP)
        445 Microsoft-DS
        458 Apple QuickTime
        546 DHCP Client
        547 DHCP Server
        563 SNEWS
        569 MSN
        1080  Socks
     }
  end 

  def self.tcpudp_type_mapper(port_num)
    # TODO : Kong, apply basic mapping TCP/DST port and service string mapping
  end


  def self.send_udpjson(sflow)

  # remap hash-keys with prefix "sflow_"
  
  
      mappings = {"agent_address" => "sflow_agent_address",
                  "sampling_rate" => "sflow_sampling_rate",
                  "i_iface_value" => "sflow_i_iface_value",
                  "o_iface_value" => "sflow_o_iface_value",
                  "eth_protocol" => "sflow_eth_type",
                  "vlan_src" => "sflow_vlan_src",
                  "vlan_dst" => "sflow_vlan_dst",
                  "ipv4_src" => "sflow_ipv4_src",
                  "ipv4_dst" => "sflow_ipv4_dst",
                  "frame_length" => "sflow_frame_length",
                  "frame_length_multiplied" => "sflow_frame_length_multiplied",
                  "tcp_src_port" => "sflow_tcp_src_port",
                  "tcp_dst_port" => "sflow_tcp_dst_port",
                  "udp_src_port" => "sflow_udp_src_port",
                  "udp_dst_port" => "sflow_udp_dst_port",
      }

      prefixed_sflow = Hash[sflow.map {|k, v| [mappings[k], v] }]

      if sflow['i_iface_value'] and sflow['o_iface_value']
        i_iface_name = {
          "sflow_i_iface_name" => 
          SNMPwalk.mapswitchportname(sflow['agent_address'],
            sflow['i_iface_value'])
        }
        o_iface_name = {"sflow_o_iface_name" => 
          SNMPwalk.mapswitchportname(sflow['agent_address'],
            sflow['o_iface_value'])
        }
        prefixed_sflow.merge!(i_iface_name)
        prefixed_sflow.merge!(o_iface_name)
      end

      $logstash.send(prefixed_sflow.to_json, 0)

  end

end
