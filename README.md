## React Native Fastlane 세팅 문서

https://www.notion.so/qnrjs42/react-native-fastlane-feat-code-push-a6c33a4f71cf4145a919633f2ad8eda8?pvs=4

## Android 세팅 준비 중...

## Config

### Config 구조

```sh
/config
  /dev
    .env
    config.json
    sentry.properties
  /pro
    .env
    config.json
    sentry.properties
  AppCenter-Config.plist
  config.json
  sentry.properties

/ios
  /fastlane
    .env.dev
    .env.pro
  /ohmy_app
    AppCenter-Config.plist
  sentry.properties
```

### Config - .env 생성

```sh
# config/dev/.env
# config/pro/.env
# .env

SENTRY_ORG=qnrjs42
SENTRY_PROJECT=react-native
SENTRY_AUTH_TOKEN=sntrys_eyJpYXQiOjE3M...
```

### Config - config.json 생성

```json
// config/dev/config.json
// config/pro/config.json
// config/config.json

{
  "mode": "development",
  "sentry_dsn": "https://2af46c6c813c2ecde638dfb947497a3a@o4507015950172160.ingest.us.sentry.io/4507015982219264"
}
```

### Config - AppCenter-Config.plist 생성

```xml
<!-- ios/ohmy_app/AppCenter-Config.plist -->
<!-- config/AppCenter-Config.plist -->

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "https://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
  <key>AppSecret</key>
  <string>1e2e3e4b-5e67-8fe9-1d0c-11e1ad2f1eb3</string>
  </dict>
</plist>
```

### Config - sentry.properties 생성

```sh
# ios/sentry.properties
# android/sentry.properties
# config/dev/sentry.properties
# config/pro/sentry.properties

auth.token=sntrys_eyJpYXQiOjE3M...

defaults.org=qnrjs42
defaults.project=react-native

defaults.url=https://sentry.io/

```

create sentry auth token: https://docs.sentry.io/product/accounts/auth-tokens/

### Fastlane - ios .env 생성

```sh
# ios/fastlane/.env.dev

FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=nqva-oxxd-ahkz-yzql
APP_IDENTIFIER=com.ohmy-app-dev
APPLE_ID=qnrjs42@gmail.com
ITC_TEAM_ID=12345678
TEAM_ID=9ABCDEFG
CODEPUSH_DEPLOYMENT_KEY=XdeGGM3B1IqStiD99SKZz_b0CM-crlhZBtPKY
```

```sh
# ios/fastlane/.env.pro

FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD=nqva-oxxd-ahkz-yzql
APP_IDENTIFIER=com.ohmy-app
APPLE_ID=qnrjs42@gmail.com
ITC_TEAM_ID=12345678
TEAM_ID=9ABCDEFG
CODEPUSH_DEPLOYMENT_KEY=4HWU_qGwc1t7I8ybKJNa6M79QeN-SMO1kWSsL
```

## Install

```sh
yarn install
npx pod-install ios or cd ios && pod install
```

## Run

```sh
yarn clean-watchman

yarn start
yarn ios or yarn android
```

## Deploy TestFlight

```sh
yarn run deploy-ios-dev
```

## Deploy Code Push And Upload Sourcemap

```sh
yarn run codepush-upload-sourcemap-ios-dev
```
