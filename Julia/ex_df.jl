### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 79044120-ff84-11eb-24b4-3121f819b702
begin
	using DataFrames
	using CSV
	using XLSX
	using CommonMark
end

# ╔═╡ 533144bc-3d50-4f94-a553-72eeab55ae34
md" # Importação dos bancos de dados"

# ╔═╡ 1f8e4f91-06d4-4dd8-821c-0a717186b8a2
begin
	caminho_pasta = "C:\\Users\\gabri\\OneDrive\\Documents\\Julia"
	clientes_df = DataFrame(CSV.File(joinpath(caminho_pasta, "CadastroClientes.csv")))
	funcionarios_df = DataFrame(CSV.File(joinpath(caminho_pasta, "CadastroFuncionarios.csv")))
	aux=XLSX.readtable(joinpath(caminho_pasta , "BaseServiçosPrestados.xlsx"), "Plan1")
	servicos_df = DataFrame(aux[1],aux[2])
	md" #### Clientes

$(clientes_df)

#### Funcionários

$(funcionarios_df)

#### Serviços

$(servicos_df)"
end

# ╔═╡ fa59439c-8878-49cb-8bb2-614ce908fcea
md" # Análise dos bancos de dados para limpeza"

# ╔═╡ e152bc18-8ef3-42b0-9378-5f1801c30890
describe(funcionarios_df)
#necessário Parse de :Impostos e :VR

# ╔═╡ 96c86d21-8935-4897-a05b-1cff7ff09040
describe(servicos_df)
#parece bom

# ╔═╡ 669d1dd4-2caf-4762-9284-8f5efe64eb1c
describe(clientes_df)
#parece bom

# ╔═╡ bfb56331-56a2-4d91-8e15-a4594236ab96
md" # Limpeza de dados"

# ╔═╡ 109911a9-dc20-4a22-afba-280323337f88
begin
	transform!(funcionarios_df, :Impostos=>(x-> parse.(Float64, replace.(x,","=>"."))) =>:Impostos)
		transform!(funcionarios_df, :Beneficios=>(x-> parse.(Float64, replace.(x,","=>"."))) =>:Beneficios)
	transform!(funcionarios_df, :VR=>(x-> parse.(Float64, replace.(x,","=>"."))) =>:VR)
end

# ╔═╡ 137f295d-c2bd-447b-8f79-0ca8cd3b436a
md" # Valor total da Folha salarial"

# ╔═╡ 783a8ec3-87bd-48a6-b648-d05f64e18edc
begin
	transform!(funcionarios_df, 4:8 =>(+)=>"Salario Total")
	folha_salarial_total = sum(funcionarios_df[:,"Salario Total"])
	cm""" São gastos R\$ $(folha_salarial_total)"""
end

# ╔═╡ 0fe990e1-f93f-4ef6-9ddd-773cd3a606f5
md" # Faturamento da empresa"

# ╔═╡ 7eb281e8-ba36-4323-8950-52eba1e50718
begin
	faturamento = innerjoin(servicos_df,clientes_df,on="ID Cliente")
	transform(faturamento, ["Valor Contrato Mensal","Tempo Total de Contrato (Meses)"]=>(*)=>"Faturamento")
end

# ╔═╡ bf9c071b-92ab-4573-b6ab-b157ea0e3174


# ╔═╡ a5e348e2-d7d0-4d0c-a2c3-66e1d195c593
md" # Porcentagem de funcionario que fecharam contrato"

# ╔═╡ 889bad1e-83c7-44ab-8fba-4a206b8594bf
md" # Contratos por Área da empresa"

# ╔═╡ 8fc25aae-ecda-4a74-b011-d125cc91a6dc
md" # Funcionários por Área"

# ╔═╡ 529b4abd-48d0-416b-84e0-65e0995de932
md" # Ticket médio mensal"

# ╔═╡ df2db4e8-be1e-4a18-b80e-be171165ecd7


# ╔═╡ 04551702-1061-454f-bd6c-a78cf16e5000


# ╔═╡ 850ce7cb-496a-4388-8c65-2f25d9a81fb4


# ╔═╡ 9b5a16a8-5167-4934-b33c-c89a8f228aef


# ╔═╡ 18095b40-9a49-4e23-867f-bcefe129a79f


# ╔═╡ 173edaa6-ed88-4ba9-aac2-15879215c11e


# ╔═╡ b348b9da-e5e6-4c33-b205-fb5b208c2e38


# ╔═╡ 0d288057-a56d-420d-9eeb-fd0c7a3f0f29


# ╔═╡ bad27d00-0497-4c5d-a5ae-2273f4734e9e


# ╔═╡ 1b7ae597-ac8c-4958-b646-12062d0e3a1e


# ╔═╡ 6b8c09bd-2886-4649-84fb-0c49c0e19271


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
XLSX = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"

[compat]
CSV = "~0.8.5"
CommonMark = "~0.8.2"
DataFrames = "~1.2.2"
XLSX = "~0.7.6"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[CSV]]
deps = ["Dates", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode"]
git-tree-sha1 = "b83aa3f513be680454437a0eee21001607e5d983"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.8.5"

[[CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "1060c5023d2ac8210c73078cb7c0c567101d201c"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.2"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "79b9563ef3f2cc5fc6d3046a5ee1a57c9de52495"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.33.0"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d785f42445b63fc86caa08bb9a9351008be9b765"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[EzXML]]
deps = ["Printf", "XML2_jll"]
git-tree-sha1 = "0fa3b52a04a4e210aeb1626def9c90df3ae65268"
uuid = "8f5d6c58-4d21-5cfd-889c-e3ad7ee6a615"
version = "1.1.0"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "4ea90bd5d3985ae1f9a908bd4500ae88921c5ce7"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "bfd7d8c7fd87f04543810d9cbd3995972236ba1b"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "cde4ce9d6f33219465b55162811d8de8139c0414"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.2.1"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "a3a337914a035b2d59c9cbe7f1a38aaba1265b02"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.6"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "d0c690d37c73aeb5ca063056283fde5585a41710"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.5.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[XLSX]]
deps = ["Dates", "EzXML", "Printf", "Tables", "ZipFile"]
git-tree-sha1 = "7744a996cdd07b05f58392eb1318bca0c4cc1dc7"
uuid = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"
version = "0.7.6"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[ZipFile]]
deps = ["Libdl", "Printf", "Zlib_jll"]
git-tree-sha1 = "c3a5637e27e914a7a445b8d0ad063d701931e9f7"
uuid = "a5390f91-8eb1-5f08-bee0-b1d1ffed6cea"
version = "0.9.3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═79044120-ff84-11eb-24b4-3121f819b702
# ╟─533144bc-3d50-4f94-a553-72eeab55ae34
# ╟─1f8e4f91-06d4-4dd8-821c-0a717186b8a2
# ╟─fa59439c-8878-49cb-8bb2-614ce908fcea
# ╠═e152bc18-8ef3-42b0-9378-5f1801c30890
# ╠═96c86d21-8935-4897-a05b-1cff7ff09040
# ╠═669d1dd4-2caf-4762-9284-8f5efe64eb1c
# ╟─bfb56331-56a2-4d91-8e15-a4594236ab96
# ╠═109911a9-dc20-4a22-afba-280323337f88
# ╟─137f295d-c2bd-447b-8f79-0ca8cd3b436a
# ╠═783a8ec3-87bd-48a6-b648-d05f64e18edc
# ╟─0fe990e1-f93f-4ef6-9ddd-773cd3a606f5
# ╠═7eb281e8-ba36-4323-8950-52eba1e50718
# ╠═bf9c071b-92ab-4573-b6ab-b157ea0e3174
# ╟─a5e348e2-d7d0-4d0c-a2c3-66e1d195c593
# ╟─889bad1e-83c7-44ab-8fba-4a206b8594bf
# ╟─8fc25aae-ecda-4a74-b011-d125cc91a6dc
# ╟─529b4abd-48d0-416b-84e0-65e0995de932
# ╠═df2db4e8-be1e-4a18-b80e-be171165ecd7
# ╠═04551702-1061-454f-bd6c-a78cf16e5000
# ╠═850ce7cb-496a-4388-8c65-2f25d9a81fb4
# ╠═9b5a16a8-5167-4934-b33c-c89a8f228aef
# ╠═18095b40-9a49-4e23-867f-bcefe129a79f
# ╠═173edaa6-ed88-4ba9-aac2-15879215c11e
# ╠═b348b9da-e5e6-4c33-b205-fb5b208c2e38
# ╠═0d288057-a56d-420d-9eeb-fd0c7a3f0f29
# ╠═bad27d00-0497-4c5d-a5ae-2273f4734e9e
# ╠═1b7ae597-ac8c-4958-b646-12062d0e3a1e
# ╠═6b8c09bd-2886-4649-84fb-0c49c0e19271
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
