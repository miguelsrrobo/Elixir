defmodule Conta do

  defstruct usuario: Usuario, saldo: 1000
  @contas "contas.txt"

  def cadastrar(usuario) do
    #contas = busca_contas()
    case busca_contas_email(usuario.email) do
      nil ->
      binary = [%__MODULE__{usuario: usuario}] ++ busca_contas()
      |> :erlang.term_to_binary()
       File.write(@contas, binary)
       _ -> {:error, "Conta ja cadastrada"}
    end
  end

  def busca_contas do
    {:ok, binary} = File.read(@contas)
    :erlang.binary_to_term(binary)
  end

  def busca_contas_email(email), do: Enum.find(busca_contas(), &(&1.usuario.email == email))

  def transferir(de, para, valor) do
    de = busca_contas_email(de.usuario.email)
    cond do
      valida_saldo(de.saldo, valor) -> {:error, "Saldo insuficiente!"}
      true ->
        para = busca_contas_email(para.usuario.email)
        de = %Conta{de | saldo: de.saldo - valor}
        para = %Conta{para | saldo: para.saldo + valor}
      [de, para]
    end
  end


  def sacar(conta, valor) do
    cond do
      valida_saldo(conta.saldo, valor) -> {:error, "Saldo insuficiente!"}
      true ->
        conta = %Conta{conta | saldo: conta.saldo - valor}
        {:ok, conta, "mensagem de email encaminhada!"}
    end
  end

  defp valida_saldo(saldo, valor), do: saldo < valor
end
