# This file was generated, do not modify it. # hide
fmt_override = Dict(:f => "%+10.3e",
                    :t => "%08.2f")
hdr_override = Dict(:name => "Name", :f => "f(x)", :t => "Time")
open("alpha2.tex", "w") do io
  println(io, "\\documentclass[varwidth=20cm,crop=true]{standalone}")
  println(io, "\\usepackage{longtable}")
  println(io, "\\begin{document}")
  pretty_latex_stats(io,
                    df[!, [:name, :status, :f, :t, :iter]],
                    col_formatters = Dict(:t => "%f"),  # disable default formatting of t
                    formatters = (v,i,j) -> begin
                      if j == 4
                        xi = floor(Int, v)
                        minutes = div(xi, 60)
                        seconds = xi % 60
                        micros = round(Int, 1e6 * (v - xi))
                        @sprintf("\\(%2d\\)m \\(%02d\\)s \\(%06d \\mu\\)s", minutes, seconds, micros)
                      else
                        v
                      end
                  end)
  println(io, "\\end{document}")
end

run(`latexmk -quiet -pdf alpha2.tex`)
run(`pdf2svg alpha2.pdf alpha2.svg`)