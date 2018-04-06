# You can put your build options here
-include config.mk

all: libjsmn.a 

libjsmn.a: jsmn.o
	$(AR) rc $@ $^

%.o: %.c jsmn.h
	$(CC) -c $(CFLAGS) $< -o $@

myexample: myjson.o jsmn.aa libjsmn.aa test_strict_links
myjson.o: example/myjson.c
	$(CC) -c $(CFLAGS) $(LDFLAGS) $< -o example/$@
jsmn.aa: jsmn.c
	$(CC) -c $(CFLAGS) $(LDFLAGS) $< -o jsmn.o
libjsmn.aa:
	$(AR) rc libjsmn.a jsmn.o
test_strict_links: example/myjson.o
	$(CC) $(CFLAGS) $(LDFLAGS) $< libjsmn.a -o myexample

jsmn_test.o: jsmn_test.c libjsmn.a

simple_example: example/simple.o libjsmn.a
	$(CC) $(LDFLAGS) $^ -o $@

jsondump: example/jsondump.o libjsmn.a
	$(CC) $(LDFLAGS) $^ -o $@

clean:
	rm -f *.o example/*.o
	rm -f *.a *.so
	rm -f simple_example
	rm -f jsondump

.PHONY: all clean test

