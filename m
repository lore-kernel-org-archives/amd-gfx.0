Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DD2C47253
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7610A20787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoxAPT+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7610A20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5C46E949;
	Thu, 30 Apr 2020 18:37:38 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CD46E949
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 18:37:36 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id b188so6780623qkd.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kzwPRcago+dpueqUi1I/BpUlg6h/D1sAs7XiVfoo+gU=;
 b=hoxAPT+pk8d7u2XGiz/tZwlFH2zdU4Se0xuXvlORV3LFYkwhvqPrtXVBdoCyIzaiPC
 lsWxpgM53XtH4hfAPQ38OUplXy739fgwU52ne7eP5xHCYhtt0V96zsnaVJ7ecGUnFPCU
 ARSe9hLAQSC2m88O6szYAF26mHc38HewYjegBzhhBNiWRkvNSMmnmbMLDZC0yGA07dNP
 xWPjuFNew/j+4Dip14omHido0OExm4zhfIRDMb6njHxEVRh+Z6CdNMMrodNFcs4wZ0yC
 VSdiGJwbTNivImyPk7MBfIIsLFnGHyF4qCuHv4xxzTXq2dNAmJPI/gGhVPaADDM3Q1H+
 3MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kzwPRcago+dpueqUi1I/BpUlg6h/D1sAs7XiVfoo+gU=;
 b=QQwoK/K/RdhZ6p5MB3BFDAPPRRU9a/dUIA0oT3+98GXVZxegTtksuUFuRBrNXicLf1
 nkTvzan7lYb3N9vkEu5oeRr5Nzu6OKn+Vo8TMuBq8IalontKZNkfjZtOhyK5KiA84lE3
 bt/Jm3C0hM6Y3x1yd9t23B4i5/h0QfwEbCHXxD4qn5hiQO9p4Q05hlYrzCUTsIslxEHC
 xAOq7p0zc5XEIjq7WnH72YItGLaC25UnA0RuyH40vWgl+u6cznLlkfBY6doFw1Szw5M5
 tMqgrIaQITPIw/Ar13ICcMLWRP88OKsOmIyilONPkgS2aRDeRtaobL84f3xmybCKFgNR
 u7ow==
X-Gm-Message-State: AGi0PubFh4TGecYW4obS0gOvN0twWRfUQ8VDvtIygJouuvnE1lR6eh3v
 ljPj0OIauAts8jp8KYRYxC4lKUnj
X-Google-Smtp-Source: APiQypJnjiHrgwFDTqLr4ZOBnbEagRE+8lQNANntKB2xJumyR/JKBJqW9oFPfhBujG7rqfvs91nJlQ==
X-Received: by 2002:a05:620a:13bc:: with SMTP id
 m28mr4243660qki.211.1588271855237; 
 Thu, 30 Apr 2020 11:37:35 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c139sm693510qkg.8.2020.04.30.11.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:37:34 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: re-structue members for ip discovery
Date: Thu, 30 Apr 2020 14:37:15 -0400
Message-Id: <20200430183719.419549-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200430183719.419549-1-alexander.deucher@amd.com>
References: <20200430183719.419549-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

This is to prepare for initializing discovery tmr size per
ASIC type

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 56 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 12 ++--
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bc1e0fd71a09..6048c5902fad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -768,7 +768,6 @@ struct amdgpu_device {
 	uint8_t				*bios;
 	uint32_t			bios_size;
 	struct amdgpu_bo		*stolen_vga_memory;
-	struct amdgpu_bo		*discovery_memory;
 	uint32_t			bios_scratch_reg_offset;
 	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
 
@@ -921,7 +920,9 @@ struct amdgpu_device {
 	struct amdgpu_display_manager dm;
 
 	/* discovery */
-	uint8_t				*discovery;
+	uint8_t				*discovery_bin;
+	uint32_t			discovery_tmr_size;
+	struct amdgpu_bo		*discovery_memory;
 
 	/* mes */
 	bool                            enable_mes;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 43bb22ad8add..b5d6274952a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -133,9 +133,10 @@ static int hw_id_map[MAX_HWIP] = {
 static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
 {
 	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
-	uint64_t pos = vram_size - DISCOVERY_TMR_SIZE;
+	uint64_t pos = vram_size - adev->discovery_tmr_size;
 
-	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary, DISCOVERY_TMR_SIZE, false);
+	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+				  adev->discovery_tmr_size, false);
 	return 0;
 }
 
@@ -167,17 +168,18 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	uint16_t checksum;
 	int r;
 
-	adev->discovery = kzalloc(DISCOVERY_TMR_SIZE, GFP_KERNEL);
-	if (!adev->discovery)
+	adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
+	adev->discovery_bin = kzalloc(adev->discovery_tmr_size, GFP_KERNEL);
+	if (!adev->discovery_bin)
 		return -ENOMEM;
 
-	r = amdgpu_discovery_read_binary(adev, adev->discovery);
+	r = amdgpu_discovery_read_binary(adev, adev->discovery_bin);
 	if (r) {
 		DRM_ERROR("failed to read ip discovery binary\n");
 		goto out;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery;
+	bhdr = (struct binary_header *)adev->discovery_bin;
 
 	if (le32_to_cpu(bhdr->binary_signature) != BINARY_SIGNATURE) {
 		DRM_ERROR("invalid ip discovery binary signature\n");
@@ -190,7 +192,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	size = bhdr->binary_size - offset;
 	checksum = bhdr->binary_checksum;
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
 					      size, checksum)) {
 		DRM_ERROR("invalid ip discovery binary checksum\n");
 		r = -EINVAL;
@@ -200,7 +202,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	info = &bhdr->table_list[IP_DISCOVERY];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
-	ihdr = (struct ip_discovery_header *)(adev->discovery + offset);
+	ihdr = (struct ip_discovery_header *)(adev->discovery_bin + offset);
 
 	if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
 		DRM_ERROR("invalid ip discovery data table signature\n");
@@ -208,7 +210,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
 					      ihdr->size, checksum)) {
 		DRM_ERROR("invalid ip discovery data table checksum\n");
 		r = -EINVAL;
@@ -218,9 +220,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	info = &bhdr->table_list[GC];
 	offset = le16_to_cpu(info->offset);
 	checksum = le16_to_cpu(info->checksum);
-	ghdr = (struct gpu_info_header *)(adev->discovery + offset);
+	ghdr = (struct gpu_info_header *)(adev->discovery_bin + offset);
 
-	if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
+	if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
 				              ghdr->size, checksum)) {
 		DRM_ERROR("invalid gc data table checksum\n");
 		r = -EINVAL;
@@ -230,16 +232,16 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	return 0;
 
 out:
-	kfree(adev->discovery);
-	adev->discovery = NULL;
+	kfree(adev->discovery_bin);
+	adev->discovery_bin = NULL;
 
 	return r;
 }
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
-	kfree(adev->discovery);
-	adev->discovery = NULL;
+	kfree(adev->discovery_bin);
+	adev->discovery_bin = NULL;
 }
 
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
@@ -263,8 +265,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery;
-	ihdr = (struct ip_discovery_header *)(adev->discovery +
+	bhdr = (struct binary_header *)adev->discovery_bin;
+	ihdr = (struct ip_discovery_header *)(adev->discovery_bin +
 			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
@@ -272,7 +274,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->discovery + die_offset);
+		dhdr = (struct die_header *)(adev->discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
@@ -286,7 +288,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				le16_to_cpu(dhdr->die_id), num_ips);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->discovery + ip_offset);
+			ip = (struct ip *)(adev->discovery_bin + ip_offset);
 			num_base_address = ip->num_base_address;
 
 			DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
@@ -335,24 +337,24 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
 	uint16_t num_ips;
 	int i, j;
 
-	if (!adev->discovery) {
+	if (!adev->discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery;
-	ihdr = (struct ip_discovery_header *)(adev->discovery +
+	bhdr = (struct binary_header *)adev->discovery_bin;
+	ihdr = (struct ip_discovery_header *)(adev->discovery_bin +
 			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->discovery + die_offset);
+		dhdr = (struct die_header *)(adev->discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->discovery + ip_offset);
+			ip = (struct ip *)(adev->discovery_bin + ip_offset);
 
 			if (le16_to_cpu(ip->hw_id) == hw_id) {
 				if (major)
@@ -375,13 +377,13 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct gc_info_v1_0 *gc_info;
 
-	if (!adev->discovery) {
+	if (!adev->discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->discovery;
-	gc_info = (struct gc_info_v1_0 *)(adev->discovery +
+	bhdr = (struct binary_header *)adev->discovery_bin;
+	gc_info = (struct gc_info_v1_0 *)(adev->discovery_bin +
 			le16_to_cpu(bhdr->table_list[GC].offset));
 
 	adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->gc_num_se);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ea0199a8f9c9..085d7c238163 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1958,15 +1958,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 
 	/*
-	 * reserve one TMR (64K) memory at the top of VRAM which holds
+	 * reserve TMR memory at the top of VRAM which holds
 	 * IP Discovery data and is protected by PSP.
 	 */
 	r = amdgpu_bo_create_kernel_at(adev,
-				       adev->gmc.real_vram_size - DISCOVERY_TMR_SIZE,
-				       DISCOVERY_TMR_SIZE,
-				       AMDGPU_GEM_DOMAIN_VRAM,
-				       &adev->discovery_memory,
-				       NULL);
+			adev->gmc.real_vram_size - adev->discovery_tmr_size,
+			adev->discovery_tmr_size,
+			AMDGPU_GEM_DOMAIN_VRAM,
+			&adev->discovery_memory,
+			NULL);
 	if (r)
 		return r;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
