# Variáveis
ERL_FILES = main.erl src/least_mean_square.erl
BEAM_FILES = $(ERL_FILES:.erl=.beam)

# Regra principal: compila todos os arquivos .erl
all: $(BEAM_FILES)

# Regra para compilar arquivos .erl em .beam
%.beam: %.erl
	erlc $<

# Regra para limpar os arquivos compilados
clean:
	rm -f *.beam src/*.beam