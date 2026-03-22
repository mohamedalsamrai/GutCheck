import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  site: 'https://freaxmate.github.io/GutCheck/',
  base: '/GutCheck/',
  integrations: [tailwind()],
});