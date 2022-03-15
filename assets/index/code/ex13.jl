# This file was generated, do not modify it. # hide
hdr_override = Dict(:name => "Name", :f => "f(x)", :t => "Time")
df = join(stats, [:f, :t], invariant_cols=[:name], hdr_override=hdr_override)
pretty_stats(stdout, df)

hdr_override = Dict(:name => "Name", :f => "\\(f(x)\\)", :t => "Time")
df = join(stats, [:f, :t], invariant_cols=[:name], hdr_override=hdr_override)
open("alpha3.tex", "w") do io
  println(io, "\\documentclass[varwidth=20cm,crop=true]{standalone}")
  println(io, "\\usepackage{longtable}")
  println(io, "\\begin{document}")
  pretty_latex_stats(io, df)
  println(io, "\\end{document}")
end

run(`latexmk -quiet -pdf alpha3.tex`)
run(`pdf2svg alpha3.pdf alpha3.svg`)