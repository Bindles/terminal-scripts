testappendz() {
# Step 1: Append another setting of "pull"=15 at the end of file.
echo "pull=15" >> file.ini

# Step 2: Overwrite speed=120 to become speed=170
sed -i 's/speed=120/speed=170/' file.ini

# Step 3: Append 24 at the end of distance array.
# Find the line that starts with "distance=" and add ",24" to the end of it.
#oustide rbacket:
#sed -i 's/distance=\(.*\)/distance=\1,24/' file.ini
#at end inside bracket
sed -i "s/distance=\[\(.*\)\]/distance=[\1,24\]/" file.ini
#beg
#sed -i "s/distance=\[\(.*\)\]/distance=[24,\1\]/" file.ini
#sed -i '$ a 24' ZARRAY
#sed -i '/^ZARRAY=(/ {$!{N;s/\n/ /g;}};s/ZARRAY=(.*)/ZARRAY=("\0"\n"24")/' file.ini
#sed -i '/^ZARRAY=(/ {$!{N;s/\n/ /g;}};s@ZARRAY=(.*)@ZARRAY=(\1\n"24")@' file.ini
#sed -i '/^ZARRAY=(/ {$!{N;s/\n/ /g;}};s/ZARRAY=(.*)/ZARRAY=(\1 "24")/' file.ini
#sed -i '/^ZARRAY=(/ {$!{N;s/\n/ /g;}};s/ZARRAY=(.*)/ZARRAY=(\1 "24")/' file.ini
#sed -i '/^ZARRAY=(/ {$!{N;s/\n/ /g;}};s/ZARRAY=(.*)/ZARRAY=(\1\n"24")/' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/\n/ /g;s/$/\n"24"/};s/ZARRAY=(.*)/ZARRAY=(\1)/' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/\n"24"/};s/ZARRAY=(.*)/ZARRAY=(\1)/' file.ini
#sed -i '/^ZARRAY=(/ {N;s/$/ "24"/};s/ZARRAY=(.*)/ZARRAY=(\1)/' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/ "24"/};s/ZARRAY=(.*)/ZARRAY=(\1)/' file.ini
#sed -i '/^ZARRAY=(/{:a;N;$!ba;s/\n/ /g;s/$/\n"24"/};s/ZARRAY=(.*)/ZARRAY=(\1)/' file.ini
#CHAMPION
sed -i '/^ZARRAY=(/{N;s/$/\n"24"/};s/ZARRAY=(.*)/ZARRAY=\0 "24"/' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/ "24"/};s/ZARRAY=(.*)/ZARRAY=(\1)/' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/ "24"/};s/^ZARRAY=(.*)/ZARRAY=\(\1 "24"\)/' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/ "24"/};s/^ZARRAY=(.*)/ZARRAY=\(\1 "24"\)/' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/ "24"/};s/^ZARRAY=(.*)/ZARRAY=(\1 "24")/' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/ "24"/};s@^ZARRAY=(.*)@ZARRAY=(\1 "24")@' file.ini
#sed -i '/^ZARRAY=(/{N;s/$/ "24"/};s@^ZARRAY=\(.*\)@ZARRAY=(\1 "24")@' file.ini
















# Step 4: Overwrite pizza with soda
# Find the line that contains "pizza:soda" and replace "pizza" with "grapes".
sed -i 's/\(.*\)pizza:soda/\1grapes:soda/' file.ini

# Step 5: Overwrite the values before the : in pairsings array to all become "grapes"
# Find all lines that contain ":soda" or ":cheese" and replace the word before the ":" with "grapes".
#sed -i 's/\(.*\):soda/grapes:soda/' file.ini
#sed -i 's/\(.*\):cheese/grapes:cheese/' file.ini
}
