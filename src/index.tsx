import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-wearables' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const Wearables = NativeModules.Wearables
  ? NativeModules.Wearables
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function isWatchPaired(): Promise<boolean> {
  return Wearables.getIsPaired();
}

export function isWatchAppInstalled(): Promise<boolean> {
  return Wearables.getIsWatchAppInstalled();
}

export function sendMessage(message: string): Promise<any> {
  return Wearables.sendMessage(message);
}

export function sendMessageData(
  message: string,
  encoding: number
): Promise<any> {
  return Wearables.sendMessageData(message, encoding);
}
