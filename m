Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E367AC433F7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDB9225AA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDkM+kKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDB9225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7328D6E837;
	Tue, 14 Jul 2020 18:24:29 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D036E832
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:26 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id m8so7931665qvk.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UR3kIBakDiq5Rx89plrMyb3CSbBByoEZLuAz/OxS4F8=;
 b=nDkM+kKEl9HZVcUNcv5k8wQumK834oQdgnLrELgtoQO9NnCE2yIfvWMxHtyTQbwspR
 TFGXBVGOH8vSvqYvkhjxGHyk4xhlXRRjzuaezarR6RfZtidpf4i19/T51JCR6Qke4roM
 eYM1JpW10hwxZX6zhtGTlPqzoDbADOZvkFFXy4qFVUn2DDrwvfjWB/KtwpwrPTkI2pio
 msO1CUyjcuK57XLVViJm4LP+T85OKiw5Zr0x0lj0iIQLsKMvYh/KygcV5j76/V1BxJ3x
 4BwZUpkCZ1ORf/MrXwgf27l/6wcBODFxzQv5sMPLi5+p2IirFGJJutiJSYmQ86Uv6IQK
 AAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UR3kIBakDiq5Rx89plrMyb3CSbBByoEZLuAz/OxS4F8=;
 b=RITt2dS+4ZEjOxCQo2tfNXCgnajc8crmpLiRA96gLBcfJGmaRyvKC1gZzqvYJnG5TY
 KA8GdGv4JlNKSTVoS6+930KYAK8E5KbrdfkJUC/h9baXn9Lt30+qKswRMp4ZV9MZ4TBF
 CDE88eaR/tV1l9Dqbz8jkUekHaLylzJR9uUityyDzJYFrwnxg8N5VNAbgGiuDcKzoRti
 Dhn9ZGwKfEOa7IH7zg7xXiZlPBbvxnQXwBjeKPcT6ZLTiYZ9TtsJQRnWYYKuaAko6zaI
 xdgtaAG2CyjfkLLhs9l6zBM9DPiQ6eGCWS+afywIjkTc5Xp1t6hO05cbBvQ2fVhhBwBq
 43ZA==
X-Gm-Message-State: AOAM5305MmhUp3mGXBILHYredgJaxyceck/DN4bWYVQu1VzsGJEu24Y1
 926IVxCIhPugWApXijE8Ne6swFaF
X-Google-Smtp-Source: ABdhPJxX+hXBAgK2pAL8apLoMHP/BORcKl17rsbwfaAPNd71PokHVLvjGUkuqpLDYcRS+ncivWJM/Q==
X-Received: by 2002:a0c:aa41:: with SMTP id e1mr5698090qvb.117.1594751065532; 
 Tue, 14 Jul 2020 11:24:25 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:25 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/42] drm/amdgpu: add gmc ip block for navy_flounder
Date: Tue, 14 Jul 2020 14:23:24 -0400
Message-Id: <20200714182353.2164930-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

navy_flounder has similar gc IP version with sienna_cichlid,
follow its setting for the moment.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <Tao.Zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 18 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/nv.c        |  1 +
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2bf112fc8185..55fedadd78c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -693,7 +693,8 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 {
 	u64 base = 0;
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		base = gfxhub_v2_1_get_fb_location(adev);
 	else
 		base = gfxhub_v2_0_get_fb_location(adev);
@@ -705,7 +706,8 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_gart_location(adev, mc);
 
 	/* base offset of vram pages */
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		adev->vm_manager.vram_base_offset = gfxhub_v2_1_get_mc_fb_offset(adev);
 	else
 		adev->vm_manager.vram_base_offset = gfxhub_v2_0_get_mc_fb_offset(adev);
@@ -822,7 +824,8 @@ static int gmc_v10_0_sw_init(void *handle)
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		gfxhub_v2_1_init(adev);
 	else
 		gfxhub_v2_0_init(adev);
@@ -980,7 +983,8 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		r = gfxhub_v2_1_gart_enable(adev);
 	else
 		r = gfxhub_v2_0_gart_enable(adev);
@@ -1004,7 +1008,8 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		gfxhub_v2_1_set_fault_enable_default(adev, value);
 	else
 		gfxhub_v2_0_set_fault_enable_default(adev, value);
@@ -1045,7 +1050,8 @@ static int gmc_v10_0_hw_init(void *handle)
  */
 static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		gfxhub_v2_1_gart_disable(adev);
 	else
 		gfxhub_v2_0_gart_disable(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 91b4d4e27a13..bc0181da25d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -510,6 +510,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_NAVY_FLOUNDER:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
