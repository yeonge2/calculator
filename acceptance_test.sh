#!/bin/bash

#curl 결과를 result 변수에 저장
#result=$(docker exec calcForStaging curl -s "http://localhost:8081/sum?a=1&b=2") - success
#result=$(docker exec calcForStaging curl -s "http://localhost:8765/sum?a=1&b=2") - failure
#result=$(curl -s "http://localhost:8081/sum?a=1&b=2") - failure
result=$(curl -s "http://localhost:8765/sum?a=1&b=2")
echo "$result"
# 기대값을 설정: 100+172=272
expected=3

# 결과값이 기대값과 동일한지 체크
if [ "$result" -eq "$expected" ]; then
    exit 0 #pass
else
    echo "Test failed. expected $expected, but result is $result"
    exit 1
fi

