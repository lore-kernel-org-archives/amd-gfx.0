Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F32CA5FC5
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 07:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC0610F5A1;
	Thu,  1 Oct 2026 07:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YayvKTzr";
	dkim-atps=neutral
Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com
 [74.125.229.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C205510EC09
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 20:03:37 +0000 (UTC)
Received: by mail-dl2-f33.google.com with SMTP id
 a92af1059eb24-1438e88300cso5857110c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790798617; x=1791403417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cASLx32ym87jdhS0h2FvPN2AduCc3BT2HfqD8zMngx0=;
 b=YayvKTzrZRVoCpfIAupEZxhGiQLSfp1KKZFfOksMwZLYDDtGLa6XaJYTz8kkcZmsAU
 XB1e8FHhnDkH/Tpx7YwGr5fnl7MW9LFEV2BzaWl3qVjOc7zeTVoublM7MBElYbSq5Z2E
 Tz21zWt3dzYBC6uv6jH0gHIFi3ygaVcMdSVfRIk6FTqshR77lubbQhbR5ACE1S3rNj1f
 5DW559odl35oahYZZSY+hJ0E1LH4MCGKmZq3YkRmA385QHmfg288gUebg5PK9hL4Sv3x
 HNDZv6wmBYRXTA5V1AUP9h/KJv1ka2FVx0hrEnhNCS4tj1A1eBYrFwPtWfwpARUd9xEj
 vVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790798617; x=1791403417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cASLx32ym87jdhS0h2FvPN2AduCc3BT2HfqD8zMngx0=;
 b=cNf3hgGENsHZfnv6d4tsb+kKAwo5chwC5FZYTHPUvGMXUMYrC7ekAaV4PObWAWzGvb
 mBtyg8ss+yxV7wQEnJGvz6ZAP2LI6tWa0wA1PAv2Ill33mPFw/dXR0jZ0flnmCasPfAS
 KzkLY8muIL6nVVfQoDgk4uMNueeqMGDDZJKS0qJ50XG8SpOrXrrbKprZyWlwM/tnaxz4
 9K+KGxMp3sBimFXf7H0xNZxQVLysdRArcY53KWSOlCm0DrOlbTp7iuk9xtJY/yhEdlIf
 khdT0VEd9XwZTf0/vOUJdq+UJd2oKOA2+WSeXXjLHE+iGopdRYU6QVZeyLYSx25EDuJI
 L9bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwBi3WudwasTkRfq1V5NrUNS74WDpUPY4UUlg3nAd3wnE+0BPExk753uNkuWhmwwdW8ohjlx8Q@lists.freedesktop.org
X-Gm-Message-State: AFuF++k7ErDpm4ZndDAyk5okzuKOLQPjkwgurbQCS4xEGIl3k0QJ4ReS
 sW7ew1SsffKQ4WukTzCaYvxZ62Cz/Rq3QfK2h7Z/4L88sOan1k4PNGp/
X-Gm-Gg: AYBFou1ojGbFqddrDUkT5NnZbalAMZnFfg23Z328utrDBnOUJpSN8DXFfp08oOT9JUf
 G7lAgaz3LuJ+XXBRIj7kon4M6vIX51XoVF8XLEGfumFmyAMVFwXEPk/JhBEHInvNtHFYTw6OoQo
 43aqFJgHGalksqbznJGz2uQbSEVhVqR9oAYQJycdQZGzn462Nu0KmoBDrDwWhVEU/83fnQ2IUmc
 V/UousID87jjuF0MDw0a4sT4qT3mkrXQglemAHpq2DsZKhs+sxjDlsYG5fwTDzFpvOV6xvobFWO
 EF7HOMiMRa06ZnOsrj0MSWyXdp7uRXJdzgL/dW5LXh1U3Gh3tkXM1tohO1rFtdMnflcp2L9My8w
 u8Wei+YCUd5gqfJqQ/5/mH0W43FCBTAU/iPqGK4V6cl5gRS5RNzu9Gbxf7EdRK2gvFDxgqSWz5r
 J/kcY9QsUHetn77Va03rpKkJoT6ZZeP9QUNA87R0xCPeYoqlWQCZbt0gPiPIx5v8Fjotrc7gvOz
 c/sqoc=
X-Received: by 2002:a05:7022:158b:b0:141:5281:8a41 with SMTP id
 a92af1059eb24-14d33494dfamr2639297c88.9.1790798616734; 
 Wed, 30 Sep 2026 13:03:36 -0700 (PDT)
Received: from G15-5520 ([36.255.19.64]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14df11858b3sm460601c88.2.2026.09.30.13.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:03:36 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] amdgpu: Use 2-argument strscpy() where destination size is
 known
Date: Wed, 30 Sep 2026 20:03:25 +0000
Message-ID: <20260930200326.42827-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 07:16:44 +0000
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

Simplify the code by dropping the explicit size argument from strscpy()
where the destination buffer has a compile-time known size.

No functional change.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 1e21e3444802..34defcfc563d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -327,7 +327,7 @@ static int amdgpu_atomfirmware_get_uma_carveout_info_v2_3(struct amdgpu_device *
 			uma_info->entries[i].memory_carved_mb = (uint32_t)opts[i].memoryCarvedGb << 10;
 
 		uma_info->entries[i].flags = opts[i].uma_carveout_option_flags.all8;
-		strscpy(uma_info->entries[i].name, opts[i].optionName, MAX_UMA_OPTION_NAME);
+		strscpy(uma_info->entries[i].name, opts[i].optionName);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 92c98e999efe..40829d2f9c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -428,7 +428,7 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
 		if (!mode)
 			return;
-		strscpy(mode->name, common_modes[i].name, DRM_DISPLAY_MODE_LEN);
+		strscpy(mode->name, common_modes[i].name);
 
 		drm_mode_probed_add(connector, mode);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e780feb7..aafcd60d2107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3591,7 +3591,7 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	 * remains intact for multi-GPU systems where this function is called
 	 * once per device.
 	 */
-	strscpy(buf, amdgpu_lockup_timeout, sizeof(buf));
+	strscpy(buf, amdgpu_lockup_timeout);
 
 	while ((timeout_setting = strsep(&input, ",")) &&
 	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f280e2..9796eeab73bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1410,7 +1410,7 @@ static void atom_get_vbios_name(struct atom_context *ctx)
 
 no_name:
 	/* do not know where to find name */
-	strscpy(ctx->name, na, sizeof(ctx->name));
+	strscpy(ctx->name, na);
 }
 
 static void atom_get_vbios_date(struct atom_context *ctx)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c3322058720f..a50d2885d786 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2356,7 +2356,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
 			ring = &adev->gfx.sw_gfx_ring[i];
 			ring->ring_obj = NULL;
-			strscpy(ring->name, amdgpu_sw_ring_name(i), sizeof(ring->name));
+			strscpy(ring->name, amdgpu_sw_ring_name(i));
 			ring->use_doorbell = true;
 			ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 			ring->is_sw_ring = true;
-- 
2.53.0

