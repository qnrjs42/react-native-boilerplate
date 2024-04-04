#!/bin/bash

# $1 = dev or pro

# 파일 경로 및 이름
pbxproj_file="../ohmy_app.xcodeproj/project.pbxproj"

# 원래 텍스트와 대체할 텍스트
[[ $1 == "dev" ]] && original_text="com\.ohmy-app(-dev)?" || original_text="com\.ohmy-app-dev"
[[ $1 == "dev" ]] && replacement_text="com.ohmy-app-dev" || replacement_text="com.ohmy-app"

# sed 명령어를 사용하여 텍스트 대체
sed -E -i '' "s/$original_text/$replacement_text/g" "$pbxproj_file"

echo "$original_text, $replacement_text"
echo "$1 app_identifier로 변경 완료"

exit 0