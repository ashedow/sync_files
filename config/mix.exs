@doc """
Documentation with ExDoc

## Generate the project documentation
    mix docs
"""
def deps do
  [{:ex_doc, "~> 0.11", only: :dev}]
end
