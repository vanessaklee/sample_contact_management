defmodule Project.Models.Eligibility do
  use Ecto.Model
  table_name :contact_eligibility
  primary_key :contelig_id
  field :contact_id
  field :employer_id
  field :employee_idnum
  field :iata_base_id
  field :eligtype_id
  field :retired
  field :eligibility_mask
end
