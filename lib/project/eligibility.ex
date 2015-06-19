defmodule Project.Eligibility do
  use Bitwise
  require Lager

  alias Project.Models.Eligibility
  alias Project.Contact

  """
  Return flag for customer's eligibility mask
  Expected Response:
    HTTP/1.1 200 OK
    Content-type: application/json; charset=utf-8
    2048
  """
  def fetch_mask(id) do
    case fetch_record(id) do
      nil  -> {:error, "No customer record found."}
      c -> c.eligibility_mask
    end
  end

  """ 
  Append new flag to customer's eligibility mask
  Expected Request:
    POST /customers/:id/eligibility_mask HTTP/1.1
    Content-Type: application/json
    cid = customer id
    flag = elig flag value
  Expected Response:
    HTTP/1.1 201 Created
  """
  def post_mask(contact,flag) do
    case fetch_record(contact.id) do
      nil     -> nil
      elig -> 
        if elig.eligibility_mask do 
          mask = bor(elig.eligibility_mask, flag)
        else 
          mask = flag
        end        
        contact = contact.eligibility_mask(mask)
        save_elig(contact)
    end
  end

  """
  Replace customer's existing eligibility mask with new mask
  Expected Request:
    PUT /customers/:id/eligibility_mask HTTP/1.1
    Content-Type: application/json
    512
  Expected Response:
    HTTP/1.1 200 OK
  """
  def put_mask(contact,id) do
    case fetch_record(contact.id) do
      nil -> nil
      elig -> contact = contact.eligibility_mask(id)
              save_elig(contact)
    end
  end

  """
  Delete flag from customer's existing eligibility mask
  Expected Request:
    PUT /customers/:id/eligibility_mask HTTP/1.1
    Content-Type: application/json
    512
  Expected Response:
    HTTP/1.1 200 OK
  """
  def delete_mask(contact,id) do 
    case fetch_record(contact.id) do
      nil -> nil
      elig -> mask = bxor(elig.eligibility_mask, id)
              contact = contact.eligibility_mask(mask)
              save_elig(contact)
    end
  end

  """
  HELPERS
  """
  def save_elig(contact) do
    case Contact.save(contact) do
      Contact[] -> :ok
      { :invalid, errors } -> nil
    end
  end

  def fetch_record(id) do
    case Ecto.all Eligibility, where: [contact_id: id] do
      {:error, _} -> nil
      []  -> nil
      [c] -> c
    end
  end
end


  """
  defmodule Type do
    use Ecto.Model
    table_name :lov_eligibility_type
    primary_key :eligtype_id
    field :elig_type
    field :mask

    def for_mask(mask) do
      Ecto.all Type,
        where: [mask: mask],
        order_by: :elig_type
    end
  end
  """