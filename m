Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5903DC79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9EE10E915;
	Mon,  7 Sep 2026 20:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s+VZhInV";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE17910E913
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:55 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so3780229f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813234; x=1789418034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Hpv4K36fga1fcOsJF+MhLtq32i2aZxcneFd/L6i4sw=;
 b=s+VZhInVrKMAjAMjU4qcdv7YQQ/Gz4oTUB9DwB34XN2npLy/Kwq90ljLQbgfHLh8H1
 YHdgoZFnNyITVdEtUk5bNbwj1z8qyPgMWThV4iq0i0nRZNG2SIgMZnNRVXifZPKtzp33
 oJOdcLVZQMR8Qf/iL6HPYb9rbzqXebefDHC3HYgM8u9UDepKjbWDgP5f1bzONLb0yUv4
 WQu1zABFOB4G+qF+1Tr/17opaKwSDZ27rEwS2Y/8CmnDjYELIvmM0DKFXkYoUJCZbtIt
 X19O1Wy/rT/mUigPubDqWNXzzd2Ve4L5ts4vMxckF7jSNZZ4U0BwztgQ7Lbjm3Ej29Tg
 asrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813234; x=1789418034;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Hpv4K36fga1fcOsJF+MhLtq32i2aZxcneFd/L6i4sw=;
 b=j7+BUITi77UlVSXgLcKpOTqGgwCTg5oYO+JwLYAADTbpMcTusOHn1GkTsZKk46H/GP
 SuSswkviY2Ab/TRKWqRa3dBa8CYYhwdwv5O6//OrREFLF75iqCBErjfsJTY0GM1mOk8f
 Pz5Rr9iGfxjDr8iBrXxbAhGbVKofeKeUE3h9qq/+eY4+SeYm/jk6iqKSLFkahnxnWMR5
 mn5mI3fqlY0EafhLFP8npqCJlrX4gNkf9USpEDA49qmpRf9SDwrLqKjxbXvZCgByS7qI
 aQ2kltzR75+7w6H1+F0j/Tla40ZX6Zt0Z/wE+j1PnTRc3jciksHQxlRRhqiME/NM7e4v
 k5MQ==
X-Gm-Message-State: AFuF++lJwoPvWFzvu0Oxgk8MRgbnV3KApoAYHzT+4T+pMCVoUBmyRgSM
 pv+WXJ2gk4HuAX1eUcsmTLLkGLPiH6ffGXc6LMfzqRKydqGTFy+CLZo9HeHVibKs
X-Gm-Gg: AYBFou0aaBh0VMjDfv5GNDI/hxl4RST1lQQ63J3c9E7U9WIUzvgsLOcUQmKSbx3ZtA0
 1tQTnee5bYIX7RMovctKeSG8T+17utrPPIE7BJDe+A5f+JInBPoFa6E1Y7hQet+0kKsf+lhTUqP
 LcGX4sJML+mIo/AM1dwXevX0kaXorjE1jfgngFUXSsCPVH2716lR8mn02uk71IURMP1Wv45HKXr
 4d0e5CjOtG6vQ8YPxNMKPf7ZUM06PePpgjPpkEDVIMDHNk/JUN2u+gmuhbVCOrsIV7iHdjZnroz
 sZ+ETWnnPI4kFZSjrhFREH3FANmXpeRMmBIwtAEVxqgOZgU9ZkmkmzOvEa9mUcByjYf4TsOBvg1
 qHMooAJvtPcfh0K1dzr73vlar925aapoY/d3pUxtWLVg9+1Vi1E0GLhEhH86pB0HTm3cE1gdgDu
 Fe7t7ApmL+wpjzMdh3cbsO057+vVNQ4+y+omdKSlb3DfTzZB06Cm2wDqPih6RCcxco7ZKIkcqll
 Ftyyl6xIef9f+WCfWu8
X-Received: by 2002:a05:6000:4604:b0:485:8eac:265 with SMTP id
 ffacd0b85a97d-4858eac02b9mr17473987f8f.57.1788813234208; 
 Mon, 07 Sep 2026 13:33:54 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:53 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/12] drm/amdgpu/sdma: Refactor SDMA v3.0 clock gating
 functions to be per-instance
Date: Mon,  7 Sep 2026 22:33:12 +0200
Message-ID: <20260907203316.159103-9-timur.kristof@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 81 +++++++++++++-------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 6213a0c77590..3d0f94372e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1345,66 +1345,60 @@ static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device *adev,
 
 static void sdma_v3_0_update_sdma_medium_grain_clock_gating(
 		struct amdgpu_device *adev,
-		bool enable)
+		const u32 instance_id,
+		const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	uint32_t temp, data;
-	int i;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			temp = data = RREG32(mmSDMA0_CLK_CTRL + sdma_offsets[i]);
-			data &= ~(SDMA0_CLK_CTRL__SOFT_OVERRIDE7_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE6_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE5_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
-				  SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK);
-			if (data != temp)
-				WREG32(mmSDMA0_CLK_CTRL + sdma_offsets[i], data);
-		}
-	} else {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			temp = data = RREG32(mmSDMA0_CLK_CTRL + sdma_offsets[i]);
-			data |= SDMA0_CLK_CTRL__SOFT_OVERRIDE7_MASK |
+		temp = data = RREG32(mmSDMA0_CLK_CTRL + reg_offset);
+		data &= ~(SDMA0_CLK_CTRL__SOFT_OVERRIDE7_MASK |
 				SDMA0_CLK_CTRL__SOFT_OVERRIDE6_MASK |
 				SDMA0_CLK_CTRL__SOFT_OVERRIDE5_MASK |
 				SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
 				SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
 				SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
 				SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
-				SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK;
-
-			if (data != temp)
-				WREG32(mmSDMA0_CLK_CTRL + sdma_offsets[i], data);
-		}
+				SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK);
+		if (data != temp)
+			WREG32(mmSDMA0_CLK_CTRL + reg_offset, data);
+	} else {
+		temp = data = RREG32(mmSDMA0_CLK_CTRL + reg_offset);
+		data |= SDMA0_CLK_CTRL__SOFT_OVERRIDE7_MASK |
+			SDMA0_CLK_CTRL__SOFT_OVERRIDE6_MASK |
+			SDMA0_CLK_CTRL__SOFT_OVERRIDE5_MASK |
+			SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
+			SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
+			SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
+			SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
+			SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK;
+
+		if (data != temp)
+			WREG32(mmSDMA0_CLK_CTRL + reg_offset, data);
 	}
 }
 
 static void sdma_v3_0_update_sdma_medium_grain_light_sleep(
 		struct amdgpu_device *adev,
-		bool enable)
+		const u32 instance_id,
+		const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	uint32_t temp, data;
-	int i;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			temp = data = RREG32(mmSDMA0_POWER_CNTL + sdma_offsets[i]);
-			data |= SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
+		temp = data = RREG32(mmSDMA0_POWER_CNTL + reg_offset);
+		data |= SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
 
-			if (temp != data)
-				WREG32(mmSDMA0_POWER_CNTL + sdma_offsets[i], data);
-		}
+		if (temp != data)
+			WREG32(mmSDMA0_POWER_CNTL + reg_offset, data);
 	} else {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			temp = data = RREG32(mmSDMA0_POWER_CNTL + sdma_offsets[i]);
-			data &= ~SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
+		temp = data = RREG32(mmSDMA0_POWER_CNTL + reg_offset);
+		data &= ~SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
 
-			if (temp != data)
-				WREG32(mmSDMA0_POWER_CNTL + sdma_offsets[i], data);
-		}
+		if (temp != data)
+			WREG32(mmSDMA0_POWER_CNTL + reg_offset, data);
 	}
 }
 
@@ -1412,6 +1406,7 @@ static int sdma_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
@@ -1420,10 +1415,12 @@ static int sdma_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	case CHIP_FIJI:
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
-		sdma_v3_0_update_sdma_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE);
-		sdma_v3_0_update_sdma_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE);
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			sdma_v3_0_update_sdma_medium_grain_clock_gating(
+				adev, i, state == AMD_CG_STATE_GATE);
+			sdma_v3_0_update_sdma_medium_grain_light_sleep(
+				adev, i, state == AMD_CG_STATE_GATE);
+		}
 		break;
 	default:
 		break;
-- 
2.55.0

