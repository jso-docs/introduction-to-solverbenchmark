# This file was generated, do not modify it. # hide
df = join(stats, [:f, :t], invariant_cols=[:name])
pretty_stats(stdout, df)