.PHONY: cscope.files format uncrustify

CFLAGS = -g -Wall -Werror

all: initiator responder

clean:
	@ rm -rf initiator.dSYM responder.dSYM
	@ rm -f initiator responder
	@ rm -f cscope.*
	@ rm -f TAGS
	@ rm -f *~

cscope.files:
	@ find . -type f -name '*.[ch]' > cscope.files

cscope: cscope.files
	@ cscope -bq

ctags: cscope.files
	@ ctags -e -L cscope.files

format:
	@ clang-format -style=file -i initiator.c responder.c

initiator: initiator.c
	@ $(CC) $(CFLAGS) initiator.c -o initiator

responder: responder.c
	@ $(CC) $(CFLAGS) responder.c -o responder

uncrustify:
	@ uncrustify --replace --no-backup -l C -c .uncrustify.cfg initiator.c responder.c
