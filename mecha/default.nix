{
  pkgs,
  beet,
  tokenstream,
  pythonPkgs,
  fetchFromGitHub,
}:
pythonPkgs.buildPythonPackage rec {

  pname = "mecha";
  version = "0.99.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "mcbeet";
    repo = "mecha";
    rev = "v${version}";
    hash = "sha256-DbpLkKzva+PmHig50qjmuS7v3uk1e8i9a0IF/qPHkh4=";
  };

  nativeBuildInputs = with pythonPkgs; [
    poetry-core
  ];

  propagatedBuildInputs = [
    beet
    tokenstream
  ];

  meta = {
    description = "A powerful Minecraft command library";
    homepage = "https://github.com/mcbeet/mecha";
    license = pkgs.lib.licenses.mit;
    mainProgram = "mecha";
  };
}
