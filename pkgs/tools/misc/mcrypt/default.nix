{ stdenv, fetchurl, libmcrypt, libmhash }:

stdenv.mkDerivation rec {
  version = "2.6.8";
  pname = "mcrypt";

  src = fetchurl {
    url = "mirror://sourceforge/mcrypt/MCrypt/${version}/${pname}-${version}.tar.gz";
    sha256 = "5145aa844e54cca89ddab6fb7dd9e5952811d8d787c4f4bf27eb261e6c182098";
  };

  patches = [ ./format-string.patch ./overflow.patch ./segv.patch ./sprintf.patch ];

  buildInputs = [ libmcrypt libmhash ];

  meta = {
    description = "Replacement for old UNIX crypt(1)";
    longDescription = ''
      mcrypt, and the accompanying libmcrypt, are intended to be replacements
      for the old Unix crypt, except that they are under the GPL and support an
      ever-wider range of algorithms and modes.
    '';
    homepage = "http://mcrypt.sourceforge.net";
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.all;
    maintainers = [ stdenv.lib.maintainers.qknight ];
  };
}
