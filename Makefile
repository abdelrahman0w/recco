INSTALL_DIR = /usr/local/bin
PROGRAM_NAME = recco

all:
	@echo -e "Run 'make install' to install the program"

install:
	@echo -e "Installing recco to $(INSTALL_DIR)..."
	@sudo mkdir -p $(INSTALL_DIR)/$(PROGRAM_NAME)-dir
	@sudo cp -R src/* $(INSTALL_DIR)/$(PROGRAM_NAME)-dir
	@sudo chmod +x $(INSTALL_DIR)/$(PROGRAM_NAME)-dir/recco.sh
	@sudo ln -sf $(INSTALL_DIR)/$(PROGRAM_NAME)-dir/recco.sh $(INSTALL_DIR)/$(PROGRAM_NAME)
	@echo "Done"

uninstall:
	@echo "Uninstalling program from $(INSTALL_DIR)..."
	@sudo rm -rf $(INSTALL_DIR)/$(PROGRAM_NAME)-dir
	@echo "Done"
