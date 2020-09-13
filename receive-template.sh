#!/bin/bash
echo ""
echo "ZDOPACK - Receive Script"
echo ""

# Find our PACKED DATA
ARCHIVE=`awk '/^__ZDOPACK_DATA_BELOW__/ {print NR + 1; exit 0; }' $0`


tail -n+$ARCHIVE $0 > mimefile
uudecode -o file.pax mimefile

pax -rvf file.pax

# Now we can work with the new folder :)
echo "Restored in 'distfolder'"
echo "Put your installation steps here..."

exit 0

__ZDOPACK_DATA_BELOW__
