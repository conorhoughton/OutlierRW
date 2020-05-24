
include("ou_process.jl")

ou=OuProcess(0.0,1.0,0.1,0.0)

for i in 1:1000
    println(ou.r)
    ouStep(ou)
end
