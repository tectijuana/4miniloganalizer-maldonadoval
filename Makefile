PROJECT := analyzer
SRC := src/analyzer.s

AS = as
LD = ld

all: $(PROJECT)

$(PROJECT): $(SRC)
	$(AS) -o $(PROJECT).o $(SRC)
	$(LD) -o $(PROJECT) $(PROJECT).o

run: $(PROJECT)
	cat data/logs_C.txt | ./analyzer

clean:
	rm -f $(PROJECT) $(PROJECT).o

