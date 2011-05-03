CFLAGS = -I .

libctemplate: ctemplate.o
	$(CC) $(CFLAGS) -O2 -shared -Wl,-soname,libctemplate.so.1 -o libctemplate.so.1.4.0 ctemplate.o -lc

ctemplate.o: ctemplate.c ctemplate.h
	$(CC) $(CFLAGS) -fpic -O2 -c ctemplate.c

clean:
	rm -f *.o libctemplate.so.1.4.0
