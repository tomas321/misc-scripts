#!/usr/bin/env python3
#
# convert XML file to JSON using the xmltojson library
#
# usage:
#   $0 XML_FILE
#

import json
import xmltodict
from sys import argv


with open(argv[1]) as f:
    xml_content = f.read()
    f.close()
    print(json.dumps(xmltodict.parse(xml_content), indent=4, sort_keys=True))
