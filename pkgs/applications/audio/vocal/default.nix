{ stdenv, fetchFromGitHub, cmake, pkgconfig, wrapGAppsHook, gnome3
, granite, gst_all_1, gtk3, libnotify, libxml2, sqlite, pcre, vala
, webkitgtk, clutter-gtk, clutter-gst, libgee, json-glib }:

let
  pname = "vocal";
  version = "2.2.0";
in
stdenv.mkDerivation rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "needle-and-thread";
    repo = "vocal";
    rev = version;
    sha256 = "09cm4azyaa9fmfymygf25gf0klpm5p04k6bc1i90jhw0f1im8sgl";
  };

  nativeBuildInputs = [ cmake wrapGAppsHook ];
  buildInputs = [
    gtk3 libnotify libxml2 sqlite pkgconfig clutter-gtk clutter-gst webkitgtk
    libgee json-glib granite pcre vala gnome3.gsettings-desktop-schemas ] ++
    (with gst_all_1; [ gstreamer gst-plugins-base gst-plugins-bad (gst-plugins-good.override { gtkSupport = true; }) gst-libav ]);

  meta = {
    description = "Podcast client for the modern free desktop";
    longDescription = ''
      Vocal is a powerful, fast, and intuitive application that helps users
      find new podcasts, manage their libraries, and enjoy the best that
      indepedent audio and video publishing has to offer.
    '';
    homepage = https://vocalproject.net/;
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.jonafato ];
  };
}
