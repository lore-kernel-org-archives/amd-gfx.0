Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D73CD98F3
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3E710F0DE;
	Wed, 17 Jun 2026 19:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mfqr2vjl";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3D010F0DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:54 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so324725e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723693; x=1782328493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRqIzuw05UinLBAdNpRBnUT1a8q0TkekQSdKnNQ5ucY=;
 b=mfqr2vjlTk5g5hgHFmnCf2VcE39B7fuqUoxlh6uwQxMTRm/CJ9lRjniGvUXg4Ia/8/
 aJWN8YyT78NTrXdItWG1RmTDkqIETiIeGRlcs9XRFxP/0ynOk1n1IWhJBwPfSPsEglQj
 8o3rQTavw8AIaCmgdXAXE8gNqvn5jWfj7thI+74XbpP+kg45jPpRwlPm4bBn6OQ29ZhE
 c7wAADPfOt6Q3YqyqclpDSpgcnHBY4iHWbThNz+P++1Tyf5U8Keuq2tNT4rlkRDZ7Ye/
 1g1yCYsZXsFeSlzZjA/OuWPWKn3ImSk7gTcrV9/l2WagM1gQCIyuFnn6ey0qhBeel52t
 R1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723693; x=1782328493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vRqIzuw05UinLBAdNpRBnUT1a8q0TkekQSdKnNQ5ucY=;
 b=Fmd3QJm9SLiUTsDKNvACSGIDCJ44nZFc+CZMclqUuJp2Pa+98f6KtIVZG/0ETGnUMC
 7SqWActkyR28zM6d7hMf2MuLNzhChcR1r8ToIWSxEpAHr05A9aehAv7xpL9c7l6pRWCx
 4McpsZzJb3xQcQRf+vqhrFqzhx2SJoe0E3mVOToMWr2yKiy+SwIVUFTEblm6Gh+qMd/b
 D/miKuLZWgkwHIW2vQn4kYjvGFLXnavqjLpgWLNS0FF+b37j8HbPMXIS/MMShwCwp3cK
 43V0yn7hp0Bpyzd4dPibxg5fE/OOqEjFHxICoMcyuDycwTtQGQ2PDHhsMs5mOWMXAsOo
 Tb8Q==
X-Gm-Message-State: AOJu0YyrUBDdNg2D2jqUOlRi2N8DiGpfVi75AKFAPhapG/6VteHB3u2x
 ZuFZO/syHB1vvqsth47fPc49AwVZsaOuDe4Nz3FGdnDSsOej5Ub1WnHguVEmNw==
X-Gm-Gg: Acq92OGMAs0zyIc/wXYxgIF0n55/wIHDR+Yah2GeDuhKaCZXns0vMgeEIb5MFPzA9Nu
 o1f3PAObDArTrrbkk+JMDpz1GnN3DsPx6j2lmfbDb4ufggcyCNdo0R4cMfL4Y6hEkHroPITvB4S
 EAQeyzcvQngb2euR/G1HyNhOd4vqLLKi9BBU+gC0+xV4CBpgfDU1uMtZihzb8gS154UGKk5uaRT
 69MRGPG15yKGt6BrC3CYUvGdQA0oCnQf835Rk+VACJtXO9c4ak/onSTz4pByovek5U87/WEjbhO
 3hehyoYns1QAlaDsAS7CBoY8bajKK1WfdQMM9n1yVYoli5Tp7Gh3scKkMnp28GOXQWsnoHCTqC5
 QfSMvgjICM8LLPKKkQ29QASob9Pw8gymEcZwledl304z7lIg7yp3sIr4B5z58y0Faoc5WIj7S3D
 CjVhtDweamJSDXzO9jDA7UIGxTSklH9IcJdY7UwoNmEMyjtRoeQP3xrRlJmkEV7Afw
X-Received: by 2002:a05:600c:470d:b0:490:e5c1:b897 with SMTP id
 5b1f17b1804b1-4923412f115mr77313675e9.20.1781723692586; 
 Wed, 17 Jun 2026 12:14:52 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 16/17] drm/amdgpu/gfx8: Fixup IP block soft reset
Date: Wed, 17 Jun 2026 21:14:27 +0200
Message-ID: <20260617191428.1784083-17-timur.kristof@gmail.com>
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

Always reset everything in the GFX block at once as opposed
to trying to figure out which blocks need to be reset based
on their busy flags. This makes the reset more robust and
predictable.

Increase delays when waiting for the GRBM and SRBM soft reset
to complete.

Call IP block suspend/resume to ensure correct operation now
that we no longer have pre/post_soft_reset().

Call clock/powergating functions, otherwise power consumption
will increase after the GFX IP block is soft reset.

Return correct error code to signal failure in case not all
rings are functional after the IP block is soft reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 43 +++++++++++++++++++------
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 77050f9884f2..d968e5b6725b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -479,8 +479,6 @@ struct amdgpu_gfx {
 	const struct amdgpu_gfx_funcs	*funcs;
 
 	/* reset mask */
-	uint32_t                        grbm_soft_reset;
-	uint32_t                        srbm_soft_reset;
 	uint32_t 			gfx_supported_reset;
 	uint32_t 			compute_supported_reset;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1366d6070481..e5b25d6b8268 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4904,13 +4904,19 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
 	u32 tmp;
 	int i;
+	int r;
 
-	if ((!adev->gfx.grbm_soft_reset) &&
-	    (!adev->gfx.srbm_soft_reset))
-		return 0;
+	grbm_soft_reset =
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_GFX, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CP, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
 
-	grbm_soft_reset = adev->gfx.grbm_soft_reset;
-	srbm_soft_reset = adev->gfx.srbm_soft_reset;
+	srbm_soft_reset =
+		REG_SET_FIELD(0, SRBM_SOFT_RESET, SOFT_RESET_GRBM, 1) |
+		REG_SET_FIELD(0, SRBM_SOFT_RESET, SOFT_RESET_SEM, 1);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
@@ -4920,14 +4926,21 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		gfx_v8_0_deactivate_hqd(adev, 2);
 		vi_srbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
+
+		udelay(50);
 	}
 
+	ip_block->version->funcs->set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
+	ip_block->version->funcs->set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
+	ip_block->version->funcs->suspend(ip_block);
+
 	if (grbm_soft_reset || srbm_soft_reset) {
 		tmp = RREG32(mmGMCON_DEBUG);
 		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 1);
 		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_CLEAR, 1);
 		WREG32(mmGMCON_DEBUG, tmp);
-		udelay(50);
+
+		udelay(100);
 	}
 
 	if (grbm_soft_reset) {
@@ -4937,11 +4950,13 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		WREG32(mmGRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmGRBM_SOFT_RESET);
 
-		udelay(50);
+		udelay(100);
 
 		tmp &= ~grbm_soft_reset;
 		WREG32(mmGRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmGRBM_SOFT_RESET);
+
+		udelay(100);
 	}
 
 	if (srbm_soft_reset) {
@@ -4951,11 +4966,13 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
-		udelay(50);
+		udelay(100);
 
 		tmp &= ~srbm_soft_reset;
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
+
+		udelay(100);
 	}
 
 	if (grbm_soft_reset || srbm_soft_reset) {
@@ -4966,7 +4983,15 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	}
 
 	/* Wait a little for things to settle down */
-	udelay(50);
+	udelay(100);
+
+	r = ip_block->version->funcs->resume(ip_block);
+	r |= ip_block->version->funcs->late_init(ip_block);
+	if (r)
+		return r;
+
+	ip_block->version->funcs->set_clockgating_state(ip_block, AMD_CG_STATE_GATE);
+	ip_block->version->funcs->set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
 }
-- 
2.54.0

