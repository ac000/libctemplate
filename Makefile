CFLAGS = -I .

template: main.o libctemplate.a
	$(CC) $(CFLAGS) -o template -L . main.o -lctemplate

libctemplate.a: ctemplate.o
	ar r libctemplate.a ctemplate.o
	ranlib libctemplate.a

ctemplate.o: ctemplate.c ctemplate.h

main.o: main.c ctemplate.h

clean:
	rm -f *.o *.a template

test:
	cd t; ./test.sh
