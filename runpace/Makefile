PREFIX?= /usr
BINDIR?= $(PREFIX)/bin

CFLAGS= -std=c99 -Wall -D_POSIX_C_SOURCE=200809L -Os
LIBS= -lm

SRC= runpace.c
OBJ= ${SRC:.c=.o}

.c.o:
	${CC} -c ${CFLAGS} ${INCFLAGS} $<

runpace: ${OBJ}
	${CC} -o $@ ${OBJ} ${LIBS}

install: runpace
	install -Dm 755 runpace $(BINDIR)/runpace

uninstall:
	rm -f $(BINDIR)/runpace

clean:
	rm -f runpace *.o
