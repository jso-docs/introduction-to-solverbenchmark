# This file was generated, do not modify it. # hide
solved(df) = (df.status .== :first_order)
costs = [df -> .!solved(df) * Inf + df.t, df -> .!solved(df) * Inf + df.iter]
costnames = ["Time", "Iterations"]
p = profile_solvers(stats, costs, costnames)
Plots.svg(p, "profile3")