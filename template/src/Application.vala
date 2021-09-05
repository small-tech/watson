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

        var header_bar = new Gtk.HeaderBar () {
            show_close_button = true
        };
        header_bar.set_title (_("Waston Dev"));

        // This demonstrates how to add a widget to the header bar and
        // how to use binding. It is not meant to showcase a good practice.
        // Quite on the contrary, unless you have a very specific need,
        // you should not need to include a light mode/dark mode toggle in your app.
        // (So remove this once you’ve learned from it.)
        var mode_switch = new Granite.ModeSwitch.from_icon_name ("display-brightness-symbolic", "weather-clear-night-symbolic");
        mode_switch.primary_icon_tooltip_text = _("Light style");
        mode_switch.secondary_icon_tooltip_text = _("Dark style");
        mode_switch.valign = Gtk.Align.CENTER;
        mode_switch.active = gtk_settings.gtk_application_prefer_dark_theme;
        mode_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");
        header_bar.pack_end (mode_switch);

        main_window.set_titlebar (header_bar);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new App ().run (args);
    }
}
