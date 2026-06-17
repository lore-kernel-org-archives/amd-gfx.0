Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1479CD98F2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136E310F0D2;
	Wed, 17 Jun 2026 19:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qj3ZPxvt";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B819210F0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:39 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso612885e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723678; x=1782328478; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVEODAM8tfOdh4PB/Ai6xz5wD7cwBRarRLOmEu8JxiQ=;
 b=qj3ZPxvtYdgEIcCn0uvDlr5gFlZIB/VSXjYvhcIH23mLAaqPB14mEuMaV+bqo17pWf
 jbwrQQBDe/58KswuQhREnlVuTZSQQeACrIMnC/2vgk4cBJ5sBFxXCszqq/wRgdN7Y3yl
 M42fA2tFmR6/NBu/0gbaPjsF67QzGDuRwzOt10QsGZIDFrkmvqBsC/V5XbvML4ukTsu0
 93xpJyOlo2hAKqX8aTHEeGhX82tQ1DOhWOtj+nMtivFLYBWCWWdPEkVmRVknvfocN/I3
 rL9dZAoaOToyivCU+9+KuBDIrAlnM0xRpuMS+8QRpFmxvPSTo11X4cUoodHsAmzhLXqk
 U3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723678; x=1782328478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NVEODAM8tfOdh4PB/Ai6xz5wD7cwBRarRLOmEu8JxiQ=;
 b=EkkC7iKkZuwRQrERuFyovu9fpzKPhLVJ/+Y+/VZxeA6q23b3CCjj1HoudDyTrscRfY
 1q9KODgGek5KagVg6YMEDfbb6A0CepPYIE2ellDyfq5edcfczDbd45r1GZkzp7LkohHw
 SMBHe4pWmKHvlrg0YOj0wIpgf0GIhi6CCAs4pw41TdkhX8+nmEqIvY4OSX07vhHLxaHI
 1L4jkpfRcuIzJasqaenyf6e0bLAT/ji9HLacAUoPesFEmOlzovkwMWOlFwjb1yQqA8gv
 5oiZKfXeXTL8u04q1g9Ga96earYu3Jzmss+xEMb4sAaqjVvFJheNBuT5hcQtCbCtXAub
 rdag==
X-Gm-Message-State: AOJu0YxH8pKVfIbPgvyz1uNfL4oLb8UaNENvkfYPwjdfEJdutUGbSnP8
 kAyVCEQ0/qr1IP8186GUqRGJz3PJnuqj1eqobbovrdseRpMI6JS97iv2BWXoGg==
X-Gm-Gg: Acq92OGgPSj2wM7tLRPLR8j1L+uVwhaSXcUa4C4Tck6mG4HXeoqUfKaUpdpQKlc3Yqt
 J1jGK2TZ3Uc3MNacirGuoaCy55qMZlelAgmEUwntBsInIwXcZzXLVqXleZMBaiwVXjt/cJ9woow
 P8dBce0/iFrUwILliq+xmAw9GimRlFX3/WMyUDzS8g61xPh439RxVBzbRQ4RUNVBzTRfi+QEMiV
 H3QO8Qk6EtOiyUM1A8PC2HTsHyXnQ01wZqZSq5acoUdKVEOf8j9Lxv1FBovsZYGVgnFCngAJS98
 97JUZMJ6JJN9eVCAZaAdM82gnts8/mtXBhLhl38j5Zg4CIlsHSzgBJzl8PC/oOAxjmB+k/0hX/c
 3GYWXPFK4dhLqvbOzpRK5C+EUf5KFxchv1tMhzVRPJQGFBGEbEOYv1l6/xoBPWb+W/Do+TZP+R8
 uQ0Wsf/tcvddII2tSPlUWMnQSDB6hGrW2y4r8JOvX/nviRqNilDie6sw==
X-Received: by 2002:a05:600c:4ec6:b0:490:3fdd:d353 with SMTP id
 5b1f17b1804b1-492381e86c9mr11415545e9.8.1781723677867; 
 Wed, 17 Jun 2026 12:14:37 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:37 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/17] drm/amdgpu: Delete check_soft_reset() from amd_ip_funcs
Date: Wed, 17 Jun 2026 21:14:16 +0200
Message-ID: <20260617191428.1784083-6-timur.kristof@gmail.com>
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

This function is not called from anywhere anymore and
every implementation was bogus.

Some implementations checked busy flags of the IP blocks,
which are not really indicative of whether the block is
hung and needs to be reset. For example the blocks
could be busy just normally executing submissions,
and not need to be reset.

Other implementations checked IB tests, which is actually
more useful, but could still just indicate that an IP block
is executing submissions normally.

It is also unnecessary because the GPU recovery code path
already knows which ring is hung so we know exactly what
we need to reset.

Just delete check_soft_reset() entirely.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 25 --------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 63 -------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      |  1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 22 -------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 18 ------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 18 ------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        | 18 ------
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         | 20 ------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         | 20 ------
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         | 42 -------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |  1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c       |  1 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 --
 drivers/gpu/drm/amd/include/amd_shared.h      |  1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 16 files changed, 258 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0abb7..0a34c08e251e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5194,30 +5194,6 @@ static int gfx_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return gfx_v11_0_cp_resume(adev);
 }
 
-static bool gfx_v11_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	int i, r;
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_ring *ring;
-	long tmo = msecs_to_jiffies(1000);
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		r = amdgpu_ring_test_ib(ring, tmo);
-		if (r)
-			return true;
-	}
-
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
-		r = amdgpu_ring_test_ib(ring, tmo);
-		if (r)
-			return true;
-	}
-
-	return false;
-}
-
 static int gfx_v11_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -7211,7 +7187,6 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.is_idle = gfx_v11_0_is_idle,
 	.wait_for_idle = gfx_v11_0_wait_for_idle,
 	.soft_reset = gfx_v11_0_soft_reset,
-	.check_soft_reset = gfx_v11_0_check_soft_reset,
 	.post_soft_reset = gfx_v11_0_post_soft_reset,
 	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
 	.set_powergating_state = gfx_v11_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 130196859ff3..dd1823bd89ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4891,68 +4891,6 @@ static int gfx_v8_0_resume(struct amdgpu_ip_block *ip_block)
 	return gfx_v8_0_hw_init(ip_block);
 }
 
-static bool gfx_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
-	u32 tmp;
-
-	/* GRBM_STATUS */
-	tmp = RREG32(mmGRBM_STATUS);
-	if (tmp & (GRBM_STATUS__PA_BUSY_MASK | GRBM_STATUS__SC_BUSY_MASK |
-		   GRBM_STATUS__BCI_BUSY_MASK | GRBM_STATUS__SX_BUSY_MASK |
-		   GRBM_STATUS__TA_BUSY_MASK | GRBM_STATUS__VGT_BUSY_MASK |
-		   GRBM_STATUS__DB_BUSY_MASK | GRBM_STATUS__CB_BUSY_MASK |
-		   GRBM_STATUS__GDS_BUSY_MASK | GRBM_STATUS__SPI_BUSY_MASK |
-		   GRBM_STATUS__IA_BUSY_MASK | GRBM_STATUS__IA_BUSY_NO_DMA_MASK |
-		   GRBM_STATUS__CP_BUSY_MASK | GRBM_STATUS__CP_COHERENCY_BUSY_MASK)) {
-		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
-						GRBM_SOFT_RESET, SOFT_RESET_CP, 1);
-		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
-						GRBM_SOFT_RESET, SOFT_RESET_GFX, 1);
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
-						SRBM_SOFT_RESET, SOFT_RESET_GRBM, 1);
-	}
-
-	/* GRBM_STATUS2 */
-	tmp = RREG32(mmGRBM_STATUS2);
-	if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY))
-		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
-						GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
-
-	if (REG_GET_FIELD(tmp, GRBM_STATUS2, CPF_BUSY) ||
-	    REG_GET_FIELD(tmp, GRBM_STATUS2, CPC_BUSY) ||
-	    REG_GET_FIELD(tmp, GRBM_STATUS2, CPG_BUSY)) {
-		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET,
-						SOFT_RESET_CPF, 1);
-		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET,
-						SOFT_RESET_CPC, 1);
-		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET,
-						SOFT_RESET_CPG, 1);
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET,
-						SOFT_RESET_GRBM, 1);
-	}
-
-	/* SRBM_STATUS */
-	tmp = RREG32(mmSRBM_STATUS);
-	if (REG_GET_FIELD(tmp, SRBM_STATUS, GRBM_RQ_PENDING))
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
-						SRBM_SOFT_RESET, SOFT_RESET_GRBM, 1);
-	if (REG_GET_FIELD(tmp, SRBM_STATUS, SEM_BUSY))
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
-						SRBM_SOFT_RESET, SOFT_RESET_SEM, 1);
-
-	if (grbm_soft_reset || srbm_soft_reset) {
-		adev->gfx.grbm_soft_reset = grbm_soft_reset;
-		adev->gfx.srbm_soft_reset = srbm_soft_reset;
-		return true;
-	} else {
-		adev->gfx.grbm_soft_reset = 0;
-		adev->gfx.srbm_soft_reset = 0;
-		return false;
-	}
-}
-
 static int gfx_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -6862,7 +6800,6 @@ static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.resume = gfx_v8_0_resume,
 	.is_idle = gfx_v8_0_is_idle,
 	.wait_for_idle = gfx_v8_0_wait_for_idle,
-	.check_soft_reset = gfx_v8_0_check_soft_reset,
 	.pre_soft_reset = gfx_v8_0_pre_soft_reset,
 	.soft_reset = gfx_v8_0_soft_reset,
 	.post_soft_reset = gfx_v8_0_post_soft_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 250316704dfa..f0707139a745 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -871,7 +871,6 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.resume = jpeg_v5_0_1_resume,
 	.is_idle = jpeg_v5_0_1_is_idle,
 	.wait_for_idle = jpeg_v5_0_1_wait_for_idle,
-	.check_soft_reset = NULL,
 	.pre_soft_reset = NULL,
 	.soft_reset = NULL,
 	.post_soft_reset = NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 7a4ecea6b39a..717eaf43c9a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -690,7 +690,6 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
 	.resume = jpeg_v5_0_2_resume,
 	.is_idle = jpeg_v5_0_2_is_idle,
 	.wait_for_idle = jpeg_v5_0_2_wait_for_idle,
-	.check_soft_reset = NULL,
 	.pre_soft_reset = NULL,
 	.soft_reset = NULL,
 	.post_soft_reset = NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 3fde9be74690..e77261a64cf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1237,27 +1237,6 @@ static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static bool sdma_v3_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
-	u32 tmp = RREG32(mmSRBM_STATUS2);
-
-	if ((tmp & SRBM_STATUS2__SDMA_BUSY_MASK) ||
-	    (tmp & SRBM_STATUS2__SDMA1_BUSY_MASK)) {
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA_MASK;
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA1_MASK;
-	}
-
-	if (srbm_soft_reset) {
-		adev->sdma.srbm_soft_reset = srbm_soft_reset;
-		return true;
-	} else {
-		adev->sdma.srbm_soft_reset = 0;
-		return false;
-	}
-}
-
 static int sdma_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1552,7 +1531,6 @@ static const struct amd_ip_funcs sdma_v3_0_ip_funcs = {
 	.resume = sdma_v3_0_resume,
 	.is_idle = sdma_v3_0_is_idle,
 	.wait_for_idle = sdma_v3_0_wait_for_idle,
-	.check_soft_reset = sdma_v3_0_check_soft_reset,
 	.pre_soft_reset = sdma_v3_0_pre_soft_reset,
 	.post_soft_reset = sdma_v3_0_post_soft_reset,
 	.soft_reset = sdma_v3_0_soft_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index bf09ac841a68..2a8f9fad1e34 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -792,23 +792,6 @@ static int sdma_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return sdma_v6_0_start(adev);
 }
 
-static bool sdma_v6_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_ring *ring;
-	int i, r;
-	long tmo = msecs_to_jiffies(1000);
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-		r = amdgpu_ring_test_ib(ring, tmo);
-		if (r)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * sdma_v6_0_start - setup and start the async dma engines
  *
@@ -1746,7 +1729,6 @@ const struct amd_ip_funcs sdma_v6_0_ip_funcs = {
 	.is_idle = sdma_v6_0_is_idle,
 	.wait_for_idle = sdma_v6_0_wait_for_idle,
 	.soft_reset = sdma_v6_0_soft_reset,
-	.check_soft_reset = sdma_v6_0_check_soft_reset,
 	.set_clockgating_state = sdma_v6_0_set_clockgating_state,
 	.set_powergating_state = sdma_v6_0_set_powergating_state,
 	.get_clockgating_state = sdma_v6_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index f154b68dda70..9f232805cd76 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -784,23 +784,6 @@ static int sdma_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return sdma_v7_0_start(adev);
 }
 
-static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_ring *ring;
-	int i, r;
-	long tmo = msecs_to_jiffies(1000);
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-		r = amdgpu_ring_test_ib(ring, tmo);
-		if (r)
-			return true;
-	}
-
-	return false;
-}
-
 static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1679,7 +1662,6 @@ const struct amd_ip_funcs sdma_v7_0_ip_funcs = {
 	.is_idle = sdma_v7_0_is_idle,
 	.wait_for_idle = sdma_v7_0_wait_for_idle,
 	.soft_reset = sdma_v7_0_soft_reset,
-	.check_soft_reset = sdma_v7_0_check_soft_reset,
 	.set_clockgating_state = sdma_v7_0_set_clockgating_state,
 	.set_powergating_state = sdma_v7_0_set_powergating_state,
 	.get_clockgating_state = sdma_v7_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e1c0a4ff0e7f..d0ab1430aade 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -775,23 +775,6 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
 	return sdma_v7_1_inst_start(adev, inst_mask);
 }
 
-static bool sdma_v7_1_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_ring *ring;
-	int i, r;
-	long tmo = msecs_to_jiffies(1000);
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-		r = amdgpu_ring_test_ib(ring, tmo);
-		if (r)
-			return true;
-	}
-
-	return false;
-}
-
 static int sdma_v7_1_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1643,7 +1626,6 @@ const struct amd_ip_funcs sdma_v7_1_ip_funcs = {
 	.is_idle = sdma_v7_1_is_idle,
 	.wait_for_idle = sdma_v7_1_wait_for_idle,
 	.soft_reset = sdma_v7_1_soft_reset,
-	.check_soft_reset = sdma_v7_1_check_soft_reset,
 	.set_clockgating_state = sdma_v7_1_set_clockgating_state,
 	.set_powergating_state = sdma_v7_1_set_powergating_state,
 	.get_clockgating_state = sdma_v7_1_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index ee8038df17e3..671f5bf18a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -390,25 +390,6 @@ static int tonga_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static bool tonga_ih_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET,
-						SOFT_RESET_IH, 1);
-
-	if (srbm_soft_reset) {
-		adev->irq.srbm_soft_reset = srbm_soft_reset;
-		return true;
-	} else {
-		adev->irq.srbm_soft_reset = 0;
-		return false;
-	}
-}
-
 static int tonga_ih_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	if (!ip_block->adev->irq.srbm_soft_reset)
@@ -481,7 +462,6 @@ static const struct amd_ip_funcs tonga_ih_ip_funcs = {
 	.resume = tonga_ih_resume,
 	.is_idle = tonga_ih_is_idle,
 	.wait_for_idle = tonga_ih_wait_for_idle,
-	.check_soft_reset = tonga_ih_check_soft_reset,
 	.pre_soft_reset = tonga_ih_pre_soft_reset,
 	.soft_reset = tonga_ih_soft_reset,
 	.post_soft_reset = tonga_ih_post_soft_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index ecd7ead7a60b..7a6b6277cadd 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1165,25 +1165,6 @@ static int uvd_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 }
 
 #define AMDGPU_UVD_STATUS_BUSY_MASK    0xfd
-static bool uvd_v6_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (REG_GET_FIELD(tmp, SRBM_STATUS, UVD_RQ_PENDING) ||
-	    REG_GET_FIELD(tmp, SRBM_STATUS, UVD_BUSY) ||
-	    (RREG32(mmUVD_STATUS) & AMDGPU_UVD_STATUS_BUSY_MASK))
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_UVD, 1);
-
-	if (srbm_soft_reset) {
-		adev->uvd.inst->srbm_soft_reset = srbm_soft_reset;
-		return true;
-	} else {
-		adev->uvd.inst->srbm_soft_reset = 0;
-		return false;
-	}
-}
 
 static int uvd_v6_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
@@ -1538,7 +1519,6 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
 	.resume = uvd_v6_0_resume,
 	.is_idle = uvd_v6_0_is_idle,
 	.wait_for_idle = uvd_v6_0_wait_for_idle,
-	.check_soft_reset = uvd_v6_0_check_soft_reset,
 	.pre_soft_reset = uvd_v6_0_pre_soft_reset,
 	.soft_reset = uvd_v6_0_soft_reset,
 	.post_soft_reset = uvd_v6_0_post_soft_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index c69f7d82060f..e01c4af46db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -631,47 +631,6 @@ static int vce_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 #define  AMDGPU_VCE_STATUS_BUSY_MASK (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK | \
 				      VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK)
 
-static bool vce_v3_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
-
-	/* According to VCE team , we should use VCE_STATUS instead
-	 * SRBM_STATUS.VCE_BUSY bit for busy status checking.
-	 * GRBM_GFX_INDEX.INSTANCE_INDEX is used to specify which VCE
-	 * instance's registers are accessed
-	 * (0 for 1st instance, 10 for 2nd instance).
-	 *
-	 *VCE_STATUS
-	 *|UENC|ACPI|AUTO ACTIVE|RB1 |RB0 |RB2 |          |FW_LOADED|JOB |
-	 *|----+----+-----------+----+----+----+----------+---------+----|
-	 *|bit8|bit7|    bit6   |bit5|bit4|bit3|   bit2   |  bit1   |bit0|
-	 *
-	 * VCE team suggest use bit 3--bit 6 for busy status check
-	 */
-	mutex_lock(&adev->grbm_idx_mutex);
-	WREG32(mmGRBM_GFX_INDEX, GET_VCE_INSTANCE(0));
-	if (RREG32(mmVCE_STATUS) & AMDGPU_VCE_STATUS_BUSY_MASK) {
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);
-	}
-	WREG32(mmGRBM_GFX_INDEX, GET_VCE_INSTANCE(1));
-	if (RREG32(mmVCE_STATUS) & AMDGPU_VCE_STATUS_BUSY_MASK) {
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);
-	}
-	WREG32(mmGRBM_GFX_INDEX, GET_VCE_INSTANCE(0));
-	mutex_unlock(&adev->grbm_idx_mutex);
-
-	if (srbm_soft_reset) {
-		adev->vce.srbm_soft_reset = srbm_soft_reset;
-		return true;
-	} else {
-		adev->vce.srbm_soft_reset = 0;
-		return false;
-	}
-}
-
 static int vce_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -909,7 +868,6 @@ static const struct amd_ip_funcs vce_v3_0_ip_funcs = {
 	.resume = vce_v3_0_resume,
 	.is_idle = vce_v3_0_is_idle,
 	.wait_for_idle = vce_v3_0_wait_for_idle,
-	.check_soft_reset = vce_v3_0_check_soft_reset,
 	.pre_soft_reset = vce_v3_0_pre_soft_reset,
 	.soft_reset = vce_v3_0_soft_reset,
 	.post_soft_reset = vce_v3_0_post_soft_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index d3db0494341e..a0638bdb9255 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1657,7 +1657,6 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.resume = vcn_v5_0_1_resume,
 	.is_idle = vcn_v5_0_1_is_idle,
 	.wait_for_idle = vcn_v5_0_1_wait_for_idle,
-	.check_soft_reset = NULL,
 	.pre_soft_reset = NULL,
 	.soft_reset = NULL,
 	.post_soft_reset = NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index bbc172db91a1..1fb1dea3f129 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -1203,7 +1203,6 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_funcs = {
 	.resume = vcn_v5_0_2_resume,
 	.is_idle = vcn_v5_0_2_is_idle,
 	.wait_for_idle = vcn_v5_0_2_wait_for_idle,
-	.check_soft_reset = NULL,
 	.pre_soft_reset = NULL,
 	.soft_reset = NULL,
 	.post_soft_reset = NULL,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index af0af7519517..1714d9a3f677 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -329,11 +329,6 @@ static int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static bool dm_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return false;
-}
-
 static int dm_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
@@ -3898,7 +3893,6 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.resume = dm_resume,
 	.is_idle = dm_is_idle,
 	.wait_for_idle = dm_wait_for_idle,
-	.check_soft_reset = dm_check_soft_reset,
 	.soft_reset = dm_soft_reset,
 	.set_clockgating_state = dm_set_clockgating_state,
 	.set_powergating_state = dm_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index ac2d3701e2bd..2f9e41cf3ac7 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -467,7 +467,6 @@ struct amd_ip_funcs {
 	void (*complete)(struct amdgpu_ip_block *ip_block);
 	bool (*is_idle)(struct amdgpu_ip_block *ip_block);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
-	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 337f9acacef0..115024b6617c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2771,7 +2771,6 @@ const struct amd_ip_funcs smu_ip_funcs = {
 	.suspend = smu_suspend,
 	.resume = smu_resume,
 	.is_idle = NULL,
-	.check_soft_reset = NULL,
 	.wait_for_idle = NULL,
 	.soft_reset = NULL,
 	.set_clockgating_state = smu_set_clockgating_state,
-- 
2.54.0

