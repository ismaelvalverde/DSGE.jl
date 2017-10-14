"""
```
hair_plot(var, realized, histories, forecasts; kwargs...)

hair_plot(var, realized, initial_values, forecasts; output_file = "",
    verbose = :low, kwargs...)
```

### Inputs

- `var::Symbol`: e.g. `:obs_gdp`
- `realized::DataFrame`: must contain realized values of `var`
- `histories::Vector{MeansBands}` (method 1) or
  `initial_values::Vector{Float64}` (method 2): vector of either historical
  `MeansBands` or initial forecast values (i.e. s_{T|T} or y_T). Needed to
  connect the forecast hairs to the realized data line
- `forecasts::Vector{MeansBands}`

### Keyword Arguments

- `output_file::String`: if specified, plot will be saved there as a PDF
- `legend`
- `verbose::Symbol`

See `?hair` for additional keyword arguments, all of which can be passed into
`hair_plot`.

### Output

- `p::Plot`
"""
function hair_plot(var::Symbol, realized::DataFrame,
                   histories::Vector{MeansBands}, forecasts::Vector{MeansBands};
                   kwargs...)

    initial_values = map(history -> history.means[end, var], histories)
    hair_plot(var, realized, initial_values, forecasts; kwargs...)
end

function hair_plot(var::Symbol, realized::DataFrame,
                   initial_values::Vector{Float64}, forecasts::Vector{MeansBands};
                   output_file::String = "",
                   verbose::Symbol = :low,
                   kwargs...)
    # Call recipe
    p = hair(var, realized, initial_values, forecasts; kwargs...)

    # Save if `output_file` provided
    save_plot(p, output_file, verbose = verbose)

    return p
end