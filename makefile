BUILD           = ./build/
BUILD_PATH      = $(BUILD)replaceits.me/
BUILD_TMP_PATH  = $(BUILD)tmp/

SCSS_PATH       = ./scss/
SCSS_MAIN       = $(SCSS_PATH)replaceits.me.scss
SCSS_FILES      = $(shell find $(SCSS_PATH) -type f -name '*.scss')

CSS_TARGET_PATH = $(BUILD_PATH)css/
CSS_TARGET      = $(CSS_TARGET_PATH)replaceits.me.css

JS_PATH         = ./js/
JS_FILES        = $(shell find $(JS_PATH) -type f -name '*.js')
JS_TARGET_PATH  = $(BUILD_PATH)js/
JS_TARGET       = $(JS_TARGET_PATH)replaceits.me.js
JS_TMP_TARGET   = $(BUILD_TMP_PATH)tmp.js

DIRECTORIES     = $(BUILD_PATH) $(CSS_TARGET_PATH) $(JS_TARGET_PATH)

all: | $(DIRECTORIES) css js

css: $(SCSS_FILES) | $(DIRECTORIES) $(CSS_TARGET) 

js: $(JS_FILES) | $(DIRECTORIES) $(JS_TARGET)

$(CSS_TARGET): $(SCSS_FILES)
	@echo -e "Compiling SCSS...\t\t\t\c"
	@scss -C --sourcemap=none $(SCSS_MAIN) $(CSS_TARGET) -t compressed 
	@echo -e "[ Done ]"

$(JS_TARGET): $(JS_FILES)
	@echo -e "Concating JS files...\t\t\t\c"
	@mkdir -p $(BUILD_TMP_PATH)
	@rm -f $(JS_TMP_TARGET)
	@for JS in $(JS_FILES); do \
		cat $$JS >> $(JS_TMP_TARGET); \
	done
	@echo -e "[ Done ]\nCompressing JS...\t\t\t\c"
	@yuicompressor --type js --charset utf-8 --nomunge -o $(JS_TARGET) $(JS_TMP_TARGET) > /dev/null 2>&1
	@rm -rf $(BUILD_TMP_PATH)
	@echo "[ Done ]"

$(DIRECTORIES):
	@echo -e "Making directories...\t\t\t\c"
	@mkdir -p $(BUILD)
	@mkdir -p $(BUILD_PATH)
	@mkdir -p $(JS_TARGET_PATH)
	@mkdir -p $(CSS_TARGET_PATH)
	@echo "[ Done ]"

clean:
	@rm -rf $(CSS_TARGET_PATH) $(JS_TARGET_PATH) $(BUILD_PATH) $(BUILD)
