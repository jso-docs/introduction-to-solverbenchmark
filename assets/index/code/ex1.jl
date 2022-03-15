# This file was generated, do not modify it. # hide
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