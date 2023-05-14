# Test Toolkit

## Git Hooks

We recommend using the Git Hooks, provided in the `.githooks` folder. 

To use them, simply configure the git config hooks path:

```shell
git config core.hooksPath .githooks/
```

## Flutter Version Manager

FVM move flutter version dependency from global machine configuration to project specific configuration file.

Check the [reference](https://fvm.app/docs/getting_started/overview) for more information.

### Setup

In order to install FVM globally run the following command:

```shell
dart pub global activate fvm
```

Install project specific Flutter version:

```shell
fvm install
```

#### Visual Studio Code

Add the following configuration to `.vscode/settings.json`:

```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk",
  "search.exclude": {
    "**/.fvm": true
  },
  "files.watcherExclude": {
    "**/.fvm": true
  }
}
```

#### Jetbrains IDEs

Open **Settings** and got to `Languages & Frameworks > Flutter`.

Change Flutter SDK path to **absolute** path of FVM _symlink_: 
`/{PROJECT_PATH}/.fvm/flutter_sdk`

### Commands

When you run any `flutter` or `dart` commands from terminal, prefix command with `fvm` like the following example:

```shell
# before
flutter run

# after
fvm flutter run
```