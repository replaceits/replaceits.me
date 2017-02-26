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

ESCAPE_SED = sed -e 's/[]\/$*.^|[]/\\&/g'

ERRORS_PATH        = ./errors/
ERRORS_FILES       = $(shell find $(ERRORS_PATH) -type f -name '*.php')
ERRORS_TARGET_PATH = $(BUILD_PATH)errors/
ERRORS_TMP_TARGET  = $(shell echo $(ERRORS_PATH) | $(ESCAPE_SED))
ERRORS_TMP_TARGET_PATH = $(shell echo $(ERRORS_TARGET_PATH) | $(ESCAPE_SED))
ERRORS_TARGETS     = $(shell echo $(ERRORS_FILES) | sed 's/$(ERRORS_TMP_TARGET)/$(ERRORS_TMP_TARGET_PATH)/g')

IMAGES_PATH        = ./images/
IMAGES_FILES       = $(shell find $(IMAGES_PATH) -type f -name '*.png')
IMAGES_TARGET_PATH = $(BUILD_PATH)images/
IMAGES_TMP_TARGET  = $(shell echo $(IMAGES_PATH) | $(ESCAPE_SED))
IMAGES_TMP_TARGET_PATH = $(shell echo $(IMAGES_TARGET_PATH) | $(ESCAPE_SED))
IMAGES_TARGETS     = $(shell echo $(IMAGES_FILES) | sed 's/$(IMAGES_TMP_TARGET)/$(IMAGES_TMP_TARGET_PATH)/g')

FILES_PATH        = ./files/
FILES_FILES       = $(shell find $(FILES_PATH) -type f -name '*.*')
FILES_TARGET_PATH = $(BUILD_PATH)files/
FILES_TMP_TARGET  = $(shell echo $(FILES_PATH) | $(ESCAPE_SED))
FILES_TMP_TARGET_PATH = $(shell echo $(FILES_TARGET_PATH) | $(ESCAPE_SED))
FILES_TARGETS     = $(shell echo $(FILES_FILES) | sed 's/$(FILES_TMP_TARGET)/$(FILES_TMP_TARGET_PATH)/g')

HTML_FILE = index.html
MISC_FILES = humans.txt robots.txt sitemap.xml favicon.ico message.php

BUILD_PATH_ESCAPED = $(shell echo $(BUILD_PATH) | $(ESCAPE_SED))
HTML_FILE_TARGET = $(shell echo $(HTML_FILE) | sed 's/^/$(BUILD_PATH_ESCAPED)/g')
MISC_FILES_TARGET = $(shell echo $(MISC_FILES) | sed 's/ /\n/g' | sed 's/^/$(BUILD_PATH_ESCAPED)/g')

DIRECTORIES     = $(BUILD_PATH) $(CSS_TARGET_PATH) $(JS_TARGET_PATH) $(ERRORS_TARGET_PATH) $(IMAGES_TARGET_PATH) $(FILES_TARGET_PATH)

all: | $(DIRECTORIES) css js errors html misc images files

css: $(SCSS_FILES) | $(DIRECTORIES) $(CSS_TARGET) 

js: $(JS_FILES) | $(DIRECTORIES) $(JS_TARGET)

errors: $(ERRORS_FILES) | $(DIRECTORIES) $(ERRORS_TARGETS)

html: $(HTML_FILE) | $(DIRECTORIES) $(HTML_FILE_TARGET)

misc: $(MISC_FILES) | $(DIRECTORIES) $(MISC_FILES_TARGET)

images: $(IMAGES_FILES) | $(DIRECTORIES) $(IMAGES_TARGETS)

files: $(FILES_FILES) | $(DIRECTORIES) $(FILES_TARGETS)

$(FILES_TARGETS): $(FILES_FILES)
	@echo -e "Copying Files files...\t\t\t\c"
	@cp $(FILES_FILES) $(FILES_TARGET_PATH)
	@echo -e "[ Done ]"

$(IMAGES_TARGETS): $(IMAGES_FILES)
	@echo -e "Copying Images files...\t\t\t\c"
	@cp $(IMAGES_FILES) $(IMAGES_TARGET_PATH)
	@echo -e "[ Done ]"

$(HTML_FILE_TARGET): $(HTML_FILE)
	@echo -e "Copying HTML files...\t\t\t\c"
	@cp $(HTML_FILE) $(BUILD_PATH)
	@echo "[ Done ]"

$(MISC_FILES_TARGET): $(MISC_FILES)
	@echo -e "Copying Misc files...\t\t\t\c"
	@cp $(MISC_FILES) $(BUILD_PATH)
	@echo "[ Done ]"

$(ERRORS_TARGETS): $(ERRORS_FILES)
	@echo -e "Copying Error files...\t\t\t\c"
	@cp $(ERRORS_FILES) $(ERRORS_TARGET_PATH)
	@echo -e "[ Done ]"

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
	@mkdir -p $(ERRORS_TARGET_PATH)
	@mkdir -p $(IMAGES_TARGET_PATH)
	@mkdir -p $(FILES_TARGET_PATH)
	@echo "[ Done ]"

clean:
	@rm -rf $(CSS_TARGET_PATH) $(JS_TARGET_PATH) $(BUILD_PATH) $(BUILD)
