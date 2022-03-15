# This file was generated, do not modify it. # hide
using Plots
pyplot()

p = performance_profile(stats, df -> df.t)
Plots.svg(p, "profile1")