Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C68C433F7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFD3207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpVxR+sH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFD3207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0116E438;
	Tue, 28 Jul 2020 22:46:45 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA9C6E432
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:43 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id r19so1467938qvw.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=quHur1UKdviZ+7rMPm8RBeSB7ZpACm44q00zH3/NPdI=;
 b=mpVxR+sHv3xMDps2iA6rollO1pnigMP8JfAqjo/eHkUe+/GkAyqVKDdA9NvlKWk4jk
 basRRC+zICMMzVzKM7fdaL3mfepwKLg3xM3eQrm8wzOFZFbnud8+qc5VTUYaqfOP1Apm
 yQIxMd879dNnGIAPf6J444flpNa7Afc8YVtJmRLnbb9i3qc9mOpLzdrQJ4O/oVH8HxcP
 Rtx09A/FLgZg02LPwPOZyNJDYi/yk7a1bbuwwKeoAEoTbvTM7nXsSPTmy2rd0OoF8+dc
 1Tm9lh9M3bjgrIdkMHArDCaKDlKOw9vy0DwwXtgbjvWgpBpXrv+zRPVEOp5B/8lUKCWo
 cATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=quHur1UKdviZ+7rMPm8RBeSB7ZpACm44q00zH3/NPdI=;
 b=KcLZ2nysg/G5WrnjbQfmf0rjCctSzlzlxukB+dMX7/IO2oz8yyfpE/ai++qieMB2X/
 2UT5AZ24dBqD7cd0pMwfFWSs3/raQWhcARe1lgRdaWENnDCGc9DNBupzQrPoifV8nHsV
 faRQlrdq0lmJZJ3zFjKmYzdDoDlRPC/Niutt+ej8k2PPvl1nMazdOqXaNXbtzKFXTQYS
 kYCywy/A1ocITTwcPXQtq5QXO05FK9AT+AoZI9t6t+vmgJq7fq8Fsl2glZy0Pd2sKv7n
 JqnzLseXZajFsUqNDRJnQTVbAHymgLO1L5+vlm2RBBcecksrKnua+7cVTMqKro76WRkI
 Cnrw==
X-Gm-Message-State: AOAM533AvGaeHHBznOXdnJLBot7mS73jmFybZrMvLOqq6tJdQ0gK1906
 iGWikTyF2Z70q1XKQUEgWqT/ROUr
X-Google-Smtp-Source: ABdhPJzw+jhMbzmKfUcjVYcgyCedMOebPRGZjRkELboWqtqHBlpAoI07E06qcVAwvAgQx50+5n7RXg==
X-Received: by 2002:ad4:49aa:: with SMTP id u10mr8852184qvx.27.1595976402609; 
 Tue, 28 Jul 2020 15:46:42 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:42 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/14] drm/amdgpu/gmc10: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Tue, 28 Jul 2020 18:46:03 -0400
Message-Id: <20200728224605.3919-13-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 57 +++++++++++---------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 337d70503970..fcde302d3eb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -553,6 +553,28 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 }
 
+static unsigned gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
+{
+	u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
+	unsigned size;
+
+	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
+	} else {
+		u32 viewport;
+		u32 pitch;
+
+		viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
+		pitch = RREG32_SOC15(DCE, 0, mmHUBPREQ0_DCSURF_SURFACE_PITCH);
+		size = (REG_GET_FIELD(viewport,
+					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
+				4);
+	}
+
+	return size;
+}
+
 static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v10_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
@@ -560,7 +582,8 @@ static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
 	.map_mtype = gmc_v10_0_map_mtype,
 	.get_vm_pde = gmc_v10_0_get_vm_pde,
-	.get_vm_pte = gmc_v10_0_get_vm_pte
+	.get_vm_pte = gmc_v10_0_get_vm_pte,
+	.get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
 };
 
 static void gmc_v10_0_set_gmc_funcs(struct amdgpu_device *adev)
@@ -701,36 +724,6 @@ static int gmc_v10_0_gart_init(struct amdgpu_device *adev)
 	return amdgpu_gart_table_vram_alloc(adev);
 }
 
-static unsigned gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
-{
-	u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
-	unsigned size;
-
-	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = AMDGPU_VBIOS_VGA_ALLOCATION;
-	} else {
-		u32 viewport;
-		u32 pitch;
-
-		viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
-		pitch = RREG32_SOC15(DCE, 0, mmHUBPREQ0_DCSURF_SURFACE_PITCH);
-		size = (REG_GET_FIELD(viewport,
-					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
-				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
-				4);
-	}
-	/* return 0 if the pre-OS buffer uses up most of vram */
-	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024)) {
-		DRM_ERROR("Warning: pre-OS buffer uses most of vram, \
-				be aware of gart table overwrite\n");
-		return 0;
-	}
-
-	return size;
-}
-
-
-
 static int gmc_v10_0_sw_init(void *handle)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
@@ -812,7 +805,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_vga_size = gmc_v10_0_get_vbios_fb_size(adev);
+	amdgpu_gmc_get_vbios_allocations(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
