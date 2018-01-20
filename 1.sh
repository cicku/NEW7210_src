LASTLINE=$(tail -1 /etc/rc.d/rc.sysinit);
STR="route";
echo "$LASTLINE" | grep -q "$STR";
until [[ $? -eq 0 ]];do
  sed -i '$d' /etc/rc.d/rc.sysinit;
  LASTLINE=$(tail -1 /etc/rc.d/rc.sysinit);
  echo "$LASTLINE" | grep -q "$STR";
done;
echo "echo \"[Terminal]\" >/var/vendor" >>/etc/rc.d/rc.sysinit;
echo "echo \"type=NEW7210\" >>/var/vendor" >>/etc/rc.d/rc.sysinit;
echo "echo \"[Local Machine]\" >>/var/vendor" >>/etc/rc.d/rc.sysinit;
echo "echo \"SN=12345678\" >>/var/vendor" >>/etc/rc.d/rc.sysinit;
echo "echo \"CID=0\" >>/var/vendor" >>/etc/rc.d/rc.sysinit;
sync;
su - idt <<EOF;
reboot;
