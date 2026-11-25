<?php
// ============================================================================
// DARKIOS // Key Management Admin Panel — PHP Version
// ============================================================================

declare(strict_types=1);

// Sessiyanı başladırıq (Login üçün mütləqdir)
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// ----------------------------------------------------------------------------
// 1) KONFİQURASİYA
// ----------------------------------------------------------------------------
$CONFIG = [
    'admin_user' => 'admin',
    'admin_pass' => 'darkios120', // Şəkildəki xəta buradakı şifrənin səhv yazılmasından ola bilər
    'app_title'  => 'DARKIOS // Key Management Admin Panel',
    'data_dir'   => __DIR__ . '/darkios_data',
];

// ----------------------------------------------------------------------------
// 2) DATA QOVLUĞUNU HAZIRLA
// ----------------------------------------------------------------------------
if (!is_dir($CONFIG['data_dir'])) {
    @mkdir($CONFIG['data_dir'], 0775, true);
}

$keysFile = $CONFIG['data_dir'] . '/keys.json';

if (!file_exists($keysFile)) {
    $now = time() * 1000;
    $seed = [
        'brand' => 'DARKIOS',
        'updatedAt' => date('c'),
        'keys' => [
            [
                'id' => 'k_1', 'code' => 'DARKIOS-30D-9X4K2M1P', 'timeLabel' => '30D',
                'createdAt' => $now - 3600000, 'expiresAt' => $now + 29 * 86400000,
                'remainingOnPause' => null, 'paused' => false, 'banned' => false,
                'deviceLimit' => 2, 'bypassHwid' => false, 'maxFps' => 120,
                'note' => 'iOS 18.2 VIP Test',
                'devices' => [['hwid' => 'HWID-8F2A-991C', 'model' => 'iPhone 16 Pro', 'ios' => '18.2']],
            ]
        ],
    ];
    @file_put_contents($keysFile, json_encode($seed, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
}

// ----------------------------------------------------------------------------
// 3) API ENDPOINT-LƏRİ
// ----------------------------------------------------------------------------
if (isset($_GET['api'])) {
    header('Content-Type: application/json; charset=utf-8');
    $action = (string)$_GET['api'];
    $input  = json_decode(file_get_contents('php://input') ?: '{}', true) ?: [];

    switch ($action) {
        case 'load':
            echo is_readable($keysFile) ? file_get_contents($keysFile) : json_encode(['ok' => false]);
            exit;
        case 'save':
            if (!isset($input['keys'])) { echo json_encode(['ok' => false, 'error' => 'keys massivi tələb olunur']); exit; }
            $payload = ['brand' => 'DARKIOS', 'updatedAt' => date('c'), 'keys' => $input['keys']];
            $written = @file_put_contents($keysFile, json_encode($payload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE), LOCK_EX);
            echo json_encode(['ok' => $written !== false]);
            exit;
        case 'login':
            $u = (string)($input['user'] ?? '');
            $p = (string)($input['pass'] ?? '');
            if ($u === $CONFIG['admin_user'] && $p === $CONFIG['admin_pass']) {
                $_SESSION['darkios_auth'] = true;
                echo json_encode(['ok' => true]);
            } else {
                echo json_encode(['ok' => false, 'error' => 'İstifadəçi adı və ya şifrə yanlışdır']);
            }
            exit;
        case 'check_auth':
            echo json_encode(['ok' => !empty($_SESSION['darkios_auth'])]);
            exit;
        case 'logout':
            $_SESSION['darkios_auth'] = false;
            session_destroy();
            echo json_encode(['ok' => true]);
            exit;
        default:
            echo json_encode(['ok' => false, 'error' => 'Naməlum API action']);
            exit;
    }
}
?>
<!DOCTYPE html>
<html lang="az" data-theme="obsidian-pure" data-layout="command">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover" />
  <title><?= htmlspecialchars($CONFIG['app_title'], ENT_QUOTES, 'UTF-8') ?></title>
  <style>
    :root {
      --bg-app: #050505; --bg-surface: #0c0c0c; --bg-elevated: #141414; --bg-hover: #1c1c1c;
      --bg-input: #080808; --fg-primary: #f5f5f5; --fg-secondary: #a3a3a3; --fg-muted: #666666;
      --border-subtle: #222222; --border-strong: #3a3a3a; --accent: #ffffff; --accent-fg: #050505;
      --shadow-panel: 0 12px 32px rgba(0, 0, 0, 0.75); --radius-sm: 4px; --radius-md: 8px; --radius-lg: 12px;
      --font-sans: -apple-system, BlinkMacSystemFont, "SF Pro Display", "Segoe UI", Roboto, sans-serif;
      --font-mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
      --ease-120: cubic-bezier(0.16, 1, 0.3, 1);
    }
    /* Mövzular (Qısaldılmış) */
    [data-theme="obsidian-pure"] { --bg-app:#050505; --bg-surface:#0b0b0b; --bg-elevated:#121212; --bg-hover:#1a1a1a; --fg-primary:#f5f5f5; --fg-secondary:#a0a0a0; --border-subtle:#202020; --accent:#ffffff; --accent-fg:#050505; }
    [data-theme="paper-noir"] { --bg-app:#f4f4f4; --bg-surface:#ffffff; --bg-elevated:#ebebeb; --bg-hover:#e0e0e0; --bg-input:#fafafa; --fg-primary:#0a0a0a; --fg-secondary:#4a4a4a; --border-subtle:#d4d4d4; --border-strong:#171717; --accent:#0a0a0a; --accent-fg:#ffffff; }
    
    * { box-sizing: border-box; margin: 0; padding: 0; }
    html, body { height: 100%; background-color: var(--bg-app); color: var(--fg-primary); font-family: var(--font-sans); font-size: 14px; line-height: 1.45; }
    
    #login-screen { position: fixed; inset: 0; z-index: 900; display: flex; align-items: center; justify-content: center; padding: 20px; background: var(--bg-app); }
    .login-box { width: 100%; max-width: 390px; background: var(--bg-surface); border: 1px solid var(--border-subtle); border-radius: var(--radius-lg); padding: 28px 24px; box-shadow: var(--shadow-panel); }
    .brand-tag { font-family: var(--font-mono); font-size: 11px; letter-spacing: 0.16em; text-transform: uppercase; color: var(--fg-secondary); margin-bottom: 6px; }
    .login-title { font-size: 20px; font-weight: 700; margin-bottom: 4px; }
    .login-sub { font-size: 12px; color: var(--fg-muted); margin-bottom: 22px; }
    .form-group { margin-bottom: 14px; }
    .form-label { display: block; font-family: var(--font-mono); font-size: 11px; text-transform: uppercase; margin-bottom: 6px; color: var(--fg-secondary); }
    .input { width: 100%; background: var(--bg-input); color: var(--fg-primary); border: 1px solid var(--border-subtle); border-radius: var(--radius-md); padding: 10px 12px; font-size: 13px; outline: none; }
    .input:focus { border-color: var(--accent); }
    .btn { display: inline-flex; align-items: center; justify-content: center; padding: 9px 14px; border-radius: var(--radius-md); border: 1px solid var(--border-subtle); background: var(--bg-elevated); color: var(--fg-primary); font-weight: 600; cursor: pointer; width: 100%; }
    .btn-primary { background: var(--accent); color: var(--accent-fg); }
    .error-msg { font-size: 12px; color: #ff4444; margin-top: 8px; display: none; }
    
    #app-shell { display: none; min-height: 100vh; padding: 20px; max-width: 1440px; margin: 0 auto; }
    .topbar { display: flex; justify-content: space-between; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid var(--border-subtle); }
  </style>
</head>
<body>

  <section id="login-screen">
    <div class="login-box">
      <div class="brand-tag">DARKIOS // ADMIN</div>
      <h1 class="login-title">Admin giriş</h1>
      <p class="login-sub">Lisenziya idarəetmə sisteminə xoş gəlmisiniz.</p>
      <div id="login-error" class="error-msg">Username və ya password yanlışdır.</div>
      <form id="login-form">
        <div class="form-group">
          <label class="form-label" for="login-user">USERNAME</label>
          <input id="login-user" class="input" type="text" value="admin" required />
        </div>
        <div class="form-group">
          <label class="form-label" for="login-pass">PASSWORD</label>
          <input id="login-pass" class="input" type="password" value="darkios120" required />
        </div>
        <button type="submit" class="btn btn-primary">Təhlükəsiz giriş →</button>
      </form>
    </div>
  </section>

  <div id="app-shell">
    <div class="topbar">
      <div class="brand-tag">DARKIOS PANEL</div>
      <button id="btn-logout" class="btn" style="width:auto;">Çıxış</button>
    </div>
    <h2>Xoş gəlmisiniz, Admin!</h2>
    <p style="margin-top:10px; color:var(--fg-muted);">Bütün sistemlər işləkdir. Açarları idarə etmək üçün tabları istifadə edin.</p>
  </div>

  <script>
    (function() {
      const $ = (id) => document.getElementById(id);

      // Auth yoxlaması (Səhifə yüklənəndə sessiyanı yoxlayır)
      fetch('?api=check_auth')
        .then(res => res.json())
        .then(data => {
          if (data.ok) {
            $('login-screen').style.display = 'none';
            $('app-shell').style.display = 'block';
          }
        });

      // Login Formu
      $('login-form').addEventListener('submit', (e) => {
        e.preventDefault();
        const user = $('login-user').value.trim();
        const pass = $('login-pass').value;
        
        $('login-error').style.display = 'none';

        fetch('?api=login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ user: user, pass: pass })
        })
        .then(res => res.json())
        .then(data => {
          if (data.ok) {
            $('login-screen').style.display = 'none';
            $('app-shell').style.display = 'block';
          } else {
            $('login-error').textContent = data.error || 'Xəta baş verdi';
            $('login-error').style.display = 'block';
          }
        })
        .catch(() => {
          $('login-error').textContent = 'Serverlə əlaqə kəsildi.';
          $('login-error').style.display = 'block';
        });
      });

      // Çıxış
      $('btn-logout').addEventListener('click', () => {
        fetch('?api=logout')
          .then(() => location.reload());
      });
    })();
  </script>
</body>
</html>
