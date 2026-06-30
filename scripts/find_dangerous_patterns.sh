#!/bin/bash
# find_dangerous_patterns.sh – Search for dangerous kernel patterns (Improved)

echo "🔍 Searching for dangerous kernel patterns..."

if [ -z "$1" ]; then
    echo "❌ Error: No directory specified."
    echo "Usage: ./find_dangerous_patterns.sh <kernel_source_directory>"
    exit 1
fi

KERNEL_DIR=$1

if [ ! -d "$KERNEL_DIR" ]; then
    echo "❌ Error: Directory '$KERNEL_DIR' does not exist."
    exit 1
fi

echo "📁 Searching in: $KERNEL_DIR"

# Pattern 1: copy_from_user without size check
echo "📌 Pattern 1: copy_from_user without size check"
grep -r --include="*.c" -A 5 -B 2 "copy_from_user" "$KERNEL_DIR" | grep -v "if (.*size" > copy_from_user_results.txt

# Pattern 2: kmalloc without NULL check (exclude generated files)
echo "📌 Pattern 2: kmalloc without NULL check"
grep -r --include="*.c" -A 3 -B 1 "kmalloc(" "$KERNEL_DIR" | grep -v -E "(flex|lex|parse|yacc)" | grep -v "if (.*NULL" > kmalloc_results.txt

# Pattern 3: mutex_lock without matching unlock (exclude generated files)
echo "📌 Pattern 3: mutex_lock without matching unlock"
grep -r --include="*.c" -A 3 -B 1 "mutex_lock(" "$KERNEL_DIR" | grep -v -E "(flex|lex|parse|yacc)" | grep -v "mutex_unlock" > mutex_results.txt

# Pattern 4: Uninitialized variables (improved and filtered)
echo "📌 Pattern 4: Potential uninitialized variables"
grep -r --include="*.c" -n -A 2 -B 1 -E "(int|char|long|unsigned) [a-zA-Z_][a-zA-Z0-9_]*\s*[;,]" "$KERNEL_DIR" | \
grep -v -E "(flex|lex|parse|yacc|\.tmp_|\.o\.)" | \
grep -v " = " | \
grep -v "//" > uninitialized_results.txt

echo "✅ Analysis complete! Check the following files:"
echo "  - copy_from_user_results.txt"
echo "  - kmalloc_results.txt"
echo "  - mutex_results.txt"
echo "  - uninitialized_results.txt"
