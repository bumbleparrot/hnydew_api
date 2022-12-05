defmodule HnydewApiWeb.Error do
  alias HnydewApiWeb.Error

  defstruct [
    error_code: 0000,
    error_message: "",
  ]

  def translate_error(changeset) do
    get_error_code(changeset.errors)
  end

  def get_error_code(errors) do
    Enum.map(errors, &atom_to_error_code/1)
  end

  def atom_to_error_code(error_data) do
    case error_data do
      {:family_id, _} -> %Error{error_code: 1000, error_message: "Invalid family id"}

      _ -> %Error{error_code: 9999, error_message: "unmapped error"}
    end
  end
end
