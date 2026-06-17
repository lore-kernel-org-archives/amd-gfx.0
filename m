Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC31CD98F6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1BF10F0D7;
	Wed, 17 Jun 2026 19:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qw1kWVao";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4DDE10F0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:37 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so604225e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723676; x=1782328476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5HyQxm+4k6rJid+mBeVbuXvKhOhocHQvv+UBU4JFhY=;
 b=qw1kWVaoo6vKjhp/RemBrmv3ooHPPn/zNmMGqe7iuI+2CC2vx8yi63nAQQSoGufps6
 hMZV61iY5VBUM3/X7PFK6njLSxNZbymc69Zyixb6LPu52f7rkwM4rV3vwAmFP+32pjhF
 +l8cXykEdhYUl3z/hdHhbazVRxOkjgeQLdi4tPETMxIcPkATtow8w46z1zkz5G6wygtX
 obgq5F5wMctapnYqY3qu+E9uOelE+ZBNbj7huq6XXzgGIf6y6z4HvctDdRZMJ/heN9vK
 3D9xFMIW87ErK9Ao4dczoPRQNuOVZeHDyp4ps+9cYixzQ20yNa7NgYB8TdT2kFkE3JaN
 wQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723676; x=1782328476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k5HyQxm+4k6rJid+mBeVbuXvKhOhocHQvv+UBU4JFhY=;
 b=Kzo0QT2cUwQ8nP8voUEflAnX27hz499ND9ngg4GJG6qsoE543JDlEpNZJkZGw0/7HO
 7PLZNN3w7NpkKGYSaSM+jZJZZV2khYSkXkeyQpdPpdYHB3y2VMG4zqlvRaD6j6fm7fIX
 H84NnFrQbsXuhtDAsHTcB9j1FdqT89gHrWDVBjjAz/21CSQ2BbnlbbqFST8iolT/jXaZ
 1MXcyV0Aq+k8fpPgc6352/l1pBJqjB2iOZT1dM+jHPb9K3Ojf3c8+Dp0nnDuIS58duoD
 hKIvFP/0UMniKypZL/1FZCA5lrqcTBPkgLGU6sQ70aTySco9KzO/y3OqdMZAsjBGEaRQ
 XhzQ==
X-Gm-Message-State: AOJu0YzhbY7S76gQ0Xn5SbFAtbIz+odB9KyFnw84Kwg+cjdRDZmgPzlS
 XPXZKnmz8hkdcBpUQarLLOPwKiERfgXsNNZ/oCUFyzCbJvhBS6JSxR8JLLLgpQ==
X-Gm-Gg: Acq92OH0sQRTJWbrzoCMGq+TxaCXLwvEdPB/YGKaAq5xnuYSrHteypOBCVqwUyO1VW9
 lTrchNjSUO+JJnTbQmGBt2xCJ3aRl76806LDeoRnGttkymeZf/RoRFZACuXbKD4978Niaufrd6G
 9mx9VYistvlqhtcsq1QVoI+DEhoVjtkrV7V6efNGrP8Q6lXIX9uiq2yUqcx6jg1jDi7LLN2leR3
 5jVz4Nfwd6hKBhcZy7kp3LBp7RkVRUZ2Eoa7xOCAp1kY9buQQEW9d0a/VfZWMLT3ZAaaGGxC9hi
 t5KmicvEL5F1fm5uNqdQHcQsRSzxxH5OIK8DwTr8QDG+ska1fKsMUmJFN99fA9IYmWrLyy08pbe
 mlKPxWRdELhwiCMkSG0UkgwMtfyzB9dlgf/PMbDd8/MPpqNkYn56Gd/Qe+UsvqyLCbvQhjyqaQl
 pQ8pquIKsFTfSNHUlN4cvz8eyWYziEUlvuY8He/eS+kIiMIgVFSj9N9A==
X-Received: by 2002:a05:600c:3317:b0:492:1e36:552c with SMTP id
 5b1f17b1804b1-492333e3b6amr61820545e9.37.1781723675942; 
 Wed, 17 Jun 2026 12:14:35 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/17] drm/amdgpu: Delete GMC 8 soft reset
Date: Wed, 17 Jun 2026 21:14:14 +0200
Message-ID: <20260617191428.1784083-4-timur.kristof@gmail.com>
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

We should only reset the memory controller during ASIC reset
and only when it's absolutely necessary. Otherwise, resetting
the memory controller typically just breaks everything and
on dGPUs may also clear the contents of VRAM (it's unclear if
it really does, but it's likely).

Specifically for GMC 8, the memory controller is reset as part
of the ASIC reset and otherwise should be left alone.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 125 ------------------------
 2 files changed, 126 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 676e3aaa1f27..f3f42f773171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -285,7 +285,6 @@ struct amdgpu_gmc {
 	struct amdgpu_irq_src	vm_fault;
 	uint32_t		vram_type;
 	uint8_t			vram_vendor;
-	uint32_t                srbm_soft_reset;
 	bool			prt_warning;
 	uint32_t		sdpif_register;
 	/* apertures */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 1d3ddffd5a11..37f7777e82d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -167,44 +167,6 @@ static void gmc_v8_0_init_golden_registers(struct amdgpu_device *adev)
 	}
 }
 
-static void gmc_v8_0_mc_stop(struct amdgpu_device *adev)
-{
-	u32 blackout;
-	struct amdgpu_ip_block *ip_block;
-
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GMC);
-	if (!ip_block)
-		return;
-
-	gmc_v8_0_wait_for_idle(ip_block);
-
-	blackout = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
-	if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE) != 1) {
-		/* Block CPU access */
-		WREG32(mmBIF_FB_EN, 0);
-		/* blackout the MC */
-		blackout = REG_SET_FIELD(blackout,
-					 MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE, 1);
-		WREG32(mmMC_SHARED_BLACKOUT_CNTL, blackout);
-	}
-	/* wait for the MC to settle */
-	udelay(100);
-}
-
-static void gmc_v8_0_mc_resume(struct amdgpu_device *adev)
-{
-	u32 tmp;
-
-	/* unblackout the MC */
-	tmp = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
-	tmp = REG_SET_FIELD(tmp, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE, 0);
-	WREG32(mmMC_SHARED_BLACKOUT_CNTL, tmp);
-	/* allow CPU access */
-	tmp = REG_SET_FIELD(0, BIF_FB_EN, FB_READ_EN, 1);
-	tmp = REG_SET_FIELD(tmp, BIF_FB_EN, FB_WRITE_EN, 1);
-	WREG32(mmBIF_FB_EN, tmp);
-}
-
 /**
  * gmc_v8_0_init_microcode - load ucode images from disk
  *
@@ -1293,89 +1255,6 @@ static int gmc_v8_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 }
 
-static bool gmc_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	u32 srbm_soft_reset = 0;
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (tmp & SRBM_STATUS__VMC_BUSY_MASK)
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
-						SRBM_SOFT_RESET, SOFT_RESET_VMC, 1);
-
-	if (tmp & (SRBM_STATUS__MCB_BUSY_MASK | SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK |
-		   SRBM_STATUS__MCC_BUSY_MASK | SRBM_STATUS__MCD_BUSY_MASK)) {
-		if (!(adev->flags & AMD_IS_APU))
-			srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
-							SRBM_SOFT_RESET, SOFT_RESET_MC, 1);
-	}
-
-	if (srbm_soft_reset) {
-		adev->gmc.srbm_soft_reset = srbm_soft_reset;
-		return true;
-	}
-
-	adev->gmc.srbm_soft_reset = 0;
-
-	return false;
-}
-
-static int gmc_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (!adev->gmc.srbm_soft_reset)
-		return 0;
-
-	gmc_v8_0_mc_stop(adev);
-	if (gmc_v8_0_wait_for_idle(ip_block))
-		dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
-
-	return 0;
-}
-
-static int gmc_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset;
-
-	if (!adev->gmc.srbm_soft_reset)
-		return 0;
-	srbm_soft_reset = adev->gmc.srbm_soft_reset;
-
-	if (srbm_soft_reset) {
-		u32 tmp;
-
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		/* Wait a little for things to settle down */
-		udelay(50);
-	}
-
-	return 0;
-}
-
-static int gmc_v8_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (!adev->gmc.srbm_soft_reset)
-		return 0;
-
-	gmc_v8_0_mc_resume(adev);
-	return 0;
-}
-
 static int gmc_v8_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
 					     unsigned int type,
@@ -1715,10 +1594,6 @@ static const struct amd_ip_funcs gmc_v8_0_ip_funcs = {
 	.resume = gmc_v8_0_resume,
 	.is_idle = gmc_v8_0_is_idle,
 	.wait_for_idle = gmc_v8_0_wait_for_idle,
-	.check_soft_reset = gmc_v8_0_check_soft_reset,
-	.pre_soft_reset = gmc_v8_0_pre_soft_reset,
-	.soft_reset = gmc_v8_0_soft_reset,
-	.post_soft_reset = gmc_v8_0_post_soft_reset,
 	.set_clockgating_state = gmc_v8_0_set_clockgating_state,
 	.set_powergating_state = gmc_v8_0_set_powergating_state,
 	.get_clockgating_state = gmc_v8_0_get_clockgating_state,
-- 
2.54.0

