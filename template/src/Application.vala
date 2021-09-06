/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: {COPYRIGHT.YEAR} {COPYRIGHT.NAME} <{COPYRIGHT.EMAIL}>
 */

public class App : Gtk.Application {
    public App () {
        Object(
            application_id: "com.github.{GITHUB.ORG}.{GITHUB.APP}",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        // Set the colour scheme of your app based on the person’s preference.
        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

        // Listen for changes in the person’s colour scheme settings
        // and update the colour scheme of the app accordingly.
        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });

        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
        };

        // Create the quit action and map the Ctrl + Q and Ctrl + W
        // accelerators to it. When we receive the quit action,
        // exit the app by destroying the main window.
        var quit_action = new SimpleAction ("quit", null);
        add_action (quit_action);
        set_accels_for_action ("app.quit",  {"<Control>q", "<Control>w"});
        quit_action.activate.connect (() => {
            main_window.destroy ();
        });

        var header_bar = new Gtk.HeaderBar () {
            show_close_button = true
        };
        header_bar.set_title (_("Waston Dev"));

        main_window.set_titlebar (header_bar);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new App ().run (args);
    }
}
