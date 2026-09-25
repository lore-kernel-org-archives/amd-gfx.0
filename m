Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A20C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2E010F900;
	Fri, 25 Sep 2026 07:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mlopop8o";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15BA610E44C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 07:25:06 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so3178055e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790321104; x=1790925904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jJsFR3C4BXwq6V8a4asvimu14gijx70uQQhfBt9Dfjk=;
 b=mlopop8o3CPIABgoNh77bfKzDcwZIKdAhhn6mKWFvsg1rOORpm31hv8r3TBsx7ufnp
 SsImscV1vY7dVleSbLs0kAvU3nBPFVyfvPzMZrXr2q+1VF2E1s+XGdhynOxbHSLcAxXI
 L9RrUS97DzYGLlbA8Eyrb4JZiw46D4dQzsCWipfv9TH1+6JwjsrYLLKg1W75xA5SLM8x
 W24gm78V36u5ez1jY0dZ/9AbgsNozlTv2i4bAOJCNrW1uqr/0gc1QAscB+doCkwMlp/y
 sjGjqlQv3J8iq4wAEQ9vPONkgiOEXhBQlq4H4BOZuWBap2Ap8W84EeJKcuDPFPh59AWh
 w2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790321104; x=1790925904;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jJsFR3C4BXwq6V8a4asvimu14gijx70uQQhfBt9Dfjk=;
 b=t1TshDbcj7NYW0mEusDsbLnYch8TmWJ37djphnl6vHxYKxxklrsqPoT0tuOSFnS6H7
 n6Ws6rbhFQx377n8PSwJQ43LJOAJ2GrYyaHhwXsZKPMFMv/rZyOGBKMjX2CclZY9WySH
 MGnVKUMS6q8v240v+zTfr6AQ0tDGWabzx6SXYfGlYqo1hTViJ3L0ifBiORM8QA7R4R/B
 RTjWn/V1+s9Fr6wO6ccNUPnWvPOxjiYH6NFv8WhBO0ay4ePx58TdC8cQqhQ1/uRL4Aqx
 Yv7pMK3MolOHPUNPHDmDclkNxUVwzRX02PwRiOyXyTpKGm1JzyKccy9fb/fA2LmT2DWR
 40HA==
X-Gm-Message-State: AFuF++nBIOxSN/IF1LRSYzjwsa2nrcaw2m9m/uthR9X4VIC0+qpErXTd
 haaAW/8uiOroR+IwB2Am7pdDQR0nm+Wy0gg+p46dbyzyl0oAKm/KHgO6
X-Gm-Gg: AYBFou0RyrsMMt4dGTJrHkmbh6wJQCNI3KIk3P5YTob9p9UNdGFejmkfbi2l/KwCJAl
 haSDlhR9mMZFsyHUdOm8sTDFMK/zdz2eDIR757qD5deozerrdGetOp3wETtfAulNfe1ByNYt1/x
 88OjZmYganKgYbQf8ucPflOJvQbaKqcllcgzwBlwhVXNIUNOguhv00Ft3PDeJTCu2ZCUHNXRnCm
 6f+pphATFMSiNw5swOfuogMQ7i2Nm2JPm1qzae/ltwU58FSmNijY/H7zZZbLEuDWmyDrqckysZa
 NjlLOWJ9ZT3et894wksmG+3aJKvB21LFzqVUH4vNl+InQ6mGsvrA5YDVRrdjssqjdcR+6UnmS8t
 Vjb2bnwaF+af6FCsPSJbZ2NjG05mXrU7EzlpRmAaqx9bjpBt/WPX67j63EOH7+DoP5gKytNJXhj
 61z5B9SyV+ObEIa4rqCjnzBVQYwc+HakVj0D4/Zd62gmH9gobzRiVuPkTcrI8/9+28dP/gpDpYr
 FtHvA==
X-Received: by 2002:a05:600c:1546:b0:49c:fa20:cc00 with SMTP id
 5b1f17b1804b1-49fe66f4f59mr83248455e9.23.1790321104123; 
 Fri, 25 Sep 2026 00:25:04 -0700 (PDT)
Received: from abcmhome.hgw.local ([83.66.10.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5dfa6a7sm201790475e9.12.2026.09.25.00.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 00:25:03 -0700 (PDT)
From: =?UTF-8?q?Ayhan=20=C3=87i=C3=A7ek?= <ayhancicek@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 =?UTF-8?q?Ayhan=20=C3=87i=C3=A7ek?= <ayhancicek@gmail.com>
Subject: [PATCH] drm/amdgpu: extend MacBook VRAM-at-0 workaround to VERDE
Date: Fri, 25 Sep 2026 10:24:44 +0300
Message-ID: <20260925072444.18982-1-ayhancicek@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:39:28 +0000
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

The existing MacBook workaround reserves VRAM at address 0 for
Polaris ASICs when the iGPU is enabled. This prevents cursor
allocations from landing at address 0.

A MacBookPro11,5 with Radeon R9 M370X (VERDE) hits the same
failure mode. Hardware cursor updates repeatedly log
"DC: Cursor address is 0!" followed by
"DC failed to set cursor attributes".

Extend the existing workaround to CHIP_VERDE. With this change,
hardware cursor operation is stable, the cursor errors remain at
zero during repeated cursor movement, and cursor disappearance
and flicker are no longer observed.

Signed-off-by: Ayhan Çiçek <ayhancicek@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1bf2a42fa..9e7f9cc2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1086,6 +1086,7 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
+	case CHIP_VERDE:
 	case CHIP_POLARIS10:
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
-- 
2.55.0

