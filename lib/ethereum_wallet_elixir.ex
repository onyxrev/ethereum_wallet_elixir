# implementation generally based on the methods described here:
# https://kobl.one/blog/create-full-ethereum-keypair-and-address/
defmodule Ethereum.Wallet do
  @address_prefix "0x" # it is conventional to prepend "0x" to addresses
  @ksha_size 256 # ethereum uses keccak-256 to hash public keys (NOT SHA3!)
  @address_size 40 # ethereum uses last 40 characters as the address

  defstruct address: nil, private_key: nil

  # creates an Ethereum.Wallet struct containing a public address and the
  # corresponding private key for the address, both as hex strings.
  # %Ethereum.Wallet{
  #   address: "0x9ec5ea8bb6f486fd4cde94d38fee18f2f3e71525",
  #   private_key: "0625d3bf685351d3ff2374a4368438b28315b64adb6e44b122759682f3868720"
  # }
  def generate do
    {public_key, private_key} = Ethereum.Wallet.Crypto.generate_pair()

    struct(
      Ethereum.Wallet,
      %{
        address: public_key_to_ethereum_address(public_key),
        private_key: private_key_to_hex(private_key)
      }
    )
  end

  defp private_key_to_hex(private_key) do
    # NOTE: the blog post referenced above describes OpenSSL occasionally
    # generating private keys that begin with a nill 00 byte, but I have not
    # observed this happening when using the :crypto bindings in my testing. (I
    # did several million iterations), so I do not handle it
    private_key
    |> Base.encode16
    |> String.downcase
  end

  defp public_key_to_ethereum_address(public_key) do
    @address_prefix <> public_key_to_hex(public_key)
  end

  defp public_key_to_hex(public_key) do
    public_key
    |> strip_leading_byte()
    |> keccak_256sum()
    |> String.slice(@address_size * -1, @address_size)
    |> String.downcase
  end

  defp strip_leading_byte(data = [_head | tail]) when is_list(data), do: tail
  defp strip_leading_byte(data) when is_binary(data) do
    data
    |> :binary.bin_to_list
    |> strip_leading_byte()
    |> :binary.list_to_bin
  end

  defp keccak_256sum(data) do
    {:ok, hash} = :ksha3.hash(@ksha_size, data)
    Base.encode16(hash)
  end
end
