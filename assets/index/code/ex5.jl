# This file was generated, do not modify it. # hide
open("alpha.tex", "w") do io
  println(io, "\\documentclass[varwidth=20cm,crop=true]{standalone}")
  println(io, "\\usepackage{longtable}")
  println(io, "\\begin{document}")
  pretty_latex_stats(io, stats[:alpha])
  println(io, "\\end{document}")
end

run(`latexmk -quiet -pdf alpha.tex`)
run(`pdf2svg alpha.pdf alpha.svg`)