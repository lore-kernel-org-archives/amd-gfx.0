Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E6BCD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A868910F0D3;
	Wed, 17 Jun 2026 19:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O4YLeelt";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F8F10F0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:40 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso13216935e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723679; x=1782328479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8K6+A7r/B8NYXiWhcOZi9YyV3tUxy0SFwGc/29EYoQ=;
 b=O4YLeelt4k/jChaEof5WYdrusHs2rTJICYOOMxZ2BQ/8oUYPajp0j9PHgDXbLr7lwQ
 b6fC381X8MAVJyzBIjvqtYsPV0EwjuYinT+g+2qcBBIKbaXJp+7i8cgs1e7bR9PUtQRV
 MFRYMIZK4pxwO2fWMgq/33CffAigqknmDoUdcNNnY9ojW3SALkasHdXmv1kgWz4tTWjH
 1XAdg6rPp9TBh3w0dPQSVF7bC+8Ia08/F8HUcYyiL+KDw9Z/MOHfVb+XM+2CXgHOXOtq
 nUf86avIGiah/c0qAUrT96X8C3W4zgq8hJ0zYcqcxTqGzqsoxtL1F2Ni7Lp8m4tKYd3W
 uXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723679; x=1782328479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8K6+A7r/B8NYXiWhcOZi9YyV3tUxy0SFwGc/29EYoQ=;
 b=ECdV8fymGpsEOlvDr4+Ya5Ehkk1AtlEroVTgE0ypc/45hPliaSBFP6bIvD75KyqXpK
 FKKqq8905Lz3wtWfrRwLd7STWZhVKKLwU5VK6qWCjNeEKBJgoeGaG1Kb4M1hYV0s89FP
 9Dt+vda8Y1B75Y26iiOsARFZ3iCsURzpdbmcVULRLWQ7AdJQ1tdJVnXPVCP1IMYyxsin
 erBeqY4Z2/2/vL2SCXRFG6YIKUwT4hXkTn3A1qlTqqqbuhl2/WBI5YqI6q0TnygvIeGz
 kOz2p9Co0ToJ8aD5Uno13R+AjJfunPBuDiBRtgcfUJkdAvK3fd3Maq08T5DsHwwgzwGW
 MtMA==
X-Gm-Message-State: AOJu0YzUhVqUwzRzw05ugK7wIjr+PU2ZNYt0hPuk3tkccBp+10U2itzW
 Usf200e5EPW7qwPW6WodbUkyxJEfhlVk8u3EIYKTDJkcRns2wW4Ohyr9FToEsQ==
X-Gm-Gg: Acq92OFVZTqFK0BX99sK5FzEVZa8ofzXco6IfXSmUnGuK2vLL94gLclYGwmxzCyC/Nz
 UlSwozg8KL6Zn/6h4OUganvzA7djhsaBfOojCG3P3BiJ4qrZ/N+VBTjDFsBABO794cyJ+LWhocS
 7W8JamhrC2zX5Dya4NmE4CJV2OQFK846ThX9+PZsYWJ4EuWMAy44aZxl7wmLBHnpWaD+c43tODT
 GhHXIH95U3MD3pBVz5z/SCvgXr0rzrRM2+NGaat9Nxtz1SbundtHhWCy79h/GAJyIMxBjB6twnX
 pej2bG1OlSsqQCxgExxgj3oDL5VoP2hV/3eF/AI6a5lvHZI2EJTk7rE/ENC+/lKFJ9qHkao+HjO
 QtDQYdKmnrqpnMJgnxjR9zTDTt29/RlXJqflU8Z8TSoAZz4Eg/IFNWWWZ849z4DIJN9e76yGloC
 8WOGwUc1ynJNCF36liQALzs0QNA0r2vJYalBXOJZhZfdf56MlgMR7xnw==
X-Received: by 2002:a7b:c456:0:b0:490:e19b:9632 with SMTP id
 5b1f17b1804b1-4923819e4b6mr8874035e9.17.1781723678925; 
 Wed, 17 Jun 2026 12:14:38 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:38 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/17] drm/amdgpu: Delete pre/post_soft_reset() from
 amd_ip_funcs
Date: Wed, 17 Jun 2026 21:14:17 +0200
Message-ID: <20260617191428.1784083-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

These functions were largely redundant with the respective
suspend() and resume() functions, the main difference being
that they were less used and therefore less likely to be
tested and correct.

Move anything relevant from pre/post_soft_reset()
that is not already done by suspend()/resume()
into the soft_reset() functions.

Note that future uses of soft_reset() will need to call
the suspend() / resume() functions and the necessary clock
and power gating functions.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 11 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 95 +++---------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 40 ----------
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c    | 20 -----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    | 25 -------
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    | 27 -------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 -
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 -
 drivers/gpu/drm/amd/include/amd_shared.h |  2 -
 11 files changed, 15 insertions(+), 213 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0a34c08e251e..e1d478a5e40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5191,14 +5191,12 @@ static int gfx_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
-	return gfx_v11_0_cp_resume(adev);
-}
+	r = gfx_v11_0_cp_resume(adev);
+	if (r)
+		return r;
 
-static int gfx_v11_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
 	/**
-	 * GFX soft reset will impact MES, need resume MES when do GFX soft reset
+	 * GFX soft reset impacts MES, resume MES after GFX soft reset is finished
 	 */
 	return amdgpu_mes_resume(adev, 0);
 }
@@ -7187,7 +7185,6 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.is_idle = gfx_v11_0_is_idle,
 	.wait_for_idle = gfx_v11_0_wait_for_idle,
 	.soft_reset = gfx_v11_0_soft_reset,
-	.post_soft_reset = gfx_v11_0_post_soft_reset,
 	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
 	.set_powergating_state = gfx_v11_0_set_powergating_state,
 	.get_clockgating_state = gfx_v11_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index dd1823bd89ad..7bd668f71b41 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4891,52 +4891,12 @@ static int gfx_v8_0_resume(struct amdgpu_ip_block *ip_block)
 	return gfx_v8_0_hw_init(ip_block);
 }
 
-static int gfx_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 grbm_soft_reset = 0;
-
-	if ((!adev->gfx.grbm_soft_reset) &&
-	    (!adev->gfx.srbm_soft_reset))
-		return 0;
-
-	grbm_soft_reset = adev->gfx.grbm_soft_reset;
-
-	/* stop the rlc */
-	adev->gfx.rlc.funcs->stop(adev);
-
-	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
-	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_GFX))
-		/* Disable GFX parsing/prefetching */
-		gfx_v8_0_cp_gfx_enable(adev, false);
-
-	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
-	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPF) ||
-	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPC) ||
-	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPG)) {
-		int i;
-
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
-
-			mutex_lock(&adev->srbm_mutex);
-			vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-			gfx_v8_0_deactivate_hqd(adev, 2);
-			vi_srbm_select(adev, 0, 0, 0, 0);
-			mutex_unlock(&adev->srbm_mutex);
-		}
-		/* Disable MEC parsing/prefetching */
-		gfx_v8_0_cp_compute_enable(adev, false);
-	}
-
-	return 0;
-}
-
 static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
 	u32 tmp;
+	int i;
 
 	if ((!adev->gfx.grbm_soft_reset) &&
 	    (!adev->gfx.srbm_soft_reset))
@@ -4945,6 +4905,16 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	grbm_soft_reset = adev->gfx.grbm_soft_reset;
 	srbm_soft_reset = adev->gfx.srbm_soft_reset;
 
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
+
+		mutex_lock(&adev->srbm_mutex);
+		vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v8_0_deactivate_hqd(adev, 2);
+		vi_srbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
 	if (grbm_soft_reset || srbm_soft_reset) {
 		tmp = RREG32(mmGMCON_DEBUG);
 		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 1);
@@ -4994,47 +4964,6 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gfx_v8_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 grbm_soft_reset = 0;
-
-	if ((!adev->gfx.grbm_soft_reset) &&
-	    (!adev->gfx.srbm_soft_reset))
-		return 0;
-
-	grbm_soft_reset = adev->gfx.grbm_soft_reset;
-
-	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
-	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPF) ||
-	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPC) ||
-	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPG)) {
-		int i;
-
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
-
-			mutex_lock(&adev->srbm_mutex);
-			vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-			gfx_v8_0_deactivate_hqd(adev, 2);
-			vi_srbm_select(adev, 0, 0, 0, 0);
-			mutex_unlock(&adev->srbm_mutex);
-		}
-		gfx_v8_0_kiq_resume(adev);
-		gfx_v8_0_kcq_resume(adev);
-	}
-
-	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
-	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_GFX))
-		gfx_v8_0_cp_gfx_resume(adev);
-
-	gfx_v8_0_cp_test_all_rings(adev);
-
-	adev->gfx.rlc.funcs->start(adev);
-
-	return 0;
-}
-
 /**
  * gfx_v8_0_get_gpu_clock_counter - return GPU clock counter snapshot
  *
@@ -6800,9 +6729,7 @@ static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.resume = gfx_v8_0_resume,
 	.is_idle = gfx_v8_0_is_idle,
 	.wait_for_idle = gfx_v8_0_wait_for_idle,
-	.pre_soft_reset = gfx_v8_0_pre_soft_reset,
 	.soft_reset = gfx_v8_0_soft_reset,
-	.post_soft_reset = gfx_v8_0_post_soft_reset,
 	.set_clockgating_state = gfx_v8_0_set_clockgating_state,
 	.set_powergating_state = gfx_v8_0_set_powergating_state,
 	.get_clockgating_state = gfx_v8_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index f0707139a745..09c8d95df89f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -871,9 +871,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.resume = jpeg_v5_0_1_resume,
 	.is_idle = jpeg_v5_0_1_is_idle,
 	.wait_for_idle = jpeg_v5_0_1_wait_for_idle,
-	.pre_soft_reset = NULL,
 	.soft_reset = NULL,
-	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v5_0_1_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_0_1_set_powergating_state,
 	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 717eaf43c9a6..ff02f72352a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -690,9 +690,7 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
 	.resume = jpeg_v5_0_2_resume,
 	.is_idle = jpeg_v5_0_2_is_idle,
 	.wait_for_idle = jpeg_v5_0_2_wait_for_idle,
-	.pre_soft_reset = NULL,
 	.soft_reset = NULL,
-	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v5_0_2_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_0_2_set_powergating_state,
 	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index e77261a64cf8..c2d098cd72ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1237,44 +1237,6 @@ static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
-
-	if (!adev->sdma.srbm_soft_reset)
-		return 0;
-
-	srbm_soft_reset = adev->sdma.srbm_soft_reset;
-
-	if (REG_GET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_SDMA) ||
-	    REG_GET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_SDMA1)) {
-		sdma_v3_0_ctx_switch_enable(adev, false);
-		sdma_v3_0_enable(adev, false);
-	}
-
-	return 0;
-}
-
-static int sdma_v3_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
-
-	if (!adev->sdma.srbm_soft_reset)
-		return 0;
-
-	srbm_soft_reset = adev->sdma.srbm_soft_reset;
-
-	if (REG_GET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_SDMA) ||
-	    REG_GET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_SDMA1)) {
-		sdma_v3_0_gfx_resume(adev);
-		sdma_v3_0_rlc_resume(adev);
-	}
-
-	return 0;
-}
-
 static int sdma_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1531,8 +1493,6 @@ static const struct amd_ip_funcs sdma_v3_0_ip_funcs = {
 	.resume = sdma_v3_0_resume,
 	.is_idle = sdma_v3_0_is_idle,
 	.wait_for_idle = sdma_v3_0_wait_for_idle,
-	.pre_soft_reset = sdma_v3_0_pre_soft_reset,
-	.post_soft_reset = sdma_v3_0_post_soft_reset,
 	.soft_reset = sdma_v3_0_soft_reset,
 	.set_clockgating_state = sdma_v3_0_set_clockgating_state,
 	.set_powergating_state = sdma_v3_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 671f5bf18a3a..a3e883f6f099 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -390,24 +390,6 @@ static int tonga_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int tonga_ih_pre_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	if (!ip_block->adev->irq.srbm_soft_reset)
-		return 0;
-
-	return tonga_ih_hw_fini(ip_block);
-}
-
-static int tonga_ih_post_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (!adev->irq.srbm_soft_reset)
-		return 0;
-
-	return tonga_ih_hw_init(ip_block);
-}
-
 static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -462,9 +444,7 @@ static const struct amd_ip_funcs tonga_ih_ip_funcs = {
 	.resume = tonga_ih_resume,
 	.is_idle = tonga_ih_is_idle,
 	.wait_for_idle = tonga_ih_wait_for_idle,
-	.pre_soft_reset = tonga_ih_pre_soft_reset,
 	.soft_reset = tonga_ih_soft_reset,
-	.post_soft_reset = tonga_ih_post_soft_reset,
 	.set_clockgating_state = tonga_ih_set_clockgating_state,
 	.set_powergating_state = tonga_ih_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 7a6b6277cadd..8bb9592b0981 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1166,17 +1166,6 @@ static int uvd_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 #define AMDGPU_UVD_STATUS_BUSY_MASK    0xfd
 
-static int uvd_v6_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (!adev->uvd.inst->srbm_soft_reset)
-		return 0;
-
-	uvd_v6_0_stop(adev);
-	return 0;
-}
-
 static int uvd_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1208,18 +1197,6 @@ static int uvd_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v6_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (!adev->uvd.inst->srbm_soft_reset)
-		return 0;
-
-	mdelay(5);
-
-	return uvd_v6_0_start(adev);
-}
-
 static int uvd_v6_0_set_interrupt_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -1519,9 +1496,7 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
 	.resume = uvd_v6_0_resume,
 	.is_idle = uvd_v6_0_is_idle,
 	.wait_for_idle = uvd_v6_0_wait_for_idle,
-	.pre_soft_reset = uvd_v6_0_pre_soft_reset,
 	.soft_reset = uvd_v6_0_soft_reset,
-	.post_soft_reset = uvd_v6_0_post_soft_reset,
 	.set_clockgating_state = uvd_v6_0_set_clockgating_state,
 	.set_powergating_state = uvd_v6_0_set_powergating_state,
 	.get_clockgating_state = uvd_v6_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index e01c4af46db1..9f4e88440c0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -662,31 +662,6 @@ static int vce_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int vce_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (!adev->vce.srbm_soft_reset)
-		return 0;
-
-	mdelay(5);
-
-	return vce_v3_0_suspend(ip_block);
-}
-
-
-static int vce_v3_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (!adev->vce.srbm_soft_reset)
-		return 0;
-
-	mdelay(5);
-
-	return vce_v3_0_resume(ip_block);
-}
-
 static int vce_v3_0_set_interrupt_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -868,9 +843,7 @@ static const struct amd_ip_funcs vce_v3_0_ip_funcs = {
 	.resume = vce_v3_0_resume,
 	.is_idle = vce_v3_0_is_idle,
 	.wait_for_idle = vce_v3_0_wait_for_idle,
-	.pre_soft_reset = vce_v3_0_pre_soft_reset,
 	.soft_reset = vce_v3_0_soft_reset,
-	.post_soft_reset = vce_v3_0_post_soft_reset,
 	.set_clockgating_state = vce_v3_0_set_clockgating_state,
 	.set_powergating_state = vce_v3_0_set_powergating_state,
 	.get_clockgating_state = vce_v3_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index a0638bdb9255..437b67c573a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1657,9 +1657,7 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.resume = vcn_v5_0_1_resume,
 	.is_idle = vcn_v5_0_1_is_idle,
 	.wait_for_idle = vcn_v5_0_1_wait_for_idle,
-	.pre_soft_reset = NULL,
 	.soft_reset = NULL,
-	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_1_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = amdgpu_vcn_dump_ip_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index 1fb1dea3f129..b9f6ae75ea72 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -1203,9 +1203,7 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_funcs = {
 	.resume = vcn_v5_0_2_resume,
 	.is_idle = vcn_v5_0_2_is_idle,
 	.wait_for_idle = vcn_v5_0_2_wait_for_idle,
-	.pre_soft_reset = NULL,
 	.soft_reset = NULL,
-	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_2_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 2f9e41cf3ac7..e7316e949d11 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -467,9 +467,7 @@ struct amd_ip_funcs {
 	void (*complete)(struct amdgpu_ip_block *ip_block);
 	bool (*is_idle)(struct amdgpu_ip_block *ip_block);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
-	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
-	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
-- 
2.54.0

