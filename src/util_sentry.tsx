import * as Sentry from '@sentry/react-native';
import CodePush from 'react-native-code-push';

import config from '@config';
import pkg from '@root/package.json';

export default (app: any) => Sentry.wrap(app);

export const utilSentryInit = (
  passedOptions: Sentry.ReactNativeOptions,
): void => {
  Sentry.init(passedOptions);
};
export const utilSentryCaptureException = (error: any): void => {
  Sentry.captureException(error);
};
export const utilSentryCaptureMessage = (message: string): void => {
  Sentry.captureMessage(message);
};
export const utilSentrySetUser = (data: Sentry.User): void => {
  Sentry.setUser(data);
};
export const utilSentrySetTag = (key: string, data: string | number): void => {
  Sentry.setTag(key, data);
};
export const utilSentryCaptureEvent = (event: Sentry.Event): void => {
  Sentry.captureEvent(event);
};
// export const utilSentryCrash = (): void => {
//   Sentry.nativeCrash();
// };

const routingInstrumentation = new Sentry.ReactNavigationInstrumentation();

export const sentryInitData: Sentry.ReactNativeOptions = {
  dsn: config.sentry_dsn,
  environment: config.mode,
  tracesSampleRate: 1.0,
  integrations: [
    new Sentry.ReactNativeTracing({
      routingInstrumentation,
    }),
  ],
};

Sentry.init({
  ...sentryInitData,
  release: `${pkg.version}_store`,
  dist: 'store',
});

CodePush.getUpdateMetadata().then(update => {
  if (update) {
    Sentry.init({
      ...sentryInitData,
      release: `${update.appVersion}+codepush:${update.label}`,
      dist: update.label,
    });
  }
});
