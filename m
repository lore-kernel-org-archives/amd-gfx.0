Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B8C433E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E204207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx00VDPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E204207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2D86E42E;
	Tue, 28 Jul 2020 22:46:38 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994926E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:37 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id e5so2198625qth.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KvlN5h3I/sq4JVwaR0ni7SE6XGuaI/d/dAxHvRwyDF8=;
 b=nx00VDPyQPsjiX8pGpP4751c0Q8Ldh0j+0QVJpvzoykevaLoImEgDwAzSvvmPASGj9
 ZGEd34xXCEjCt3Nz9HJGvIxvDDUVe5Q/WafnivqxG/pZU5nbFY7bOtvRC8B0cBdK4znK
 lbdJWmuBbOwhgMTBjVmyQVD0rt91awhh65jAa01Nelm3f+J65XzXCaCSf5gs3jJxGCc8
 XsbRVPwo5GpZDveojbhiuyRMhqU4JTuD8H2DEO4XJUfX4g1cc0orlTN7bubrmusp7KjW
 +uA/XO7A7UefnS1m5aXgVGhZj6QXrlj8qMCIElHBnpshqsVrEi58HNx0Puu7M5VR/gwc
 py9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KvlN5h3I/sq4JVwaR0ni7SE6XGuaI/d/dAxHvRwyDF8=;
 b=TBlGGTKv8KwNxwWXTPDHtYU/lny5Fj0NRtECv2+EON55DmpvpFk1Loq59NYbL/k36Q
 HGXwGelZxm6/mX7+WzFOFRfwwl0Agl8PSsLoUVHfyVNTDtWvscYQoPPKsemhPZDC1yze
 SsdhYgGEzkz5pr944862ll07lPKBdF/ca6/aDVXOaDt/OBliQ0yBfbmKo+KaI9xDJO0p
 osxo5jDJY3AYCbAN/GwFTwQ9QiuZFPT8kfmm8FvcSckDtJ/a14BHW52iyAXXUx8wtC9L
 r02yaxyB7S9oA3eIWGrzvXtj9xWyE2VSq779wTPpkBEXXI7nBEPMkCSo97bCorrdoVkN
 v9zA==
X-Gm-Message-State: AOAM531+FDZSula3qLuV2aldF+o0N9tvyybYAeymTuDp7V/rCbmaSyLt
 6Zg5WhYbcGxTkBy/+5uGoasTtQcX
X-Google-Smtp-Source: ABdhPJz2OEzaAadWQwTE8bq4as79P+5ZUrkiLjusQ3MZpMFPml1bhg81UTH2CAuA9ZyJDN/Iio5iDA==
X-Received: by 2002:ac8:42c8:: with SMTP id g8mr3648257qtm.97.1595976396569;
 Tue, 28 Jul 2020 15:46:36 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/14] drm/amdgpu: move keep stolen memory check into gmc core
Date: Tue, 28 Jul 2020 18:45:56 -0400
Message-Id: <20200728224605.3919-6-alexander.deucher@amd.com>
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

Rather than leaving this as a gmc v9 specific hack.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 +++--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index ddb64be670c2..0cf18f01e67a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -215,6 +215,7 @@ struct amdgpu_gmc {
 	bool			prt_warning;
 	uint64_t		stolen_vga_size;
 	struct amdgpu_bo	*stolen_vga_memory;
+	bool			keep_stolen_vga_memory;
 	uint32_t		sdpif_register;
 	/* apertures */
 	u64			shared_aperture_start;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 39781127d059..fd61769202b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2042,8 +2042,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 void amdgpu_ttm_late_init(struct amdgpu_device *adev)
 {
 	void *stolen_vga_buf;
+
 	/* return the VGA stolen memory (if any) back to VRAM */
-	amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
+	if (!adev->gmc.keep_stolen_vga_memory)
+		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
 }
 
 /**
@@ -2051,10 +2053,15 @@ void amdgpu_ttm_late_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
+	void *stolen_vga_buf;
+
 	if (!adev->mman.initialized)
 		return;
 
 	amdgpu_ttm_training_reserve_vram_fini(adev);
+	/* return the stolen vga memory back to VRAM */
+	if (adev->gmc.keep_stolen_vga_memory)
+		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
 	/* return the IP Discovery TMR memory back to VRAM */
 	amdgpu_bo_free_kernel(&adev->discovery_memory, NULL, NULL);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b66c60680dba..c5d2e4390fba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -932,8 +932,7 @@ static int gmc_v9_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	if (!gmc_v9_0_keep_stolen_memory(adev))
-		amdgpu_bo_late_init(adev);
+	amdgpu_bo_late_init(adev);
 
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
@@ -1076,7 +1075,7 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	 * TODO Remove once GART corruption is resolved
 	 * Check related code in gmc_v9_0_sw_fini
 	 * */
-	if (gmc_v9_0_keep_stolen_memory(adev))
+	if (adev->gmc.keep_stolen_vga_memory)
 		return AMDGPU_VBIOS_VGA_ALLOCATION;
 
 	d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
@@ -1243,6 +1242,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	adev->gmc.keep_stolen_vga_memory = gmc_v9_0_keep_stolen_memory(adev);
 	adev->gmc.stolen_vga_size = gmc_v9_0_get_vbios_fb_size(adev);
 
 	/* Memory manager */
@@ -1275,15 +1275,10 @@ static int gmc_v9_0_sw_init(void *handle)
 static int gmc_v9_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	void *stolen_vga_buf;
 
 	amdgpu_gmc_ras_fini(adev);
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
-
-	if (gmc_v9_0_keep_stolen_memory(adev))
-		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
-
 	amdgpu_gart_table_vram_free(adev);
 	amdgpu_bo_fini(adev);
 	amdgpu_gart_fini(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
