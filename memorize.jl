using DataFrames, NCDataFrame, CSV, Feather

function load_csv(path::String)
	df = CSV.read(path, DataFrame)
	df
end

# function write_nc(df::DataFrame, path::String)
# 	writenc(df, path)
# end

struct Errata
	index::Int
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
			push!(erratum, Errata(i, x, y))
		end
	end

	return score / length(array1) * 100, erratum
end

function do_test_once(sentence1::String, sentence2::String)
	score, erratum = match_two_sentences(sentence1, sentence2)

	if score == 100
		println("score: $score")
	else
		println("score: $score, errata: $erratum")
	end

	return score
end

function do_test(path::String, range::UnitRange{Int64})
	df = Feather.read(path)
	total_score = Vector{Float64}(undef, length(range))

	for i in range
		ans = df[i, :Sentence]
		mean = df[i, :Meaning]
		println(mean)
		println("")
		print("> ")
		user_ans = readline()
		score = do_test_once(user_ans, ans)
		total_score[i] = score
		println("=========================================================")
	end

	println("score results: ", total_score)
	println("total score: ", sum(total_score) / length(total_score))
end
	

function main()
	# df = load_csv("data/sentence.csv")
	# write_nc(df, "data/sentence.nc")

	#df = readnc("data/sentence.nc")
	# Feather.write("data/sentence.feather", df)
	println("=========================================================")
	println("||                     Memorize Test                   ||")
	println("=========================================================")

	do_test("data/sentence.feather", 1:2)
end

main()