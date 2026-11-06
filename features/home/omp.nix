{ inputs, pkgs, ... }:

let
  sol = "openai-codex/gpt-6.1-sol";
  deepseek = "opencode-go/deepseek-v4.1-flash";
  glm = "opencode-go/glm-5.3-flash";
  modelRoles = {
    default = sol;
    inherit deepseek glm;
  };
  preset = model: {
    modelRoles = modelRoles // { default = model; };
    defaultThinkingLevel = "auto";
  };
in
{
  imports = [ inputs.omp.homeManagerModules.default ];

  programs.omp = {
    enable = true;
    # Upstream's thin-LTO option avoids the slow fat-LTO release link.
    package = inputs.omp.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      withFatLto = false;
    };
    # Activation restores these values; OMP can still save runtime changes.
    settings = {
      inherit modelRoles;
      cycleOrder = [ "default" "deepseek" "glm" ];
      modelPresets = {
        dp = preset sol;
        deepseek = preset deepseek;
        glm = preset glm;
      };
      defaultThinkingLevel = "auto";
      symbolPreset = "nerd";
      composer.shape = "band";
      theme.dark = "titanium";
      setupVersion = 2;
      memory.backend = "local";
      autolearn.enabled = true;
      bash.gitGuard = true;
      bashInterceptor.enabled = true;
      github.enabled = true;
      security.enabled = true;
      browser.headless = true;
      task = {
        perCallModel = "on";
        enableEffort = true;
        disabledAgents = [ ];
        # Hard per-agent overrides conflict with per-call model selection.
        agentModelOverrides = { };
      };
      providers.openaiWebsockets = "off";
      display.subagentLivePreview = true;
      retry = {
        enabled = true;
        maxRetries = 100;
        baseDelayMs = 5000;
        maxDelayMs = 1800000;
      };
    };
  };
}
