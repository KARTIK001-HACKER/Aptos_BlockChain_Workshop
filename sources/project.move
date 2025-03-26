module MyModule::ArtLicensing {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing an art license.
    struct License has key, store {
        artist: address,    // Artist's address
        price: u64,         // License price in AptosCoin
    }

    /// Function to create an art license.
    public fun create_license(creator: &signer, price: u64) {
        let license = License {
            artist: signer::address_of(creator),
            price,
        };
        move_to(creator, license);
    }

    /// Function to purchase an art license.
    public fun purchase_license(buyer: &signer, artist: address) acquires License {
        let license = borrow_global<License>(artist);

        // Transfer payment from buyer to artist
        coin::transfer<AptosCoin>(buyer, artist, license.price);
    }
}
