Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75272E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 14:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F2C10EB04;
	Tue,  7 Jan 2025 14:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VWsbo/Uv";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2AE10EB04
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 14:54:12 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso30383746a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2025 06:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736261591; x=1736866391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TK2M5ZAcDYBti+AJCWYIBeGyF0gf1q2Fk9wk6GE9DDs=;
 b=VWsbo/Uv6E+EcBlKohxHMRagonldh038nHyYvRPnVR6FLy7RxVUPEEUXxZoNMaGGc3
 kB31eJfhlzLWX/Eytxh3pV9x6oSs+kNbKq+4CYL55IJJhjp9dn/E/lKhTg0WmXOyg0hM
 X21T8CK+ji+6i1v9opfilNYJJuZeUrq1zslCKtNKeYI43njsw+XoMyGl8UJCkfMsK9Yl
 ElssgW1cDp5W8PhkfJ68Vwezm8Jawditu66Zd0gG/RRVjzNDZMb3abPv3ljhU3h4eiJK
 Gt/cx3tduIAaSb4OnG21/L4JtYmJdjqit6qccdRJEkz9tXhUSMKDavOp3xQm2sDKPGN7
 ipNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736261591; x=1736866391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TK2M5ZAcDYBti+AJCWYIBeGyF0gf1q2Fk9wk6GE9DDs=;
 b=GZPXbL79687nAMWZEDt3Bv8Wh1B2lJ+mkP7lEy+2wrraGHj2rEypvd7iBE+KJNm8HC
 fnXkIuvseS21wa2ajPKXCjCDytp0Z8jb0XyDHJoH2hWyEO1SHK6EJrIvc/VBFBVsAXBT
 uU9eSDkKV0nwcYIFMCuB7qzv+QDpcH/CkQIqt0R/WOAf+NxFg0V+C5WLrp0gGrZuxDDC
 6hVCI+wFose/cSEoGWJKLEHrGv4+seA3B3MWUee+8mAEYcswP0i5UZOp70nF2K7Wzmyf
 TLGlgEjguOgZhr9Fee5LX8rFIctREC3c2GL32l5treaSJVFr0AwlLm5FKK6zlmT4dexK
 7PGw==
X-Gm-Message-State: AOJu0YwdEMd1Jx2+FFDalXLIRP5UG++r9batb3L5kHiWu8RKqfL4Oq7a
 rHrh02N2EstlW6ZDFt79qDQgpctRfBUVk4TeOLPHWFT57NYlg7BNAqnLyLrB
X-Gm-Gg: ASbGnctZqv17yZ4jBH2GPDWc/3Hx+cjKzwNCHPWAfcEMyDxBOzWAG3pWs9J57dEmRnb
 dqY73d5UVdjg95V7lIj09HGz62SN28LQBOFI7OLvP93qpvTFOTLKja7ExXllsNdwqBx1VldD7TL
 XCk4FTPHWzYNFmlamZTpSvF0DejUHT0OP9eNutU1K2TpOhDd6wVVO1g/earvyJ3zBWMkJMi5rNC
 7Fr9SSJ/0IcWCveH9bVtkYtdARk2zZavyWwD8DvRVtY861+KR7FcFq7Qx10kZ7IalQ=
X-Google-Smtp-Source: AGHT+IHZinfjx/aThL8TXl98MvsyaJsQyotamSBl9+Cp2+3rIvaVMrqGo+bRv7uoPvkeTg1oHB4VHg==
X-Received: by 2002:a05:6402:5297:b0:5d0:ece3:158a with SMTP id
 4fb4d7f45d1cf-5d95e8c2306mr3118170a12.3.1736261590504; 
 Tue, 07 Jan 2025 06:53:10 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1513:4500:e5:dd5f:a700:7ec4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80679eea6sm24315393a12.49.2025.01.07.06.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 06:53:10 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	sima@ffwll.ch
Subject: [PATCH] drm/amdgpu: mark a bunch of module parameters unsafe
Date: Tue,  7 Jan 2025 15:53:08 +0100
Message-Id: <20250107145308.53467-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We sometimes have people trying to use debugging options in production
environments.

Mark options only meant to be used for debugging as unsafe so that the
kernel is tainted when they are used.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index acb9dc3705ac..9ddfdb02a6a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -401,7 +401,7 @@ module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
  * the kernel log for the list of IPs on the asic. The default is 0xffffffff (enable all blocks on a device).
  */
 MODULE_PARM_DESC(ip_block_mask, "IP Block Mask (all blocks enabled (default))");
-module_param_named(ip_block_mask, amdgpu_ip_block_mask, uint, 0444);
+module_param_named_unsafe(ip_block_mask, amdgpu_ip_block_mask, uint, 0444);
 
 /**
  * DOC: bapm (int)
@@ -459,7 +459,7 @@ module_param_named(vm_update_mode, amdgpu_vm_update_mode, int, 0444);
  * Enable experimental hw support (1 = enable). The default is 0 (disabled).
  */
 MODULE_PARM_DESC(exp_hw_support, "experimental hw support (1 = enable, 0 = disable (default))");
-module_param_named(exp_hw_support, amdgpu_exp_hw_support, int, 0444);
+module_param_named_unsafe(exp_hw_support, amdgpu_exp_hw_support, int, 0444);
 
 /**
  * DOC: dc (int)
@@ -570,14 +570,14 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
  * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
  */
 MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
-module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
+module_param_named_unsafe(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
 
 /**
  * DOC: emu_mode (int)
  * Set value 1 to enable emulation mode. This is only needed when running on an emulator. The default is 0 (disabled).
  */
 MODULE_PARM_DESC(emu_mode, "Emulation mode, (1 = enable, 0 = disable)");
-module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
+module_param_named_unsafe(emu_mode, amdgpu_emu_mode, int, 0444);
 
 /**
  * DOC: ras_enable (int)
@@ -732,7 +732,7 @@ module_param_named(noretry, amdgpu_noretry, int, 0644);
  */
 MODULE_PARM_DESC(force_asic_type,
 	"A non negative value used to specify the asic type for all supported GPUs");
-module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
+module_param_named_unsafe(force_asic_type, amdgpu_force_asic_type, int, 0444);
 
 /**
  * DOC: use_xgmi_p2p (int)
@@ -955,7 +955,7 @@ module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
  */
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
-module_param_named(reset_method, amdgpu_reset_method, int, 0644);
+module_param_named_unsafe(reset_method, amdgpu_reset_method, int, 0644);
 
 /**
  * DOC: bad_page_threshold (int) Bad page threshold is specifies the
@@ -1051,7 +1051,7 @@ module_param_named(seamless, amdgpu_seamless, int, 0444);
  * - 0x4: Disable GPU soft recovery, always do a full reset
  */
 MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by default");
-module_param_named(debug_mask, amdgpu_debug_mask, uint, 0444);
+module_param_named_unsafe(debug_mask, amdgpu_debug_mask, uint, 0444);
 
 /**
  * DOC: agp (int)
-- 
2.34.1

