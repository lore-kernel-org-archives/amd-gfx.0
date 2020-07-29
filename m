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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB7BC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740D42075F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwcXHrK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740D42075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8EF6E5D3;
	Wed, 29 Jul 2020 17:35:10 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414856E5CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:35:05 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id s15so6791019qvv.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LgAhK4OrGS6Jre9cF2gt35LJdMExFo4Mfh8n5sROl1Q=;
 b=LwcXHrK8MzTgt3d5aA7XrETfS/8ciD71+9whVbl6sY6aXfWjYgde0NFWO1ltR6/1st
 fVu9XJGM6KGlOSdFO89RKn6dL2iy5/Qyi16YnoeElilhqF2lICncVCIDG0g+rRd0smKE
 sgk/khcnbRIPWt/actd8UsXW5TnG8HN63ILbOgGHPtNRS6WsYNecgcdIsqCRM68HdCjf
 vOwXiE/qXkwenS+riwfU15oaehDDfQIysws3OsVHMvHejj0de11lNsi1J9yfAhN3pGSR
 6FnISyC6WtsoE9DTlCGRJBQ++0eoXWcQYPAv+yh48Z/LrrMismpLweRLaDYyY24w1NLa
 L1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LgAhK4OrGS6Jre9cF2gt35LJdMExFo4Mfh8n5sROl1Q=;
 b=SLRom2SSrpzmqdLLqBRgZ0SnRURDUONCNSgyMHueoeyfWZCyW1Z6Q2BrqQeDYhb/ml
 /OGJ6gB4cviMOKVI13VZ0i6YjlNgNBisaEORNPZvHPmg870CaH8T92whrainqv0QOQK7
 QYD08e3O+7vY9BNgQ3Vv2g9I8i4CtWvmnHEYT8UGe5nuxJuNTFOO8fH4AUnDHfRLXPnf
 zf0sExxjowVCuGyXjOrV/jNj5bqaYpJPBtVyfvGyXmauvGrzptxyKA2ATSm9phs1DGiw
 DZVrHNjOaEp7ezQXg+rQlMPMXi0vYslxJ+uo3dTgadfOG3cGwuyqTNC1KVmFKQDSOkxc
 B44g==
X-Gm-Message-State: AOAM533ci2OXR+8L/7m+vCcZf/DWyZ88bTLlsaL4dNA7aeb4Jao5hgIm
 f0Qvyrp2YKp6qfENBcnj7icfEfv6
X-Google-Smtp-Source: ABdhPJxppunP8RnYmD74IFRi3e5UAQ+zR+p0LdlblNcPMmZ2tPhSwwZa999GLwKB/aktFImUvp9jTg==
X-Received: by 2002:ad4:4d83:: with SMTP id cv3mr34011078qvb.236.1596044103884; 
 Wed, 29 Jul 2020 10:35:03 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:35:03 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/17] drm/amdgpu: move IP discovery data to mman
Date: Wed, 29 Jul 2020 13:34:38 -0400
Message-Id: <20200729173439.3698-17-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 54 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 20 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  5 ++
 5 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 899664357015..44fd0ef7394f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -918,11 +918,6 @@ struct amdgpu_device {
 	/* display related functionality */
 	struct amdgpu_display_manager dm;
 
-	/* discovery */
-	uint8_t				*discovery_bin;
-	uint32_t			discovery_tmr_size;
-	struct amdgpu_bo		*discovery_memory;
-
 	/* mes */
 	bool                            enable_mes;
 	struct amdgpu_mes               mes;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 638c2cc426c1..461840455f59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1563,7 +1563,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 
 	adev->firmware.gpu_info_fw = NULL;
 
-	if (adev->discovery_bin) {
+	if (adev->mman.discovery_bin) {
 		amdgpu_discovery_get_gfx_info(adev);
 
 		/*
@@ -3415,7 +3415,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
-	if (adev->discovery_bin)
+	if (adev->mman.discovery_bin)
 		amdgpu_discovery_fini(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a50ff2306504..bfb95143ba5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -136,7 +136,7 @@ static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *bin
 	uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 
 	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
-				  adev->discovery_tmr_size, false);
+				  adev->mman.discovery_tmr_size, false);
 	return 0;
 }
 
@@ -168,18 +168,18 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	uint16_t checksum;
 	int r;
 
-	adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
-	adev->discovery_bin = kzalloc(adev->discovery_tmr_size, GFP_KERNEL);
-	if (!adev->discovery_bin)
+	adev->mman.discovery_tmr_size = DISCOVERY_TMR_SIZE;
+	adev->mman.discovery_bin = kzalloc(adev->mman.discovery_tmr_size, GFP_KERNEL);
+	if (!adev->mman.discovery_bin)
 		return -ENOMEM;
 
-	r = amdgpu_discovery_read_binary(adev, adev->discovery_bin);
+	r = amdgpu_discovery_read_binary(adev, adev->mman.discovery_bin);
 	if (r) {
 		DRM_ERROR("failed to read ip discovery binary\n");
 		goto out;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery_bin;
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 
 	if (le32_to_cpu(bhdr->binary_signature) != BINARY_SIGNATURE) {
 		DRM_ERROR("invalid ip discovery binary signature\n");
@@ -192,7 +192,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	size = bhdr->binary_size - offset;
 	checksum = bhdr->binary_checksum;
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      size, checksum)) {
 		DRM_ERROR("invalid ip discovery binary checksum\n");
 		r = -EINVAL;
@@ -202,7 +202,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	info = &bhdr->table_list[IP_DISCOVERY];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
-	ihdr = (struct ip_discovery_header *)(adev->discovery_bin + offset);
+	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin + offset);
 
 	if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
 		DRM_ERROR("invalid ip discovery data table signature\n");
@@ -210,7 +210,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      ihdr->size, checksum)) {
 		DRM_ERROR("invalid ip discovery data table checksum\n");
 		r = -EINVAL;
@@ -220,9 +220,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	info = &bhdr->table_list[GC];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
-	ghdr = (struct gpu_info_header *)(adev->discovery_bin + offset);
+	ghdr = (struct gpu_info_header *)(adev->mman.discovery_bin + offset);
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 				              ghdr->size, checksum)) {
 		DRM_ERROR("invalid gc data table checksum\n");
 		r = -EINVAL;
@@ -232,16 +232,16 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	return 0;
 
 out:
-	kfree(adev->discovery_bin);
-	adev->discovery_bin = NULL;
+	kfree(adev->mman.discovery_bin);
+	adev->mman.discovery_bin = NULL;
 
 	return r;
 }
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
-	kfree(adev->discovery_bin);
-	adev->discovery_bin = NULL;
+	kfree(adev->mman.discovery_bin);
+	adev->mman.discovery_bin = NULL;
 }
 
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
@@ -265,8 +265,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery_bin;
-	ihdr = (struct ip_discovery_header *)(adev->discovery_bin +
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
 			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
@@ -274,7 +274,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->discovery_bin + die_offset);
+		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
@@ -288,7 +288,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				le16_to_cpu(dhdr->die_id), num_ips);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->discovery_bin + ip_offset);
+			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
 			num_base_address = ip->num_base_address;
 
 			DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
@@ -337,24 +337,24 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
 	uint16_t num_ips;
 	int i, j;
 
-	if (!adev->discovery_bin) {
+	if (!adev->mman.discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery_bin;
-	ihdr = (struct ip_discovery_header *)(adev->discovery_bin +
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
 			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->discovery_bin + die_offset);
+		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->discovery_bin + ip_offset);
+			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
 
 			if (le16_to_cpu(ip->hw_id) == hw_id) {
 				if (major)
@@ -377,13 +377,13 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct gc_info_v1_0 *gc_info;
 
-	if (!adev->discovery_bin) {
+	if (!adev->mman.discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery_bin;
-	gc_info = (struct gc_info_v1_0 *)(adev->discovery_bin +
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	gc_info = (struct gc_info_v1_0 *)(adev->mman.discovery_bin +
 			le16_to_cpu(bhdr->table_list[GC].offset));
 
 	adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->gc_num_se);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index cc1a5b2876b6..ea9b5b39f640 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1825,7 +1825,7 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 	memset(ctx, 0, sizeof(*ctx));
 
 	ctx->c2p_train_data_offset =
-		ALIGN((adev->gmc.mc_vram_size - adev->discovery_tmr_size - SZ_1M), SZ_1M);
+		ALIGN((adev->gmc.mc_vram_size - adev->mman.discovery_tmr_size - SZ_1M), SZ_1M);
 	ctx->p2c_train_data_offset =
 		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size =
@@ -1864,10 +1864,10 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	 * Otherwise, fallback to legacy approach to check and reserve tmr block for ip
 	 * discovery data and G6 memory training data respectively
 	 */
-	adev->discovery_tmr_size =
+	adev->mman.discovery_tmr_size =
 		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
-	if (!adev->discovery_tmr_size)
-		adev->discovery_tmr_size = DISCOVERY_TMR_OFFSET;
+	if (!adev->mman.discovery_tmr_size)
+		adev->mman.discovery_tmr_size = DISCOVERY_TMR_OFFSET;
 
 	if (mem_train_support) {
 		/* reserve vram for mem train according to TMR location */
@@ -1887,14 +1887,14 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	}
 
 	ret = amdgpu_bo_create_kernel_at(adev,
-				adev->gmc.real_vram_size - adev->discovery_tmr_size,
-				adev->discovery_tmr_size,
+				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
+				adev->mman.discovery_tmr_size,
 				AMDGPU_GEM_DOMAIN_VRAM,
-				&adev->discovery_memory,
+				&adev->mman.discovery_memory,
 				NULL);
 	if (ret) {
 		DRM_ERROR("alloc tmr failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->discovery_memory, NULL, NULL);
+		amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
 		return ret;
 	}
 
@@ -1968,7 +1968,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * If IP discovery enabled, a block of memory should be
 	 * reserved for IP discovey.
 	 */
-	if (adev->discovery_bin) {
+	if (adev->mman.discovery_bin) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
@@ -2066,7 +2066,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	if (adev->mman.keep_stolen_vga_memory)
 		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
 	/* return the IP Discovery TMR memory back to VRAM */
-	amdgpu_bo_free_kernel(&adev->discovery_memory, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 
 	if (adev->mman.aper_base_kaddr)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 98af87f38f3e..6d7b83d967ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -65,6 +65,11 @@ struct amdgpu_mman {
 	uint64_t		stolen_extended_size;
 	struct amdgpu_bo	*stolen_extended_memory;
 	bool			keep_stolen_vga_memory;
+
+	/* discovery */
+	uint8_t				*discovery_bin;
+	uint32_t			discovery_tmr_size;
+	struct amdgpu_bo		*discovery_memory;
 };
 
 struct amdgpu_copy_mem {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
