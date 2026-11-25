<?php
// ============================================================================
// DARKIOS // Key Management Admin Panel — PHP Version
// Bu fayl heç bir xarici asılılıq tələb etmir (təmiz PHP + HTML + JS + CSS).
// PHP 7.4+ / 8.x ilə işləyir.
// ============================================================================

declare(strict_types=1);

// ----------------------------------------------------------------------------
// 1) KONFİQURASİYA (istəsəniz dəyişdirin)
// ----------------------------------------------------------------------------
$CONFIG = [
    'admin_user' => 'admin',
    'admin_pass' => 'darkios120',
    'app_title'  => 'DARKIOS // Key Management Admin Panel',
    'data_dir'   => __DIR__ . '/darkios_data', // keys.json burada saxlanılır
];

// ----------------------------------------------------------------------------
// 2) DATA QOVLUĞUNU HAZIRLA
// ----------------------------------------------------------------------------
if (!is_dir($CONFIG['data_dir'])) {
    @mkdir($CONFIG['data_dir'], 0775, true);
}

$keysFile = $CONFIG['data_dir'] . '/keys.json';

// İlk dəfədirsə, default demo açarlar yaradılır
if (!file_exists($keysFile)) {
    $now = time() * 1000;
    $seed = [
        'brand' => 'DARKIOS',
        'updatedAt' => date('c'),
        'keys' => [
            [
                'id' => 'k_1',
                'code' => 'DARKIOS-30D-9X4K2M1P',
                'timeLabel' => '30D',
                'createdAt' => $now - 3600000,
                'expiresAt' => $now + 29 * 86400000,
                'remainingOnPause' => null,
                'paused' => false,
                'banned' => false,
                'deviceLimit' => 2,
                'bypassHwid' => false,
                'maxFps' => 120,
                'note' => 'iOS 18.2 VIP Test',
                'devices' => [
                    ['hwid' => 'HWID-8F2A-991C', 'model' => 'iPhone 16 Pro', 'ios' => '18.2'],
                ],
            ],
            [
                'id' => 'k_2',
                'code' => 'DARKIOS-7D-4L8N2Q7R',
                'timeLabel' => '7D',
                'createdAt' => $now - 7200000,
                'expiresAt' => $now + 6 * 86400000,
                'remainingOnPause' => 5 * 86400000,
                'paused' => true,
                'banned' => false,
                'deviceLimit' => 1,
                'bypassHwid' => false,
                'maxFps' => 120,
                'note' => 'Dayandırılmış Slot',
                'devices' => [],
            ],
        ],
    ];
    @file_put_contents($keysFile, json_encode($seed, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
}

// ----------------------------------------------------------------------------
// 3) API ENDPOINT-LƏRİ (?api=... üçün)
// ----------------------------------------------------------------------------
if (isset($_GET['api'])) {
    header('Content-Type: application/json; charset=utf-8');

    $action = (string)$_GET['api'];
    $input  = json_decode(file_get_contents('php://input') ?: '{}', true) ?: [];

    // Sadə auth yoxlaması (istəyə görə sərtləşdirilə bilər)
    $isAuthed = isset($_SESSION['darkios_auth']) ? (bool)$_SESSION['darkios_auth'] : true;

    switch ($action) {
        case 'load':
            if (!is_readable($keysFile)) {
                echo json_encode(['ok' => false, 'error' => 'keys.json oxunmur']);
                exit;
            }
            echo file_get_contents($keysFile);
            exit;

        case 'save':
            if (!isset($input['keys']) || !is_array($input['keys'])) {
                echo json_encode(['ok' => false, 'error' => 'keys massivi tələb olunur']);
                exit;
            }
            $payload = [
                'brand' => 'DARKIOS',
                'updatedAt' => date('c'),
                'keys' => $input['keys'],
            ];
            $written = @file_put_contents(
                $keysFile,
                json_encode($payload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE),
                LOCK_EX
            );
            echo json_encode(['ok' => $written !== false]);
            exit;

        case 'login':
            $u = (string)($input['user'] ?? '');
            $p = (string)($input['pass'] ?? '');
            if ($u === $CONFIG['admin_user'] && $p === $CONFIG['admin_pass']) {
                echo json_encode(['ok' => true]);
            } else {
                echo json_encode(['ok' => false, 'error' => 'İstifadəçi adı və ya şifrə yanlışdır']);
            }
            exit;

        default:
            echo json_encode(['ok' => false, 'error' => 'Naməlum API action']);
            exit;
    }
}

// ----------------------------------------------------------------------------
// 4) HTML SƏHİFƏSİ (orijinal fayl olduğu kimi + PHP inteqrasiyası)
// ----------------------------------------------------------------------------
?>
<!DOCTYPE html>
<html lang="az" data-theme="obsidian-pure" data-layout="command">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover" />
  <title><?= htmlspecialchars($CONFIG['app_title'], ENT_QUOTES, 'UTF-8') ?></title>
  <style>
    /* ==========================================================================
       DARKIOS MONOCHROME ENGINE — 120 FPS GPU ACCELERATED
       Zero Emojis | Zero Bright Colors | High-Contrast Noir / Monochrome
       ========================================================================== */
    :root {
      --bg-app: #050505;
      --bg-surface: #0c0c0c;
      --bg-elevated: #141414;
      --bg-hover: #1c1c1c;
      --bg-input: #080808;
      --fg-primary: #f5f5f5;
      --fg-secondary: #a3a3a3;
      --fg-muted: #666666;
      --border-subtle: #222222;
      --border-strong: #3a3a3a;
      --accent: #ffffff;
      --accent-fg: #050505;
      --status-active: #e5e5e5;
      --status-paused: #888888;
      --status-banned: #4a4a4a;
      --shadow-panel: 0 12px 32px rgba(0, 0, 0, 0.75);
      --radius-sm: 4px;
      --radius-md: 8px;
      --radius-lg: 12px;
      --font-sans: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
      --font-mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", monospace;
      --ease-120: cubic-bezier(0.16, 1, 0.3, 1);
    }

    /* 50 Monochrome & High-Contrast Dark Themes */
    [data-theme="obsidian-pure"] { --bg-app:#050505; --bg-surface:#0b0b0b; --bg-elevated:#121212; --bg-hover:#1a1a1a; --fg-primary:#f5f5f5; --fg-secondary:#a0a0a0; --border-subtle:#202020; --accent:#ffffff; --accent-fg:#050505; }
    [data-theme="paper-noir"] { --bg-app:#f4f4f4; --bg-surface:#ffffff; --bg-elevated:#ebebeb; --bg-hover:#e0e0e0; --bg-input:#fafafa; --fg-primary:#0a0a0a; --fg-secondary:#4a4a4a; --fg-muted:#7a7a7a; --border-subtle:#d4d4d4; --border-strong:#171717; --accent:#0a0a0a; --accent-fg:#ffffff; --shadow-panel:0 10px 28px rgba(0,0,0,0.08); }
    [data-theme="graphite-matte"] { --bg-app:#111214; --bg-surface:#17181b; --bg-elevated:#1f2125; --bg-hover:#282a2f; --fg-primary:#eef0f2; --fg-secondary:#9aa0a6; --border-subtle:#2b2e33; --accent:#eef0f2; --accent-fg:#111214; }
    [data-theme="carbon-weave"] { --bg-app:#070708; --bg-surface:#0e0f11; --bg-elevated:#16181b; --bg-hover:#202327; --fg-primary:#f0f2f5; --fg-secondary:#8d949e; --border-subtle:#23272c; --accent:#f0f2f5; --accent-fg:#070708; }
    [data-theme="silver-gelatin"] { --bg-app:#0e0e0e; --bg-surface:#161616; --bg-elevated:#1f1f1f; --bg-hover:#292929; --fg-primary:#e8e8e8; --fg-secondary:#9c9c9c; --border-subtle:#2c2c2c; --accent:#e8e8e8; --accent-fg:#0e0e0e; }
    [data-theme="chalk-ink"] { --bg-app:#fafafa; --bg-surface:#ffffff; --bg-elevated:#f0f0f0; --bg-hover:#e5e5e5; --bg-input:#ffffff; --fg-primary:#111111; --fg-secondary:#525252; --fg-muted:#888888; --border-subtle:#dcdcdc; --border-strong:#262626; --accent:#111111; --accent-fg:#ffffff; --shadow-panel:0 8px 24px rgba(0,0,0,0.06); }
    [data-theme="void-pitch"] { --bg-app:#000000; --bg-surface:#060606; --bg-elevated:#0d0d0d; --bg-hover:#161616; --fg-primary:#ffffff; --fg-secondary:#8e8e93; --border-subtle:#1c1c1e; --accent:#ffffff; --accent-fg:#000000; }
    [data-theme="ash-slate"] { --bg-app:#141517; --bg-surface:#1b1d20; --bg-elevated:#24272b; --bg-hover:#2e3237; --fg-primary:#e6e8eb; --fg-secondary:#979da6; --border-subtle:#2f3339; --accent:#e6e8eb; --accent-fg:#141517; }
    [data-theme="iron-oxide"] { --bg-app:#0c0a0a; --bg-surface:#141111; --bg-elevated:#1d1919; --bg-hover:#272222; --fg-primary:#f2ecec; --fg-secondary:#a39999; --border-subtle:#2b2525; --accent:#f2ecec; --accent-fg:#0c0a0a; }
    [data-theme="cold-steel"] { --bg-app:#090c0f; --bg-surface:#0f1419; --bg-elevated:#171e26; --bg-hover:#202934; --fg-primary:#edf2f7; --fg-secondary:#8fa1b3; --border-subtle:#222d38; --accent:#edf2f7; --accent-fg:#090c0f; }
    [data-theme="warm-stone"] { --bg-app:#12110f; --bg-surface:#191815; --bg-elevated:#22201c; --bg-hover:#2c2a25; --fg-primary:#f3f0e8; --fg-secondary:#a6a092; --border-subtle:#302d27; --accent:#f3f0e8; --accent-fg:#12110f; }
    [data-theme="newsprint-light"] { --bg-app:#e9e7e2; --bg-surface:#f5f4f0; --bg-elevated:#e0ddd6; --bg-hover:#d5d1c8; --bg-input:#faf9f6; --fg-primary:#141413; --fg-secondary:#4f4e49; --fg-muted:#7c7a72; --border-subtle:#c9c5bc; --border-strong:#1c1c1a; --accent:#141413; --accent-fg:#f5f4f0; --shadow-panel:0 8px 20px rgba(0,0,0,0.07); }
    [data-theme="eclipse-core"] { --bg-app:#040405; --bg-surface:#0a0a0c; --bg-elevated:#121216; --bg-hover:#1a1a20; --fg-primary:#f7f7fa; --fg-secondary:#8c8c99; --border-subtle:#202028; --accent:#f7f7fa; --accent-fg:#040405; }
    [data-theme="basalt-dark"] { --bg-app:#101010; --bg-surface:#171717; --bg-elevated:#202020; --bg-hover:#2a2a2a; --fg-primary:#ededed; --fg-secondary:#999999; --border-subtle:#292929; --accent:#ededed; --accent-fg:#101010; }
    [data-theme="platinum-fog"] { --bg-app:#161719; --bg-surface:#1e2023; --bg-elevated:#272a2e; --bg-hover:#32363b; --fg-primary:#f1f3f5; --fg-secondary:#a1a7b0; --border-subtle:#33373d; --accent:#f1f3f5; --accent-fg:#161719; }
    [data-theme="tungsten-lab"] { --bg-app:#0b0c0e; --bg-surface:#121417; --bg-elevated:#191c20; --bg-hover:#22262c; --fg-primary:#e9ecef; --fg-secondary:#8e96a0; --border-subtle:#252a30; --accent:#e9ecef; --accent-fg:#0b0c0e; }
    [data-theme="monolith-v1"] { --bg-app:#060606; --bg-surface:#0d0d0d; --bg-elevated:#151515; --bg-hover:#1e1e1e; --fg-primary:#fafafa; --fg-secondary:#949494; --border-subtle:#242424; --accent:#fafafa; --accent-fg:#060606; }
    [data-theme="monolith-v2"] { --bg-app:#080808; --bg-surface:#101010; --bg-elevated:#181818; --bg-hover:#222222; --fg-primary:#e4e4e4; --fg-secondary:#8a8a8a; --border-subtle:#262626; --accent:#e4e4e4; --accent-fg:#080808; }
    [data-theme="ghost-shell"] { --bg-app:#0d0e10; --bg-surface:#141619; --bg-elevated:#1c1f24; --bg-hover:#262a31; --fg-primary:#e5e7eb; --fg-secondary:#9ca3af; --border-subtle:#2a2e37; --accent:#e5e7eb; --accent-fg:#0d0e10; }
    [data-theme="smoked-quartz"] { --bg-app:#0b0a0c; --bg-surface:#131115; --bg-elevated:#1b181e; --bg-hover:#252129; --fg-primary:#f0eef2; --fg-secondary:#9e99a6; --border-subtle:#2c2731; --accent:#f0eef2; --accent-fg:#0b0a0c; }
    [data-theme="lead-pencil"] { --bg-app:#18191b; --bg-surface:#202224; --bg-elevated:#292c2f; --bg-hover:#34383c; --fg-primary:#eceef0; --fg-secondary:#9ba1a8; --border-subtle:#363a3f; --accent:#eceef0; --accent-fg:#18191b; }
    [data-theme="silver-halide"] { --bg-app:#121212; --bg-surface:#1a1a1a; --bg-elevated:#232323; --bg-hover:#2e2e2e; --fg-primary:#f2f2f2; --fg-secondary:#a6a6a6; --border-subtle:#303030; --accent:#f2f2f2; --accent-fg:#121212; }
    [data-theme="stark-white"] { --bg-app:#ffffff; --bg-surface:#ffffff; --bg-elevated:#f4f4f4; --bg-hover:#eaeaea; --bg-input:#ffffff; --fg-primary:#000000; --fg-secondary:#404040; --fg-muted:#737373; --border-subtle:#d0d0d0; --border-strong:#000000; --accent:#000000; --accent-fg:#ffffff; --shadow-panel:0 6px 18px rgba(0,0,0,0.06); }
    [data-theme="night-shift"] { --bg-app:#090807; --bg-surface:#100f0d; --bg-elevated:#181613; --bg-hover:#221f1b; --fg-primary:#f0ece4; --fg-secondary:#9e978b; --border-subtle:#292520; --accent:#f0ece4; --accent-fg:#090807; }
    [data-theme="deep-slate"] { --bg-app:#0a0d10; --bg-surface:#11151a; --bg-elevated:#181e25; --bg-hover:#212933; --fg-primary:#e8edf2; --fg-secondary:#8c98a6; --border-subtle:#232c37; --accent:#e8edf2; --accent-fg:#0a0d10; }
    [data-theme="charcoal-grid"] { --bg-app:#0e0e0f; --bg-surface:#151517; --bg-elevated:#1e1e21; --bg-hover:#28282c; --fg-primary:#ededef; --fg-secondary:#96969e; --border-subtle:#2a2a2e; --accent:#ededef; --accent-fg:#0e0e0f; }
    [data-theme="cinder-block"] { --bg-app:#131313; --bg-surface:#1b1b1b; --bg-elevated:#242424; --bg-hover:#2f2f2f; --fg-primary:#e6e6e6; --fg-secondary:#949494; --border-subtle:#2d2d2d; --accent:#e6e6e6; --accent-fg:#131313; }
    [data-theme="foggy-mirror"] { --bg-app:#191a1c; --bg-surface:#212326; --bg-elevated:#2b2e32; --bg-hover:#363a3f; --fg-primary:#f0f2f4; --fg-secondary:#a0a6ae; --border-subtle:#373b40; --accent:#f0f2f4; --accent-fg:#191a1c; }
    [data-theme="dark-room"] { --bg-app:#040303; --bg-surface:#090707; --bg-elevated:#100d0d; --bg-hover:#181414; --fg-primary:#f5f0f0; --fg-secondary:#948a8a; --border-subtle:#1f1a1a; --accent:#f5f0f0; --accent-fg:#040303; }
    [data-theme="pewter-cast"] { --bg-app:#141516; --bg-surface:#1c1d1f; --bg-elevated:#25272a; --bg-hover:#303337; --fg-primary:#ebeded; --fg-secondary:#989c9f; --border-subtle:#2e3135; --accent:#ebeded; --accent-fg:#141516; }
    [data-theme="noir-cinema"] { --bg-app:#060607; --bg-surface:#0c0c0e; --bg-elevated:#141418; --bg-hover:#1d1d22; --fg-primary:#f4f4f6; --fg-secondary:#8e8e96; --border-subtle:#222228; --accent:#f4f4f6; --accent-fg:#060607; }
    [data-theme="vellum-gray"] { --bg-app:#eceae6; --bg-surface:#f7f6f3; --bg-elevated:#e2dfda; --bg-hover:#d7d3cd; --bg-input:#fbfaf8; --fg-primary:#181817; --fg-secondary:#54534f; --fg-muted:#82807a; --border-subtle:#cfcbc4; --border-strong:#222220; --accent:#181817; --accent-fg:#f7f6f3; --shadow-panel:0 8px 22px rgba(0,0,0,0.06); }
    [data-theme="ink-wash"] { --bg-app:#09090a; --bg-surface:#111113; --bg-elevated:#19191c; --bg-hover:#232327; --fg-primary:#f1f1f3; --fg-secondary:#92929a; --border-subtle:#252529; --accent:#f1f1f3; --accent-fg:#09090a; }
    [data-theme="shadow-box"] { --bg-app:#070707; --bg-surface:#0f0f0f; --bg-elevated:#171717; --bg-hover:#212121; --fg-primary:#ebebeb; --fg-secondary:#8c8c8c; --border-subtle:#222222; --accent:#ebebeb; --accent-fg:#070707; }
    [data-theme="metal-core"] { --bg-app:#0d0f12; --bg-surface:#14171c; --bg-elevated:#1d2128; --bg-hover:#272c35; --fg-primary:#edf0f5; --fg-secondary:#9098a6; --border-subtle:#282e38; --accent:#edf0f5; --accent-fg:#0d0f12; }
    [data-theme="bone-china"] { --bg-app:#f6f5f2; --bg-surface:#ffffff; --bg-elevated:#edeae4; --bg-hover:#e2ded6; --bg-input:#ffffff; --fg-primary:#121211; --fg-secondary:#4d4c48; --fg-muted:#7d7b75; --border-subtle:#d6d2ca; --border-strong:#191918; --accent:#121211; --accent-fg:#ffffff; --shadow-panel:0 8px 22px rgba(0,0,0,0.06); }
    [data-theme="slate-vault"] { --bg-app:#0b0d10; --bg-surface:#12151a; --bg-elevated:#1a1e25; --bg-hover:#232832; --fg-primary:#e6eaf0; --fg-secondary:#8892a0; --border-subtle:#242a34; --accent:#e6eaf0; --accent-fg:#0b0d10; }
    [data-theme="obsidian-grid"] { --bg-app:#050506; --bg-surface:#0b0b0d; --bg-elevated:#131316; --bg-hover:#1c1c20; --fg-primary:#f4f4f6; --fg-secondary:#8b8b93; --border-subtle:#212126; --accent:#f4f4f6; --accent-fg:#050506; }
    [data-theme="graphite-pro"] { --bg-app:#121315; --bg-surface:#191b1e; --bg-elevated:#222529; --bg-hover:#2c3035; --fg-primary:#f0f2f4; --fg-secondary:#9ca3ac; --border-subtle:#2e3238; --accent:#f0f2f4; --accent-fg:#121315; }
    [data-theme="pure-contrast"] { --bg-app:#000000; --bg-surface:#000000; --bg-elevated:#111111; --bg-hover:#222222; --fg-primary:#ffffff; --fg-secondary:#b3b3b3; --border-subtle:#404040; --border-strong:#ffffff; --accent:#ffffff; --accent-fg:#000000; }
    [data-theme="soot-black"] { --bg-app:#040404; --bg-surface:#0a0a0a; --bg-elevated:#121212; --bg-hover:#1b1b1b; --fg-primary:#e8e8e8; --fg-secondary:#878787; --border-subtle:#1e1e1e; --accent:#e8e8e8; --accent-fg:#040404; }
    [data-theme="frost-gray"] { --bg-app:#17191c; --bg-surface:#1f2226; --bg-elevated:#292d32; --bg-hover:#343940; --fg-primary:#f2f4f7; --fg-secondary:#a3aab3; --border-subtle:#363b42; --accent:#f2f4f7; --accent-fg:#17191c; }
    [data-theme="tar-pit"] { --bg-app:#030303; --bg-surface:#080808; --bg-elevated:#0f0f0f; --bg-hover:#171717; --fg-primary:#ededed; --fg-secondary:#828282; --border-subtle:#1a1a1a; --accent:#ededed; --accent-fg:#030303; }
    [data-theme="ash-paper"] { --bg-app:#e6e6e6; --bg-surface:#f2f2f2; --bg-elevated:#dcdcdc; --bg-hover:#cfcfcf; --bg-input:#f9f9f9; --fg-primary:#111111; --fg-secondary:#4a4a4a; --fg-muted:#767676; --border-subtle:#c4c4c4; --border-strong:#181818; --accent:#111111; --accent-fg:#f2f2f2; --shadow-panel:0 8px 20px rgba(0,0,0,0.06); }
    [data-theme="steel-core"] { --bg-app:#0c0e11; --bg-surface:#13161b; --bg-elevated:#1b1f26; --bg-hover:#252a33; --fg-primary:#eceff4; --fg-secondary:#8e96a4; --border-subtle:#262c36; --accent:#eceff4; --accent-fg:#0c0e11; }
    [data-theme="noir-matte"] { --bg-app:#080809; --bg-surface:#0f0f11; --bg-elevated:#17171a; --bg-hover:#202024; --fg-primary:#f3f3f5; --fg-secondary:#91919a; --border-subtle:#232328; --accent:#f3f3f5; --accent-fg:#080809; }
    [data-theme="carbon-slate"] { --bg-app:#0a0b0d; --bg-surface:#111316; --bg-elevated:#191c20; --bg-hover:#22262c; --fg-primary:#eef0f3; --fg-secondary:#8f96a0; --border-subtle:#24282e; --accent:#eef0f3; --accent-fg:#0a0b0d; }
    [data-theme="chalk-dark"] { --bg-app:#0d0d0d; --bg-surface:#151515; --bg-elevated:#1e1e1e; --bg-hover:#282828; --fg-primary:#f8f8f8; --fg-secondary:#9e9e9e; --border-subtle:#2b2b2b; --accent:#f8f8f8; --accent-fg:#0d0d0d; }
    [data-theme="silver-mist"] { --bg-app:#151618; --bg-surface:#1d1f22; --bg-elevated:#26292d; --bg-hover:#31353a; --fg-primary:#f0f2f4; --fg-secondary:#9ea4ad; --border-subtle:#31353b; --accent:#f0f2f4; --accent-fg:#151618; }
    [data-theme="darkios-prime"] { --bg-app:#050505; --bg-surface:#0c0c0e; --bg-elevated:#141418; --bg-hover:#1d1d22; --fg-primary:#ffffff; --fg-secondary:#9898a0; --border-subtle:#242429; --border-strong:#ffffff; --accent:#ffffff; --accent-fg:#050505; }

    * { box-sizing: border-box; margin: 0; padding: 0; -webkit-tap-highlight-color: transparent; }

    html, body {
      height: 100%;
      background-color: var(--bg-app);
      color: var(--fg-primary);
      font-family: var(--font-sans);
      font-size: 14px;
      line-height: 1.45;
      overflow-x: hidden;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }

    .gpu-layer, .panel, .modal-backdrop, .modal-sheet, .btn, .nav-item, .key-row, .toast {
      transform: translateZ(0);
      backface-visibility: hidden;
      will-change: transform, opacity;
      transition: transform 140ms var(--ease-120), background-color 140ms var(--ease-120), border-color 140ms var(--ease-120), opacity 140ms var(--ease-120);
    }
    .btn:active { transform: translateZ(0) scale(0.97); }

    ::-webkit-scrollbar { width: 6px; height: 6px; }
    ::-webkit-scrollbar-track { background: var(--bg-app); }
    ::-webkit-scrollbar-thumb { background: var(--border-strong); border-radius: 3px; }

    #login-screen { position: fixed; inset: 0; z-index: 900; display: flex; align-items: center; justify-content: center; padding: 20px; background: var(--bg-app); }
    .login-box { width: 100%; max-width: 390px; background: var(--bg-surface); border: 1px solid var(--border-subtle); border-radius: var(--radius-lg); padding: 28px 24px; box-shadow: var(--shadow-panel); }
    .brand-tag { font-family: var(--font-mono); font-size: 11px; letter-spacing: 0.16em; text-transform: uppercase; color: var(--fg-secondary); margin-bottom: 6px; }
    .login-title { font-size: 20px; font-weight: 700; letter-spacing: -0.02em; margin-bottom: 4px; }
    .login-sub { font-size: 12px; color: var(--fg-muted); margin-bottom: 22px; }
    .form-group { margin-bottom: 14px; }
    .form-label { display: block; font-family: var(--font-mono); font-size: 11px; text-transform: uppercase; letter-spacing: 0.08em; color: var(--fg-secondary); margin-bottom: 6px; }
    .input, .select, .textarea { width: 100%; background: var(--bg-input, var(--bg-app)); color: var(--fg-primary); border: 1px solid var(--border-subtle); border-radius: var(--radius-md); padding: 10px 12px; font-size: 13px; font-family: inherit; outline: none; }
    .input:focus, .select:focus, .textarea:focus { border-color: var(--accent); }
    .mono { font-family: var(--font-mono); }
    .btn { display: inline-flex; align-items: center; justify-content: center; gap: 6px; padding: 9px 14px; border-radius: var(--radius-md); border: 1px solid var(--border-subtle); background: var(--bg-elevated); color: var(--fg-primary); font-size: 12px; font-weight: 600; letter-spacing: 0.02em; cursor: pointer; user-select: none; white-space: nowrap; }
    .btn:hover { background: var(--bg-hover); border-color: var(--border-strong); }
    .btn-primary { background: var(--accent); color: var(--accent-fg); border-color: var(--accent); }
    .btn-primary:hover { opacity: 0.9; background: var(--accent); }
    .btn-danger { border-color: var(--border-strong); background: transparent; color: var(--fg-secondary); }
    .btn-danger:hover { background: var(--bg-hover); color: var(--fg-primary); }
    .btn-sm { padding: 6px 10px; font-size: 11px; border-radius: var(--radius-sm); }
    .btn-block { width: 100%; }
    .error-msg { font-size: 12px; color: var(--fg-primary); background: var(--bg-elevated); border: 1px solid var(--border-strong); padding: 8px 10
