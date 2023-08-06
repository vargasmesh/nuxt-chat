import { defineConfig, presetUno, presetAttributify, transformerDirectives } from "unocss";
import presetIcons from "@unocss/preset-icons";
import presetTagify from "@unocss/preset-tagify";

export default defineConfig({
  presets: [presetUno(), presetTagify(), presetAttributify(), presetIcons()],
  transformers: [
    transformerDirectives(),
  ],
});
