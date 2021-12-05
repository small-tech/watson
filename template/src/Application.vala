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

            // Command-line options.

            // If your app takes command-line arguments, you can specify it
            // using the set_option_context_parameter_string () method.
            // (The option context parameter string is displayed next to the
            // list of options on the first line of the --help screen.)

            // Display the app description as the option context summary.
            // The option context summary is displayed above the set of options
            // on the --help screen.
            set_option_context_summary (_("{APP.DESCRIPTION}"));

            // Display the copyright notice as the option context description.
            // The option context description is displayed below the set of options
            // on the --help screen.
            set_option_context_description (_("Copyright ⓒ {COPYRIGHT.YEAR}-present {COPYRIGHT.NAME}. Licensed under GNU GPL version 3.0."));

            // Add option: --version, -v
            add_main_option(
                "version", 'v',
                GLib.OptionFlags.NONE,
                GLib.OptionArg.NONE,
                _("Show version number and exit"),
                null
            );

            // Signal: Handle local options.
            handle_local_options.connect((application, options) => {
                // Handle option: --version, -v:
                //
                // Print a minimal version string based on the GNU coding standards.
                // https://www.gnu.org/prep/standards/standards.html#g_t_002d_002dversion
                if (options.contains("version")) {
                    print (@"{APP.NAME} $(Constants.Config.VERSION)\n");

                    // OK.
                    return 0;
                }

                // Let the system handle any other command-line options.
                return -1;
            });
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
