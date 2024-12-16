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

export async function isWatchPaired(): Promise<any> {
  return await Wearables.getIsPaired();
}

export async function isWatchAppInstalled(): Promise<any> {
  return await Wearables.getIsWatchAppInstalled();
}

export async function sendMessage(message: Record<string, any>): Promise<any> {
  return await Wearables.sendMessage(message);
}
