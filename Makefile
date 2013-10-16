#  Copyright (c) 2005-2006  Volker Grabsch, Matthias Pohl
#
#  Permission is hereby granted, free of charge, to any person obtaining
#  a copy of this software and associated documentation files (the
#  "Software"), to deal in the Software without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of the Software, and to
#  permit persons to whom the Software is furnished to do so, subject
#  to the following conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
# 
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


VERSION = 2.0
RESULT = crontab
SOURCES = $(wildcard crontab-*)
REAL_PWD = $(shell pwd)
DIST_SOURCES = Makefile README README.de

$(RESULT): $(SOURCES) Makefile
	# create crontab
	( \
	echo "#________________________________________" ; \
	echo "#  This file is automatically generated.  DO NOT EDIT!" ; \
	echo "#" ; \
	echo "#________________________________________" ; \
	echo "#+++ update crontab +++" ; \
	echo "#" ; \
	echo "* * * * *  cd '$(REAL_PWD)' && '$(MAKE)' >/dev/null" ; \
	for FILE in $(SOURCES) ; do \
	    NAME=`echo "$$FILE" | sed "s,^crontab-,,"` ; \
	    echo "#" ; \
	    echo "#________________________________________" ; \
	    echo "#+++ crontab of $$NAME +++" ; \
	    echo "#" ; \
	    sed "s,@NAME@,$$NAME,g; s,@PWD@,$(REAL_PWD),g" < "$$FILE" ; \
	done \
	) > '$@'
	# install crontab
	crontab '$@'

dist:
	tar -cv $(DIST_SOURCES) | gzip -9 > make-crontab-$(VERSION).tgz
