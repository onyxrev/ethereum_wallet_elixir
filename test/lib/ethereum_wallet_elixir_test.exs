defmodule EthereumWalletTest do
  use ExUnit.Case, async: false

  import Mock

  @crypto_lib_public_key Base.decode16!(
    "04DABE36A15ABBAB3875E4BF9E1C866691A934F0509334669BC92443869E3396EEFB837" <>
      "C0C6839E1C832575E992004A9B83D6B7DF1BD8DFACFCB97F0183D0ADF49"
  )
  @crypto_lib_private_key Base.decode16!(
    "B18DB9C9C53F7114248CB64F33980F1BAC4754127CC13C923BA8B1D7AB42B1B4"
  )

  test "it generates a deterministic set of private keys for a given ECDH secp256k1 input" do
    with_mock Ethereum.Wallet.Crypto, [
      generate_pair: fn() -> {@crypto_lib_public_key, @crypto_lib_private_key} end
    ] do
      assert Ethereum.Wallet.generate() == %Ethereum.Wallet{
        address: "0xd73ae0e9be10efe28ef6c81248c3b2dcb108736e",
        private_key: "b18db9c9c53f7114248cb64f33980f1bac4754127cc13c923ba8b1d7ab42b1b4"
      }
    end
  end
end
