PREFIX?= /usr
BINDIR?= $(PREFIX)/bin

CFLAGS= -std=c99 -Wall -D_POSIX_C_SOURCE=200809L -Os

SRC= exctoi.c
OBJ= ${SRC:.c=.o}

.c.o:
	${CC} -c ${CFLAGS} ${INCFLAGS} $<

exctoi: ${OBJ}
	${CC} -o $@ ${OBJ} ${LIBS}

install: exctoi
	install -Dm 755 exctoi $(BINDIR)/exctoi

uninstall:
	rm -f $(BINDIR)/exctoi

clean:
	rm -f exctoi *.o
