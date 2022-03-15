# This file was generated, do not modify it. # hide
cost(df) = (df.status .!= :first_order) * Inf + df.t
p = performance_profile(stats, cost)
Plots.svg(p, "profile2")