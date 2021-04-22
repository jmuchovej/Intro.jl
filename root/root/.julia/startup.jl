# using Pkg
# Pkg.activate()
# Pkg.instantiate()
# Pkg.precompile()

using Pluto
# options = Pluto.ServerOptions(
#     :host => "0.0.0.0",
#     :port => "43655",
#     :launch_browser => false,
# )
Pluto.run(; :host => "0.0.0.0", :port => 43655, :launch_browser => false)