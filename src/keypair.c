/* MIT License */
#include <sodium/crypto_box_curve25519xsalsa20poly1305.h>
#include <sodium/crypto_scalarmult_curve25519.h>
#include <stdio.h>

int main() {
	unsigned char cpublickey[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES];
	unsigned char csecretkey[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES];
	int i;

	if (0 != crypto_box_curve25519xsalsa20poly1305_keypair(cpublickey, csecretkey)) {
		perror("crypto_box_keypair failed");
		return 1;
	}

	printf("Secret: ");
	for (i = 0; i < crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES; i++)
		printf("%02x", csecretkey[i]);
	printf("\n");

	printf("Public: ");
	for (i = 0; i < crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES; i++)
		printf("%02x", cpublickey[i]);
	printf("\n");

	return 0;
}
