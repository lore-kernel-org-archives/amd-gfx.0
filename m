Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCB7C4451C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B062510E962;
	Tue, 21 Jul 2026 11:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AoI+Nbu5";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC3910E962
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:38 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso835555766b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634216; x=1785239016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OUp1ft2tSJQpr/3MuyF+Mpjn5XN2DouqnFgD14kxvZM=;
 b=AoI+Nbu5Ee+Vh5wa4yW+tk0Qv9ap5AgEddNNvuNKqeiZxFFeQkkXO48cbaJzrCpSyo
 PFVtGn+mVKnfFzFfZ79/npRe1lJMF9Z7PNtunas3bbJgN2e0pnoknxpNKxm5TMcNkU4x
 W5+NnSIIpByi4BY6Ft6igisofWQ9AVXJ8YXCSQ9+HKDa6vLizb8Io7o1uu5u+yob9jys
 0uWCloy4is2QEdDVBOd4/B62rztaGLqoRpozbs3nFGfsEvoFx9nfpfVsiDMeei3lyHEC
 R9oM3aBdW7E733RVxWwre7vDPkX6t6r8wUNMW30pwzpZelD5srxO2ZJShQfLR0AN8NDh
 NIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634216; x=1785239016;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OUp1ft2tSJQpr/3MuyF+Mpjn5XN2DouqnFgD14kxvZM=;
 b=hd+G4W+gcOwbzbCKIVNP9yEioSOruNCvjrkiHcWWvaXPJ3q4rSEO0lk7e7hUTTDHe5
 lFIziNHJ4xHx3UGsaY84arN9++eItP3C1veb//W1i2EozO67bF7NK25xwvGmP7UWJ1rV
 Soll+ZOvxWIyyTMP6FQUK5eM02SsHpHGB6zhj7mCQ+ELFGpI2nfsCKhwodydpAADz/UN
 VFEFcrFHUEYhj7ZLnzxPB9bbFXqJaIXpnLNHgnlTwVBc7DJuLDm0TJskZfsC4B3dapS/
 Ej9hRjJiUcF2XKjpHO4TksQAfURIhzfJBlmC+O5qJkhEl1sVKMFYk/MK6jlhwgAYQETx
 kZHw==
X-Gm-Message-State: AOJu0YzNb3UXmR0bllZZdEdaAEaxVlzGzfPPOXZ8N25AJogL/u9X8rKF
 2XDnZSK6mzOpyyC1r+AVff4vJHmcYqg/Uteth5+QUjZjGmW6ED3yf2o3sE5fdkiV
X-Gm-Gg: AR+sD13btimk5vXVHF5wPI0AGMV1C+cOEMSwzvudtllPAurWX50UiGfqbR0ocJdkPOT
 tcUfK4qv+tpu0YvXBX2yz0Cet5OnRtRgnezMVseAzPqQmULnZZ0zvnu6/MNLmnIX8IT5Elxez/J
 OrRDpt+DMUoPmqsUC9M6ROKkZghJUq3C3IXl51L/7wBRveyd0KCmgaBSVSk6MELaDc2/Kp3/ZIH
 qE2IcOvuCzuxehlMDBtrMjRrCcD35L3UVpctc/b0rzh7wxNvkRhR8DJEvb3kdEie3t1ZTi3uBIg
 UMkiRbSsRC4ewB9b87KyWKYvfspNOdW0/DQ546/87q6KWe8dcNiuTZun5M6W+KBC+pxEQzAd5A0
 qoYeTUHSRHUU1gSKAqqVuRB6bVHY+28H2NifjPV1T8qzwWw9xj5P3en1JnIrJbvOrEFOXOJSGeF
 f6wavv7kn8dtrWlL/qF9a0Fmv6G2RuBXROnj8hxzBJGL0=
X-Received: by 2002:a17:907:74b:b0:c16:852b:ecee with SMTP id
 a640c23a62f3a-c16b47c5012mr750034866b.36.1784634216283; 
 Tue, 21 Jul 2026 04:43:36 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 8/9] drm/amdgpu/gfx7: Fixup IP block soft reset
Date: Tue, 21 Jul 2026 13:43:21 +0200
Message-ID: <20260721114322.17535-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721114322.17535-1-timur.kristof@gmail.com>
References: <20260721114322.17535-1-timur.kristof@gmail.com>
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

Use basically the same implementation as GFX8,
except for the GFX7 specific MQD functions.

Reset every block using the GRBM, then proceed
to reset the GRBM and SEM blocks using the SRBM.

Remove the redundant gfx_v7_0_update_cg() function.
The soft reset now calls the clock and powergating
functions of the IP block instead.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 148 +++++++++++++-------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index dbd4667100b6..e31a2101f308 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3616,21 +3616,6 @@ static void gfx_v7_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
 	}
 }
 
-static void gfx_v7_0_update_cg(struct amdgpu_device *adev,
-			       bool enable)
-{
-	gfx_v7_0_enable_gui_idle_interrupt(adev, false);
-	/* order matters! */
-	if (enable) {
-		gfx_v7_0_enable_mgcg(adev, true);
-		gfx_v7_0_enable_cgcg(adev, true);
-	} else {
-		gfx_v7_0_enable_cgcg(adev, false);
-		gfx_v7_0_enable_mgcg(adev, false);
-	}
-	gfx_v7_0_enable_gui_idle_interrupt(adev, true);
-}
-
 static void gfx_v7_0_enable_sclk_slowdown_on_pu(struct amdgpu_device *adev,
 						bool enable)
 {
@@ -4549,80 +4534,99 @@ static int gfx_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 static int gfx_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
 	u32 tmp;
-	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+	int r;
 
-	/* GRBM_STATUS */
-	tmp = RREG32(mmGRBM_STATUS);
-	if (tmp & (GRBM_STATUS__PA_BUSY_MASK | GRBM_STATUS__SC_BUSY_MASK |
-		   GRBM_STATUS__BCI_BUSY_MASK | GRBM_STATUS__SX_BUSY_MASK |
-		   GRBM_STATUS__TA_BUSY_MASK | GRBM_STATUS__VGT_BUSY_MASK |
-		   GRBM_STATUS__DB_BUSY_MASK | GRBM_STATUS__CB_BUSY_MASK |
-		   GRBM_STATUS__GDS_BUSY_MASK | GRBM_STATUS__SPI_BUSY_MASK |
-		   GRBM_STATUS__IA_BUSY_MASK | GRBM_STATUS__IA_BUSY_NO_DMA_MASK))
-		grbm_soft_reset |= GRBM_SOFT_RESET__SOFT_RESET_CP_MASK |
-			GRBM_SOFT_RESET__SOFT_RESET_GFX_MASK;
-
-	if (tmp & (GRBM_STATUS__CP_BUSY_MASK | GRBM_STATUS__CP_COHERENCY_BUSY_MASK)) {
-		grbm_soft_reset |= GRBM_SOFT_RESET__SOFT_RESET_CP_MASK;
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_GRBM_MASK;
-	}
+	grbm_soft_reset =
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_GFX, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CP, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
+
+	srbm_soft_reset =
+		REG_SET_FIELD(0, SRBM_SOFT_RESET, SOFT_RESET_GRBM, 1) |
+		REG_SET_FIELD(0, SRBM_SOFT_RESET, SOFT_RESET_SEM, 1);
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
+
+		mutex_lock(&adev->srbm_mutex);
+		cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v7_0_deactivate_hqd(adev, 2);
+		cik_srbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
 
-	/* GRBM_STATUS2 */
-	tmp = RREG32(mmGRBM_STATUS2);
-	if (tmp & GRBM_STATUS2__RLC_BUSY_MASK)
-		grbm_soft_reset |= GRBM_SOFT_RESET__SOFT_RESET_RLC_MASK;
+		udelay(50);
+	}
 
-	/* SRBM_STATUS */
-	tmp = RREG32(mmSRBM_STATUS);
-	if (tmp & SRBM_STATUS__GRBM_RQ_PENDING_MASK)
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_GRBM_MASK;
+	ip_block->version->funcs->set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
+	ip_block->version->funcs->set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
+	ip_block->version->funcs->suspend(ip_block);
 
 	if (grbm_soft_reset || srbm_soft_reset) {
-		/* disable CG/PG */
-		gfx_v7_0_fini_pg(adev);
-		gfx_v7_0_update_cg(adev, false);
+		tmp = RREG32(mmGMCON_DEBUG);
+		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 1);
+		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_CLEAR, 1);
+		WREG32(mmGMCON_DEBUG, tmp);
 
-		/* stop the rlc */
-		adev->gfx.rlc.funcs->stop(adev);
+		udelay(100);
+	}
 
-		/* Disable GFX parsing/prefetching */
-		WREG32(mmCP_ME_CNTL, CP_ME_CNTL__ME_HALT_MASK | CP_ME_CNTL__PFP_HALT_MASK | CP_ME_CNTL__CE_HALT_MASK);
+	if (grbm_soft_reset) {
+		tmp = RREG32(mmGRBM_SOFT_RESET);
+		tmp |= grbm_soft_reset;
+		dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32(mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmGRBM_SOFT_RESET);
 
-		/* Disable MEC parsing/prefetching */
-		WREG32(mmCP_MEC_CNTL, CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK);
+		udelay(100);
 
-		if (grbm_soft_reset) {
-			tmp = RREG32(mmGRBM_SOFT_RESET);
-			tmp |= grbm_soft_reset;
-			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
-			WREG32(mmGRBM_SOFT_RESET, tmp);
-			tmp = RREG32(mmGRBM_SOFT_RESET);
+		tmp &= ~grbm_soft_reset;
+		WREG32(mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmGRBM_SOFT_RESET);
 
-			udelay(50);
+		udelay(100);
+	}
 
-			tmp &= ~grbm_soft_reset;
-			WREG32(mmGRBM_SOFT_RESET, tmp);
-			tmp = RREG32(mmGRBM_SOFT_RESET);
-		}
+	if (srbm_soft_reset) {
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+		tmp |= srbm_soft_reset;
+		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
 
-		if (srbm_soft_reset) {
-			tmp = RREG32(mmSRBM_SOFT_RESET);
-			tmp |= srbm_soft_reset;
-			dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-			WREG32(mmSRBM_SOFT_RESET, tmp);
-			tmp = RREG32(mmSRBM_SOFT_RESET);
+		udelay(100);
 
-			udelay(50);
+		tmp &= ~srbm_soft_reset;
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
 
-			tmp &= ~srbm_soft_reset;
-			WREG32(mmSRBM_SOFT_RESET, tmp);
-			tmp = RREG32(mmSRBM_SOFT_RESET);
-		}
-		/* Wait a little for things to settle down */
-		udelay(50);
+		udelay(100);
 	}
+
+	if (grbm_soft_reset || srbm_soft_reset) {
+		tmp = RREG32(mmGMCON_DEBUG);
+		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 0);
+		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_CLEAR, 0);
+		WREG32(mmGMCON_DEBUG, tmp);
+	}
+
+	/* Wait a little for things to settle down */
+	udelay(100);
+
+	r = ip_block->version->funcs->resume(ip_block);
+	r |= ip_block->version->funcs->late_init(ip_block);
+	if (r)
+		return r;
+
+	ip_block->version->funcs->set_clockgating_state(ip_block, AMD_CG_STATE_GATE);
+	ip_block->version->funcs->set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+
 	return 0;
 }
 
-- 
2.55.0

