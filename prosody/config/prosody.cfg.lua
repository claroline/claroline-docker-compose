daemonize = false;

cross_domain_bosh = true
consider_bosh_secure = true

admins = { }

modules_enabled = {
		"roster"; -- Allow users to have a roster. Recommended ;)
		"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections
		"dialback"; -- s2s dialback support
		"disco"; -- Service discovery
		"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
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
		-- Just testing gajim/jabber
		"s2s";
};

allow_registration = true;

c2s_require_encryption = false

s2s_secure_auth = false

--pidfile = "/var/run/prosody/prosody.pid"

authentication = "internal_plain"

log = {
    {levels = {min = "info"}, to = "console"};
}

VirtualHost "claroline.loc" -- Todo this needs to be called from a variable

VirtualHost "localhost"

Component "conference.prosody" "muc"
	name = "The claroline chatroom server"
		restrict_room_creation = false
