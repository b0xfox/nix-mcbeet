{
  pkgs,
  pythonPackages,
  fetchFromGitHub,
}:
pythonPackages.buildPythonPackage rec {

  pname = "tokenstream";
  version = "1.7.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "vberlier";
    repo = "tokenstream";
    rev = "v${version}";
    hash = "sha256-idTgTVaZkF6M9ly5HzqmHtUUc7Bp5VrR2EioDSHmThM=";
  };

  nativeBuildInputs = with pythonPackages; [
    poetry-core
  ];

  meta = {
    description = "A versatile token stream for handwritten parsers.";
    homepage = "https://github.com/vberlier/tokenstream";
    license = pkgs.lib.licenses.mit;
  };
}
