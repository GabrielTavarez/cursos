### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 213ede50-faf2-11eb-17ef-9b4b63997a8d
begin
	using DataFrames
	using CSV
	using Statistics
end

# ╔═╡ cfe9402c-21fe-44b6-a46a-79dc8d609b7e
md""" ### Criação básica de DataFrames"""

# ╔═╡ 70ae3a73-2252-4346-9292-e433ebea6bb0
begin
	DataFrame(A=1:3,B=5:7,Fixed = 1)
end

# ╔═╡ dfd44fd0-339a-4831-b1a4-542599914be4
begin
	data_frame = DataFrame(A = Int[], B = String[])
	push!(data_frame, (1, "M"))
	push!(data_frame, [2, "F"])
	push!(data_frame, Dict(:B => "F", :A => 3))
end

# ╔═╡ fe550976-50ed-4974-afbf-64d73c0da5e4
random_tab = DataFrame(rand(10, 3), [:a, :b, :c])

# ╔═╡ acf24730-c5f1-4186-95c9-17dfcaae3c25
DataFrame("customer age" => [15, 20, 25],
		  "first name" =>["Rohit", "Rahul", "Akshat"])

# ╔═╡ 3394f485-9c9d-40c9-ad5d-f4b7302ca978
#d=DataFrames a partir de dicionários
begin
	dict = Dict("customer age" => [15, 20, 25],
                   "first name" => ["Rohit", "Rahul", "Akshat"])
	DataFrame(dict)
end

# ╔═╡ 98e890d4-4b56-444f-94b6-66bdb272c337
#DataFrames a partir de vetor de tuple
DataFrame((a=[1, 2], b=[3, 4]))

# ╔═╡ 349ee372-944b-4cdd-a580-d0941416a9b5
#DataFrame a partir de vetores
DataFrame([(a=1, b=0), (a=2, b=0)])

# ╔═╡ 134339d4-da0a-49d7-9d90-ee67e57f42b8
#DataFrame a partir de MATRIZES
DataFrame([1 0; 2 0], :auto)

# ╔═╡ 673f9a96-8773-499f-b384-147e5f282686
begin
	data = [1 2 4 5; 15 58 69 41; 23 21 26 69]
	nomes = ["a", "b", "c", "d"]
	DataFrame(data,nomes)
end

# ╔═╡ 8fa9269a-0093-4dc3-bee2-6d39e22fde9a
md""" ### Leitura de CSV"""

# ╔═╡ cdc792a7-bee0-4c8c-a8c1-46941242387b
begin
	german_ref =CSV.read(joinpath(dirname(pathof(DataFrames)),
	                                      "..", "docs", "src", "assets", "german.csv"),
	                             DataFrame)
	
	#obs joinpath(dirname(pathof(DataFrames)),"..", "docs", "src", "assets", "german.csv")
	#é equivalente a:
#C:\\Users\\gabri\\.julia\\packages\\DataFrames\\vuMM8\\src\\..\\docs\\src\\assets\\german.csv"
	
	german = copy(german_ref)
	
	#obs: também é possivel
	german_ref2 = DataFrame(CSV.File( "C:\\Users\\gabri\\.julia\\packages\\DataFrames\\vuMM8\\src\\..\\docs\\src\\assets\\german.csv"))
	
	#leitura excel
	#df = DataFrame(XLSX.readtable("myfile.xlsx", "mysheet")...)
	
end

# ╔═╡ 44cffb05-a739-419b-9d68-4fb9b3aabfd3
md" ### Exportar CSV"

# ╔═╡ 1b489587-3e99-4356-b9c5-1b5691a5ed35
begin
	caminho_escrita = "C:\\Users\\gabri\\OneDrive\\Documents\\teste_csv_julia.csv"
	CSV.write(caminho_escrita,german)
end

# ╔═╡ 57d4f9df-d3f7-453e-b93d-a2766d53eb03
md" ### Vizualização"

# ╔═╡ d8aeb626-95f5-4a54-881a-86d4dd5a438e
begin
	first(german,5) #mostra as primeiras 5 linhas do DataFrame
	last(german, 6) #mostra as ultimas 6 linhas do DataFrame
	
	### view(DataFrame, array_linhas, array_colunas)
	view(german, 2, 2) #mostra uma unica célula
	view(german, : , :) #mostra as linhas e colunas de algum DataFrame
end

# ╔═╡ 740f86a6-1f5a-477b-9c8f-5b388c7938f4
begin
	#usando betewwn, cols, not
	german[:, Not(:Age)] #retorna todo a DataFrame menos a coluna :Age
	german[:, Between(:Sex, :Housing)] #Retorna as colunas Sex, Job, Housing
	german[:,Cols("Age",Between("Sex","Job"))]#Retorna as colunas Age,Sex,Job, Housing
	german[Not(5), r"S"] #retorna colunas com a letra S menos a linhas 5
end

# ╔═╡ a020ad94-349d-41ce-af02-7aa6fff33e5e
begin
	names(german) #retorna uma lista de nomes das colunas
	names(german, String) #retorna uma lista de nomes das Colunas do tipo String
end

# ╔═╡ de67a888-a9aa-4477-b48d-4bb199b2cf60
propertynames(german) #retorna uma lista de simbolos de l=nomes das colunas

# ╔═╡ ae30807d-95d0-44d1-9be7-55b75aea00af
eltype.(eachcol(german)) #retorna uma lista de tipos de cada coluna

# ╔═╡ a616fdcb-8e25-458d-be78-899e0012f4f3
md""" #### empty x empty!"""

# ╔═╡ e707b267-a29b-40f1-a689-83d94dc6f6b3
begin
	a = empty(german) #cria um novo DataFrame com o formato de german, mas vazio
	#b = empty!(german) #exclui as linhas de german
end

# ╔═╡ 2df984cb-60d2-447a-9a82-2f0012a9af74
md" ### Infos Basicas do DataFrame"

# ╔═╡ 95967099-b59b-4bb3-aae9-4b81a883ad84
begin
	size(german) #(1000,100)
	size(german,1) #1000
	size(german,2) #10
	
	nrow(german) #1000
	ncol(german) #10
end

# ╔═╡ 66d581fb-ae28-423b-a998-f835f98f346d
describe(german)

# ╔═╡ 07ea3b8b-bae7-41b5-8429-ce86695ca161
describe(german, cols=1:3) # define quais colunas são analisadas

# ╔═╡ 60de527a-697b-4a03-805e-d2e30e777aa0
#função show(german, allrows=True) -> imprimirá todas as linhas

# ╔═╡ 57ce4db0-459f-4ca1-a88a-6cf531bc362e
md""" ### Análises de dados"""

# ╔═╡ 10bcfc9e-23c1-4a87-aeaa-31a5fe4fadbf
begin
	mean(skipmissing(german."Age"))
end

# ╔═╡ 70fb0f8b-45fd-4cf4-94fc-f8769ac818a5
mapcols(id -> id .^ 2, german) 

#realia uma função a todas coluna. Deve passar a coluna como argumento da função
#não altera a função original german

# ╔═╡ 51031790-038a-4d14-a7d2-c97a0a45b48b
md" ### Renomear Colunas"

# ╔═╡ a2628481-6ced-41e2-bd77-6c86cdd061b0
rename!(german,  "Duration" => "Time")

# ╔═╡ a28e8624-6da7-4260-a483-70b275ccd227
md""" ### Acessando coluna"""

# ╔═╡ 09a1976d-8f3c-4d57-96bb-b92cd3108800
begin
	#acessando a coluna Sex do DataFrame
	german.Sex
	german."Sex"
	german[!,"Sex"]
	col_name = "Sex"
	german[!,col_name]
end

# ╔═╡ 04dae648-eb5a-4f01-bf32-e4b5b3b09f4b
begin
	#acessando a coluna Sex do DataFrame
	german[:,col_name] 
	#dessa forma é criada uma cópia da coluna que não irá afetar a coluna original
end

# ╔═╡ c4c4ac9a-b214-4651-80ae-5fa5cb632f80
begin
	german.Sex === german[!, :Sex] #True
	german.Sex === german[:, :Sex] #False
end

# ╔═╡ 4bdd806c-3f7f-4386-98bb-6699d31c53e1
md""" ### Acessando Index

---

**data\_frame[selected\_rows, selected\_columns]**

data\_frame[array , array] -> Retorna um DataFrame 

data\_frame[array , Symbol/Strin] -> Retorna um Array

pode-se usar data\_frame[condicao,coluna]

É sempre necessário passar linhas e colunas. Operado4: [**:**] indica todos os elementos da linha ou coluna


---
**select(DataFrame, colunas)**

tem a vantagem de poder ter vários métodos de seleção de colunas

ex. select(DF, 1, :Sex, r'a')
"""

# ╔═╡ b1225148-050e-42af-b6e8-55276ab5c413
begin
	german[1:5,1:2] #indicies de linha e coluna
	german[1:5, [:Sex , :Age]] #indices de linha e nomes por Symbol das colunas
	german[1:5,:] #apenas as 5 primeiras linhas, mas todas as colunas
	german[[1,6,15] , :]
	german[! , :] # Retorna todas as linhas e colunas do próprio DataFrame (!)	
end

# ╔═╡ 311a7934-f903-4e94-8a91-d5c127d26ad9
 begin
	german[:, [:Sex]] #retorna um DataFrame
	german[:, :Sex] #retorna um Array
end

# ╔═╡ e2950bd7-1a10-417d-b2a7-2c5c7d2b24c2
begin
	select(german, r"S")
	select(german, Not(["Sex","id","Age"]))
end

# ╔═╡ b7604637-a911-4096-8f48-4fdc01f02182
md" ### Acesso condicional 

data\_frame[condicao,coluna]"

# ╔═╡ 34c5887e-f36d-4c28-b305-ddd9b0445637
begin
	### ACESSO CONDICIONAL ###
	
	#Retorna apenas as linhas com Age> que 30
	german[german."Age" .> 30,:] #necessário o .> para realizar comparação célula a celula
	
	german[(german."Age" .> 30) .& (german."Sex" .== "male"),:]
	
end

# ╔═╡ 12096062-b935-46ae-9839-0d4cc76a214b
md" ### Manipulação de dados"

# ╔═╡ f0ac36b9-e028-49f1-92b4-7892e536c8af
df1 = german[1:6, 2:4]

# ╔═╡ e7713517-210f-4545-81cc-9d1a1d78b412
begin
	val = [80, 85, 98, 95, 78, 89]
	df1.Age = val #alterar todos os valores da coluna
	view(df1, :,:)
end

# ╔═╡ 4d294541-f2c5-48b3-b8b7-6dee68880451
begin
	df1[1:3, :Job] = [10, 10, 10] #muda apenas os valores acessados
	view(df1,:,:)
end

# ╔═╡ 38bcb63c-c0a3-4e34-98e8-0dc573a9dab1
begin
	df1[!, :Sex] = ["male", "female", "female", "transgender", "female", "male"]
	df1[3, 1:3] = [78, "male", 4] #muda apenas os valores acessados
	view(df1,:,:)
end


# ╔═╡ eb4a5cb6-61c0-49fa-b14e-a8cf774c740b
begin
	df2 = df1[2, :] #não cria uma cópia de df1. Toda alteração em df2, altera df1
	df2.Age = 100
	df2[2:3] = ["male", 2]
	df2
end

# ╔═╡ 828e9f95-e987-437e-89c0-349ae0758fb5
begin
	df1[!, :Customers] = ["Rohit", "Akshat", "Rahul", "Aayush", "Prateek", "Anam"]
	df1[:, :City] = ["Kanpur", "Lucknow", "Bhuvneshwar", "Jaipur", "Ranchi", "Dehradoon"]
	df1[:, 3] .= 4 #precisa do .= para colocar o valor em todo o array
	view(df1,:,:)
end

# ╔═╡ df524d25-a2d4-466c-bf19-082e60b7c527
begin
	#df1[:, :Age] .= "Economics" 
	#ERROR: não pode converter a cópia de df1 em Economics
	
	
	
	df1[!, :Age] .= "Economics" #não dá erro
	view(df1,:,:)
end

# ╔═╡ 929b2820-e568-4d53-8124-f956c700b731
md" ### Inserção de colunas

insertcols!( DataFrame, index\_da\_coluna, Symbol\_Name => valor)
"

# ╔═╡ 72b4e080-795a-4af4-9fb1-676678b42a40
insertcols!(df1, 1, :Country => "India")

# ╔═╡ d87e13b8-fd10-42c2-a804-28addbbab982
md""" ### Transformações

tranformacao( DataFrameSource, coluna => transformations => coluna\_alvo\_nome)

---

**tranformações:**

* combine -> cria um novo DataFrame populado com a transformação

* select -> cria um novo DataFrame com o mesmo número de linhas do Source, e populado com a transformação

* select! -> altera a Source

* transform -> cria um novo DataFrame com o mesmo número de Linhas e Colunas do Source, e popupado com a transformação

* transform! -> altera o Source

---

**transformations:**

* mean
* unique
* uppercase
* sqrt
* exp
* sin

"""

# ╔═╡ 9738c507-816b-49e5-b96e-e8bdd724284a
combine(german, :Age => mean => :mean_age)

# ╔═╡ 3d475ca8-8595-4dee-867c-1f657531b0f4
select(german, :Age => mean => :mean_age)

# ╔═╡ a715bab8-0a10-4233-b5b2-88cba4973e86
combine(german, :Age => mean => :mean_age, :Housing => unique => :housing)

# ╔═╡ c5cff247-e077-46e6-bf50-f584dd5e1619
begin
	#necessita da função lambda quando acessa os valores da coluna 1 a 1
	select(german, :Sex => (x -> uppercase.(x)) => :Sex) 
	
	#ByRow realiza a transformação célula a celula
	select(german, :Sex ,:Sex => ByRow(uppercase) => :Sex_UpperCase)
end

# ╔═╡ 94fb1cb6-f0f2-4458-823a-8b1f0570d3b8
 select(german, :Sex => :x1, :Age => :x2) #apenas crria um dataset igual com nomes diferentes

# ╔═╡ 7c3491b1-f521-4da1-aa44-1de52fe47e1a
select(german, :Age, :Job, [:Age, :Job] => (+) => :res) #soma de coluna

# ╔═╡ 056907e1-069e-4eda-94a1-ec4e7cfb1423
begin
	df = german_ref[1:8, 1:5]
	transform(df, :Age => maximum => "Age")
end

# ╔═╡ e6b1bbeb-3368-40bd-9102-a36c5214c5dd
transform(df, :Age => :Sex, :Sex => :Age)

# ╔═╡ ef6112df-2515-41e2-bb89-2d28f3c34e4e
random_tab

# ╔═╡ 04552782-b281-4bea-97b5-9dbad44a3571
transform(random_tab, AsTable(:) => ByRow(argmax) => :prediction)

# ╔═╡ 42bfa204-651f-44ce-acc6-d8f7a4205abe
md" ### Limpeza de dados

dropmissing(DataFrame, colunas, 
"

# ╔═╡ 0eecdf2c-855f-467c-9d61-946cbd3ff14d
begin
	data_missing = DataFrame(i = 1:5,
                      x = [missing, 4, missing, 2, 1],
                      y = [missing, missing, "c", "d", "e"])
end

# ╔═╡ 59eb7067-5731-40e1-aa11-cc5d1e7099e1
dropmissing!(data_missing, ["x"], disallowmissing=true ) #remove linhas com valores missing

# ╔═╡ c6190a53-ee74-43f2-9394-6a4136ee6c5b
md" ### Juntar DataFrames

innerjoin(DF1, DF2, on = coluna\_de\_juncao)

---

* **innerjoin** : Retona apenas os valores que tem correspondência entre os 2 dataframes
* **leftjoin** : Retorna todo o Dataframe da esquerda e apenas as correspondências da direita
* **rightjoin** : Retorna todo o Dataframe da direita e apenas as correspondências da esquerda
* **outerjoin** : Retorna todos os valores dos 2 dataframes, mas preenche o que não corresponder com Missing
* **semijoin** : Igual innerjoy, mas apenas com os valores do dataframe da esquerda
* **antijoin** : Retorna apenas os valores do dataframe da esquerda que não tem correspondência com algum dataframe da direita


---

Caso a correspondencia seja em colunas com nomes diferentes em cada dataframe, usa-se:

innerjoin(a, b, on = coluna\_a => coluna\_b)

innerjoin(a, b, on = :ID => :IDNew)
"

# ╔═╡ 84425b4d-203f-468d-bfe5-01ee3697e636
jobs = DataFrame(ID = [20, 60], Job = ["Lawyer", "Doctor"])

# ╔═╡ a478e663-e445-400a-b1e5-59241a0331de
people = DataFrame(ID = [20, 40], Name = ["John Doe", "Jane Doe"])

# ╔═╡ 5781e83d-966b-4e82-8c86-213876f6e423
innerjoin(people,jobs,on ="ID")

# ╔═╡ 63b3e1b1-f279-468a-a257-6fb3fb75ae98
leftjoin(people, jobs, on= :ID)

# ╔═╡ 02315cae-6523-4c4b-8c7f-6e6bb7d36198
semijoin(people, jobs, on=:ID)

# ╔═╡ b417acff-b3b8-44b9-973d-3176983f58a1
antijoin(people, jobs, on=:ID)

# ╔═╡ 03ab8498-783a-46db-a2e9-d004278d0f2c
begin
	A = DataFrame(City = ["Amsterdam", "London", "London", "New York", "New York"],
                     Job = ["Lawyer", "Lawyer", "Lawyer", "Doctor", "Doctor"],
                     Category = [1, 2, 3, 4, 5])
	B = DataFrame(Location = ["Amsterdam", "London", "London", "New York", "New York"],
                     Work = ["Lawyer", "Lawyer", "Lawyer", "Doctor", "Doctor"],
                     Name = ["a", "b", "c", "d", "e"])
	innerjoin(A,B, on= [:City=>:Location, :Job=>:Work])	
end

# ╔═╡ 80eb2695-5590-48bd-a5bd-cd5e6fa2cb87
md""" 
Junção por várias colunas:

**A**:
$(A)

**B**
$B

"""

# ╔═╡ 687fa62d-dc5e-404a-bec4-b9ddfd53b7a6
md" ## Separação - Transformação - Combinação

Agrupamentos
"



# ╔═╡ 57678686-1f96-4f73-8eb1-65263ec28106
iris = CSV.read((joinpath(dirname(pathof(DataFrames)),
                                 "..", "docs", "src", "assets", "iris.csv")),
                       DataFrame)

# ╔═╡ 1e6264e0-6166-4b4a-a476-8f887e0acb8e
md" ### GROUPBY

Separa o dataframe em subgrupos dependendo do agrupamento que fizer.Cada grupo terá um dos valores da coluna especificada.

groupby(DataFrame, coluna)
"

# ╔═╡ e52308d6-046e-4400-b62f-7ae0eaa21794
 gdf = groupby(iris, :Species) 

# ╔═╡ f4c4cd05-8747-4b83-a448-45dfe746b222
gdf[ [("Iris-setosa",) , ("Iris-virginica",) ]] #pega apenas 2 dos 3 grupos

# ╔═╡ 47aeb4b0-5aa8-4f69-aade-9bcb94b4f6bf
md" ### Tranformações em grupos"

# ╔═╡ 6c211780-9124-40da-8b1e-94136fbd67a8
md" #### Combine"

# ╔═╡ 337fab2a-fd4a-4599-a921-d67287549f9c
combine(gdf, :PetalLength=>mean)

# ╔═╡ 0bd449bf-2602-4f58-9141-c0aff65ce634
combine(gdf, nrow) #retorna o número de linhas por grupo

# ╔═╡ 3bae609e-2b80-4417-ba51-9337492752b3
combine(gdf, nrow=>:NumRows , :PetalLength =>mean => :Mean)

# ╔═╡ 9b7ffe6b-4a4b-4ff5-ac89-9a4b2ae992c3
combine(gdf, [:PetalLength, :SepalLength] => ((p, s) -> (a=mean(p)/mean(s), b=sum(p))) => AsTable)
#poderia ser passado para um vetor de colunas também
#combine(gdf, [:PetalLength, :SepalLength] => ((p, s) -> (a=mean(p)/mean(s), b=sum(p))) => [:ColA, :ColB])

# ╔═╡ abcf471a-2545-45fc-9166-58ae95aa7383
#valor AsTable, passa um dataframe como parâmetro
combine(gdf,
               AsTable([:PetalLength, :SepalLength]) =>
               x -> std(x.PetalLength) / std(x.SepalLength))

# ╔═╡ aab59bd0-6997-4523-a4c6-efe26624c1f3
combine(gdf, :PetalLength => (x -> [extrema(x)]) => [:min, :max]) 
#retorna os minimos e máximos na forma tuple para cada grupo

# ╔═╡ 42921b6d-cd8e-416e-8259-ca82d8584cc1
combine(gdf, :PetalWidth=>unique)

# ╔═╡ 89648a58-3ebd-4760-b4d4-b24606633156
md" #### Select e Transform"

# ╔═╡ a96f0294-dd65-4b80-ab2e-8ed4ba36bd60
select(gdf, 1:2 => cor)

# ╔═╡ addd9f54-0941-46ad-ab69-5f3117c01b3e
transform(gdf, :Species => x -> chop.(x, head=5, tail=0))
#função chop(string, head=n, tail = m) 
#remove o primeiros n caracteres da string, e os ultimos m caracteres da string

# ╔═╡ 33144eb4-cdb3-47ef-b029-d88963000539
md"Pode-se selecionar grupos desejados a partir de tuples com o valor de separação dos grupos"

# ╔═╡ ea826a09-c36f-4449-9124-36794f1a64a5
md" ### Stack

Tranforma uma tabela curta em tablea longa a partir das colunas selecionada.

Cada linha terá o valor da coluna
"

# ╔═╡ ac76785e-ae4c-4b20-bd43-8c6af93e78b5
stacked = stack(iris, 1:4) #faz um empilhamento das coluna 1:4 (todas menos :value);

# ╔═╡ 03a60ea1-444d-4a7f-ba5f-4cbfc3f6b981
medias_stacked = combine(groupby(stacked, [:Species,:variable]), :value=>mean=> :media)

# ╔═╡ c95d570e-1f5b-4bc0-ba91-d1801b088c8a
unstack(medias_stacked,:Species,:media)

# ╔═╡ 63511ed3-1273-49fe-8050-5fd0e3e70357
md" ### Ordenamento"

# ╔═╡ 75b8f291-3ac6-46f8-b015-c72f5a0712ca
sort(iris) 

# ╔═╡ fd859d3d-05f0-4586-a2f0-fb7f1d820d60
sort(iris, rev=true) #ordena ao contrário

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.8.5"
DataFrames = "~1.2.2"
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

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "344f143fa0ec67e47917848795ab19c6a455f32c"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.32.0"

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

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

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
# ╟─213ede50-faf2-11eb-17ef-9b4b63997a8d
# ╟─cfe9402c-21fe-44b6-a46a-79dc8d609b7e
# ╠═70ae3a73-2252-4346-9292-e433ebea6bb0
# ╠═dfd44fd0-339a-4831-b1a4-542599914be4
# ╠═fe550976-50ed-4974-afbf-64d73c0da5e4
# ╠═acf24730-c5f1-4186-95c9-17dfcaae3c25
# ╠═3394f485-9c9d-40c9-ad5d-f4b7302ca978
# ╠═98e890d4-4b56-444f-94b6-66bdb272c337
# ╠═349ee372-944b-4cdd-a580-d0941416a9b5
# ╠═134339d4-da0a-49d7-9d90-ee67e57f42b8
# ╠═673f9a96-8773-499f-b384-147e5f282686
# ╟─8fa9269a-0093-4dc3-bee2-6d39e22fde9a
# ╠═cdc792a7-bee0-4c8c-a8c1-46941242387b
# ╟─44cffb05-a739-419b-9d68-4fb9b3aabfd3
# ╠═1b489587-3e99-4356-b9c5-1b5691a5ed35
# ╟─57d4f9df-d3f7-453e-b93d-a2766d53eb03
# ╠═d8aeb626-95f5-4a54-881a-86d4dd5a438e
# ╠═740f86a6-1f5a-477b-9c8f-5b388c7938f4
# ╠═a020ad94-349d-41ce-af02-7aa6fff33e5e
# ╠═de67a888-a9aa-4477-b48d-4bb199b2cf60
# ╠═ae30807d-95d0-44d1-9be7-55b75aea00af
# ╟─a616fdcb-8e25-458d-be78-899e0012f4f3
# ╠═e707b267-a29b-40f1-a689-83d94dc6f6b3
# ╟─2df984cb-60d2-447a-9a82-2f0012a9af74
# ╠═95967099-b59b-4bb3-aae9-4b81a883ad84
# ╠═66d581fb-ae28-423b-a998-f835f98f346d
# ╠═07ea3b8b-bae7-41b5-8429-ce86695ca161
# ╠═60de527a-697b-4a03-805e-d2e30e777aa0
# ╟─57ce4db0-459f-4ca1-a88a-6cf531bc362e
# ╠═10bcfc9e-23c1-4a87-aeaa-31a5fe4fadbf
# ╠═70fb0f8b-45fd-4cf4-94fc-f8769ac818a5
# ╠═51031790-038a-4d14-a7d2-c97a0a45b48b
# ╠═a2628481-6ced-41e2-bd77-6c86cdd061b0
# ╟─a28e8624-6da7-4260-a483-70b275ccd227
# ╠═09a1976d-8f3c-4d57-96bb-b92cd3108800
# ╠═04dae648-eb5a-4f01-bf32-e4b5b3b09f4b
# ╠═c4c4ac9a-b214-4651-80ae-5fa5cb632f80
# ╟─4bdd806c-3f7f-4386-98bb-6699d31c53e1
# ╠═b1225148-050e-42af-b6e8-55276ab5c413
# ╠═311a7934-f903-4e94-8a91-d5c127d26ad9
# ╠═e2950bd7-1a10-417d-b2a7-2c5c7d2b24c2
# ╟─b7604637-a911-4096-8f48-4fdc01f02182
# ╠═34c5887e-f36d-4c28-b305-ddd9b0445637
# ╟─12096062-b935-46ae-9839-0d4cc76a214b
# ╠═f0ac36b9-e028-49f1-92b4-7892e536c8af
# ╠═e7713517-210f-4545-81cc-9d1a1d78b412
# ╠═4d294541-f2c5-48b3-b8b7-6dee68880451
# ╠═38bcb63c-c0a3-4e34-98e8-0dc573a9dab1
# ╠═eb4a5cb6-61c0-49fa-b14e-a8cf774c740b
# ╠═828e9f95-e987-437e-89c0-349ae0758fb5
# ╠═df524d25-a2d4-466c-bf19-082e60b7c527
# ╟─929b2820-e568-4d53-8124-f956c700b731
# ╠═72b4e080-795a-4af4-9fb1-676678b42a40
# ╟─d87e13b8-fd10-42c2-a804-28addbbab982
# ╠═9738c507-816b-49e5-b96e-e8bdd724284a
# ╠═3d475ca8-8595-4dee-867c-1f657531b0f4
# ╠═a715bab8-0a10-4233-b5b2-88cba4973e86
# ╠═c5cff247-e077-46e6-bf50-f584dd5e1619
# ╠═94fb1cb6-f0f2-4458-823a-8b1f0570d3b8
# ╠═7c3491b1-f521-4da1-aa44-1de52fe47e1a
# ╠═056907e1-069e-4eda-94a1-ec4e7cfb1423
# ╠═e6b1bbeb-3368-40bd-9102-a36c5214c5dd
# ╠═ef6112df-2515-41e2-bb89-2d28f3c34e4e
# ╠═04552782-b281-4bea-97b5-9dbad44a3571
# ╟─42bfa204-651f-44ce-acc6-d8f7a4205abe
# ╠═0eecdf2c-855f-467c-9d61-946cbd3ff14d
# ╠═59eb7067-5731-40e1-aa11-cc5d1e7099e1
# ╟─c6190a53-ee74-43f2-9394-6a4136ee6c5b
# ╠═84425b4d-203f-468d-bfe5-01ee3697e636
# ╠═a478e663-e445-400a-b1e5-59241a0331de
# ╠═5781e83d-966b-4e82-8c86-213876f6e423
# ╠═63b3e1b1-f279-468a-a257-6fb3fb75ae98
# ╠═02315cae-6523-4c4b-8c7f-6e6bb7d36198
# ╠═b417acff-b3b8-44b9-973d-3176983f58a1
# ╠═80eb2695-5590-48bd-a5bd-cd5e6fa2cb87
# ╠═03ab8498-783a-46db-a2e9-d004278d0f2c
# ╟─687fa62d-dc5e-404a-bec4-b9ddfd53b7a6
# ╠═57678686-1f96-4f73-8eb1-65263ec28106
# ╟─1e6264e0-6166-4b4a-a476-8f887e0acb8e
# ╠═e52308d6-046e-4400-b62f-7ae0eaa21794
# ╠═f4c4cd05-8747-4b83-a448-45dfe746b222
# ╟─47aeb4b0-5aa8-4f69-aade-9bcb94b4f6bf
# ╟─6c211780-9124-40da-8b1e-94136fbd67a8
# ╠═337fab2a-fd4a-4599-a921-d67287549f9c
# ╠═0bd449bf-2602-4f58-9141-c0aff65ce634
# ╠═3bae609e-2b80-4417-ba51-9337492752b3
# ╠═9b7ffe6b-4a4b-4ff5-ac89-9a4b2ae992c3
# ╠═abcf471a-2545-45fc-9166-58ae95aa7383
# ╠═aab59bd0-6997-4523-a4c6-efe26624c1f3
# ╠═42921b6d-cd8e-416e-8259-ca82d8584cc1
# ╠═89648a58-3ebd-4760-b4d4-b24606633156
# ╠═a96f0294-dd65-4b80-ab2e-8ed4ba36bd60
# ╠═addd9f54-0941-46ad-ab69-5f3117c01b3e
# ╟─33144eb4-cdb3-47ef-b029-d88963000539
# ╠═ea826a09-c36f-4449-9124-36794f1a64a5
# ╠═ac76785e-ae4c-4b20-bd43-8c6af93e78b5
# ╠═03a60ea1-444d-4a7f-ba5f-4cbfc3f6b981
# ╠═c95d570e-1f5b-4bc0-ba91-d1801b088c8a
# ╠═63511ed3-1273-49fe-8050-5fd0e3e70357
# ╠═75b8f291-3ac6-46f8-b015-c72f5a0712ca
# ╠═fd859d3d-05f0-4586-a2f0-fb7f1d820d60
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
