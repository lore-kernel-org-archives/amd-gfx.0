Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80264C79FA0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D94810E916;
	Mon,  7 Sep 2026 20:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lH9yE7mA";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D8610E917
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:34:05 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so4447240f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813244; x=1789418044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XG3T0Tenllgp9v8ken++UCRqYOxtREUzHuDe1qfxv4E=;
 b=lH9yE7mAZiucZwYw3rIuIoFiH0n7K6H0l7x4RL5U4raI+j3KALU68TT9zkG9E+jw5n
 s+R9PPnDnxK+2gx7RvgQ006Al+94nIKFL0/DpoFpo/I/c5wk3+O4APo7sVQWibcvNefR
 UobeCqQcrkXV5Y3XoLSDmr3yRZupDO+dO5PaX9DHY98yiiasivkS0tv8vBwDKFbAsXTM
 SWQJwAWmx1de7yCY7te2MyvZRupUuLW/2aC3FmgItIw95te0MbheAHJ+yLUV2ZgsqOW9
 Uy8FwaX8poAF4WZbiBnh5agN+QQY61hSj1by4dVKx6nfLopVn+1eE1NsK9wuw5eIa4/r
 Vzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813244; x=1789418044;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XG3T0Tenllgp9v8ken++UCRqYOxtREUzHuDe1qfxv4E=;
 b=iIJfFPPSFIsnvkzkU2FfyEVDEWOWDVtNejRmXqpXXYBXe5+nyYddO7qSsk3wrhsezq
 bO8Vt2XJG7b1wQdpcniI6Q6bp7VL39qmoWMwvGgxjXeNsvaBZeXyisyHVGqV6U3bS/4L
 VcVsQqD+bd1yPrPKkA+pbfSugJGfKhe3UTcnYGDL4Rqv/rCdAPhVc1nMvWTg8y4rzZ4J
 tUdgu3TcE3b6SF23TkWH30Gcp7XQ/GWxS7q9SjFDRdJCeE9nHmRHpPyjWt0J7VownZyO
 uFpWyY7SEvlCbahn5QNU+Mu47aLbGwiHbnlvjLWTowWQ62MDffskMT8i8M4yygzZr3AP
 HLpw==
X-Gm-Message-State: AFuF++lmAJm4DWaFqq2TkxtooZaMG0A+lwUiOuzNDUztaHC2hzc3Z8gE
 R6JqE1OHQcUeesT794PKHVqeznzSzL8WAnPrjV7xdfCNT475bG4DRtLQHhYyaxp8
X-Gm-Gg: AYBFou32ilpexbw62llSwz/ytYgCtOg2cexJIxzdZg9s3yIznWX4tOMT5z4aTqUxQCi
 sfR6HccryE/X994HMRCuWmFBiLvpymchLf5VkYNa1hvlBX6YIpO0H7kL2eICj24EE0nCcnGFC0N
 Eod8iMVcrVOvtqyXnkx5PsYAyJqEH1MeTCtXOUs4XiAFJDbvUdccTVatbqM4SVhE8Empn0bxv+S
 e06lBjhCefRSfkMRQHZYX0MjNT2xPzQMheWvv1Crlc8XR9SSkSedLV+7befItEC5AFenNE/bU6u
 syiHieJ0XVDdrryTw6t3sgIXtXV9jyqIHdq62hkTrF56Xo0EPKkkGzj8yXGQnGbOkJvrD7XM9gN
 d0sKCqgbN2oW4k6jdWp1380V59iLCHUmzZl3nLA3eRLAAhEGdlvrTr5ybP3aVU7jj5ZWSjrCniV
 JLB3eCKKn+KahNJfTzWP2oDfdpBV7GdXE8yVx2MUw0+78dMfro6M5XA+ucFMR1SRlJGtSOP8OLq
 QPq04egi0ZYT2wJTTeP
X-Received: by 2002:a5d:5f56:0:b0:485:9f68:9b65 with SMTP id
 ffacd0b85a97d-4859f689c06mr7195629f8f.30.1788813243628; 
 Mon, 07 Sep 2026 13:34:03 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:34:03 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/12] drm/amdgpu/sdma: Refactor SDMA v4.0 clock gating
 functions to be per-instance
Date: Mon,  7 Sep 2026 22:33:15 +0200
Message-ID: <20260907203316.159103-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907203316.159103-1-timur.kristof@gmail.com>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
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

Refactor clock gating functions to take the SDMA engine
instance ID as an argument and only affect one SDMA engine
instance at once.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 89 ++++++++++++--------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 038e1ee8ff4c..259857596cfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2208,66 +2208,58 @@ static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
 
 static void sdma_v4_0_update_medium_grain_clock_gating(
 		struct amdgpu_device *adev,
-		bool enable)
+		const u32 instance_id,
+		const bool enable)
 {
 	uint32_t data, def;
-	int i;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			def = data = RREG32_SDMA(i, mmSDMA0_CLK_CTRL);
-			data &= ~(SDMA0_CLK_CTRL__SOFT_OVERRIDE7_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE6_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE5_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK);
-			if (def != data)
-				WREG32_SDMA(i, mmSDMA0_CLK_CTRL, data);
-		}
+		def = data = RREG32_SDMA(instance_id, mmSDMA0_CLK_CTRL);
+		data &= ~(SDMA0_CLK_CTRL__SOFT_OVERRIDE7_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE6_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE5_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK);
+		if (def != data)
+			WREG32_SDMA(instance_id, mmSDMA0_CLK_CTRL, data);
 	} else {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			def = data = RREG32_SDMA(i, mmSDMA0_CLK_CTRL);
-			data |= (SDMA0_CLK_CTRL__SOFT_OVERRIDE7_MASK |
-				 SDMA0_CLK_CTRL__SOFT_OVERRIDE6_MASK |
-				 SDMA0_CLK_CTRL__SOFT_OVERRIDE5_MASK |
-				 SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
-				 SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
-				 SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
-				 SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
-				 SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK);
-			if (def != data)
-				WREG32_SDMA(i, mmSDMA0_CLK_CTRL, data);
-		}
+		def = data = RREG32_SDMA(instance_id, mmSDMA0_CLK_CTRL);
+		data |= (SDMA0_CLK_CTRL__SOFT_OVERRIDE7_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE6_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE5_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK);
+		if (def != data)
+			WREG32_SDMA(instance_id, mmSDMA0_CLK_CTRL, data);
 	}
 }
 
 
 static void sdma_v4_0_update_medium_grain_light_sleep(
 		struct amdgpu_device *adev,
-		bool enable)
+		const u32 instance_id,
+		const bool enable)
 {
 	uint32_t data, def;
-	int i;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			/* 1-not override: enable sdma mem light sleep */
-			def = data = RREG32_SDMA(0, mmSDMA0_POWER_CNTL);
-			data |= SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
-			if (def != data)
-				WREG32_SDMA(0, mmSDMA0_POWER_CNTL, data);
-		}
+		/* 1-not override: enable sdma mem light sleep */
+		def = data = RREG32_SDMA(instance_id, mmSDMA0_POWER_CNTL);
+		data |= SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
+		if (def != data)
+			WREG32_SDMA(instance_id, mmSDMA0_POWER_CNTL, data);
 	} else {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
 		/* 0-override:disable sdma mem light sleep */
-			def = data = RREG32_SDMA(0, mmSDMA0_POWER_CNTL);
-			data &= ~SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
-			if (def != data)
-				WREG32_SDMA(0, mmSDMA0_POWER_CNTL, data);
-		}
+		def = data = RREG32_SDMA(instance_id, mmSDMA0_POWER_CNTL);
+		data &= ~SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
+		if (def != data)
+			WREG32_SDMA(instance_id, mmSDMA0_POWER_CNTL, data);
 	}
 }
 
@@ -2275,14 +2267,17 @@ static int sdma_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	sdma_v4_0_update_medium_grain_clock_gating(adev,
-			state == AMD_CG_STATE_GATE);
-	sdma_v4_0_update_medium_grain_light_sleep(adev,
-			state == AMD_CG_STATE_GATE);
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		sdma_v4_0_update_medium_grain_clock_gating(
+			adev, i, state == AMD_CG_STATE_GATE);
+		sdma_v4_0_update_medium_grain_light_sleep(
+			adev, i, state == AMD_CG_STATE_GATE);
+	}
 	return 0;
 }
 
-- 
2.55.0

