admins = { }

modules_enabled = {
		"roster"; -- Allow users to have a roster. Recommended ;)
		"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections
		"dialback"; -- s2s dialback support
		"disco"; -- Service discovery
		"private"; -- Private XML storage (for room bookmarks, etc.)
		"vcard"; -- Allow users to set vCards
		"version"; -- Replies to server version requests
		"uptime"; -- Report how long server has been running
		"time"; -- Let others know the time here on this server
		"ping"; -- Replies to XMPP pings with pongs
		"pep"; -- Enables users to publish their mood, activity, playing music and more
		"register"; -- Allow users to register on this server using a client and change passwords
		"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
		"admin_telnet"; -- Opens telnet console interface on localhost port 5582
		"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
		"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
};

allow_registration = true;

daemonize = false;

ssl = {
   key = "/etc/prosody/certs/localhost.key";
   certificate = "/etc/prosody/certs/localhost.cert";
}

c2s_require_encryption = false

s2s_secure_auth = false

authentication = "internal_plain"

log = {
	-- Log files (change 'info' to 'debug' for debug logs):
	info = "/var/log/prosody/prosody.log";
	error = "/var/log/prosody/prosody.err";
    warn = "/var/log/prosody/prosody.warn";
	-- Syslog:
	{ levels = { "error" }; to = "syslog";  };
}

bosh_ports = {
                 {
                    port = 5280;
                    path = "http-bind";
                 },
                 {
                    port = 5281;
                    path = "http-bind";
                    ssl = ssl
                 }
              }

bosh_max_inactivity = 15
cross_domain_bosh = true

consider_bosh_secure = true

VirtualHost "claroline.loc"
	enabled = true
    ssl = ssl


Component "conference.prosody" "muc"
    name = "Claroline chat service"
        restrict_room_creation = false
Include "conf.d/*.cfg.lua"
