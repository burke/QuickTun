.PHONY: default clean
default: quicktun quicktun.keypair

quicktun: src/proto.nacltai.c
	cc -o $@ $< -lsodium

quicktun.keypair: src/keypair.c
	cc -o $@ $< -lsodium

clean:
	rm -rf quicktun quicktun.keypair
