Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6723FC79F82
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 18:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D728410E57C;
	Fri,  4 Sep 2026 18:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nw9JN5hg";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F3D10E57C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 18:34:33 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4858269e3d9so119179f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788546872; x=1789151672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FlwWt2iLMB/h895ucBf3DrW8tBlCIQBvAtOjJ/JDgn4=;
 b=Nw9JN5hgsl/Wv8YOxFS8RDPlyR6lQrG7tNr12p8eUdj389JQ7N/haE9XCtvn6D9sh3
 SKa0Tg1Iuhvp3PI02Kmy5kY0MyO49gxkM6uU9QYuXfMz46XR/LGJ6ePLDSdW+ah8lZ6N
 lSanPV3LPlgV/1rM2kO0HIm07ncD6t2i+cQmOHbrdmzKK4q+ZvyMWHtiCwtthUfA6qcx
 oA6A/69YG6iiob8n+aKKnQ/Ppzy+UmC2tDVpO491hO/5C9z5XJPyqfxh3e0XInr093/+
 L2uqtQRkfu9tUpXDJrby90zUflPxpNL1RZsEoPRe4JuaGWTbwgVJmJuc8vmf4GXKLcLZ
 BRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788546872; x=1789151672;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FlwWt2iLMB/h895ucBf3DrW8tBlCIQBvAtOjJ/JDgn4=;
 b=Yy4/8S5qQA76qowMkUzIydakwfKsZxmPNPUnrjOeHDG83ELfZTacU1sbNjJywuWr8+
 Z8a//a3oyjrf3ncW2x4+Q7RtJGeITmdRH26DpZUc32fDNirnebyryX8B21G3vLjTqs5k
 6nSkvK+H2ZDWBsFvGtD6Bk9AmGbbF8ciClg/VIepIi/rg/1bUqUgC3s04VYoQVLIQX5M
 Ftjudw0G8UhYxAVlBhOOGWUJ6cISZmX9hA4vM4zKCozGmeNzK4jo6KJ6DdE6FIsK/GgO
 9nPMpJRRT0ddB7viEC6LbOcSMQ5+Py+bXRnjJS8byIQa/n4QhfdmHf+EiK97zW5ef4Of
 iNFA==
X-Gm-Message-State: AFuF++nRsIjJYeF4HBBhiTWAK6IzJbZeLTkw25tWpqP5v5E7yjNw4vzs
 p7dWBy+xk95+q1ZQyj3a2w26z/UYKRJ8cN8+oHAgmPK+33SSvJZv+Lb5CmHwnmB8
X-Gm-Gg: AYBFou1AdyYQILgPJVvf6F6m+QMVHaRGESXvdzsuWq0Q4VJaaYARkZIWS45AQRE8h2Z
 XRJASOM3P3Rp2M3NDGUs576/zyf5Gasas6qOjGPzXkM7Oqo/ooLnPLTV4+Vs6DfKEuk5zsxX2WY
 HgzL5VbJ/ZzpxF5HemyrB0lYck53EGClljvZcnoMSbzUq4tOrG9Gah1jYtCtAz03aiXYeaDk4Ym
 yjJVL+ACml6tCzj3NPIQWxeCaf9wAlhRkTlnKh5XqxRydzypbpp5ifExk4tttfHbGzMmCwK6piQ
 r7H27hidu710YfFyRPTHyzgc8Lmemf6lma5AE7B2z4liKz3quWiVzS28ElIyeScQeFvPAKFmW+Q
 Smg/2zZdj0SjAJ0sqsj4gHSG4ra4HEAndnns761rRxgKOD0UsyTQGR7lAHt94vj3ROtkEMjtx59
 QgPoovgemhxovFDMwxFyO4blf1AjVW/EOTaoXyP9qrHT9yPjwqg3BEuPsUWVGi+yzqvZ7HLqqZ2
 Qi1W2jHWqI3Rp9x6gnblLvVLKBmjpk=
X-Received: by 2002:a05:600c:8b11:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49cf82417f7mr180112645e9.10.1788546871475; 
 Fri, 04 Sep 2026 11:34:31 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm118373095e9.5.2026.09.04.11.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:34:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amdgpu: Delete GMC v6-v7 soft_reset() code
Date: Fri,  4 Sep 2026 20:34:07 +0200
Message-ID: <20260904183409.571117-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904183409.571117-1-timur.kristof@gmail.com>
References: <20260904183409.571117-1-timur.kristof@gmail.com>
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

Note that the soft reset code for GMC v6-v7 was never
called from anywhere, so there is no loss of functionality
from this commit. The implementation looks plausible but
it was never enabled or tested, and unlikely to be useful.

We should only reset the memory controller during ASIC reset
and otherwise leave it alone. Resetting the memory controller
can break everything and risks losing the contents of VRAM
(it's unclear if VRAM is lost or not, but it's likely).

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 85 ---------------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 83 --------------------------
 2 files changed, 168 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index cdd11587b12a..71409eb718d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -61,45 +61,6 @@ MODULE_FIRMWARE("amdgpu/si58_mc.bin");
 #define MC_SEQ_MISC0__MT__HBM    0x60000000
 #define MC_SEQ_MISC0__MT__DDR3   0xB0000000
 
-static void gmc_v6_0_mc_stop(struct amdgpu_device *adev)
-{
-	u32 blackout;
-	struct amdgpu_ip_block *ip_block;
-
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GMC);
-	if (!ip_block)
-		return;
-
-	gmc_v6_0_wait_for_idle(ip_block);
-
-	blackout = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
-	if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE) != 1) {
-		/* Block CPU access */
-		WREG32(mmBIF_FB_EN, 0);
-		/* blackout the MC */
-		blackout = REG_SET_FIELD(blackout,
-					 MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE, 0);
-		WREG32(mmMC_SHARED_BLACKOUT_CNTL, blackout | 1);
-	}
-	/* wait for the MC to settle */
-	udelay(100);
-
-}
-
-static void gmc_v6_0_mc_resume(struct amdgpu_device *adev)
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
 static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
@@ -981,51 +942,6 @@ static int gmc_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 }
 
-static int gmc_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	u32 srbm_soft_reset = 0;
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
-		gmc_v6_0_mc_stop(adev);
-
-		if (gmc_v6_0_wait_for_idle(ip_block))
-			dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
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
-		udelay(50);
-
-		gmc_v6_0_mc_resume(adev);
-		udelay(50);
-	}
-
-	return 0;
-}
-
 static int gmc_v6_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
 					     unsigned int type,
@@ -1139,7 +1055,6 @@ static const struct amd_ip_funcs gmc_v6_0_ip_funcs = {
 	.suspend = gmc_v6_0_suspend,
 	.resume = gmc_v6_0_resume,
 	.wait_for_idle = gmc_v6_0_wait_for_idle,
-	.soft_reset = gmc_v6_0_soft_reset,
 	.set_clockgating_state = gmc_v6_0_set_clockgating_state,
 	.set_powergating_state = gmc_v6_0_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c9cc55e18893..c95e097241bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -85,44 +85,6 @@ static void gmc_v7_0_init_golden_registers(struct amdgpu_device *adev)
 	}
 }
 
-static void gmc_v7_0_mc_stop(struct amdgpu_device *adev)
-{
-	struct amdgpu_ip_block *ip_block;
-	u32 blackout;
-
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GMC);
-	if (!ip_block)
-		return;
-
-	gmc_v7_0_wait_for_idle(ip_block);
-
-	blackout = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
-	if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE) != 1) {
-		/* Block CPU access */
-		WREG32(mmBIF_FB_EN, 0);
-		/* blackout the MC */
-		blackout = REG_SET_FIELD(blackout,
-					 MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE, 0);
-		WREG32(mmMC_SHARED_BLACKOUT_CNTL, blackout | 1);
-	}
-	/* wait for the MC to settle */
-	udelay(100);
-}
-
-static void gmc_v7_0_mc_resume(struct amdgpu_device *adev)
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
  * gmc_v7_0_init_microcode - load ucode images from disk
  *
@@ -1168,50 +1130,6 @@ static int gmc_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 }
 
-static int gmc_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset = 0;
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
-		gmc_v7_0_mc_stop(adev);
-		if (gmc_v7_0_wait_for_idle(ip_block))
-			dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
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
-
-		gmc_v7_0_mc_resume(adev);
-		udelay(50);
-	}
-
-	return 0;
-}
-
 static int gmc_v7_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
 					     unsigned int type,
@@ -1353,7 +1271,6 @@ static const struct amd_ip_funcs gmc_v7_0_ip_funcs = {
 	.suspend = gmc_v7_0_suspend,
 	.resume = gmc_v7_0_resume,
 	.wait_for_idle = gmc_v7_0_wait_for_idle,
-	.soft_reset = gmc_v7_0_soft_reset,
 	.set_clockgating_state = gmc_v7_0_set_clockgating_state,
 	.set_powergating_state = gmc_v7_0_set_powergating_state,
 };
-- 
2.55.0

