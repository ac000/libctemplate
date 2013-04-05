CFLAGS = -I .

all: libctemplate libctemplate-fcgi libctemplate-fcgx

libctemplate: ctemplate.o
	$(CC) $(CFLAGS) -O2 -shared -Wl,-soname,libctemplate.so.1 -o libctemplate.so.1.4.0 ctemplate.o -lc

libctemplate-fcgi: ctemplate-fcgi.o
	$(CC) $(CFLAGS) -O2 -shared -Wl,-soname,libctemplate-fcgi.so.1 -o libctemplate-fcgi.so.1.4.0 ctemplate-fcgi.o -lc

libctemplate-fcgx: ctemplate-fcgx.o
	$(CC) $(CFLAGS) -O2 -shared -Wl,-soname,libctemplate-fcgx.so.1 -o libctemplate-fcgx.so.1.4.0 ctemplate-fcgx.o -lc

ctemplate.o: ctemplate.c ctemplate.h
	$(CC) $(CFLAGS) -fpic -O2 -c ctemplate.c

ctemplate-fcgi.o: ctemplate.c ctemplate.h
	$(CC) $(CFLAGS) -D_HAVE_FCGI -fpic -O2 -c ctemplate.c -o ctemplate-fcgi.o

ctemplate-fcgx.o: ctemplate.c ctemplate.h
	$(CC) $(CFLAGS) -D_HAVE_FCGX -fpic -O2 -c ctemplate.c -o ctemplate-fcgx.o

clean:
	rm -f *.o libctemplate.so.1.4.0 libctemplate-fcgi.so.1.4.0 libctemplate-fcgx.so.1.4.0
