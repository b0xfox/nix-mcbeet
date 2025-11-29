{
  pkgs,
  beet,
  pythonPackages,
  fetchFromGitHub,
}:
pythonPackages.buildPythonPackage rec {

  pname = "lectern";
  version = "0.34.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "mcbeet";
    repo = "lectern";
    rev = "v${version}";
    hash = "sha256-uqbHaHzWb2+A9DHexGuAybh7kDxr1R7f/Sd5Aw9LBvA=";
  };

  nativeBuildInputs = with pythonPackages; [
    poetry-core
  ];

  propagatedBuildInputs = [
    beet
    pythonPackages.click
    pythonPackages.markdown-it-py
  ];

  meta = {
    description = "Literate Minecraft data packs and resource packs.";
    homepage = "https://github.com/mcbeet/lectern";
    license = pkgs.lib.licenses.mit;
    mainProgram = "lectern";
  };
}
