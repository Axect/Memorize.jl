### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ dd9b9cec-e2e6-11eb-1a80-a98966998238
using CSV, DataFrames, Random, PlutoUI

# ╔═╡ 6c449fd5-f71e-4e90-859c-939e181f582c
df = CSV.read("data/sentence.csv", DataFrame);

# ╔═╡ f5d97ca6-cbce-4045-8a3d-0d0ec08c2755
s_vec = df[:,:Sentence];

# ╔═╡ a3e7bfa3-c5ff-4076-9758-5b387e92d058
m_vec = df[:,:Meaning];

# ╔═╡ c8c45d9c-2645-4dd0-85fd-8386c6ac1d9a
@bind button Button()

# ╔═╡ e2353533-fd9a-429f-9c9d-10fc3d58328b
begin
	button
	
	index = rand(1:length(s_vec));
	println("Nothing")
end

# ╔═╡ eb7fdd1c-945e-4235-acfe-63f5445604a3
answer = @bind s TextField((80,3));

# ╔═╡ 2b33cf7c-fc85-4171-94f6-6cc46761f53a
md"""
### Question

**Write the original sentence of given meaning.**

* Meaning : $(m_vec[index])
  
* Answer : $answer
"""

# ╔═╡ f5329af9-4a7c-42da-92fc-f9d17b4f95e8
s

# ╔═╡ 7a0c34a5-555e-4713-a428-f616f74e1158
function replace_punct(s)
	a = replace(s, "\u2019" => "'");
	b = replace(a, "“" => "\"");
	c = replace(b, "”" => "\"");
	return c
end

# ╔═╡ 31eb90db-c313-4f68-a1e0-c0d4c603a877
with_terminal() do
	println("Exactly? : $(replace_punct(s_vec[index]) == s)")
end

# ╔═╡ Cell order:
# ╟─dd9b9cec-e2e6-11eb-1a80-a98966998238
# ╟─6c449fd5-f71e-4e90-859c-939e181f582c
# ╟─f5d97ca6-cbce-4045-8a3d-0d0ec08c2755
# ╟─a3e7bfa3-c5ff-4076-9758-5b387e92d058
# ╟─e2353533-fd9a-429f-9c9d-10fc3d58328b
# ╟─c8c45d9c-2645-4dd0-85fd-8386c6ac1d9a
# ╟─2b33cf7c-fc85-4171-94f6-6cc46761f53a
# ╟─31eb90db-c313-4f68-a1e0-c0d4c603a877
# ╟─eb7fdd1c-945e-4235-acfe-63f5445604a3
# ╟─f5329af9-4a7c-42da-92fc-f9d17b4f95e8
# ╟─7a0c34a5-555e-4713-a428-f616f74e1158
