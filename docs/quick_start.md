# Quick Start Guide for Kernel Analysis

## Step 1: Download a Kernel Source

### Android Kernel
```bash
git clone https://android.googlesource.com/kernel/common.git android-kernel
cd android-kernel
```
Qualcomm Kernel (if available)
```bash
git clone https://source.codeaurora.org/quic/la/kernel/msm-4.14.git
```
Step 2: Run the Analysis Scripts
Find Dangerous Patterns
bash
../scripts/find_dangerous_patterns.sh .
```
This will generate four result files:

copy_from_user_results.txt

kmalloc_results.txt

mutex_results.txt

uninitialized_results.txt

Run Coccinelle Checks
```bash
# Check for missing NULL checks after kmalloc
spatch --sp-file ../scripts/coccinelle_checks/kmalloc_check.cocci --dir . --no-includes

# Check for missing mutex_unlock in error paths
spatch --sp-file ../scripts/coccinelle_checks/mutex_check.cocci --dir . --no-includes
```
Step 3: Review the Results
Use less to view results:

```bash
less copy_from_user_results.txt
```
Look for:

Functions that receive user input without proper validation

Missing error checks

Potential race conditions

Step 4: Manual Verification
For each finding, check:

Is the variable controlled by user input?

Is there a check missing?

Can this lead to panic or code execution?

Step 5: Write a Report
Include:

Vulnerable code snippet

Explanation of the impact

Proposed fix

Proof of Concept (if possible)

🔗 Resources
Linux Kernel Source

Android Kernel Source

Coccinelle Documentation
