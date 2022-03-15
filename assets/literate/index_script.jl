# This file was generated, do not modify it.

using DataFrames, Printf, Random

Random.seed!(0)

n = 10
names = [:alpha, :beta, :gamma]
stats = Dict(name => DataFrame(:id => 1:n,
         :name => [@sprintf("prob%03d", i) for i = 1:n],
         :status => map(x -> x < 0.75 ? :first_order : :failure, rand(n)),
         :f => randn(n),
         :t => 1e-3 .+ rand(n) * 1000,
         :iter => rand(10:10:100, n),
         :irrelevant => randn(n)) for name in names)

stats[:alpha]

using SolverBenchmark

pretty_stats(stats[:alpha])

pretty_latex_stats(stats[:alpha])

open("alpha.tex", "w") do io
  println(io, "\\documentclass[varwidth=20cm,crop=true]{standalone}")
  println(io, "\\usepackage{longtable}")
  println(io, "\\begin{document}")
  pretty_latex_stats(io, stats[:alpha])
  println(io, "\\end{document}")
end

run(`latexmk -quiet -pdf alpha.tex`)
run(`pdf2svg alpha.pdf alpha.svg`)

df = stats[:alpha]
pretty_stats(df[!, [:name, :f, :t]])

pretty_stats(df[!, [:name, :f, :t]], tf=tf_markdown)

fmt_override = Dict(:f => "%+10.3e",
                    :t => "%08.2f")
hdr_override = Dict(:name => "Name", :f => "f(x)", :t => "Time")
pretty_stats(stdout,
             df[!, [:name, :f, :t]],
             col_formatters = fmt_override,
             hdr_override = hdr_override)

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

df = join(stats, [:f, :t])
pretty_stats(stdout, df)

df = join(stats, [:f, :t], invariant_cols=[:name])
pretty_stats(stdout, df)

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

using Plots
pyplot()

p = performance_profile(stats, df -> df.t)
Plots.svg(p, "profile1")

cost(df) = (df.status .!= :first_order) * Inf + df.t
p = performance_profile(stats, cost)
Plots.svg(p, "profile2")

solved(df) = (df.status .== :first_order)
costs = [df -> .!solved(df) * Inf + df.t, df -> .!solved(df) * Inf + df.iter]
costnames = ["Time", "Iterations"]
p = profile_solvers(stats, costs, costnames)
Plots.svg(p, "profile3")

