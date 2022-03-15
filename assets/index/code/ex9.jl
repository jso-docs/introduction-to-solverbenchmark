# This file was generated, do not modify it. # hide
fmt_override = Dict(:f => "%+10.3e",
                    :t => "%08.2f")
hdr_override = Dict(:name => "Name", :f => "f(x)", :t => "Time")
pretty_stats(df[!, [:name, :f, :t]],
             col_formatters = fmt_override,
             hdr_override = hdr_override,
             formatters = (v, i, j) -> begin
               if j == 3  # t is the 3rd column
                 vi = floor(Int, v)
                 minutes = div(vi, 60)
                 seconds = vi % 60
                 micros = round(Int, 1e6 * (v - vi))
                 @sprintf("%2dm %02ds %06dμs", minutes, seconds, micros)
               else
                 v
               end
             end)