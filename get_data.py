#!/opt/local/bin/python2.7
"""
    ***** BEGIN LICENSE BLOCK *****
    
    Copyright © 2011 Simon Kornblith
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    ***** END LICENSE BLOCK *****
"""

import os, glob, re, string
from xml.etree.ElementTree import ElementTree, tostring

STYLES_PATH = 'styles/'

attrs = {"prefix":{}, "suffix":{}, "delimiter":{}}
group_lengths = {}

# Iterate over styles
for file in glob.glob(os.path.join(STYLES_PATH, '*.csl')):
	# Generate XML tree
	tree = ElementTree()
	tree.parse(file)
	
	# Perform substitution on macros
	macros = {}
	for parent in tree.findall('[{http://purl.org/net/xbiblio/csl}macro]'):
		for el in parent.findall('{http://purl.org/net/xbiblio/csl}macro'):
			macros[el.get("name")] = list(el)
			parent.remove(el)
	
	for el in tree.findall('.//{http://purl.org/net/xbiblio/csl}text'):
		macro_name = el.get("macro")
		if macro_name is not None:
			el.tag = '{http://purl.org/net/xbiblio/csl}group'
			el.extend(macros[macro_name])
	
	# Collapse groups
	for el in tree.findall('.//{http://purl.org/net/xbiblio/csl}group'):
		children = list(el)
		nchildren = len(children)
		if nchildren == 0:
			continue
		elif nchildren == 1:
			for affix in ["prefix", "suffix"]:
				parent_affix = el.get(affix)
				child_affix = children[0].get(affix)
				if parent_affix:
					if child_affix:
						if affix == "prefix":
							children[0].set(affix, parent_affix+child_affix)
						else:
							children[0].set(affix, child_affix+parent_affix)
					else:
						children[0].set(affix, parent_affix)
			
			el.clear()
			el.attrib = children[0].attrib
			el.tag = children[0].tag
			el.extend(list(children[0]))
		else:
			if nchildren in group_lengths:
				group_lengths[nchildren] += 1
			else:
				group_lengths[nchildren] = 1
	
	# Get prefixes and suffixes and count occurences
	allElements = tree.findall('.//{http://purl.org/net/xbiblio/csl}text')
	allElements.extend(tree.findall('.//{http://purl.org/net/xbiblio/csl}group'))
	for el in allElements:
		if el.tag == "{http://purl.org/net/xbiblio/csl}text" and not el.get("variable", None):
			continue
		
		for attr in ["prefix", "suffix"]:
			attr_value = el.get(attr, "")
			
			if el.get("quotes") == "true":
				attr_value += '"'
			
			if re.match('^[\x20-\x2F\x3A-\x40\x5B-\x60\x7B-\x7F]*$', attr_value) \
					and not re.search(' {3}', attr_value) and attr_value.find("\n") == -1:
				if attr_value in attrs[attr]:
					attrs[attr][attr_value] += 1
				else:
					attrs[attr][attr_value] = 1
	
	# Get delimiters and count occurences
	for el in tree.findall('.//{http://purl.org/net/xbiblio/csl}group'):
		attr_value = el.get("delimiter", "")
	
		if attr_value in attrs["delimiter"]:
			attrs["delimiter"][attr_value] += 1
		else:
			attrs["delimiter"][attr_value] = 1

print(group_lengths)

# Output data in Scheme
for attr in attrs:
	print("(define "+attr+"-list (list ")
	for attr_value, number_occurrences in attrs[attr].items():
		if attr_value == "":
			print('\t(pair \'() '+str(number_occurrences)+')')
		else:
			print('\t(pair (list "'+string.join([attr_value[i].replace('"', '\\"') for i in range(len(attr_value))], '" "')+'") '+str(number_occurrences)+')')
	print("))")