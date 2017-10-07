defmodule Ethereum.Wallet.Crypto do
  def generate_pair() do
    # all ethereum addresses are based on valid ECDH secp256k1 keys
    :crypto.generate_key(:ecdh, :secp256k1)
  end
end
