namespace {APP.NAMESPACE}.Widgets {
    public class HeaderBar : Hdy.HeaderBar {
        public HeaderBar () {
            Object (
                title: _("{APP.NAME}"),
                has_subtitle: false,
                show_close_button: true,
                hexpand: true
            );
        }
    }
}
