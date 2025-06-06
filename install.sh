#!/bin/bash

# Function to check if a Python package is installed
is_installed() {
    pip show "$1" &> /dev/null
    return $?
}

# Check and install dependencies
echo "Checking dependencies from requirements.txt..."
missing_dependencies=()

while IFS= read -r package; do
    pkg_name=$(echo "$package" | cut -d'=' -f1)
    if ! is_installed "$pkg_name"; then
        echo "$pkg_name is not installed."
        missing_dependencies+=("$package")
    else
        echo " ✅ $pkg_name is already installed."
    fi
done < requirements.txt

if [ ${#missing_dependencies[@]} -gt 0 ]; then
    echo "Installing missing dependencies..."
    for dependency in "${missing_dependencies[@]}"; do
        pip install "$dependency"
    done
else
    echo " 😊 All dependencies are already installed."
fi

# Install Playwright browsers
 playwright install
