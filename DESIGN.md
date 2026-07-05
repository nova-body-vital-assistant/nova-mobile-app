---
name: Vitality Core
colors:
  surface: '#f3fcf0'
  surface-dim: '#d4dcd1'
  surface-bright: '#f3fcf0'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#edf6eb'
  surface-container: '#e8f0e5'
  surface-container-high: '#e2ebdf'
  surface-container-highest: '#dce5da'
  on-surface: '#161d17'
  on-surface-variant: '#3c4a3e'
  inverse-surface: '#2a322b'
  inverse-on-surface: '#ebf3e8'
  outline: '#6c7b6d'
  outline-variant: '#bbcbbb'
  surface-tint: '#006d36'
  primary: '#006d36'
  on-primary: '#ffffff'
  primary-container: '#00bf63'
  on-primary-container: '#004620'
  inverse-primary: '#45e180'
  secondary: '#5e5e5e'
  on-secondary: '#ffffff'
  secondary-container: '#e2e2e2'
  on-secondary-container: '#646464'
  tertiary: '#5d5f5f'
  on-tertiary: '#ffffff'
  tertiary-container: '#a5a6a6'
  on-tertiary-container: '#3a3c3c'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#67fe9a'
  primary-fixed-dim: '#45e180'
  on-primary-fixed: '#00210c'
  on-primary-fixed-variant: '#005227'
  secondary-fixed: '#e2e2e2'
  secondary-fixed-dim: '#c6c6c6'
  on-secondary-fixed: '#1b1b1b'
  on-secondary-fixed-variant: '#474747'
  tertiary-fixed: '#e2e2e2'
  tertiary-fixed-dim: '#c6c6c7'
  on-tertiary-fixed: '#1a1c1c'
  on-tertiary-fixed-variant: '#454747'
  background: '#f3fcf0'
  on-background: '#161d17'
  surface-variant: '#dce5da'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Lexend
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Lexend
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Lexend
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Lexend
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  base: 4px
  xs: 8px
  sm: 16px
  md: 24px
  lg: 32px
  xl: 48px
  container-margin: 20px
  gutter: 16px
---

## Brand & Style

The design system is centered on the intersection of human vitality and digital precision. It is engineered for health and wellness applications that require an atmosphere of optimism, clarity, and approachability. The brand personality is encouraging and energetic, yet deeply rooted in data-driven reliability.

The visual style follows a **Modern/Soft** aesthetic. It moves away from the rigid edges of traditional enterprise software, embracing organic, highly rounded forms that feel comfortable and "touchable." This approach minimizes visual friction, creating an environment where complex health data feels intuitive and less clinical.

## Colors

The palette is anchored by a high-energy primary green (#00bf63), symbolizing growth, health, and "go-ahead" status signals. This is balanced by a strict monochrome foundation of pure black and white to ensure maximum contrast and professional authority.

- **Primary:** Used for key actions, progress indicators, and success states.
- **Surface & Background:** A clean white is used for cards to pop against a very light gray off-white background, creating a soft layered effect.
- **Accessibility:** Text must maintain a minimum 4.5:1 ratio against backgrounds. Use black for primary text on white/light-gray, and white text only on the primary green or black surfaces.

## Typography

Typography is selected for peak readability and a friendly, athletic character. 

**Plus Jakarta Sans** is used for headlines to provide a modern, slightly rounded geometric feel that complements the UI's shape language. **Lexend** is utilized for all body and label text; its specific design intent—to reduce visual stress and improve reading speed—is critical for users scanning health metrics. 

Maintain tight tracking on large display type and generous line heights for body text to ensure an airy, accessible feel.

## Layout & Spacing

The design system utilizes a **Fluid Grid** with fixed outer margins. The internal spacing rhythm is built on an 8px base unit to maintain mathematical harmony across all screen sizes.

- **Mobile:** 4-column grid with 20px side margins.
- **Desktop:** 12-column grid with a maximum content width of 1280px.
- **Vertical Spacing:** Use the `md` (24px) or `lg` (32px) units to separate major sections, ensuring the UI feels expansive and uncluttered. Data density should be managed through card grouping rather than tightening margins.

## Elevation & Depth

This design system uses **Tonal Layers** combined with **Ambient Shadows** to create a sense of organized depth. 

Depth is primarily used to separate interactive cards from the background. Surfaces do not use harsh borders; instead, they rely on a soft, diffused shadow (0px 4px 20px rgba(0,0,0,0.05)) to suggest elevation. Higher elevation levels should be used sparingly, reserved for modals or persistent bottom sheets, utilizing a slightly more pronounced shadow and a backdrop blur of 8px to maintain focus.

## Shapes

The shape language is the most defining characteristic of the design system. It utilizes **Pill-shaped (Level 3)** rounding to evoke a friendly, soft, and modern feel.

Large containers and dashboard cards must use a minimum corner radius of 24px. This extreme rounding helps to "contain" data points, making them feel like distinct, manageable units of information. Smaller elements like buttons and input fields should follow a fully rounded (stadium) style where possible, or a minimum of 16px to maintain consistency with the larger containers.

## Components

- **Buttons:** Use stadium-shaped (fully rounded) containers. The primary button is #00bf63 with white text. Elevation is removed in favor of a subtle scale-down effect (0.98) on press.
- **Cards:** Dashboard cards must feature 24px corner radius, a white fill, and the soft ambient shadow defined in the Elevation section. Padding inside cards should be at least 24px.
- **Chips:** Small, highly rounded badges used for filtering or status. Use light tints of the primary green (e.g., 10% opacity) for background fills to keep them subtle.
- **Input Fields:** Search bars and text inputs should be stadium-shaped with a 1px light gray border. On focus, the border thickens and changes to the primary green.
- **Progress Indicators:** Use thick, rounded strokes for circular or linear progress bars to match the "soft" aesthetic of the typeface and container shapes.
- **Lists:** List items should have generous vertical padding (16px+) and be separated by subtle dividers or placed within individual rounded sub-cards.