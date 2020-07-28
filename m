Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B716C433F1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F09207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwPcAhUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F09207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B096E435;
	Tue, 28 Jul 2020 22:46:44 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00236E433
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:42 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so9950629qvb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qiMop+01gWlVsL+lmIj664Fy5MuX7Y8/7GVUwwKG6lI=;
 b=fwPcAhUifYsAZrN16wL7EyE+bFtuuOgOXkvzgq/PVm+Y8f+aUqnUDN+AT+AuqDw2WP
 ti/44SOU5S6w7iMcQS6vcx4tuSb3g8Cah2lLVdS9LG2tTFygKHzOhz17lt/6XshX6v5l
 aeeftpHvPP8HUbkTu2w+Fr4+aJQSHbyaFheNW8fANVCeuDk7vIOLzUdZzY+aM4F0tm+6
 PIsZfZNhQKig2nIxgUTuh9pUa9ehbBGGlmKcWQL3A3VqnshCpHBAKJclO4OmXmBwCBlI
 15Wbe5wmdScjRdUmb+z11LF4etyJSTfeuA149qTxT6IqTzfp6wUqkgiWhJboA6eIpX2x
 O/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qiMop+01gWlVsL+lmIj664Fy5MuX7Y8/7GVUwwKG6lI=;
 b=TCQpwQA20VSOilU+RfDhbgfpRjAbs0mjpTpdpBuquq5AqdhnhLXBkcldtCbEFaEO//
 agjxMKE+FuS3sL1AA/l6yeQdEGvXytVfbDrl31CTExveasNbgXyuCvEBSqM7T223lPbV
 edcDwG8yVTlxVOdNST4klsSbKbzm20J1oDV70EbgpOPrBqn4aXbL3WvJ0ALAZ+3d50rh
 bOpX7Le+YSPOuBTrCR+hOEguTZHbbFvMih9/Sx4Wv9ixGljALJYkslk+bnm5u01RGj6e
 RpP4AWtfnxNwoaNIr8exa+9TwomvG1lydwdFsT/il7sWFUhNpKmF2UxUct15IOgmdzCj
 NeAw==
X-Gm-Message-State: AOAM530o0VYWSineEgZ/khzbEU7ryxK2ayBycKT8aduCK9bR3WvZJ3Fq
 UkulvMaVGue4N4Xr8mtOl6VHksAU
X-Google-Smtp-Source: ABdhPJy6t5+VR56Gq3tkCKEgLnWAdSoQhqSetoP9Gcz0smZPvEmXOuxQoJZfB+8JNI4hREMWFS2QpQ==
X-Received: by 2002:a0c:f189:: with SMTP id m9mr25844768qvl.152.1595976401714; 
 Tue, 28 Jul 2020 15:46:41 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/14] drm/amdgpu/gmc9: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Tue, 28 Jul 2020 18:46:02 -0400
Message-Id: <20200728224605.3919-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200728224605.3919-1-alexander.deucher@amd.com>
References: <20200728224605.3919-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The new helper centralizes the logic in one place.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 112 +++++++++-----------------
 1 file changed, 38 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c5d2e4390fba..65488ddc34c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -827,6 +827,41 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags |= AMDGPU_PTE_SNOOPED;
 }
 
+static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
+{
+	u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
+	unsigned size;
+
+	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
+	} else {
+		u32 viewport;
+
+		switch (adev->asic_type) {
+		case CHIP_RAVEN:
+		case CHIP_RENOIR:
+			viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
+			size = (REG_GET_FIELD(viewport,
+					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(viewport,
+					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
+				4);
+			break;
+		case CHIP_VEGA10:
+		case CHIP_VEGA12:
+		case CHIP_VEGA20:
+		default:
+			viewport = RREG32_SOC15(DCE, 0, mmSCL0_VIEWPORT_SIZE);
+			size = (REG_GET_FIELD(viewport, SCL0_VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(viewport, SCL0_VIEWPORT_SIZE, VIEWPORT_WIDTH) *
+				4);
+			break;
+		}
+	}
+
+	return size;
+}
+
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
@@ -834,7 +869,8 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
 	.map_mtype = gmc_v9_0_map_mtype,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
-	.get_vm_pte = gmc_v9_0_get_vm_pte
+	.get_vm_pte = gmc_v9_0_get_vm_pte,
+	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
 };
 
 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
@@ -902,31 +938,6 @@ static int gmc_v9_0_early_init(void *handle)
 	return 0;
 }
 
-static bool gmc_v9_0_keep_stolen_memory(struct amdgpu_device *adev)
-{
-
-	/*
-	 * TODO:
-	 * Currently there is a bug where some memory client outside
-	 * of the driver writes to first 8M of VRAM on S3 resume,
-	 * this overrides GART which by default gets placed in first 8M and
-	 * causes VM_FAULTS once GTT is accessed.
-	 * Keep the stolen memory reservation until the while this is not solved.
-	 * Also check code in gmc_v9_0_get_vbios_fb_size and gmc_v9_0_late_init
-	 */
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-		return true;
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	default:
-		return false;
-	}
-}
-
 static int gmc_v9_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1066,52 +1077,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 	return amdgpu_gart_table_vram_alloc(adev);
 }
 
-static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
-{
-	u32 d1vga_control;
-	unsigned size;
-
-	/*
-	 * TODO Remove once GART corruption is resolved
-	 * Check related code in gmc_v9_0_sw_fini
-	 * */
-	if (adev->gmc.keep_stolen_vga_memory)
-		return AMDGPU_VBIOS_VGA_ALLOCATION;
-
-	d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
-	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = AMDGPU_VBIOS_VGA_ALLOCATION;
-	} else {
-		u32 viewport;
-
-		switch (adev->asic_type) {
-		case CHIP_RAVEN:
-		case CHIP_RENOIR:
-			viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
-			size = (REG_GET_FIELD(viewport,
-					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
-				REG_GET_FIELD(viewport,
-					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
-				4);
-			break;
-		case CHIP_VEGA10:
-		case CHIP_VEGA12:
-		case CHIP_VEGA20:
-		default:
-			viewport = RREG32_SOC15(DCE, 0, mmSCL0_VIEWPORT_SIZE);
-			size = (REG_GET_FIELD(viewport, SCL0_VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
-				REG_GET_FIELD(viewport, SCL0_VIEWPORT_SIZE, VIEWPORT_WIDTH) *
-				4);
-			break;
-		}
-	}
-	/* return 0 if the pre-OS buffer uses up most of vram */
-	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
-		return 0;
-
-	return size;
-}
-
 static int gmc_v9_0_sw_init(void *handle)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
@@ -1242,8 +1207,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.keep_stolen_vga_memory = gmc_v9_0_keep_stolen_memory(adev);
-	adev->gmc.stolen_vga_size = gmc_v9_0_get_vbios_fb_size(adev);
+	amdgpu_gmc_get_vbios_allocations(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
