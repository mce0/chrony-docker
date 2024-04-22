#!/bin/sh

CHRONY_CONF_FILE="/etc/chrony/chrony.conf"

# confirm correct permissions on chrony run directory
if [ -d /run/chrony ]; then
  chown -R chrony:chrony /run/chrony
  chmod o-rx /run/chrony
  # remove previous pid file if it exist
  rm -f /var/run/chrony/chronyd.pid
fi

# confirm correct permissions on chrony variable state directory
if [ -d /var/lib/chrony ]; then
  chown -R chrony:chrony /var/lib/chrony
fi

# chrony.conf from GrapheneOS with some modifications
curl https://raw.githubusercontent.com/GrapheneOS/infrastructure/main/chrony.conf | tee ${CHRONY_CONF_FILE}
sed -i 's/leapsectz/# leapsectz/g' ${CHRONY_CONF_FILE}
sed -i 's/cmdport/# cmdport/g' ${CHRONY_CONF_FILE}
echo allow all | tee -a ${CHRONY_CONF_FILE}

## startup chronyd in the foreground
exec /usr/sbin/chronyd -u chrony -d -x