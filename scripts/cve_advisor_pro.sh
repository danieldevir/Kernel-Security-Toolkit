#!/bin/bash
# =============================================
# 🛡️ CVE Advisor Pro - Advanced CVE Intelligence
# Author: Daniel Baradaran
# Usage: ./cve_advisor_pro.sh <CVE-ID>
# Example: ./cve_advisor_pro.sh CVE-2024-6387
# =============================================

CVE_ID=$1
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if [ -z "$CVE_ID" ]; then
    echo -e "${RED}❌ Usage: ./cve_advisor_pro.sh <CVE-ID>${NC}"
    exit 1
fi

echo -e "${BLUE}🔍 Hunting down $CVE_ID from NVD database...${NC}"

# =============================================
# Step 1: Fetch raw data from NVD API
# =============================================
API_URL="https://services.nvd.nist.gov/rest/json/cves/2.0?cveId=$CVE_ID"
RESPONSE=$(curl -s "$API_URL")

if echo "$RESPONSE" | grep -q '"totalResults":0'; then
    echo -e "${RED}❌ CVE $CVE_ID not found in NVD.${NC}"
    exit 1
fi

# =============================================
# Step 2: Extract full details (using grep/sed)
# =============================================
DESCRIPTION=$(echo "$RESPONSE" | grep -o '"description":\[{"lang":"en","value":"[^"]*"' | head -1 | sed 's/"description":\[{"lang":"en","value":"//' | sed 's/"$//')
CVSS_SCORE=$(echo "$RESPONSE" | grep -o '"baseScore":[0-9.]*' | head -1 | sed 's/"baseScore"://')
SEVERITY=$(echo "$RESPONSE" | grep -o '"baseSeverity":"[^"]*"' | head -1 | sed 's/"baseSeverity":"//' | sed 's/"$//')
PUBLISHED=$(echo "$RESPONSE" | grep -o '"published":"[^"]*"' | head -1 | sed 's/"published":"//' | sed 's/"$//')
MODIFIED=$(echo "$RESPONSE" | grep -o '"lastModified":"[^"]*"' | head -1 | sed 's/"lastModified":"//' | sed 's/"$//')
VECTOR=$(echo "$RESPONSE" | grep -o '"vectorString":"[^"]*"' | head -1 | sed 's/"vectorString":"//' | sed 's/"$//')
ATTACK_VECTOR=$(echo "$VECTOR" | grep -o 'AV:[NLAP]' | cut -d: -f2)
PRIVILEGES=$(echo "$VECTOR" | grep -o 'PR:[NLH]' | cut -d: -f2)
USER_INTERACTION=$(echo "$VECTOR" | grep -o 'UI:[NR]' | cut -d: -f2)
SCOPE=$(echo "$VECTOR" | grep -o 'S:[UC]' | cut -d: -f2)
CONFIDENTIALITY=$(echo "$VECTOR" | grep -o 'C:[NLH]' | cut -d: -f2)
INTEGRITY=$(echo "$VECTOR" | grep -o 'I:[NLH]' | cut -d: -f2)
AVAILABILITY=$(echo "$VECTOR" | grep -o 'A:[NLH]' | cut -d: -f2)

# Extract affected products (CPE list)
CPE_LIST=$(echo "$RESPONSE" | grep -o '"cpeName":"[^"]*"' | head -5 | sed 's/"cpeName":"//' | sed 's/"$//')

# =============================================
# Step 3: Generate risk assessment
# =============================================
RISK_LEVEL="🟢 LOW"
if [ -n "$CVSS_SCORE" ]; then
    if (( $(echo "$CVSS_SCORE >= 9.0" | bc -l) )); then
        RISK_LEVEL="🔴 CRITICAL"
    elif (( $(echo "$CVSS_SCORE >= 7.0" | bc -l) )); then
        RISK_LEVEL="🟠 HIGH"
    elif (( $(echo "$CVSS_SCORE >= 4.0" | bc -l) )); then
        RISK_LEVEL="🟡 MEDIUM"
    else
        RISK_LEVEL="🟢 LOW"
    fi
fi

# =============================================
# Step 4: Build the advisory report
# =============================================
OUTPUT_FILE="${CVE_ID}_advisory.txt"

cat > "$OUTPUT_FILE" <<EOF
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║         🛡️  CVE ADVISORY PRO  -  ADVANCED THREAT INTELLIGENCE        ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝

📌 CVE ID          : $CVE_ID
📅 Published       : $PUBLISHED
🔄 Last Modified   : $MODIFIED
📊 Severity        : ${SEVERITY:-N/A}
🎯 Risk Level      : $RISK_LEVEL
💥 CVSS Score      : ${CVSS_SCORE:-N/A} / 10.0

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📖 DESCRIPTION:
$DESCRIPTION

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔐 ATTACK VECTOR ANALYSIS:
┌─────────────────────────────────────────────────────────────────────┐
│ Attack Vector        : ${ATTACK_VECTOR:-Unknown}                    │
│ Privileges Required  : ${PRIVILEGES:-Unknown}                      │
│ User Interaction     : ${USER_INTERACTION:-Unknown}                │
│ Scope                : ${SCOPE:-Unknown}                           │
│ Confidentiality      : ${CONFIDENTIALITY:-Unknown}                 │
│ Integrity            : ${INTEGRITY:-Unknown}                       │
│ Availability         : ${AVAILABILITY:-Unknown}                    │
└─────────────────────────────────────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💻 AFFECTED PRODUCTS (Sample):
$CPE_LIST

🔍 HOW TO CHECK IF YOU'RE AFFECTED:
1️⃣ Identify your software version:
   - Linux: uname -a
   - Android: getprop ro.build.version.release

2️⃣ Compare with affected products listed above.

3️⃣ Check vendor advisories.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔧 RECOMMENDED ACTIONS:
${SEVERITY}
- 🔴 CRITICAL: Apply patch immediately. This vulnerability is being actively exploited.
- 🟠 HIGH: Apply patch within 48 hours.
- 🟡 MEDIUM: Apply patch within the next patch cycle.
- 🟢 LOW: Monitor and apply patch when convenient.

📌 Additional Recommendations:
• Restrict network access to affected systems
• Enable logging and monitoring
• Check for Indicators of Compromise (IoCs)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 REFERENCES & SOURCES:
• NVD Entry        : https://nvd.nist.gov/vuln/detail/$CVE_ID
• MITRE CVE        : https://cve.mitre.org/cgi-bin/cvename.cgi?name=$CVE_ID
• Google Security  : https://security.googleblog.com/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️  DISCLAIMER:
This information is provided for educational and research purposes only.
Always test patches in a controlled environment before applying to production.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Stay curious. Stay kind. — Daniel Baradaran
EOF

echo -e "${GREEN}✅ Advisory saved to: $OUTPUT_FILE${NC}"
cat "$OUTPUT_FILE"
