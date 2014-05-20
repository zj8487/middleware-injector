all: install

install:
	npm install

build: install
	node node_modules/coffee-script/bin/coffee -c .

clean:
	find . -path './node_modules' -prune -o -name '*.js' -exec rm -fr {} \;
