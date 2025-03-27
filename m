Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B056FC36011
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D3E10E94A;
	Thu, 27 Mar 2025 20:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MQVrB1RP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FD910E187
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 43E3B614C0;
 Thu, 27 Mar 2025 20:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483AC4CEEA;
 Thu, 27 Mar 2025 20:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107953;
 bh=42OsuCB0/aEVtnyA+ySVPnPtQGy5gsyrK2acikwD670=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MQVrB1RPNQXhO0JI0P3vSObVH743rn6l5F1lY+pA98pxRvJAijsVHSoMZphNyVbXf
 oTtqN5fwyyVZQRw7kotJX2YVDHaefyktlF7N1eeEsrk5iX0spQpsqDD5GJsA0nTOFU
 ZGEZqP9d2/KNTMadcBKSTcXmGQNZuQglMz/Pbe8rIzXmG5fVXBmWVzhYwyOnYtXnhZ
 IOpqpGqK2+v5IC8B/aq1O9iEEyyh+w591/4gfFM7B/BUacTsLhNUgZnOakM9aEMNVB
 7GeTanQTxmufPkF6tjfEYoX1iqOfYc9cXf+N9B4BJ0dK/45xpRo6pTygVyPWZhdqB3
 I60eCUyyES0RQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 08/14] drm/amd: Use drm_*() macros for all amdgpu_ucode prints
Date: Thu, 27 Mar 2025 15:38:52 -0500
Message-ID: <20250327203858.3796086-9-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
MIME-Version: 1.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

Messages emitted from amdgpu_ucode are currently with legacy DRM
macros. These don't show which device they are using. To make messages
clearer in multi-GPU systems adjust to drm_*() macros.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 456 ++++++++++++----------
 1 file changed, 245 insertions(+), 211 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index a28cd5e962cce..971f28d2c31f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -33,17 +33,25 @@
 static void amdgpu_ucode_print_common_hdr(struct amdgpu_device *adev,
 					  const struct common_firmware_header *hdr)
 {
-	DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
-	DRM_DEBUG("header_size_bytes: %u\n", le32_to_cpu(hdr->header_size_bytes));
-	DRM_DEBUG("header_version_major: %u\n", le16_to_cpu(hdr->header_version_major));
-	DRM_DEBUG("header_version_minor: %u\n", le16_to_cpu(hdr->header_version_minor));
-	DRM_DEBUG("ip_version_major: %u\n", le16_to_cpu(hdr->ip_version_major));
-	DRM_DEBUG("ip_version_minor: %u\n", le16_to_cpu(hdr->ip_version_minor));
-	DRM_DEBUG("ucode_version: 0x%08x\n", le32_to_cpu(hdr->ucode_version));
-	DRM_DEBUG("ucode_size_bytes: %u\n", le32_to_cpu(hdr->ucode_size_bytes));
-	DRM_DEBUG("ucode_array_offset_bytes: %u\n",
-		  le32_to_cpu(hdr->ucode_array_offset_bytes));
-	DRM_DEBUG("crc32: 0x%08x\n", le32_to_cpu(hdr->crc32));
+	drm_dbg(adev_to_drm(adev),
+		"size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
+	drm_dbg(adev_to_drm(adev),
+		"header_size_bytes: %u\n", le32_to_cpu(hdr->header_size_bytes));
+	drm_dbg(adev_to_drm(adev),
+		"header_version_major: %u\n", le16_to_cpu(hdr->header_version_major));
+	drm_dbg(adev_to_drm(adev),
+		"header_version_minor: %u\n", le16_to_cpu(hdr->header_version_minor));
+	drm_dbg(adev_to_drm(adev),
+		"ip_version_major: %u\n", le16_to_cpu(hdr->ip_version_major));
+	drm_dbg(adev_to_drm(adev),
+		"ip_version_minor: %u\n", le16_to_cpu(hdr->ip_version_minor));
+	drm_dbg(adev_to_drm(adev),
+		"ucode_version: 0x%08x\n", le32_to_cpu(hdr->ucode_version));
+	drm_dbg(adev_to_drm(adev),
+		"ucode_size_bytes: %u\n", le32_to_cpu(hdr->ucode_size_bytes));
+	drm_dbg(adev_to_drm(adev),
+		"ucode_array_offset_bytes: %u\n", le32_to_cpu(hdr->ucode_array_offset_bytes));
+	drm_dbg(adev_to_drm(adev), "crc32: 0x%08x\n", le32_to_cpu(hdr->crc32));
 }
 
 void amdgpu_ucode_print_mc_hdr(struct amdgpu_device *adev,
@@ -52,19 +60,20 @@ void amdgpu_ucode_print_mc_hdr(struct amdgpu_device *adev,
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
 
-	DRM_DEBUG("MC\n");
-	amdgpu_ucode_print_common_hdr(hdr);
+	drm_dbg(adev_to_drm(adev), "MC\n");
+	amdgpu_ucode_print_common_hdr(adev, hdr);
 
 	if (version_major == 1) {
 		const struct mc_firmware_header_v1_0 *mc_hdr =
 			container_of(hdr, struct mc_firmware_header_v1_0, header);
 
-		DRM_DEBUG("io_debug_size_bytes: %u\n",
+		drm_dbg(adev_to_drm(adev), "io_debug_size_bytes: %u\n",
 			  le32_to_cpu(mc_hdr->io_debug_size_bytes));
-		DRM_DEBUG("io_debug_array_offset_bytes: %u\n",
+		drm_dbg(adev_to_drm(adev), "io_debug_array_offset_bytes: %u\n",
 			  le32_to_cpu(mc_hdr->io_debug_array_offset_bytes));
 	} else {
-		DRM_ERROR("Unknown MC ucode version: %u.%u\n", version_major, version_minor);
+		drm_err(adev_to_drm(adev),
+			"Unknown MC ucode version: %u.%u\n", version_major, version_minor);
 	}
 }
 
@@ -77,30 +86,41 @@ void amdgpu_ucode_print_smc_hdr(struct amdgpu_device *adev,
 	const struct smc_firmware_header_v2_0 *v2_0_hdr;
 	const struct smc_firmware_header_v2_1 *v2_1_hdr;
 
-	DRM_DEBUG("SMC\n");
-	amdgpu_ucode_print_common_hdr(hdr);
+	drm_dbg(adev_to_drm(adev), "SMC\n");
+	amdgpu_ucode_print_common_hdr(adev, hdr);
 
 	if (version_major == 1) {
 		v1_0_hdr = container_of(hdr, struct smc_firmware_header_v1_0, header);
-		DRM_DEBUG("ucode_start_addr: %u\n", le32_to_cpu(v1_0_hdr->ucode_start_addr));
+		drm_dbg(adev_to_drm(adev),
+			"ucode_start_addr: %u\n",
+			le32_to_cpu(v1_0_hdr->ucode_start_addr));
 	} else if (version_major == 2) {
 		switch (version_minor) {
 		case 0:
 			v2_0_hdr = container_of(hdr, struct smc_firmware_header_v2_0, v1_0.header);
-			DRM_DEBUG("ppt_offset_bytes: %u\n", le32_to_cpu(v2_0_hdr->ppt_offset_bytes));
-			DRM_DEBUG("ppt_size_bytes: %u\n", le32_to_cpu(v2_0_hdr->ppt_size_bytes));
+			drm_dbg(adev_to_drm(adev),
+				"ppt_offset_bytes: %u\n",
+				le32_to_cpu(v2_0_hdr->ppt_offset_bytes));
+			drm_dbg(adev_to_drm(adev),
+				"ppt_size_bytes: %u\n",
+				le32_to_cpu(v2_0_hdr->ppt_size_bytes));
 			break;
 		case 1:
 			v2_1_hdr = container_of(hdr, struct smc_firmware_header_v2_1, v1_0.header);
-			DRM_DEBUG("pptable_count: %u\n", le32_to_cpu(v2_1_hdr->pptable_count));
-			DRM_DEBUG("pptable_entry_offset: %u\n", le32_to_cpu(v2_1_hdr->pptable_entry_offset));
+			drm_dbg(adev_to_drm(adev),
+				"pptable_count: %u\n",
+				le32_to_cpu(v2_1_hdr->pptable_count));
+			drm_dbg(adev_to_drm(adev),
+				"pptable_entry_offset: %u\n",
+				le32_to_cpu(v2_1_hdr->pptable_entry_offset));
 			break;
 		default:
 			break;
 		}
 
 	} else {
-		DRM_ERROR("Unknown SMC ucode version: %u.%u\n", version_major, version_minor);
+		drm_err(adev_to_drm(adev),
+			"Unknown SMC ucode version: %u.%u\n", version_major, version_minor);
 	}
 }
 
@@ -110,25 +130,26 @@ void amdgpu_ucode_print_gfx_hdr(struct amdgpu_device *adev,
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
 
-	DRM_DEBUG("GFX\n");
-	amdgpu_ucode_print_common_hdr(hdr);
+	drm_dbg(adev_to_drm(adev), "GFX\n");
+	amdgpu_ucode_print_common_hdr(adev, hdr);
 
 	if (version_major == 1) {
 		const struct gfx_firmware_header_v1_0 *gfx_hdr =
 			container_of(hdr, struct gfx_firmware_header_v1_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
+		drm_dbg(adev_to_drm(adev), "ucode_feature_version: %u\n",
 			  le32_to_cpu(gfx_hdr->ucode_feature_version));
-		DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(gfx_hdr->jt_offset));
-		DRM_DEBUG("jt_size: %u\n", le32_to_cpu(gfx_hdr->jt_size));
+		drm_dbg(adev_to_drm(adev), "jt_offset: %u\n", le32_to_cpu(gfx_hdr->jt_offset));
+		drm_dbg(adev_to_drm(adev), "jt_size: %u\n", le32_to_cpu(gfx_hdr->jt_size));
 	} else if (version_major == 2) {
 		const struct gfx_firmware_header_v2_0 *gfx_hdr =
 			container_of(hdr, struct gfx_firmware_header_v2_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
-			  le32_to_cpu(gfx_hdr->ucode_feature_version));
+		drm_dbg(adev_to_drm(adev),
+			"ucode_feature_version: %u\n", le32_to_cpu(gfx_hdr->ucode_feature_version));
 	} else {
-		DRM_ERROR("Unknown GFX ucode version: %u.%u\n", version_major, version_minor);
+		drm_err(adev_to_drm(adev),
+			"Unknown GFX ucode version: %u.%u\n", version_major, version_minor);
 	}
 }
 
@@ -138,22 +159,22 @@ void amdgpu_ucode_print_rlc_hdr(struct amdgpu_device *adev,
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
 
-	DRM_DEBUG("RLC\n");
-	amdgpu_ucode_print_common_hdr(hdr);
+	drm_dbg(adev_to_drm(adev), "RLC\n");
+	amdgpu_ucode_print_common_hdr(adev, hdr);
 
 	if (version_major == 1) {
 		const struct rlc_firmware_header_v1_0 *rlc_hdr =
 			container_of(hdr, struct rlc_firmware_header_v1_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
+		drm_dbg(adev_to_drm(adev), "ucode_feature_version: %u\n",
 			  le32_to_cpu(rlc_hdr->ucode_feature_version));
-		DRM_DEBUG("save_and_restore_offset: %u\n",
+		drm_dbg(adev_to_drm(adev), "save_and_restore_offset: %u\n",
 			  le32_to_cpu(rlc_hdr->save_and_restore_offset));
-		DRM_DEBUG("clear_state_descriptor_offset: %u\n",
+		drm_dbg(adev_to_drm(adev), "clear_state_descriptor_offset: %u\n",
 			  le32_to_cpu(rlc_hdr->clear_state_descriptor_offset));
-		DRM_DEBUG("avail_scratch_ram_locations: %u\n",
+		drm_dbg(adev_to_drm(adev), "avail_scratch_ram_locations: %u\n",
 			  le32_to_cpu(rlc_hdr->avail_scratch_ram_locations));
-		DRM_DEBUG("master_pkt_description_offset: %u\n",
+		drm_dbg(adev_to_drm(adev), "master_pkt_description_offset: %u\n",
 			  le32_to_cpu(rlc_hdr->master_pkt_description_offset));
 	} else if (version_major == 2) {
 		const struct rlc_firmware_header_v2_0 *rlc_hdr =
@@ -170,129 +191,133 @@ void amdgpu_ucode_print_rlc_hdr(struct amdgpu_device *adev,
 		switch (version_minor) {
 		case 0:
 			/* rlc_hdr v2_0 */
-			DRM_DEBUG("ucode_feature_version: %u\n",
+			drm_dbg(adev_to_drm(adev), "ucode_feature_version: %u\n",
 				  le32_to_cpu(rlc_hdr->ucode_feature_version));
-			DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(rlc_hdr->jt_offset));
-			DRM_DEBUG("jt_size: %u\n", le32_to_cpu(rlc_hdr->jt_size));
-			DRM_DEBUG("save_and_restore_offset: %u\n",
-				  le32_to_cpu(rlc_hdr->save_and_restore_offset));
-			DRM_DEBUG("clear_state_descriptor_offset: %u\n",
-				  le32_to_cpu(rlc_hdr->clear_state_descriptor_offset));
-			DRM_DEBUG("avail_scratch_ram_locations: %u\n",
-				  le32_to_cpu(rlc_hdr->avail_scratch_ram_locations));
-			DRM_DEBUG("reg_restore_list_size: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_restore_list_size));
-			DRM_DEBUG("reg_list_format_start: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_format_start));
-			DRM_DEBUG("reg_list_format_separate_start: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_format_separate_start));
-			DRM_DEBUG("starting_offsets_start: %u\n",
-				  le32_to_cpu(rlc_hdr->starting_offsets_start));
-			DRM_DEBUG("reg_list_format_size_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_format_size_bytes));
-			DRM_DEBUG("reg_list_format_array_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
-			DRM_DEBUG("reg_list_size_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_size_bytes));
-			DRM_DEBUG("reg_list_array_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
-			DRM_DEBUG("reg_list_format_separate_size_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_format_separate_size_bytes));
-			DRM_DEBUG("reg_list_format_separate_array_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_format_separate_array_offset_bytes));
-			DRM_DEBUG("reg_list_separate_size_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_separate_size_bytes));
-			DRM_DEBUG("reg_list_separate_array_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr->reg_list_separate_array_offset_bytes));
+			drm_dbg(adev_to_drm(adev),
+				"jt_offset: %u\n", le32_to_cpu(rlc_hdr->jt_offset));
+			drm_dbg(adev_to_drm(adev),
+				"jt_size: %u\n", le32_to_cpu(rlc_hdr->jt_size));
+			drm_dbg(adev_to_drm(adev),
+				"save_and_restore_offset: %u\n",
+				le32_to_cpu(rlc_hdr->save_and_restore_offset));
+			drm_dbg(adev_to_drm(adev), "clear_state_descriptor_offset: %u\n",
+				le32_to_cpu(rlc_hdr->clear_state_descriptor_offset));
+			drm_dbg(adev_to_drm(adev), "avail_scratch_ram_locations: %u\n",
+				le32_to_cpu(rlc_hdr->avail_scratch_ram_locations));
+			drm_dbg(adev_to_drm(adev), "reg_restore_list_size: %u\n",
+				le32_to_cpu(rlc_hdr->reg_restore_list_size));
+			drm_dbg(adev_to_drm(adev), "reg_list_format_start: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_format_start));
+			drm_dbg(adev_to_drm(adev), "reg_list_format_separate_start: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_format_separate_start));
+			drm_dbg(adev_to_drm(adev), "starting_offsets_start: %u\n",
+				le32_to_cpu(rlc_hdr->starting_offsets_start));
+			drm_dbg(adev_to_drm(adev), "reg_list_format_size_bytes: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_format_size_bytes));
+			drm_dbg(adev_to_drm(adev), "reg_list_format_array_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "reg_list_size_bytes: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_size_bytes));
+			drm_dbg(adev_to_drm(adev), "reg_list_array_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "reg_list_format_separate_size_bytes: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_format_separate_size_bytes));
+			drm_dbg(adev_to_drm(adev), "reg_list_format_separate_array_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_format_separate_array_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "reg_list_separate_size_bytes: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_separate_size_bytes));
+			drm_dbg(adev_to_drm(adev), "reg_list_separate_array_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr->reg_list_separate_array_offset_bytes));
 			break;
 		case 1:
 			/* rlc_hdr v2_1 */
-			DRM_DEBUG("reg_list_format_direct_reg_list_length: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->reg_list_format_direct_reg_list_length));
-			DRM_DEBUG("save_restore_list_cntl_ucode_ver: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_ucode_ver));
-			DRM_DEBUG("save_restore_list_cntl_feature_ver: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_feature_ver));
-			DRM_DEBUG("save_restore_list_cntl_size_bytes %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_size_bytes));
-			DRM_DEBUG("save_restore_list_cntl_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_offset_bytes));
-			DRM_DEBUG("save_restore_list_gpm_ucode_ver: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_ucode_ver));
-			DRM_DEBUG("save_restore_list_gpm_feature_ver: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_feature_ver));
-			DRM_DEBUG("save_restore_list_gpm_size_bytes %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_size_bytes));
-			DRM_DEBUG("save_restore_list_gpm_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_offset_bytes));
-			DRM_DEBUG("save_restore_list_srm_ucode_ver: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_ucode_ver));
-			DRM_DEBUG("save_restore_list_srm_feature_ver: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_feature_ver));
-			DRM_DEBUG("save_restore_list_srm_size_bytes %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_size_bytes));
-			DRM_DEBUG("save_restore_list_srm_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "reg_list_format_direct_reg_list_length: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->reg_list_format_direct_reg_list_length));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_cntl_ucode_ver: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_ucode_ver));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_cntl_feature_ver: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_feature_ver));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_cntl_size_bytes %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_size_bytes));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_cntl_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_gpm_ucode_ver: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_ucode_ver));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_gpm_feature_ver: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_feature_ver));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_gpm_size_bytes %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_size_bytes));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_gpm_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_srm_ucode_ver: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_ucode_ver));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_srm_feature_ver: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_feature_ver));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_srm_size_bytes %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_size_bytes));
+			drm_dbg(adev_to_drm(adev), "save_restore_list_srm_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_offset_bytes));
 			break;
 		case 2:
 			/* rlc_hdr v2_2 */
-			DRM_DEBUG("rlc_iram_ucode_size_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_2->rlc_iram_ucode_size_bytes));
-			DRM_DEBUG("rlc_iram_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_2->rlc_iram_ucode_offset_bytes));
-			DRM_DEBUG("rlc_dram_ucode_size_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_2->rlc_dram_ucode_size_bytes));
-			DRM_DEBUG("rlc_dram_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_2->rlc_dram_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "rlc_iram_ucode_size_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_2->rlc_iram_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "rlc_iram_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_2->rlc_iram_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "rlc_dram_ucode_size_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_2->rlc_dram_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "rlc_dram_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_2->rlc_dram_ucode_offset_bytes));
 			break;
 		case 3:
 			/* rlc_hdr v2_3 */
-			DRM_DEBUG("rlcp_ucode_version: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_version));
-			DRM_DEBUG("rlcp_ucode_feature_version: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_feature_version));
-			DRM_DEBUG("rlcp_ucode_size_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_size_bytes));
-			DRM_DEBUG("rlcp_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_offset_bytes));
-			DRM_DEBUG("rlcv_ucode_version: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_version));
-			DRM_DEBUG("rlcv_ucode_feature_version: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_feature_version));
-			DRM_DEBUG("rlcv_ucode_size_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_size_bytes));
-			DRM_DEBUG("rlcv_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "rlcp_ucode_version: %u\n",
+				le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_version));
+			drm_dbg(adev_to_drm(adev), "rlcp_ucode_feature_version: %u\n",
+				le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_feature_version));
+			drm_dbg(adev_to_drm(adev), "rlcp_ucode_size_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "rlcp_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "rlcv_ucode_version: %u\n",
+				le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_version));
+			drm_dbg(adev_to_drm(adev), "rlcv_ucode_feature_version: %u\n",
+				le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_feature_version));
+			drm_dbg(adev_to_drm(adev), "rlcv_ucode_size_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "rlcv_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_offset_bytes));
 			break;
 		case 4:
 			/* rlc_hdr v2_4 */
-			DRM_DEBUG("global_tap_delays_ucode_size_bytes :%u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->global_tap_delays_ucode_size_bytes));
-			DRM_DEBUG("global_tap_delays_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->global_tap_delays_ucode_offset_bytes));
-			DRM_DEBUG("se0_tap_delays_ucode_size_bytes :%u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->se0_tap_delays_ucode_size_bytes));
-			DRM_DEBUG("se0_tap_delays_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->se0_tap_delays_ucode_offset_bytes));
-			DRM_DEBUG("se1_tap_delays_ucode_size_bytes :%u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->se1_tap_delays_ucode_size_bytes));
-			DRM_DEBUG("se1_tap_delays_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->se1_tap_delays_ucode_offset_bytes));
-			DRM_DEBUG("se2_tap_delays_ucode_size_bytes :%u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->se2_tap_delays_ucode_size_bytes));
-			DRM_DEBUG("se2_tap_delays_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->se2_tap_delays_ucode_offset_bytes));
-			DRM_DEBUG("se3_tap_delays_ucode_size_bytes :%u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->se3_tap_delays_ucode_size_bytes));
-			DRM_DEBUG("se3_tap_delays_ucode_offset_bytes: %u\n",
-				  le32_to_cpu(rlc_hdr_v2_4->se3_tap_delays_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "global_tap_delays_ucode_size_bytes :%u\n",
+				le32_to_cpu(rlc_hdr_v2_4->global_tap_delays_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "global_tap_delays_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_4->global_tap_delays_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "se0_tap_delays_ucode_size_bytes :%u\n",
+				le32_to_cpu(rlc_hdr_v2_4->se0_tap_delays_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "se0_tap_delays_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_4->se0_tap_delays_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "se1_tap_delays_ucode_size_bytes :%u\n",
+				le32_to_cpu(rlc_hdr_v2_4->se1_tap_delays_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "se1_tap_delays_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_4->se1_tap_delays_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "se2_tap_delays_ucode_size_bytes :%u\n",
+				le32_to_cpu(rlc_hdr_v2_4->se2_tap_delays_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "se2_tap_delays_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_4->se2_tap_delays_ucode_offset_bytes));
+			drm_dbg(adev_to_drm(adev), "se3_tap_delays_ucode_size_bytes :%u\n",
+				le32_to_cpu(rlc_hdr_v2_4->se3_tap_delays_ucode_size_bytes));
+			drm_dbg(adev_to_drm(adev), "se3_tap_delays_ucode_offset_bytes: %u\n",
+				le32_to_cpu(rlc_hdr_v2_4->se3_tap_delays_ucode_offset_bytes));
 			break;
 		default:
-			DRM_ERROR("Unknown RLC v2 ucode: v2.%u\n", version_minor);
+			drm_err(adev_to_drm(adev), "Unknown RLC v2 ucode: v2.%u\n", version_minor);
 			break;
 		}
 	} else {
-		DRM_ERROR("Unknown RLC ucode version: %u.%u\n", version_major, version_minor);
+		drm_err(adev_to_drm(adev),
+			"Unknown RLC ucode version: %u.%u\n", version_major, version_minor);
 	}
 }
 
@@ -302,43 +327,49 @@ void amdgpu_ucode_print_sdma_hdr(struct amdgpu_device *adev,
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
 
-	DRM_DEBUG("SDMA\n");
-	amdgpu_ucode_print_common_hdr(hdr);
+	drm_dbg(adev_to_drm(adev), "SDMA\n");
+	amdgpu_ucode_print_common_hdr(adev, hdr);
 
 	if (version_major == 1) {
 		const struct sdma_firmware_header_v1_0 *sdma_hdr =
 			container_of(hdr, struct sdma_firmware_header_v1_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
+		drm_dbg(adev_to_drm(adev), "ucode_feature_version: %u\n",
 			  le32_to_cpu(sdma_hdr->ucode_feature_version));
-		DRM_DEBUG("ucode_change_version: %u\n",
+		drm_dbg(adev_to_drm(adev), "ucode_change_version: %u\n",
 			  le32_to_cpu(sdma_hdr->ucode_change_version));
-		DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(sdma_hdr->jt_offset));
-		DRM_DEBUG("jt_size: %u\n", le32_to_cpu(sdma_hdr->jt_size));
+		drm_dbg(adev_to_drm(adev), "jt_offset: %u\n", le32_to_cpu(sdma_hdr->jt_offset));
+		drm_dbg(adev_to_drm(adev), "jt_size: %u\n", le32_to_cpu(sdma_hdr->jt_size));
 		if (version_minor >= 1) {
 			const struct sdma_firmware_header_v1_1 *sdma_v1_1_hdr =
 				container_of(sdma_hdr, struct sdma_firmware_header_v1_1, v1_0);
-			DRM_DEBUG("digest_size: %u\n", le32_to_cpu(sdma_v1_1_hdr->digest_size));
+			drm_dbg(adev_to_drm(adev),
+				"digest_size: %u\n", le32_to_cpu(sdma_v1_1_hdr->digest_size));
 		}
 	} else if (version_major == 2) {
 		const struct sdma_firmware_header_v2_0 *sdma_hdr =
 			container_of(hdr, struct sdma_firmware_header_v2_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
+		drm_dbg(adev_to_drm(adev), "ucode_feature_version: %u\n",
 			  le32_to_cpu(sdma_hdr->ucode_feature_version));
-		DRM_DEBUG("ctx_jt_offset: %u\n", le32_to_cpu(sdma_hdr->ctx_jt_offset));
-		DRM_DEBUG("ctx_jt_size: %u\n", le32_to_cpu(sdma_hdr->ctx_jt_size));
-		DRM_DEBUG("ctl_ucode_offset: %u\n", le32_to_cpu(sdma_hdr->ctl_ucode_offset));
-		DRM_DEBUG("ctl_jt_offset: %u\n", le32_to_cpu(sdma_hdr->ctl_jt_offset));
-		DRM_DEBUG("ctl_jt_size: %u\n", le32_to_cpu(sdma_hdr->ctl_jt_size));
+		drm_dbg(adev_to_drm(adev),
+			"ctx_jt_offset: %u\n", le32_to_cpu(sdma_hdr->ctx_jt_offset));
+		drm_dbg(adev_to_drm(adev),
+			"ctx_jt_size: %u\n", le32_to_cpu(sdma_hdr->ctx_jt_size));
+		drm_dbg(adev_to_drm(adev),
+			"ctl_ucode_offset: %u\n", le32_to_cpu(sdma_hdr->ctl_ucode_offset));
+		drm_dbg(adev_to_drm(adev),
+			"ctl_jt_offset: %u\n", le32_to_cpu(sdma_hdr->ctl_jt_offset));
+		drm_dbg(adev_to_drm(adev),
+			"ctl_jt_size: %u\n", le32_to_cpu(sdma_hdr->ctl_jt_size));
 	} else if (version_major == 3) {
 		const struct sdma_firmware_header_v3_0 *sdma_hdr =
 			container_of(hdr, struct sdma_firmware_header_v3_0, header);
 
-		DRM_DEBUG("ucode_reversion: %u\n",
+		drm_dbg(adev_to_drm(adev), "ucode_reversion: %u\n",
 			  le32_to_cpu(sdma_hdr->ucode_feature_version));
 	} else {
-		DRM_ERROR("Unknown SDMA ucode version: %u.%u\n",
+		drm_err(adev_to_drm(adev), "Unknown SDMA ucode version: %u.%u\n",
 			  version_major, version_minor);
 	}
 }
@@ -351,43 +382,43 @@ void amdgpu_ucode_print_psp_hdr(struct amdgpu_device *adev,
 	uint32_t fw_index;
 	const struct psp_fw_bin_desc *desc;
 
-	DRM_DEBUG("PSP\n");
-	amdgpu_ucode_print_common_hdr(hdr);
+	drm_dbg(adev_to_drm(adev), "PSP\n");
+	amdgpu_ucode_print_common_hdr(adev, hdr);
 
 	if (version_major == 1) {
 		const struct psp_firmware_header_v1_0 *psp_hdr =
 			container_of(hdr, struct psp_firmware_header_v1_0, header);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
+		drm_dbg(adev_to_drm(adev), "ucode_feature_version: %u\n",
 			  le32_to_cpu(psp_hdr->sos.fw_version));
-		DRM_DEBUG("sos_offset_bytes: %u\n",
+		drm_dbg(adev_to_drm(adev), "sos_offset_bytes: %u\n",
 			  le32_to_cpu(psp_hdr->sos.offset_bytes));
-		DRM_DEBUG("sos_size_bytes: %u\n",
+		drm_dbg(adev_to_drm(adev), "sos_size_bytes: %u\n",
 			  le32_to_cpu(psp_hdr->sos.size_bytes));
 		if (version_minor == 1) {
 			const struct psp_firmware_header_v1_1 *psp_hdr_v1_1 =
 				container_of(psp_hdr, struct psp_firmware_header_v1_1, v1_0);
-			DRM_DEBUG("toc_header_version: %u\n",
+			drm_dbg(adev_to_drm(adev), "toc_header_version: %u\n",
 				  le32_to_cpu(psp_hdr_v1_1->toc.fw_version));
-			DRM_DEBUG("toc_offset_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "toc_offset_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_1->toc.offset_bytes));
-			DRM_DEBUG("toc_size_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "toc_size_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_1->toc.size_bytes));
-			DRM_DEBUG("kdb_header_version: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_header_version: %u\n",
 				  le32_to_cpu(psp_hdr_v1_1->kdb.fw_version));
-			DRM_DEBUG("kdb_offset_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_offset_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_1->kdb.offset_bytes));
-			DRM_DEBUG("kdb_size_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_size_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_1->kdb.size_bytes));
 		}
 		if (version_minor == 2) {
 			const struct psp_firmware_header_v1_2 *psp_hdr_v1_2 =
 				container_of(psp_hdr, struct psp_firmware_header_v1_2, v1_0);
-			DRM_DEBUG("kdb_header_version: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_header_version: %u\n",
 				  le32_to_cpu(psp_hdr_v1_2->kdb.fw_version));
-			DRM_DEBUG("kdb_offset_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_offset_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_2->kdb.offset_bytes));
-			DRM_DEBUG("kdb_size_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_size_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_2->kdb.size_bytes));
 		}
 		if (version_minor == 3) {
@@ -395,23 +426,23 @@ void amdgpu_ucode_print_psp_hdr(struct amdgpu_device *adev,
 				container_of(psp_hdr, struct psp_firmware_header_v1_1, v1_0);
 			const struct psp_firmware_header_v1_3 *psp_hdr_v1_3 =
 				container_of(psp_hdr_v1_1, struct psp_firmware_header_v1_3, v1_1);
-			DRM_DEBUG("toc_header_version: %u\n",
+			drm_dbg(adev_to_drm(adev), "toc_header_version: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.fw_version));
-			DRM_DEBUG("toc_offset_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "toc_offset_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.offset_bytes));
-			DRM_DEBUG("toc_size_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "toc_size_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->v1_1.toc.size_bytes));
-			DRM_DEBUG("kdb_header_version: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_header_version: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.fw_version));
-			DRM_DEBUG("kdb_offset_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_offset_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.offset_bytes));
-			DRM_DEBUG("kdb_size_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "kdb_size_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->v1_1.kdb.size_bytes));
-			DRM_DEBUG("spl_header_version: %u\n",
+			drm_dbg(adev_to_drm(adev), "spl_header_version: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->spl.fw_version));
-			DRM_DEBUG("spl_offset_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "spl_offset_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->spl.offset_bytes));
-			DRM_DEBUG("spl_size_bytes: %u\n",
+			drm_dbg(adev_to_drm(adev), "spl_size_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->spl.size_bytes));
 		}
 	} else if (version_major == 2) {
@@ -421,72 +452,73 @@ void amdgpu_ucode_print_psp_hdr(struct amdgpu_device *adev,
 			desc = &(psp_hdr_v2_0->psp_fw_bin[fw_index]);
 			switch (desc->fw_type) {
 			case PSP_FW_TYPE_PSP_SOS:
-				DRM_DEBUG("psp_sos_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_sos_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_sos_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_sos_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_SYS_DRV:
-				DRM_DEBUG("psp_sys_drv_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_sys_drv_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_sys_drv_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_sys_drv_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_KDB:
-				DRM_DEBUG("psp_kdb_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_kdb_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_kdb_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_kdb_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_TOC:
-				DRM_DEBUG("psp_toc_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_toc_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_toc_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_toc_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_SPL:
-				DRM_DEBUG("psp_spl_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_spl_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_spl_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_spl_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_RL:
-				DRM_DEBUG("psp_rl_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_rl_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_rl_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_rl_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_SOC_DRV:
-				DRM_DEBUG("psp_soc_drv_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_soc_drv_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_soc_drv_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_soc_drv_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_INTF_DRV:
-				DRM_DEBUG("psp_intf_drv_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_intf_drv_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_intf_drv_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_intf_drv_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_DBG_DRV:
-				DRM_DEBUG("psp_dbg_drv_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_dbg_drv_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_dbg_drv_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_dbg_drv_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			case PSP_FW_TYPE_PSP_RAS_DRV:
-				DRM_DEBUG("psp_ras_drv_version: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_ras_drv_version: %u\n",
 					  le32_to_cpu(desc->fw_version));
-				DRM_DEBUG("psp_ras_drv_size_bytes: %u\n",
+				drm_dbg(adev_to_drm(adev), "psp_ras_drv_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
 			default:
-				DRM_DEBUG("Unsupported PSP fw type: %d\n", desc->fw_type);
+				drm_dbg(adev_to_drm(adev),
+					"Unsupported PSP fw type: %d\n", desc->fw_type);
 				break;
 			}
 		}
 	} else {
-		DRM_ERROR("Unknown PSP ucode version: %u.%u\n",
+		drm_err(adev_to_drm(adev), "Unknown PSP ucode version: %u.%u\n",
 			  version_major, version_minor);
 	}
 }
@@ -497,19 +529,20 @@ void amdgpu_ucode_print_gpu_info_hdr(struct amdgpu_device *adev,
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
 
-	DRM_DEBUG("GPU_INFO\n");
-	amdgpu_ucode_print_common_hdr(hdr);
+	drm_dbg(adev_to_drm(adev), "GPU_INFO\n");
+	amdgpu_ucode_print_common_hdr(adev, hdr);
 
 	if (version_major == 1) {
 		const struct gpu_info_firmware_header_v1_0 *gpu_info_hdr =
 			container_of(hdr, struct gpu_info_firmware_header_v1_0, header);
 
-		DRM_DEBUG("version_major: %u\n",
+		drm_dbg(adev_to_drm(adev), "version_major: %u\n",
 			  le16_to_cpu(gpu_info_hdr->version_major));
-		DRM_DEBUG("version_minor: %u\n",
+		drm_dbg(adev_to_drm(adev), "version_minor: %u\n",
 			  le16_to_cpu(gpu_info_hdr->version_minor));
 	} else {
-		DRM_ERROR("Unknown gpu_info ucode version: %u.%u\n", version_major, version_minor);
+		drm_err(adev_to_drm(adev),
+			"Unknown gpu_info ucode version: %u.%u\n", version_major, version_minor);
 	}
 }
 
@@ -1122,7 +1155,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 			&adev->firmware.fw_buf_mc,
 			&adev->firmware.fw_buf_ptr);
 		if (!adev->firmware.fw_buf) {
-			dev_err(adev->dev, "failed to create kernel buffer for firmware.fw_buf\n");
+			drm_err(adev_to_drm(adev),
+				"failed to create kernel buffer for firmware.fw_buf\n");
 			return -ENOMEM;
 		} else if (amdgpu_sriov_vf(adev)) {
 			memset(adev->firmware.fw_buf_ptr, 0, adev->firmware.fw_size);
@@ -1462,7 +1496,7 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 	r = vsnprintf(fname, sizeof(fname), fmt, ap);
 	va_end(ap);
 	if (r == sizeof(fname)) {
-		dev_warn(adev->dev, "amdgpu firmware name buffer overflow\n");
+		drm_warn(adev_to_drm(adev), "amdgpu firmware name buffer overflow\n");
 		return -EOVERFLOW;
 	}
 
-- 
2.43.0

