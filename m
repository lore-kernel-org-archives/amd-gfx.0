Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B265DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE972075F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bspGLr+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE972075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D46E6E5D4;
	Wed, 29 Jul 2020 17:35:12 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA5B6E5CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:35:06 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id x12so9745523qtp.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mna0avq8tH9ZcmAFkxZHqlv0gToIMbW0Z++vmAsXR1I=;
 b=bspGLr+uuwAXtRFUyEjh/igcon0oRpVHv7IXlRjnTbkfuS531w+axmK+cSJAGjc08F
 c9/w5ygGXGknm5Tcx2a9Pe25zKSJqjsmjJKF/Z/LsM+70QqVEHzExmACJHyfG6InaXLP
 jraFUXcg9pUyMP2MoYNM5r4gVKj5pe/t9lbTMaa355g08m6Hny6ANQS/MhV5RPrAIinh
 cOIR7ITLuhJZ5PN8eYyQ48Y8whrgk45Br7/RThKPbFOv+w31FoTw8Sc8GRbFwOWoIdH3
 1sLPSK2oHkchIQQEkz/mFlpOMOP3H8X47zH2hQrYJUr7xLc/urZRk8fLmwGAGxqN1IAi
 FIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mna0avq8tH9ZcmAFkxZHqlv0gToIMbW0Z++vmAsXR1I=;
 b=V4ejuCJZW0qQS2wYQy6DBL/s5/tKtoyM+Xu/3DpluyKytMT02U+OOl1cRXcKxDunii
 OWnCti+BAqf/XJSrz2IKjMaNGK6adoMLmRoQb1ZdUD0bKCTNi74+AvVWHw22rOtDE2Ti
 N1104ir9ZqHmlH+YdzRHYoKQiSpV/HrEGSyZQ7oP2yf1WSQHWdNE4Ww/NMHVnUmtP1X5
 4qcnIjNjtsKIIU+n3/zpJisaH8lbuchoAa/6N2m/fLIvBHb1RTaUBj3piWzcHCUKPJWT
 W0zJTE2NbQWZ3j47g7wbnC+W4cXlIYissiv0kpnxzmTUW2Uti6zcv+kFDJxsxmwkVHm/
 s9zg==
X-Gm-Message-State: AOAM531OXqnkV5iwTxavTeBhxyrzQk5oJMmcpYAqvCxVq8a8vJ4LoRhk
 VHcmxjOGSAR1BP8tq4UiXp8mMqli
X-Google-Smtp-Source: ABdhPJzxSirePHkx9kPuonSCbXt46lSFu61UGJeSxYF2vCl4/x0hPspJEUpj1QEOyFGSsFlplDdxVA==
X-Received: by 2002:ac8:67da:: with SMTP id r26mr25152988qtp.332.1596044105182; 
 Wed, 29 Jul 2020 10:35:05 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:35:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/17] drm/amdgpu: move vram usage by vbios to mman
Date: Wed, 29 Jul 2020 13:34:39 -0400
Message-Id: <20200729173439.3698-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729173439.3698-1-alexander.deucher@amd.com>
References: <20200729173439.3698-1-alexander.deucher@amd.com>
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 12 -----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  4 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 20 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 13 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  6 +++---
 6 files changed, 30 insertions(+), 29 deletions(-)

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
index 29f767e026e4..681f2ef739b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1786,9 +1786,9 @@ static int amdgpu_atombios_allocate_fb_scratch(struct amdgpu_device *adev)
 			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
 			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
 			/* Firmware request VRAM reservation for SR-IOV */
-			adev->fw_vram_usage.start_offset = (start_addr &
+			adev->mman.fw_vram_usage.start_offset = (start_addr &
 				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-			adev->fw_vram_usage.size = size << 10;
+			adev->mman.fw_vram_usage.size = size << 10;
 			/* Use the default scratch size */
 			usage_bytes = 0;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 1279053324f9..07a835d42b72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -89,9 +89,9 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
 			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
 			/* Firmware request VRAM reservation for SR-IOV */
-			adev->fw_vram_usage.start_offset = (start_addr &
+			adev->mman.fw_vram_usage.start_offset = (start_addr &
 				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-			adev->fw_vram_usage.size = size << 10;
+			adev->mman.fw_vram_usage.size = size << 10;
 			/* Use the default scratch size */
 			usage_bytes = 0;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ea9b5b39f640..f81a33f79517 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1766,8 +1766,8 @@ static struct ttm_bo_driver amdgpu_bo_driver = {
  */
 static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
 {
-	amdgpu_bo_free_kernel(&adev->fw_vram_usage.reserved_bo,
-		NULL, &adev->fw_vram_usage.va);
+	amdgpu_bo_free_kernel(&adev->mman.fw_vram_usage.reserved_bo,
+		NULL, &adev->mman.fw_vram_usage.va);
 }
 
 /**
@@ -1781,19 +1781,19 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 {
 	uint64_t vram_size = adev->gmc.visible_vram_size;
 
-	adev->fw_vram_usage.va = NULL;
-	adev->fw_vram_usage.reserved_bo = NULL;
+	adev->mman.fw_vram_usage.va = NULL;
+	adev->mman.fw_vram_usage.reserved_bo = NULL;
 
-	if (adev->fw_vram_usage.size == 0 ||
-	    adev->fw_vram_usage.size > vram_size)
+	if (adev->mman.fw_vram_usage.size == 0 ||
+	    adev->mman.fw_vram_usage.size > vram_size)
 		return 0;
 
 	return amdgpu_bo_create_kernel_at(adev,
-					  adev->fw_vram_usage.start_offset,
-					  adev->fw_vram_usage.size,
+					  adev->mman.fw_vram_usage.start_offset,
+					  adev->mman.fw_vram_usage.size,
 					  AMDGPU_GEM_DOMAIN_VRAM,
-					  &adev->fw_vram_usage.reserved_bo,
-					  &adev->fw_vram_usage.va);
+					  &adev->mman.fw_vram_usage.reserved_bo,
+					  &adev->mman.fw_vram_usage.va);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6d7b83d967ce..95a513f7785f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -41,6 +41,16 @@
 
 #define AMDGPU_POISON	0xd0bed0be
 
+/*
+ * Firmware VRAM reservation
+ */
+struct amdgpu_fw_vram_usage {
+	u64 start_offset;
+	u64 size;
+	struct amdgpu_bo *reserved_bo;
+	void *va;
+};
+
 struct amdgpu_mman {
 	struct ttm_bo_device		bdev;
 	bool				mem_global_referenced;
@@ -70,6 +80,9 @@ struct amdgpu_mman {
 	uint8_t				*discovery_bin;
 	uint32_t			discovery_tmr_size;
 	struct amdgpu_bo		*discovery_memory;
+
+	/* firmware VRAM reservation */
+	struct amdgpu_fw_vram_usage fw_vram_usage;
 };
 
 struct amdgpu_copy_mem {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 5cae39d35c04..816e086f00d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -401,7 +401,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page = *(uint64_t *)(adev->fw_vram_usage.va +
+			retired_page = *(uint64_t *)(adev->mman.fw_vram_usage.va +
 					bp_block_offset + bp_idx * sizeof(uint64_t));
 			bp.retired_page = retired_page;
 
@@ -428,10 +428,10 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 
-	if (adev->fw_vram_usage.va != NULL) {
+	if (adev->mman.fw_vram_usage.va != NULL) {
 		adev->virt.fw_reserve.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)(
-			adev->fw_vram_usage.va + AMDGIM_DATAEXCHANGE_OFFSET);
+			adev->mman.fw_vram_usage.va + AMDGIM_DATAEXCHANGE_OFFSET);
 		AMDGPU_FW_VRAM_PF2VF_READ(adev, header.size, &pf2vf_size);
 		AMDGPU_FW_VRAM_PF2VF_READ(adev, checksum, &checksum);
 		AMDGPU_FW_VRAM_PF2VF_READ(adev, feature_flags, &adev->virt.gim_feature);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
