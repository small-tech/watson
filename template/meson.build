project(
    'com.github.{GITHUB.ORG}.{GITHUB.APP}',
    'vala',
    'c',
    version: '1.0.0'
)

i18n = import('i18n')
gnome = import('gnome')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language: 'c')

conf_data = configuration_data()
conf_data.set_quoted('PROJECT_NAME', meson.project_name())
conf_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf_data.set_quoted('LOCALEDIR', join_paths(get_option('prefix'), get_option('localedir')))
conf_data.set_quoted('VERSION', meson.project_version())
config_header = configure_file(
    input : 'src' / 'Constants' / 'Config.vala.in',
    output : 'Config.vala',
    configuration : conf_data
)

# Custom resource support.
# Place custom icons, etc. in the data/ directory
# and add them to data/gresource.xml.
gresource = gnome.compile_resources(
    'gresource',
    'data' / 'gresource.xml',
    source_dir: 'data'
)

executable(
    meson.project_name(),
    gresource,
    'src' / 'Application.vala',
    'src' / 'MainWindow.vala',
    'src' / 'Widgets' / 'HeaderBar.vala',
    'src' / 'Constants' / 'Colors.vala',
    config_header,
    dependencies: [
      dependency('granite', version: '>=5.2.4'),
      dependency('gtk+-3.0'),
      dependency('libhandy-1', version: '>=0.90.0'),
      meson.get_compiler('vala').find_library('posix')
    ],
    install: true
)

# Translate and install our .desktop file.
i18n.merge_file(
    input: 'data' / '{GITHUB.APP}.desktop.in',
    output: meson.project_name() + '.desktop',
    po_dir: meson.source_root() / 'po',
    type: 'desktop',
    install: true,
    install_dir: get_option('datadir') / 'applications'
)

# Translate and install our .appdata file.
i18n.merge_file(
    input: 'data' / '{GITHUB.APP}.appdata.xml.in',
    output: meson.project_name() + '.appdata.xml',
    po_dir: meson.source_root() / 'po',
    install: true,
    install_dir: get_option('datadir') / 'metainfo'
)

icon_sizes = ['16', '24', '32', '48', '64', '128']

foreach i : icon_sizes
    install_data(
        'data' / i + '.svg',
        install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i / 'apps',
        rename: meson.project_name() + '.svg'
    )
    install_data(
        'data' / i + '.svg',
        install_dir: get_option('datadir') / 'icons' / 'hicolor' / i + 'x' + i + '@2' / 'apps',
        rename: meson.project_name() + '.svg'
    )
endforeach

# Also execute the build files from the translation
# and data subdirectories.
subdir('po')
subdir('data')

# Execute post install script to compile gsettings schemas.
meson.add_install_script('meson/post_install.py')
