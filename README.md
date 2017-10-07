[![Build Status](https://semaphoreci.com/api/v1/onyxrev/ethereum_wallet_elixir/branches/master/badge.svg)](https://semaphoreci.com/onyxrev/ethereum_wallet_elixir)

# Ethereum Wallet

Generate Ethereum public addresses and private keys using Elixir with C bindings to crypto libraries.

## Usage

Pretty straightforward. No support for BIP39/44 or anything at this time.

```elixir
iex(1)> Ethereum.Wallet.generate
%Ethereum.Wallet{
  address: "0x9ec5ea8bb6f486fd4cde94d38fee18f2f3e71525",
  private_key: "0625d3bf685351d3ff2374a4368438b28315b64adb6e44b122759682f3868720"
}
```
