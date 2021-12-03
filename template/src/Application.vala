/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: {COPYRIGHT.YEAR} {COPYRIGHT.NAME} <{COPYRIGHT.EMAIL}>
 */

namespace {APP.NAMESPACE} {
    public GLib.Settings saved_state;

    public class Application : Gtk.Application {

        public Application () {
            Object(
                application_id: "com.github.{GITHUB.ORG}.{GITHUB.APP}",
                flags: ApplicationFlags.FLAGS_NONE
            );

            saved_state = new GLib.Settings ("com.github.{GITHUB.ORG}.{GITHUB.APP}.saved-state");
        }

        construct {
            // Initialise localisation.
            GLib.Intl.setlocale (LocaleCategory.ALL, "");
            GLib.Intl.bindtextdomain (Constants.Config.GETTEXT_PACKAGE, Constants.Config.LOCALEDIR);
            GLib.Intl.bind_textdomain_codeset (Constants.Config.GETTEXT_PACKAGE, "UTF-8");
            GLib.Intl.textdomain (Constants.Config.GETTEXT_PACKAGE);
        }

        protected override void activate () {
            // Use person’s preferred color scheme.
            // See: https://docs.elementary.io/develop/apis/color-scheme
            use_preferred_color_scheme ();

            // Ensure there is only one window and show it.
            MainWindow window;
            unowned List<Gtk.Window> windows = get_windows ();
            if (windows.length () > 0) {
                window = windows.last ().data as MainWindow;
                window.present ();
            } else {
                window = new MainWindow (this);
                window.show ();
            };
        }

        private void use_preferred_color_scheme () {
            // Set color scheme of app based on person’s preference.
            var granite_settings = Granite.Settings.get_default ();
            var gtk_settings = Gtk.Settings.get_default ();
            gtk_settings.gtk_application_prefer_dark_theme
                = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

            // Listen for changes in person’s color scheme settings
            // and update color scheme of app accordingly.
            granite_settings.notify["prefers-color-scheme"].connect (() => {
                gtk_settings.gtk_application_prefer_dark_theme
                    = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
            });
        }

        public static int main (string[] commandline_arguments) {
            return new Application ().run (commandline_arguments);
        }
    }
}
