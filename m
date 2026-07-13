Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856EAC44508
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2EC10E970;
	Mon, 13 Jul 2026 12:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I4bOhb1h";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB6810E970
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:57 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso2049184f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947536; x=1784552336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WsdCGB9uCzuKYwcraoVHVMiQRUe60rRhYTedJJKR2lg=;
 b=I4bOhb1hfhh9w9RL2jOgAhhD0tkIou/iWHq2g8ituBH3+EyNkBsPJ/C/Y7hsqTAkDi
 0OiGCXAa5XE4dNtLU2fjikLHr2nNQiKu0sA/sD+hM2YC7664rAeDWTpNAaO0QkNtSv8r
 agaV+j+HCT/B9PhfW4JTNHh7b6VmGnHm4LEANbjjeIDsExEvw0YrPoVARw/dFpf4NspX
 JdlyTgBSUvKOFmKodZFYmlWW/akBzsN63MQRTeXz6zVZsWFY0090XRYmGOkaa0rcUSob
 km6cQTaDiHwEfQgvTL4QILgEtqZVIlln91C4ekMF6Nk8KQhC0T5u4T+OQcl8YYq5PYtB
 N74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947536; x=1784552336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WsdCGB9uCzuKYwcraoVHVMiQRUe60rRhYTedJJKR2lg=;
 b=XUZD1hs9VA05wkE44jw2ZehoLyTY97/6xaI252jKgOmkOA75naussGbU2NWKXkQyWJ
 AZTpGcJVgP6XCnT5avCmV+pvZ+m6Mi28llb80JpV+UF/vc1QesUBiKcOr8Rzof1r+W+R
 NpKL5dXNfTTd9mHolTJnwCxlqYrTn1XNaYs9Y3HJhpDgo0GixdYjJwSZlD1q55ILrTSv
 18TlQv2F1CxoLO3wfqjcFzn0gnHQf2HAxVe6mLBcteMOf+d+st1VYI1ep4+mJs6cOE5C
 4YyyZxAqYJX2T/pQEH5wQoA67NSjp5n93wqooxpWLlB38aBORwd2WtZLOJ86oDm+AIMK
 r+IA==
X-Gm-Message-State: AOJu0YxLAPWjB8ScvBq0glMA8eOY3I7OPebC89OY3oG8ksvms8qHRgaM
 fLGg01GX6VFduRwrcLSu0PU2njkDzk4+2LxWiROw0X98S/V1heZrv1Y0m8k7Cg==
X-Gm-Gg: AfdE7cluEUgBzOKhcxNy0JL2WYan4H0ES6ciOWjD7VJQhfFsiCQMS2HefBczpbvzQlL
 U+6kvPE5cDd3K80bB9sep+E10A2QdeR83hqhw/faoxMl3QsByktD7BwDpXs+lCS2fvs6TyUDEiG
 I8ERCgt5r85dzuHJExJV4j6PMkLwOqEfYxL7/avTjuDT3CcoJR0/bYVx0OM/POianE+ZK8HKCnq
 Q4mhAflcIWr/JmiHuJX/sAQXoDz/lCd1Shhv8hyU0cCn1xJSZU9+yHAKpcDobhxx1j88p34iiL7
 mXVQPFCSrI4KBVfDHot83ja5kIPPiq9S86jQrIOYFiMmOr8EoUT7A5ZIo6mWlbHVM21lK2TQLGn
 UYgfPz0MPL7GzXxRBoH9m/c4WX7VOHVTme+DxjX8DENtwBsRgh0AReyyRz1kurq8sCPqan0RlHj
 HYUwk7TFTnoh3uvtIWe2inijdXYa6WadTcP4hOAoSkCdRXf02BmGryXA==
X-Received: by 2002:a05:6000:2912:b0:454:a41f:d082 with SMTP id
 ffacd0b85a97d-47f2dcb3f2fmr9669026f8f.3.1783947536267; 
 Mon, 13 Jul 2026 05:58:56 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:55 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 8/9] drm/amdgpu/gfx7: Fixup IP block soft reset
Date: Mon, 13 Jul 2026 14:58:37 +0200
Message-ID: <20260713125838.30607-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713125838.30607-1-timur.kristof@gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
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
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 148 +++++++++++++-------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 6d52b8710437..825e3d7d5f0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3618,21 +3618,6 @@ static void gfx_v7_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
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
@@ -4551,80 +4536,99 @@ static int gfx_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
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
+		gfx_v7_0_mqd_deactivate(adev, 2);
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

