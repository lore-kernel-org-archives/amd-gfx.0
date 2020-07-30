Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26744C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0343207F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVHqjKQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0343207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96516E96A;
	Thu, 30 Jul 2020 20:04:46 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8786E966
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:45 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id l13so6756562qvt.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3h7+47C10uNtgr0TxcOz+R3XZON1T+Tc5FDnPO34Qzo=;
 b=OVHqjKQSsbGNqRBKWb6/g8gg5FcDUvopsE90ulxWG4Vnb9GBY2yMZLUZyPMjyTd+rq
 lHk1en2PKTNZiN2R94EfQume9ef5ZsRJYchd9i3Qpnp1IN64LY2AB8UhVl1fQJNxDvgI
 ktWrpWfZpQQAIuX681feFuOtDSQWC09GDX14vYMnmkalCvNKA1izstIgtSttOs/ydsuN
 fDA84gmnurLc7xCCGID4Ig2+FJf4D9MNpGTNlqyHB8jDurR0tscF++0iniuZONXvzbzK
 E0z/uEKbqPHq5D05eiWmPflp+E93njnmLy92oc9zwk+O9vxHpTmZGZFG4XsrXmwC+n/i
 PXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3h7+47C10uNtgr0TxcOz+R3XZON1T+Tc5FDnPO34Qzo=;
 b=LaaN0gzyXXd7i+b9gq/O0Nqrgv7lxalNzrUzxNfxKgBnnyzl1/JiEbB4J2hZ3heuh7
 /zC+Cpq03R5A5cgdjVXQgAxicX39UYJtjI+5okBe7Ild6hKB8K+wTwxKMsnAELv3SZsO
 yyGFTNcwdmSXw6kIbb4sxMQDqlj+AhefTteiu9C1MBEGX90+wEeIyvkrrKa2F5URskJ4
 tg4Ct1Zazkik/DpeDd6tR7F+hZOrvYl3eM/Z1MAZKUrr2Pj2lKVbArEEoOv368lMG+YO
 Yz3xJG9vTJ5ZRSnDCyEO3/qo64ezJKQq5TEs/P/mqEK6iptnh76NbGDQdpaqkkCFX1mj
 4Mzg==
X-Gm-Message-State: AOAM532L5d3g0iEseNKPfK80UJ16hllkSwuFi5PFzViSQgMv0wekHClW
 9ILfIrcyDpXhCKaBvLxd8PWmNrD7
X-Google-Smtp-Source: ABdhPJyGDOXtR5ja2B3rAe9ZlwAgjuIls6fmhlMCMQ/mJFtsCkaYDe2wcpLdGLDvatdG+LNbSpxhew==
X-Received: by 2002:a05:6214:849:: with SMTP id
 dg9mr800353qvb.165.1596139481208; 
 Thu, 30 Jul 2020 13:04:41 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/17] drm/amdgpu: move vram usage by vbios to mman (v2)
Date: Thu, 30 Jul 2020 16:04:14 -0400
Message-Id: <20200730200414.40485-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200730200414.40485-1-alexander.deucher@amd.com>
References: <20200730200414.40485-1-alexander.deucher@amd.com>
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

It's related to the memory manager so move it there.

v2: inline the structure

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 12 -----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  4 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 20 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  6 +++---
 6 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 44fd0ef7394f..81f6412eb54f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -649,16 +649,6 @@ struct amdgpu_atcs {
 	struct amdgpu_atcs_functions functions;
 };
 
-/*
- * Firmware VRAM reservation
- */
-struct amdgpu_fw_vram_usage {
-	u64 start_offset;
-	u64 size;
-	struct amdgpu_bo *reserved_bo;
-	void *va;
-};
-
 /*
  * CGS
  */
@@ -942,8 +932,6 @@ struct amdgpu_device {
 	struct delayed_work     delayed_init_work;
 
 	struct amdgpu_virt	virt;
-	/* firmware VRAM reservation */
-	struct amdgpu_fw_vram_usage fw_vram_usage;
 
 	/* link all shadow bo */
 	struct list_head                shadow_list;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 29f767e026e4..e33f63712b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1786,9 +1786,9 @@ static int amdgpu_atombios_allocate_fb_scratch(struct amdgpu_device *adev)
 			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
 			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
 			/* Firmware request VRAM reservation for SR-IOV */
-			adev->fw_vram_usage.start_offset = (start_addr &
+			adev->mman.fw_vram_usage_start_offset = (start_addr &
 				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-			adev->fw_vram_usage.size = size << 10;
+			adev->mman.fw_vram_usage_size = size << 10;
 			/* Use the default scratch size */
 			usage_bytes = 0;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 1279053324f9..17c010d0431f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -89,9 +89,9 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
 			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
 			/* Firmware request VRAM reservation for SR-IOV */
-			adev->fw_vram_usage.start_offset = (start_addr &
+			adev->mman.fw_vram_usage_start_offset = (start_addr &
 				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-			adev->fw_vram_usage.size = size << 10;
+			adev->mman.fw_vram_usage_size = size << 10;
 			/* Use the default scratch size */
 			usage_bytes = 0;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ea9b5b39f640..c7421aa32946 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1766,8 +1766,8 @@ static struct ttm_bo_driver amdgpu_bo_driver = {
  */
 static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
 {
-	amdgpu_bo_free_kernel(&adev->fw_vram_usage.reserved_bo,
-		NULL, &adev->fw_vram_usage.va);
+	amdgpu_bo_free_kernel(&adev->mman.fw_vram_usage_reserved_bo,
+		NULL, &adev->mman.fw_vram_usage_va);
 }
 
 /**
@@ -1781,19 +1781,19 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 {
 	uint64_t vram_size = adev->gmc.visible_vram_size;
 
-	adev->fw_vram_usage.va = NULL;
-	adev->fw_vram_usage.reserved_bo = NULL;
+	adev->mman.fw_vram_usage_va = NULL;
+	adev->mman.fw_vram_usage_reserved_bo = NULL;
 
-	if (adev->fw_vram_usage.size == 0 ||
-	    adev->fw_vram_usage.size > vram_size)
+	if (adev->mman.fw_vram_usage_size == 0 ||
+	    adev->mman.fw_vram_usage_size > vram_size)
 		return 0;
 
 	return amdgpu_bo_create_kernel_at(adev,
-					  adev->fw_vram_usage.start_offset,
-					  adev->fw_vram_usage.size,
+					  adev->mman.fw_vram_usage_start_offset,
+					  adev->mman.fw_vram_usage_size,
 					  AMDGPU_GEM_DOMAIN_VRAM,
-					  &adev->fw_vram_usage.reserved_bo,
-					  &adev->fw_vram_usage.va);
+					  &adev->mman.fw_vram_usage_reserved_bo,
+					  &adev->mman.fw_vram_usage_va);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6d7b83d967ce..de37ceff0e56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -70,6 +70,12 @@ struct amdgpu_mman {
 	uint8_t				*discovery_bin;
 	uint32_t			discovery_tmr_size;
 	struct amdgpu_bo		*discovery_memory;
+
+	/* firmware VRAM reservation */
+	u64		fw_vram_usage_start_offset;
+	u64		fw_vram_usage_size;
+	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
+	void		*fw_vram_usage_va;
 };
 
 struct amdgpu_copy_mem {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 5cae39d35c04..1e211544f2dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -401,7 +401,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page = *(uint64_t *)(adev->fw_vram_usage.va +
+			retired_page = *(uint64_t *)(adev->mman.fw_vram_usage_va +
 					bp_block_offset + bp_idx * sizeof(uint64_t));
 			bp.retired_page = retired_page;
 
@@ -428,10 +428,10 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 
-	if (adev->fw_vram_usage.va != NULL) {
+	if (adev->mman.fw_vram_usage_va != NULL) {
 		adev->virt.fw_reserve.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)(
-			adev->fw_vram_usage.va + AMDGIM_DATAEXCHANGE_OFFSET);
+			adev->mman.fw_vram_usage_va + AMDGIM_DATAEXCHANGE_OFFSET);
 		AMDGPU_FW_VRAM_PF2VF_READ(adev, header.size, &pf2vf_size);
 		AMDGPU_FW_VRAM_PF2VF_READ(adev, checksum, &checksum);
 		AMDGPU_FW_VRAM_PF2VF_READ(adev, feature_flags, &adev->virt.gim_feature);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
