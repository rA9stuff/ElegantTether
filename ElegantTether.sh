# modified by @mosk_i (Matty) to add more automation
echo "entering pwndfu mode"
cd ipwndfu
./ipwndfu -p
echo "removing sigchecks"
python rmsigchks.py
cd ..
rm -rf bm.plist shsh.shsh ibec.* ibss.*
nonce=$(./bin/igetnonce | grep "ApNonce=.*" -o | cut -c 9-)
echo "Your current ApNonce is $nonce"

#grep ecid
ecid=$(./bin/igetnonce | grep "ECID=.*" -o | cut -c 6-)
echo "Your ECID is $ecid"

model=$(./bin/igetnonce | grep "iP.* in" -o | rev | cut -c 4- | rev)
bconfig=$(./bin/igetnonce | grep "device as .*, " -o | rev | cut -c 3- | rev | cut -c 11-)
dbconfig=$(./bin/igetnonce | grep "device as .*, " -o | rev | cut -c 5- | rev | cut -c 11-)
echo "Your device is an $model"
echo "Your boardconfig is $bconfig"

#Getting 10.3.3 firmware URL so we can partial zip download ibss/ibec/buildmanifest
IPSWURL=$(curl https://api.ipsw.me/v2.1/$model/latest/url/)
echo $IPSWURL
pzblist=$(bin/pzb download $IPSWURL BuildManifest.plist bm12.plist)
echo $pzblist

ibecpath=$(cat bm12.plist | grep "iBEC..*.RELEASE.im4p" -m 1 | cut -c 15- | rev | cut -c 10- | rev)
ibsspath=$(cat bm12.plist | grep "iBSS..*.RELEASE.im4p" -m 1 | cut -c 15- | rev | cut -c 10- | rev)

ibecdownload=$(bin/pzb download $IPSWURL $ibecpath ibec.im4p)
ibssdownload=$(bin/pzb download $IPSWURL $ibsspath ibss.im4p)
echo $ibssdownload
echo $ibecdownload

LIPSWURL=$(curl https://api.ipsw.me/v2.1/$model/14B100/url/)
echo $LIPSWURL
./bin/pzb download $LIPSWURL Firmware/Mav7Mav8-7.01.00.Release.bbfw bb.bbfw
./bin/pzb download $LIPSWURL Firmware/all_flash/all_flash.$bconfig.production/sep-firmware.$dbconfig.RELEASE.im4p sep.im4p

#tsschecker
./bin/tsschecker -B $bconfig -d $model -s -e $ecid -m bm12.plist --apnonce $nonce
echo "*SIGNING iBSS*"
#sign
mv *.shsh* shsh.shsh
bin/img4tool -s shsh.shsh -c ibss.signed -p ibss.im4p >/dev/null
sleep 0.3
echo "*SIGNING iBEC*"
bin/img4tool -s shsh.shsh -c ibec.signed -p ibec.im4p >/dev/null
sleep 0.3
echo "*SIGNING COMPLETE!*"
sleep 0.2
echo "*UPLOADING SIGNED iBSS*"
bin/irecovery -f ibss.signed
echo "*UPLOADING SIGNED iBEC*"
bin/irecovery -f ibec.signed
sleep 2
echo "*READY TO RESTORE*"
# who doesn't like rgb
bin/irecovery -c "bgcolor 255 0 255" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 245 0 245" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 230 0 230" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 220 0 220" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 210 0 210" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 200 0 200" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 190 0 190" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 180 0 180" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 170 0 170" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 160 0 160" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 150 0 150" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 140 0 140" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 130 0 130" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 120 0 120" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 100 0 100" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 80 0 80" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 60 0 60" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 40 0 40" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 20 0 20" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 0 0 0" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 20 0 20" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 40 0 40" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 60 0 60" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 80 0 80" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 100 0 100" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 120 0 120" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 130 0 130" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 140 0 140" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 150 0 150" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 160 0 160" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 170 0 170" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 180 0 180" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 190 0 190" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 200 0 200" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 210 0 210" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 220 0 220" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 230 0 230" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 240 0 240" >/dev/null
sleep 0.04
bin/irecovery -c "bgcolor 255 0 255" >/dev/null
sleep 0.04
# clean up
rm -rf ibec.* ibss.* bm.plist
./bin/futurerestoretether -t shsh.shsh -s sep.im4p -m bm12.plist -p bm12.plist -b bb.bbfw 10.1.1tether.ipsw
# clean up 2
rm -rf shsh.shsh bm12.plist

