.PHONY : all clean realclean

GCPP=g++
GCPPFLAGS=
DEPS =

CODE_IN = code
CODE_OUT = bin

CODE_SRC = $(wildcard ${CODE_IN}/*.cpp)
CODE_TARGETS = $(patsubst ${CODE_IN}/%.cpp, ${CODE_OUT}/%.out, ${CODE_SRC})

${CODE_OUT}/%.out: $(CODE_IN)/%.cpp $(DEPS)
	$(GCPP) -o $@ $< $(GCPPFLAGS)

CPP_IN = markdown
CPP_OUT = html

CPPHEADER = ${CPP_OUT}/header.html
CPPFOOTER = ${CPP_OUT}/footer.html

CPP_HEADFOOT_SRC := ${CPP_IN}/header.md ${CPP_IN}/footer.md
CPP_HEADFOOT_TARGETS := ${CPP_OUT}/header.html ${CPP_OUT}/footer.html
CPP_SRC := $(filter-out ${CPP_HEADFOOT_SRC}, $(wildcard ${CPP_IN}/*.md))
CPP_TARGETS := $(patsubst ${CPP_IN}/%.md, ${CPP_OUT}/%.html, ${CPP_SRC})

#${CPP_OUT}/header.html : ${CPP_IN}/header.md
	#@${HOME}/bin/pan2html.sh $< $@

#${CPP_OUT}/footer.html : ${CPP_IN}/footer.md
	#@${HOME}/bin/pan2html.sh $< $@

#index.html : index.md
	#@${HOME}/bin/md2html.sh ${CPPHEADER} ${CPPFOOTER} $< $@

${CPP_OUT}/%.html : ${CPP_IN}/%.md
	@${HOME}/bin/pan2html.sh ${CPP_IN}/footer.md ${CPP_OUT}/footer.html
	@${HOME}/bin/pan2html.sh ${CPP_IN}/header.md ${CPP_OUT}/header.html
	@${HOME}/bin/md2html.sh ${CPPHEADER} ${CPPFOOTER} index.md index.html
	@${HOME}/bin/md2html.sh ${CPPHEADER} ${CPPFOOTER} $< $@

cpp : ${CODE_TARGETS} ${CPP_TARGETS}

clean :
	rm -f ${CPP_HEADFOOT_TARGETS} $(CPP_TARGETS) index.html

realclean :
	rm -f $(CODE_TARGETS) ${CPP_HEADFOOT_TARGETS} $(CPP_TARGETS) index.html
