#!/bin/bash
set -e

# On first run, perform setup for admin user
if [ ! -f /terraria/tshocksetupdone ]; then
    echo "First run: Running TShock setup to create admin user."
    # Start the server in the background
    mono --runtime=v4.0 TerrariaServer.exe -configpath . -worldpath . -autocreate 2 -worldname "RenderWorld" -port 7777 > tshock.log 2>&1 &
    TSPID=$!
    # Wait for TShock to finish startup (look for "Type 'help' for a list of commands.")
    until grep -q "Type 'help' for a list of commands." tshock.log; do
      sleep 2
    done
    sleep 2
    # Register the admin user and add to superadmin
    expect <<EOF
spawn telnet localhost 7777
expect "You are not logged in."
send "/register dandevss admindan\n"
expect "Account registered successfully"
send "/user addgroup dandevss superadmin\n"
expect "added to group"
send "exit\n"
EOF
    touch /terraria/tshocksetupdone
    kill $TSPID
    sleep 3
fi

# Start server normally
exec mono --runtime=v4.0 TerrariaServer.exe -configpath . -worldpath . -autocreate 2 -worldname "RenderWorld" -port 7777