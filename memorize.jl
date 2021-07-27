using DataFrames, NCDataFrame, CSV, Feather

function load_csv(path::String)
	df = CSV.read(path, DataFrame)
	df
end

# function write_nc(df::DataFrame, path::String)
# 	writenc(df, path)
# end

struct Errata
	index::UInt
	answer::String
	errata::String
end

function match_two_sentences(sentence1::String, sentence2::String)
	array1 = split(sentence1)
	array2 = split(sentence2)
	
	score = 0
	erratum = []

	for (i, (x, y)) in enumerate(zip(array1, array2))
		if x == y
			score = score + 1
		else
			erratum.append(Errata(i, x, y))
		end
	end

	return score / length(array1) * 100, erratum
end

function do_test_once(sentence1::String, sentence2::String, total_score::Vector{T}) where T <: Number
	score, erratum = match_two_sentences(sentence1, sentence2)

	if score == 100
		println("score: $score")
	else
		println("score: $score, errata: $erratum")
	end

	push!(total_score, score)
end
	

function main()
	# df = load_csv("data/sentence.csv")
	# write_nc(df, "data/sentence.nc")

	#df = readnc("data/sentence.nc")
	# Feather.write("data/sentence.feather", df)

	df = Feather.read("data/sentence.feather")
	
	sentence1 = df[1, :Sentence]
	mean1 = df[1, :Meaning]
	println(mean1)
	sentence2 = readline()

	score, erratum = match_two_sentences(sentence1, sentence2)

	println(score)
	println(erratum)
end

main()