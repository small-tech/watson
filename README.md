# Watson

> “It’s elementary, my dear…”

Watson is an application template for elementary OS 6 (Odin).

Watson will get you up and running with scaffolding that compiles on elementary OS 6 (Odin) and follows elementary OS 6 best practices (e.g., [code style](https://docs.elementary.io/develop/writing-apps/code-style)). Once you’ve made it your own, you can submit your app for inclusion in the [AppCenter](https://docs.elementary.io/develop/appcenter/publishing-requirements) as a curated app.

## What Watson is (and what Watson is not).

The scaffolding that’s included is based on the [elementary OS Developer Documentation](https://docs.elementary.io/develop/) and [elementary OS Human Interface Guidelines](https://docs.elementary.io/hig/).

If you haven’t already done so, we highly recommended you read through both of these important resources before continuing.

Also, to refer to language or library details during development, bookmark [Valadoc](https://valadoc.org/).

_Watson is not a substitute for knowing what you’re doing. It is meant to lower the barrier of entry to creating an elementary OS application by automating the start of a new project and ensure you do not misconfigure your project or leave out important aspects (like translations). So, again, please read the above documents before starting to develop apps for elementary OS._

## Getting started

### On GitHub:

1. __Press the green “Use this template” button__ for this repository to create your new project’s repository using Watson as the template.

### On your development machine:

2. __Clone your project__ and switch to its directory in Terminal:

    ```shell
    git clone git@github.com:<my-org>/<my-app>.git
    cd <my-app>
    ```

3. __Initialise your project__:

    ```shell
    ./watson
    ```

> __Note on the GitHub-centric workflow:__ The elementary OS AppCenter currently ties application bundle IDs and the directory structure for assets, etc., to the GitHub project. So your project’s application bundle ID will be something like com.github.small_tech.comet (the init script will automatically convert dashes to underscores as per flatpak’s naming requirements). I have raised my concerns about this both from a legal perspective [as it is a trademark violation](https://github.com/elementary/appcenter/discussions/1622) and, more generally, [because it gives Microsoft a de-facto veto right on what apps are allowed on elementary OS](https://github.com/elementary/houston/issues/436#issuecomment-905554984). I do hope that this decision will be reviewed going forward. In the meanwhile, however, Watson is designed to make full use of the current system to make setting up a new elementary OS project as simple as possible while following all relevant platform guidelines and encouraging good practices. – [Aral](https://ar.al)


## What to expect

### Pre-flight checks

Watson will first check that you have the [elementary OS development libraries](https://docs.elementary.io/develop/writing-apps/the-basic-setup#development-libraries) installed. These are required to create apps for elementary OS. If you don’t have them installed, Watson will ask you if you want to install them now.

Next, Watson will check if you have [VSCodium](https://vscodium.com) installed. You do _not_ need to use VSCodium to create elementary OS apps. You can, for instance, use elementary OS [Code](https://docs.elementary.io/develop/writing-apps/the-basic-setup#code), which comes preinstalled, or a different third-party editor like [Builder](https://apps.gnome.org/en/app/org.gnome.Builder/). However, if you do have VSCodium installed, there are a number of extensions that will make creating your elementary OS app easier ([Vala](https://github.com/Prince781/vala-vscode), [Meson](https://github.com/asabil/vscode-meson), [CodeLLDB](https://github.com/vadimcn/vscode-lldb), [XML](https://github.com/redhat-developer/vscode-xml), [YAML](https://github.com/redhat-developer/vscode-yaml)). If Watson cannot find these extensions installed, it will ask you if you’d like to install them now. With these extensions installed, once you’ve initialised your project, you can simple open it in VSCodium and hit F5 to run/debug it (and you will get code intelligence, etc., for all your source files).

### Interactive sections

Watson will ask for your app details in a series of graphical dialogue windows and update the necessary bits of the template files (application bundle IDs, asset paths, etc.) to customise them for your project based on your answers.

It will also replace this README and the CHANGELOG with your application’s versions, recreate the git repository (so you start with a fresh history), make an initial commit, and set up your git remote so `origin` points to your repository.

Watson will delete itself once it’s done, leaving only your project behind.

That’s it!

Now you can customise the template further to create your app, knowing you have scaffolding that adheres to elementary OS guidelines.

Before moving on, make sure you learn how to set up [continuous integration](https://docs.elementary.io/develop/writing-apps/our-first-app/continuous-integration) and review the AppCenter [publishing requirements](https://docs.elementary.io/develop/appcenter/publishing-requirements) before you [submit your app](https://developer.elementary.io/).

Enjoy and here’s hoping Watson will make it easier for you to start building excellent apps for elementary OS.

## What is included?

  - A prompt to install the [elementary OS development libraries](https://docs.elementary.io/develop/writing-apps/the-basic-setup#development-libraries) if they don’t already exist on your machine.

  - A prompt to install recommended [VSCodium](https://vscodium.com/) Vala development and debugging extensions ([Vala](https://github.com/Prince781/vala-vscode), [Meson](https://github.com/asabil/vscode-meson), [CodeLLDB](https://github.com/vadimcn/vscode-lldb), [XML](https://github.com/redhat-developer/vscode-xml), [YAML](https://github.com/redhat-developer/vscode-yaml)) if you have VSCodium installed and are missing any of them.

  - A basic window with [header bar](https://docs.elementary.io/develop/apis/actions#gtk-headerbar).

  - [Action wired up for quit](https://docs.elementary.io/develop/apis/actions#glib-simpleaction) (<kbd>Ctrl</kdb>+<kbd>Q</kbd>).

  - Simple [notifications](https://docs.elementary.io/develop/apis/notifications) example.

  - [Granite](https://valadoc.org/granite/Granite.html) library for application [launchers](https://docs.elementary.io/develop/apis/launchers), [badges](https://docs.elementary.io/develop/apis/launchers#badges), [progress bars](https://docs.elementary.io/develop/apis/launchers#progress-bars), etc.

  - [State saving](https://docs.elementary.io/develop/apis/state-saving) using a [gschema.xml](https://docs.elementary.io/develop/apis/state-saving#define-settings-keys) file and [GSettings](https://valadoc.org/gio-2.0/GLib.Settings.html).

  - [Custom resources](https://docs.elementary.io/develop/apis/gresource) ([custom icons](https://docs.elementary.io/develop/apis/gresource#icons), etc.) using a [gresource.xml](https://docs.elementary.io/develop/apis/gresource) file.

  - [Colour scheme](https://docs.elementary.io/develop/apis/color-scheme) support.

  - [.desktop](https://docs.elementary.io/develop/writing-apps/our-first-app#the-desktop-file) file for information about your app that’s displayed in the Application Menu and Dock.

  - [AppData.xml](https://docs.elementary.io/develop/writing-apps/our-first-app#appdata-xml) file for information need to list your app in AppCenter.

  - [LICENSE](https://docs.elementary.io/develop/writing-apps/our-first-app#legal-stuff) file for the GNU GPL license.

  - [Meson configuration files](https://docs.elementary.io/develop/writing-apps/our-first-app/the-build-system) and a build script.

  - [Support for translations](https://docs.elementary.io/develop/writing-apps/our-first-app/translations) with [GNU gettext via Meson](https://mesonbuild.com/Localisation.html).

  - [App icon](https://docs.elementary.io/develop/writing-apps/our-first-app/icons)

  - [Flatpak manifest](https://docs.elementary.io/develop/writing-apps/our-first-app/packaging)

  - The recommended [EditorConfig](https://docs.elementary.io/develop/writing-apps/code-style#editorconfig) for elementary OS Code and other compatible editors for enforcing the suggested [code style](https://docs.elementary.io/develop/writing-apps/code-style).

  - _.gitignore_ file that ignores the _build_ and _.flatpak-builder_ directories.

## What’s _not_ included?

You will need to configure your GitHub account and set up git on your machine yourself.

For instructions on how to do this, please see the [Basic Setup](https://docs.elementary.io/develop/writing-apps/the-basic-setup) section of the [elementary OS Developer Documentation](https://docs.elementary.io/develop/).
