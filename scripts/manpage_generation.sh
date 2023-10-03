#!/bin/bash
# Generate a file with convert2rhel synopsis for argparse-manpage
PYTHONPATH="/usr/lib/python3/dist-packages/:$PYTHONPATH" /usr/bin/python3.10 -c 'import sys;print(sys.path)'
PYTHONPATH="/usr/lib/python3/dist-packages/:$PYTHONPATH" /usr/bin/python3.10 -c 'from convert2rhel import toolopts; print("[synopsis]\n."+toolopts.CLI.usage())' > man/synopsis
echo "HERE WE ARE"

 Directory to store the generated manpages
MANPAGE_DIR="man"

VER=$(grep -oP '^Version:\s+\K\S+' packaging/convert2rhel.spec)
/usr/bin/python3.10 -m pip install argparse-manpage six pexpect

echo "THERE WE GO"

# Generate the manpage using argparse-manpage
PYTHONPATH=. /usr/bin/python3.10 /usr/bin/argparse-manpage --pyfile man/__init__.py --function get_parser --manual-title="General Commands Manual" --description="Automates the conversion of Red Hat Enterprise
Linux derivative distributions to Red Hat Enterprise Linux." --project-name "convert2rhel $VER" --prog="convert2rhel" --include man/distribution --include man/synopsis > "$MANPAGE_DIR/convert2rhel.8"

# # Directory to store the generated manpages
# MANPAGE_DIR="man"

# VER=$(grep -oP '^Version:\s+\K\S+' packaging/convert2rhel.spec)

# # Generate a file with convert2rhel synopsis for argparse-manpage
# python -c 'from convert2rhel import toolopts; print("[synopsis]\n."+toolopts.CLI.usage())' > man/synopsis

# # Generate the manpage using argparse-manpage
# PYTHONPATH=. argparse-manpage --pyfile man/__init__.py --function get_parser --manual-title="General Commands Manual" --description="Automates the conversion of Red Hat Enterprise Linux derivative distributions to Red Hat Enterprise Linux." --project-name "convert2rhel $VER" --prog="convert2rhel" --include man/distribution --include man/synopsis > "$MANPAGE_DIR/convert2rhel.8"
