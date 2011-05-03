CFLAGS = -I ..

all: fact printenv

fact:  fact.o ../libctemplate.a
	$(CC) -o fact -L .. fact.o -lctemplate

printenv:  printenv.o ../libctemplate.a
	$(CC) -o printenv -L .. printenv.o -lctemplate

fact.o: fact.c ../ctemplate.h

printenv.o: printenv.c ../ctemplate.h

clean:
	rm -f *.o fact printenv
