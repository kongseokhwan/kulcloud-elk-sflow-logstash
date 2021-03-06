class SflowStorage
  require 'json'
  @@ipv4_type_mapper = {
	"0"=>"HOPOPT",
	"1"=>"ICMP",
	"2"=>"IGMP",
	"3"=>"GGP",
	"4"=>"IP-in-IP",
	"5"=>"ST",
	"6"=>"TCP",
	"7"=>"CBT",
	"8"=>"EGP",
	"9"=>"IGP",
	"10"=>"BBN-RCC-MON",
	"11"=>"NVP-II",
	"12"=>"PUP",
	"13"=>"ARGUS",
	"14"=>"EMCON",
	"15"=>"XNET",
	"16"=>"CHAOS",
	"17"=>"UDP",
	"18"=>"MUX",
	"19"=>"DCN-MEAS",
	"20"=>"HMP",
	"21"=>"PRM",
	"22"=>"XNS-IDP",
	"23"=>"TRUNK-1",
	"24"=>"TRUNK-2",
	"25"=>"LEAF-1",
	"26"=>"LEAF-2",
	"27"=>"RDP",
	"28"=>"IRTP",
	"29"=>"ISO-TP4",
	"30"=>"NETBLT",
	"31"=>"MFE-NSP",
	"32"=>"MERIT-INP",
	"33"=>"DCCP",
	"34"=>"3PC",
	"35"=>"IDPR",
	"36"=>"XTP",
	"37"=>"DDP",
	"38"=>"IDPR-CMTP",
	"39"=>"TP++",
	"40"=>"IL",
	"41"=>"IPv6",
	"42"=>"SDRP",
	"43"=>"IPv6-Route",
	"44"=>"IPv6-Frag",
	"45"=>"IDRP",
	"46"=>"RSVP",
	"47"=>"GRE",
	"48"=>"MHRP",
	"49"=>"BNA",
	"50"=>"ESP",
	"51"=>"AH",
	"52"=>"I-NLSP",
	"53"=>"SWIPE",
	"54"=>"NARP",
	"55"=>"MOBILE",
	"56"=>"TLSP",
	"57"=>"SKIP",
	"58"=>"IPv6-ICMP",
	"59"=>"IPv6-NoNxt",
	"60"=>"IPv6-Opts",
	"62"=>"CFTP",
	"64"=>"SAT-EXPAK",
	"65"=>"KRYPTOLAN",
	"66"=>"RVD",
	"67"=>"IPPC",
	"69"=>"SAT-MON",
	"70"=>"VISA",
	"71"=>"IPCU",
	"72"=>"CPNX",
	"73"=>"CPHB",
	"74"=>"WSN",
	"75"=>"PVP",
	"76"=>"BR-SAT-MON",
	"77"=>"SUN-ND",
	"78"=>"WB-MON",
	"79"=>"WB-EXPAK",
	"80"=>"ISO-IP",
	"81"=>"VMTP",
	"82"=>"SECURE-VMTP",
	"83"=>"VINES",
	"84"=>"TTP",
	"84"=>"IPTM",
	"85"=>"NSFNET-IGP",
	"86"=>"DGP",
	"87"=>"TCF",
	"88"=>"EIGRP",
	"89"=>"OSPF",
	"90"=>"Sprite-RPC",
	"91"=>"LARP",
	"92"=>"MTP",
	"93"=>"AX.25",
	"94"=>"IPIP",
	"95"=>"MICP",
	"96"=>"SCC-SP",
	"97"=>"ETHERIP",
	"98"=>"ENCAP",
	"100"=>"GMTP",
	"101"=>"IFMP",
	"102"=>"PNNI",
	"103"=>"PIM",
	"104"=>"ARIS",
	"105"=>"SCPS",
	"106"=>"QNX",
	"107"=>"A/N",
	"108"=>"IPComp",
	"109"=>"SNP",
	"110"=>"Compaq-Peer",
	"111"=>"IPX-in-IP",
	"112"=>"VRRP",
	"113"=>"PGM",
	"115"=>"L2TP",
	"116"=>"DDX",
	"117"=>"IATP",
	"118"=>"STP",
	"119"=>"SRP",
	"120"=>"UTI",
	"121"=>"SMP",
	"122"=>"SM",
	"123"=>"PTP",
	"124"=>"IS-IS",
	"125"=>"FIRE",
	"126"=>"CRTP",
	"127"=>"CRUDP",
	"128"=>"SSCOPMCE",
	"129"=>"IPLT",
	"130"=>"SPS",
	"131"=>"PIPE",
	"132"=>"SCTP",
	"133"=>"FC",
	"134"=>"RSVP-E2E-IGNORE",
	"135"=>"Mobility",
	"136"=>"UDPLite",
	"137"=>"MPLS-in-IP",
	"138"=>"manet",
	"139"=>"HIP",
	"140"=>"Shim6",
	"141"=>"WESP",
	"142"=>"ROHC",
	"255"=>"Reserved"
  }

  @@eth_type_mapper = {
	"257" => "Experimental",
	"512" => "XEROX PUP",
	"513" => "PUP Addr Trans",
	"1536" => "XEROX NS IDP",
	"2048" => "IPv4",
	"2049" => "X.75 Internet",
	"2050" => "NBS Internet",
	"2051" => "ECMA Internet",
	"2052" => "Chaosnet",
	"2053" => "X.25 Level 3",
	"2054" => "ARP",
	"2055" => "XNS Compatability",
	"2056" => "Frame Relay ARP",
	"2076" => "Symbolics Private",
	"2184" => "Xyplex",
	"2304" => "Ungermann-Bass net debugr",
	"2560" => "Xerox IEEE802.3 PUP",
	"2561" => "PUP Addr Trans",
	"2989" => "Banyan VINES",
	"2990" => "VINES Loopback",
	"2991" => "VINES Echo",
	"4096" => "Berkeley Trailer nego",
	"4097" => "Berkeley Trailer encap/IP",
	"5632" => "TRILL",
	"16962" => "PCS Basic Block Protocol",
	"21000" => "BBN Simnet",
	"24576" => "DEC Unassigned",
	"24577" => "DEC MOP Dump/Load",
	"24578" => "DEC MOP Remote Console",
	"24579" => "DEC DECNET Phase IV Route",
	"24580" => "DEC LAT",
	"24581" => "DEC Diagnostic Protocol",
	"24582" => "DEC Customer Protocol",
	"24583" => "DEC LAVC, SCA",
	"24584" => "DEC Unassigned",
	"24592" => "3Com Corporation",
	"25944" => "Trans Ether Bridging",
	"25945" => "Raw Frame Relay",
	"28672" => "Ungermann-Bass download",
	"28674" => "Ungermann-Bass dia/loop",
	"28704" => "LRT",
	"28720" => "Proteon",
	"28724" => "Cabletron",
	"32771" => "Cronus VLN",
	"32772" => "Cronus Direct",
	"32773" => "HP Probe",
	"32774" => "Nestar",
	"32776" => "AT&T",
	"32784" => "Excelan",
	"32787" => "SGI diagnostics",
	"32788" => "SGI network games",
	"32789" => "SGI reserved",
	"32790" => "SGI bounce server",
	"32793" => "Apollo Domain",
	"32814" => "Tymshare",
	"32815" => "Tigan",
	"32821" => "RARP",
	"32822" => "Aeonic Systems",
	"32824" => "DEC LANBridge",
	"32825" => "DEC Unassigned",
	"32829" => "DEC Ethernet Encryption",
	"32830" => "DEC Unassigned",
	"32831" => "DEC LAN Traffic Monitor",
	"32832" => "DEC Unassigned",
	"32836" => "Planning Research Corp",
	"32838" => "AT&T",
	"32839" => "AT&T",
	"32841" => "ExperData",
	"32859" => "Stanford V Kernel exp",
	"32860" => "Stanford V Kernel prod",
	"32861" => "Evans & Sutherland",
	"32864" => "Little Machines",
	"32866" => "Counterpoint Computers",
	"32871" => "Veeco Integrated Auto",
	"32872" => "General Dynamics",
	"32873" => "AT&T",
	"32874" => "Autophon",
	"32876" => "ComDesign",
	"32877" => "Computgraphic Corp",
	"32878" => "Landmark Graphics Corp",
	"32890" => "Matra",
	"32891" => "Dansk Data Elektronik",
	"32892" => "Merit Internodal",
	"32893" => "Vitalink Communications",
	"32896" => "Vitalink TransLAN III",
	"32897" => "Counterpoint Computers",
	"32923" => "Appletalk",
	"32924" => "Datability",
	"32927" => "Spider Systems Ltd",
	"32931" => "Nixdorf Computerd",
	"32932" => "Siemens Gammasonics Inc",
	"32960" => "DCA Data Exchange Cluster",
	"32964" => "Banyan Systems",
	"32965" => "Banyan Systems",
	"32966" => "Pacer Software",
	"32967" => "Applitek Corporation",
	"32968" => "Intergraph Corporation",
	"32973" => "Harris Corporation",
	"32975" => "Taylor Instrument",
	"32979" => "Rosemount Corporation",
	"32981" => "IBM SNA Service on Ether",
	"32989" => "Varian Associates",
	"32990" => "Integrated Solutions TRFS",
	"32992" => "Allen-Bradley",
	"32996" => "Datability",
	"33010" => "Retix",
	"33011" => "AppleTalk AARP",
	"33012" => "Kinetics",
	"33015" => "Apollo Computer",
	"33023" => "Wellfleet Communications",
	"33024" => "VLAN",
	"33025" => "Wellfleet Communications",
	"33031" => "Symbolics Private",
	"33072" => "Hayes Microcomputers",
	"33073" => "VG Laboratory Systems",
	"33074" => "Bridge Communications",
	"33079" => "Novell",
	"33081" => "KTI",
	"33100" => "IPv6",
	"34527" => "ATOMIC",
	"34667" => "TCP/IP Compression",
	"34668" => "IP Autonomous Systems",
	"34669" => "MPLS",
	"34915" => "PPPoE Discovery Stage",
	"34916" => "PPPoE Session Stage",
	"34958" => "802.1X",
	"34984" => "802.1Q",
	"35015" => "802.11",
	"35020" => "LLDP",
	"35045" => "802.1AE",
	"35061" => "MVRP",
	"35062" => "MMRP",
	"35085" => "802.11r",
	"35095" => "802.21",
	"35113" => "802.1Qbe",
	"35131" => "TRILL FGL",
	"35136" => "802.1Qbg",
	"35142" => "TRILL RBridge Channel",
	"36864" => "Loopback",
	"65535" => "Reserved"
     }
  @@tcp_type_mapper = {
        "1" => "TCPMUX",
        "5" => "RJE",
        "7" => "ECHO",
        "17" => "DAYTIME",
        "18" => "MSP",
        "19" => "CHARGEN",
        "20" => "FTP",
        "21" => "FTP",
        "22" => "SSH",
        "23" => "Telnet",
        "25" => "SMTP",
        "29" => "MSG",
        "37" => "Time",
        "42" => "Nameserv",
        "49" => "TACAS",
        "53" => "DNS",
        "80" => "HTTP",
        "109" => "POP2",
        "110" => "POP3",
        "115" => "SFTP",
        "118" => "SQL",
        "119" => "NNTP",
        "139" => "NETBIOS",
        "143" => "IMAP4",
        "179" => "BGP",
        "190" => "GACP",
        "194" => "IRC",
        "197" => "DLS",
        "389" => "LDAP",
        "443" => "HTTPS",
        "444" => "SNPP",
        "458" => "QuickTime",
        "515" => "LDP",
        "540" => "UUCP",
        "546" => "DHCPClient",
        "547" => "DHCPServer",
        "569" => "MSN"
     }
  @@udp_type_mapper = {
        "1" => "TCPMUX",
        "5" => "RJE",
        "7" => "ECHO",
        "18" => "MSP",
        "19" => "CHARGEN",
        "29" => "MSG",
        "37" => "Time",
        "42" => "Nameserv",
        "49" => "TACAS",
        "53" => "DNS",
        "67" => "BOOTP",
        "69" => "TFTP",
        "80" => "HTTP",
        "115" => "SFTP",
        "118" => "SQL",
        "123" => "NTP",
        "161" => "SNMP",
        "458" => "QuickTime",
        "514" => "syslog",
        "515" => "LDP",
        "540" => "UUCP",
        "546" => "DHCPClient",
        "547" => "DHCPServer",
        "569" => "MSN"
     }

  def self.send_udpjson(sflow)
  # remap hash-keys with prefix "sflow_"
      mappings = {"agent_address" => "sflow_agent_address",
                  "sampling_rate" => "sflow_sampling_rate",
                  "i_iface_value" => "sflow_i_iface_value",
                  "o_iface_value" => "sflow_o_iface_value",
                  "eth_type" => "sflow_eth_type",
                  "vlan_src" => "sflow_vlan_src",
                  "vlan_dst" => "sflow_vlan_dst",
                  "ipv4_src" => "sflow_ipv4_src",
                  "ipv4_dst" => "sflow_ipv4_dst",
                  "ipv4_type" => "sflow_ipv4_type",
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
      if sflow['ipv4_type']
        if @@ipv4_type_mapper[sflow['ipv4_type'].to_s]
          ipv4_type = {
            "sflow_ipv4_type" => @@ipv4_type_mapper[sflow['ipv4_type'].to_s]
          }
        else
          ipv4_type = {
            "sflow_ipv4_type" => sflow['ipv4_type'].to_s
          }
        end
        prefixed_sflow.merge!(ipv4_type)
      end    
      if sflow['eth_type']
        if @@eth_type_mapper[sflow['eth_type'].to_s]
          eth_type = {
            "sflow_eth_type" => @@eth_type_mapper[sflow['eth_type'].to_s]
          }
        else
          eth_type = {
            "sflow_eth_type" => sflow['eth_type'].to_s
          }
        end
        prefixed_sflow.merge!(eth_type)
      end
      if sflow['tcp_src_port'] and sflow['tcp_dst_port']
        if @@tcp_type_mapper[sflow['tcp_src_port'].to_s]
          tcp_src_port = {
            "sflow_tcp_src_port" => @@tcp_type_mapper[sflow['tcp_src_port'].to_s]
          }
        else
          tcp_src_port = {
            "sflow_tcp_src_port" => sflow['tcp_src_port'].to_s
          }
        end
	if @@tcp_type_mapper[sflow['tcp_dst_port'].to_s]
	  tcp_dst_port = {
	    "sflow_tcp_dst_port" => @@tcp_type_mapper[sflow['tcp_dst_port'].to_s]
	  }
	else
	  tcp_dst_port = {
	    "sflow_tcp_dst_port" => sflow['tcp_dst_port'].to_s
	  }
        end
        prefixed_sflow.merge!(tcp_src_port)
        prefixed_sflow.merge!(tcp_dst_port)
      end
      if sflow['udp_src_port'] and sflow['udp_dst_port']
        if @@udp_type_mapper[sflow['udp_src_port'].to_s]
          udp_src_port = {
            "sflow_udp_src_port" => @@udp_type_mapper[sflow['udp_src_port'].to_s]
          }
        else
          udp_src_port = {
            "sflow_udp_src_port" => sflow['udp_src_port'].to_s
          }
        end
	if @@udp_type_mapper[sflow['udp_dst_port'].to_s]
	  udp_dst_port = {
	    "sflow_udp_dst_port" => @@udp_type_mapper[sflow['udp_dst_port'].to_s]
	  }
	else
	  udp_dst_port = {
	    "sflow_udp_dst_port" => sflow['udp_dst_port'].to_s
	  }
        end
        prefixed_sflow.merge!(udp_src_port)
        prefixed_sflow.merge!(udp_dst_port)
      end
      puts prefixed_sflow
      $logstash.send(prefixed_sflow.to_json, 0)

  end

end
