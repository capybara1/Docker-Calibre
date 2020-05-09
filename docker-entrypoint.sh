#!/bin/sh

LIBRARY_PATH="/data/${LIBRARY:-default}"

if [ ! -f "$LIBRARY_PATH/metadata.db" ]; then
	mkdir -p "$LIBRARY_PATH"
	/opt/calibre/calibredb add /tmp/welcome.html --library-path "$LIBRARY_PATH"
fi

if [ ! -f /data/users.sqlite ]; then
	expect <<-EOF
	spawn /opt/calibre/calibre-server --userdb /data/users.sqlite --manage-users
	expect "What do you want to do?"
	send "1\r"
	expect "Enter the username"
	send "${USERNAME:-default}\r"
	expect "Enter the new password"
	send "${PASSWORD:-default}\r"
	expect "Re-enter the new password"
	send "${PASSWORD:-default}\r"
	expect eof
	EOF
fi

exec /opt/calibre/calibre-server \
	--log /dev/stdout \
	--listen-on 0.0.0.0 --port 8080 \
	--enable-auth --userdb /data/users.sqlite \
	"$LIBRARY_PATH"
