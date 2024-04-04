#!/bin/bash

# $1 dev or pro


# Step 1 - CodePush
[[ $1 == "dev" ]] && sentryDeployment="Staging" || sentryDeployment="Production"
appcenter codepush release-react -a qnrjs42/ohmy-app-ios --sourcemap-output-dir ./build --output-dir ./build --use-hermes -d $sentryDeployment


# Step 2 - Get CodePush Deployment List
text=$(appcenter codepush deployment list -a qnrjs42/ohmy-app-ios)
# ex)
# text=$(cat <<'EOF'
# ┌────────────┬────────────────────────────────┬──────────────────────┐
# │ Name       │ Update Metadata                │ Install Metrics      │
# ├────────────┼────────────────────────────────┼──────────────────────┤
# │ Production │ Label: v2                      │ No installs recorded │
# │            │ App Version: 1.0.9             │                      │
# │            │ Mandatory: No                  │                      │
# │            │ Release Time: Apr 02, 10:39 AM │                      │
# │            │ Released By: qnrjs42@naver.com │                      │
# ├────────────┼────────────────────────────────┼──────────────────────┤
# │ Staging    │ Label: v10                     │ Active: 17% (1 of 6) │
# │            │ App Version: 1.0.13            │ Installed: 1         │
# │            │ Mandatory: No                  │                      │
# │            │ Release Time: Apr 03, 11:02 AM │                      │
# │            │ Released By: qnrjs42@naver.com │                      │
# └────────────┴────────────────────────────────┴──────────────────────┘
# EOF
# )

# Step 3 - dev이면 Staging, pro이면 Production의 Label, App Version 추출
[[ $1 == "dev" ]] && result=$(echo "$text" | tail -n 6) || result=$(echo "$text" | head -n 6)
label=$(echo "$result" | grep -oE 'Label:\s*\S+' | cut -d ':' -f 2 | tr -d '[:space:]')
appVersion=$(echo "$result" | grep -oE 'App Version:\s*\S+' | cut -d ':' -f 2 | tr -d '[:space:]')

# Step 4 - Sentry Upload Sourcemap
npx sentry-cli sourcemaps upload --debug-id-reference --release=$appVersion+codepush:$label --dist=$label --strip-prefix ./ build/CodePush/main.jsbundle build/main.jsbundle.map

echo "code-push sourcemap upload success"

exit 0