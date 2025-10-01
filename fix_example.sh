#!/bin/bash

# fix_example.sh
# A utility script to validate and fix common repository setup issues
# for GitHub Copilot coding agent training environment

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a file exists
check_file() {
    local file=$1
    if [ -f "$file" ]; then
        print_success "Found: $file"
        return 0
    else
        print_warning "Missing: $file"
        return 1
    fi
}

# Function to check if a directory exists
check_directory() {
    local dir=$1
    if [ -d "$dir" ]; then
        print_success "Found: $dir"
        return 0
    else
        print_warning "Missing: $dir"
        return 1
    fi
}

# Main validation function
validate_repository() {
    print_status "Validating repository structure..."
    echo ""

    local issues=0

    # Check for essential documentation files
    print_status "Checking documentation files..."
    check_file "README.md" || ((issues++))
    check_file "AGENTS.md" || ((issues++))
    check_file "CLAUDE.md" || ((issues++))
    check_file "GEMINI.md" || ((issues++))
    echo ""

    # Check for .github directory structure
    print_status "Checking .github directory structure..."
    check_directory ".github" || ((issues++))
    check_directory ".github/workflows" || ((issues++))
    check_directory ".github/instructions" || ((issues++))
    check_file ".github/copilot-instructions.md" || ((issues++))
    echo ""

    # Check for instruction files
    print_status "Checking instruction files..."
    check_file ".github/instructions/general.instructions.md" || ((issues++))
    check_file ".github/instructions/development.instructions.md" || ((issues++))
    check_file ".github/instructions/testing.instructions.md" || ((issues++))
    check_file ".github/instructions/python.instructions.md" || ((issues++))
    check_file ".github/instructions/javascript.instructions.md" || ((issues++))
    check_file ".github/instructions/wallet-integration.instructions.md" || ((issues++))
    echo ""

    # Check for workflow files
    print_status "Checking workflow files..."
    check_file ".github/workflows/copilot-setup-steps.yml" || ((issues++))
    echo ""

    # Report summary
    echo "================================"
    if [ $issues -eq 0 ]; then
        print_success "All checks passed! Repository structure is complete."
        return 0
    else
        print_warning "Found $issues issue(s). Some files or directories are missing."
        return 1
    fi
}

# Function to fix common issues
fix_issues() {
    print_status "Attempting to fix common issues..."
    echo ""

    # Create .github directory if missing
    if [ ! -d ".github" ]; then
        print_status "Creating .github directory..."
        mkdir -p .github
        print_success "Created .github directory"
    fi

    # Create .github/workflows directory if missing
    if [ ! -d ".github/workflows" ]; then
        print_status "Creating .github/workflows directory..."
        mkdir -p .github/workflows
        print_success "Created .github/workflows directory"
    fi

    # Create .github/instructions directory if missing
    if [ ! -d ".github/instructions" ]; then
        print_status "Creating .github/instructions directory..."
        mkdir -p .github/instructions
        print_success "Created .github/instructions directory"
    fi

    print_success "Basic directory structure has been created/verified."
    echo ""
    print_status "Note: Missing files must be created manually with appropriate content."
}

# Function to display help
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "A utility script to validate and fix common repository setup issues"
    echo "for GitHub Copilot coding agent training environment."
    echo ""
    echo "OPTIONS:"
    echo "  -h, --help       Show this help message"
    echo "  -v, --validate   Validate repository structure (default)"
    echo "  -f, --fix        Attempt to fix common issues"
    echo "  -a, --all        Validate and fix in one step"
    echo ""
    echo "EXAMPLES:"
    echo "  $0                    # Validate repository structure"
    echo "  $0 --validate         # Validate repository structure"
    echo "  $0 --fix              # Fix common issues"
    echo "  $0 --all              # Validate and fix"
    echo ""
}

# Main script logic
main() {
    echo ""
    echo "================================"
    echo "  Repository Setup Validator"
    echo "  GitHub Copilot Agent Training"
    echo "================================"
    echo ""

    # Parse command line arguments
    case "${1:-}" in
        -h|--help)
            show_help
            exit 0
            ;;
        -f|--fix)
            fix_issues
            exit 0
            ;;
        -a|--all)
            validate_repository
            echo ""
            fix_issues
            echo ""
            print_status "Re-validating after fixes..."
            echo ""
            validate_repository
            exit 0
            ;;
        -v|--validate|"")
            validate_repository
            exit $?
            ;;
        *)
            print_error "Unknown option: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
