#!/bin/bash
# rdiff-backup restoration test simulation
# By Robbie Ferguson

# CONFIG - No trailing slashes
backup_location=/location/of/backup # your rdiff-backup root folder
testfilesourcedir=/etc # the folder, located within backup_location, which contains the file we'll use to test restore
testfilesourcefile=fstab # a file within backup_location/testfilesourcedir to use for testing

# No user configurable parts beyond this point
echo Running rdiff-backup Restoration Simulation...
echo ""

testfilesource=$testfilesourcedir/$testfilesourcefile

printf "Test 1 - Verify rdiff-backup Integrity... "
`which rdiff-backup` --verify $backup_location > /dev/null 2>&1
error=$?
if [ "$error" = "0" ]; then
  echo PASS
else
  echo FAIL
fi
echo ""

printf "Test 2 - Direct Copy From Current Set... "
cp -a $backup_location$testfilesource /tmp/ > /dev/null 2>&1
testfiledest=/tmp/$testfilesourcefile
if [ -e $testfiledest ]; then
  echo PASS
  rm $testfiledest
else
  echo FAIL
  error=1
fi
echo ""

printf "Test 3 - Restore From Current Set... "
`which rdiff-backup` -r now "$backup_location$testfilesource" "/tmp/$testfilesourcefile" > /dev/null 2>&1
testfiledest=/tmp/$testfilesourcefile
if [ -e $testfiledest ]; then
  echo PASS
  rm $testfiledest
else
  echo FAIL
  error=1
fi
echo ""

testdate=$(date --date="1 month ago" +"%Y/%m/%d")
printf "Test 4 - Restore From $testdate... "
`which rdiff-backup` -r $testdate "$backup_location$testfilesource" "/tmp/$testfilesourcefile" > /dev/null 2>&1
testfiledest=/tmp/$testfilesourcefile
if [ -e $testfiledest ]; then
  echo PASS
  rm $testfiledest
else
  echo FAIL
  error=1
fi
echo ""

testdate=$(date --date="6 months ago" +"%Y/%m/%d")
printf "Test 5 - Restore From $testdate... "
`which rdiff-backup` -r $testdate "$backup_location$testfilesource" "/tmp/$testfilesourcefile" > /dev/null 2>&1
testfiledest=/tmp/$testfilesourcefile
if [ -e $testfiledest ]; then
  echo PASS
  rm $testfiledest
else
  echo FAIL
  error=1
fi
echo ""

testdate=$(date --date="12 months ago" +"%Y/%m/%d")
printf "Test 6 - Restore From $testdate... "
`which rdiff-backup` -r $testdate "$backup_location$testfilesource" "/tmp/$testfilesourcefile" > /dev/null 2>&1
testfiledest=/tmp/$testfilesourcefile
if [ -e $testfiledest ]; then
  echo PASS
  rm $testfiledest
else
  echo FAIL
  error=1
fi
echo ""

testdate=$(date --date="18 months ago" +"%Y/%m/%d")
printf "Test 7 - Restore From $testdate... "
`which rdiff-backup` -r $testdate "$backup_location$testfilesource" "/tmp/$testfilesourcefile" > /dev/null 2>&1
testfiledest=/tmp/$testfilesourcefile
if [ -e $testfiledest ]; then
  echo PASS
  rm $testfiledest
else
  echo FAIL
  error=1
fi
