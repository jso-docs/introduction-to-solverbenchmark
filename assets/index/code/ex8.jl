# This file was generated, do not modify it. # hide
fmt_override = Dict(:f => "%+10.3e",
                    :t => "%08.2f")
hdr_override = Dict(:name => "Name", :f => "f(x)", :t => "Time")
pretty_stats(stdout,
             df[!, [:name, :f, :t]],
             col_formatters = fmt_override,
             hdr_override = hdr_override)