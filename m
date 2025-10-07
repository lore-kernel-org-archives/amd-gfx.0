Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA6ECAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 12:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5169710E7FC;
	Wed,  8 Oct 2025 12:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvyH8B/e";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F47710E0F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 22:46:03 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso4418883f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Oct 2025 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759877161; x=1760481961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3pQQY2keBFswywTklmwxwyGGVpvzk59ZMACKy3TjyoA=;
 b=WvyH8B/eMRguMiSUiNHuTOhuiMctOqFVPJKQEbOs/YxXGZMaXLSn3OIHtUYiBBQ5G+
 jff4k9jAK1N/MBWGwGPSyHuOaxagXRgoAs/HIaQN3qW7tL+DU6fVyHjRX/ArTXMarFbc
 6iyTfOmobTdoQitqgDbjcNafZxhFYkWuWiOWF8G6TJn65T4x7SnbbFhoLM7RAgZR64rs
 dlGFePP/tmn7de4PrBOQ4MqbeBSm1tobbfQukcuDFzyPsKxES8u7IQswKGvOkrs0acxT
 8OVxv6eXUGGqW2oBE4Mt7PnJihm9V32kbXjuRUnyPYFfujfzBWipQuhGK3bVqE0iPhDd
 iMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759877161; x=1760481961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3pQQY2keBFswywTklmwxwyGGVpvzk59ZMACKy3TjyoA=;
 b=Fp8HFzon10sfVxYPDb27saNXM9ZPRqscJXtv2G5t3MCSHanLtd8EeNmBAwOQQ+P5ap
 HoXzb6k9IrbOgkXs3B26pcVf2GVcOg1ywm+IjZbo9Oluaq4WJPrTSXVAMd0z8pG2RupV
 iap0ku0o78oO41bpXWujX3NVBvf4A6SRz65RntdLbzrj4Rw7VL9M6S1jWckUwbicY4vI
 7zDURkUpx3TCtpxJ1Z/scOlo5XmCCBKbMjCeodEuUuWQ60eoSDWSvd9nMXhlBuUsQoLu
 z8/iSvej7Y20SfuKaAMvxSRB2MM/LThwBCUI98IPWueXRBCmQ4iHseWIwg2wVHSwencr
 z+1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7di84QWe2adIHuFck7RhI8ZG3OreauBctQEvp4cBl8aSCDufhKBYn/UzLgptI2dkl/5CY1CIM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8+V4YIeSma4S7NdeuphkR6vMGngCTIlhMM2AqO8sOSTKg7/rX
 Khrx9Xje31NSKHENDRbjfCZd1wPhm69EguhMu8fqNH9K7o3inLdNDrSZ
X-Gm-Gg: ASbGncsN/qn4jXm++LGc0JorFnv8EdfBXEy+ZBC6QVTzi1z92JxURSiOTZgaIznK246
 D0Dp/3eeSWXqxQUT2+qseDp+Fw+UD12TdxaeChDfGHzz81zrzzG/7mGc6WRC5+64qxSjj/O2LMx
 jEWvyJe5ZTP+ldAMvOnsKIA+VqhY4u73fXR0CiHdmiDp87qX+E6bYRPmoUZWPrOXYZ8ampzg7SF
 VYQrVoWBI7v1NoOVR1zve5IAp5cOFb4X2iwEF3Ph1hf7fANgguDrzpJUFDOaPU+LIG7Vf6dNj62
 6ri1Go4+pamkXgjMVmHA6BtTw7wwyc7LmQoOOZ+sLEmkxkfgnJQrjwgg0Mn29Ujs7Nr6KP8n6bt
 pAkSYpYZ86XHSWrUJUEj7Ev0VSb9dpQwgfw/yp/agFHa2IgUDGKgnMiocJ/Nm5cQ=
X-Google-Smtp-Source: AGHT+IGpUoeWYYfKgtD3wk2UP4YLDCFnN42FiNw3j98CkNvoabTKCMcEKd8fM1WEcK58BkjWgmbiLQ==
X-Received: by 2002:a05:6000:1a8e:b0:3ff:17ac:a34c with SMTP id
 ffacd0b85a97d-4266e8e46b1mr536653f8f.59.1759877161371; 
 Tue, 07 Oct 2025 15:46:01 -0700 (PDT)
Received: from ekhafagy-ROG-Strix.. ([41.37.1.171])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01a0sm26925335f8f.48.2025.10.07.15.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 15:46:01 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Yilin Chen <Yilin.Chen@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: eslam.medhat1993@gmail.com
Subject: [PATCH RESEND] drm/amd/display: Initialize return value in
 dm_cache_state()
Date: Wed,  8 Oct 2025 01:45:44 +0300
Message-ID: <20251007224549.87548-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Oct 2025 12:49:35 +0000
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

Initialize the return variable "r" to 0 in dm_cache_state() to fix
a potential use of uninitialized variable warning.

The return value for this function might not be a PTR_ERR, in casse if
condition fails. In that case we ensure predictable reutrn.

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e1622bf7a42..6b4f3eb9ce48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3115,7 +3115,7 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 
 static int dm_cache_state(struct amdgpu_device *adev)
 {
-	int r;
+	int r = 0;
 
 	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
 	if (IS_ERR(adev->dm.cached_state)) {
-- 
2.43.0

