Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2045C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 15:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA912053B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 15:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA912053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A326EA24;
	Wed, 16 Sep 2020 15:05:32 +0000 (UTC)
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8102A6EA24
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 15:05:30 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id 5DD3C1840114; Wed, 16 Sep 2020 10:57:05 -0400 (EDT)
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] SWDEV-220451 - Query guest's information by VF2PF message
 - Guest side - part 2
Date: Wed, 16 Sep 2020 10:57:02 -0400
Message-Id: <20200916145702.18866-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Add VF2PF message support
- Remove incorrect Macro to avoid compile error
- Remove duplicated struct and use amdgv_sriovmsg.h

Change-Id: I8175d304871f4b5aab75fd071a6bdf8008137dbe
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 244 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  75 +------
 3 files changed, 198 insertions(+), 125 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5d702f6e77de..483ec0136332 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3443,8 +3443,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_request_full_gpu(adev, false);
+		amdgpu_virt_fini_data_exchange(adev);
+	}
 
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f76961d17246..1f1171812e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -31,6 +31,12 @@
 #include "soc15.h"
 #include "nv.h"
 
+#define POPULATE_UCODE_INFO(vf2pf_info, ucode, ver) \
+	do { \
+		vf2pf_info->ucode_info[ucode].id = ucode; \
+		vf2pf_info->ucode_info[ucode].version = ver; \
+	} while (0)
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
 	/* By now all MMIO pages except mailbox are blocked */
@@ -239,10 +245,10 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev)
 }
 
 
-int amdgpu_virt_fw_reserve_get_checksum(void *obj,
-					unsigned long obj_size,
-					unsigned int key,
-					unsigned int chksum)
+unsigned int amd_sriov_msg_checksum(void *obj,
+				unsigned long obj_size,
+				unsigned int key,
+				unsigned int checksum)
 {
 	unsigned int ret = key;
 	unsigned long i = 0;
@@ -252,9 +258,9 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj,
 	/* calculate checksum */
 	for (i = 0; i < obj_size; ++i)
 		ret += *(pos + i);
-	/* minus the chksum itself */
-	pos = (char *)&chksum;
-	for (i = 0; i < sizeof(chksum); ++i)
+	/* minus the checksum itself */
+	pos = (char *)&checksum;
+	for (i = 0; i < sizeof(checksum); ++i)
 		ret -= *(pos + i);
 	return ret;
 }
@@ -415,33 +421,187 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	}
 }
 
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
+static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 {
-	uint32_t pf2vf_size = 0;
-	uint32_t checksum = 0;
+	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
+	uint32_t checksum;
 	uint32_t checkval;
-	char *str;
+
+	if (adev->virt.fw_reserve.p_pf2vf == NULL)
+		return -EINVAL;
+
+	if (pf2vf_info->size > 1024) {
+		DRM_ERROR("invalid pf2vf message size\n");
+		return -EINVAL;
+	}
+
+	switch (pf2vf_info->version) {
+	case 1:
+		checksum = ((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->checksum;
+		checkval = amd_sriov_msg_checksum(
+			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+			adev->virt.fw_reserve.checksum_key, checksum);
+		if (checksum != checkval) {
+			DRM_ERROR("invalid pf2vf message\n");
+			return -EINVAL;
+		}
+
+		adev->virt.gim_feature =
+			((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->feature_flags;
+		break;
+	case 2:
+		/* TODO: missing key, need to add it later */
+		checksum = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->checksum;
+		checkval = amd_sriov_msg_checksum(
+			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+			0, checksum);
+		if (checksum != checkval) {
+			DRM_ERROR("invalid pf2vf message\n");
+			return -EINVAL;
+		}
+
+		adev->virt.vf2pf_update_interval_ms =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->vf2pf_update_interval_ms;
+		adev->virt.gim_feature =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
+
+		break;
+	default:
+		DRM_ERROR("invalid pf2vf version\n");
+		return -EINVAL;
+	}
+
+	/* correct too large or too little interval value */
+	if (adev->virt.vf2pf_update_interval_ms < 200 || adev->virt.vf2pf_update_interval_ms > 10000)
+		adev->virt.vf2pf_update_interval_ms = 2000;
+
+	return 0;
+}
+
+static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
+	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
+
+	if (adev->virt.fw_reserve.p_vf2pf == NULL)
+		return;
+
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCE,      adev->vce.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_UVD,      adev->uvd.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MC,       adev->gmc.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ME,       adev->gfx.me_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_PFP,      adev->gfx.pfp_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_CE,       adev->gfx.ce_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC,      adev->gfx.rlc_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLC, adev->gfx.rlc_srlc_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLG, adev->gfx.rlc_srlg_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,      adev->psp.asd_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,   adev->psp.ta_ras_ucode_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,  adev->psp.ta_xgmi_ucode_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SMC,      adev->pm.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA,     adev->sdma.instance[0].fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA2,    adev->sdma.instance[1].fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCN,      adev->vcn.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_DMCU,     adev->dm.dmcu_fw_version);
+}
+
+static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
+
+	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
+
+	if (adev->virt.fw_reserve.p_vf2pf == NULL)
+		return -EINVAL;
+
+	memset(vf2pf_info, 0, sizeof(struct amd_sriov_msg_vf2pf_info));
+
+	vf2pf_info->header.size = sizeof(struct amd_sriov_msg_vf2pf_info);
+	vf2pf_info->header.version = AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER;
+
+#ifdef MODULE
+	if (THIS_MODULE->version != NULL)
+		strcpy(vf2pf_info->driver_version, THIS_MODULE->version);
+	else
+#endif
+		strcpy(vf2pf_info->driver_version, "N/A");
+
+	vf2pf_info->pf2vf_version_required = 0; // no requirement, guest understands all
+	vf2pf_info->driver_cert = 0;
+	vf2pf_info->os_info.all = 0;
+
+	vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(&adev->mman.bdev.man[TTM_PL_VRAM]) >> 20;
+	vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(&adev->mman.bdev.man[TTM_PL_VRAM]) >> 20;
+	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
+	vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;
+
+	amdgpu_virt_populate_vf2pf_ucode_info(adev);
+
+	/* TODO: read dynamic info */
+	vf2pf_info->gfx_usage = 0;
+	vf2pf_info->compute_usage = 0;
+	vf2pf_info->encode_usage = 0;
+	vf2pf_info->decode_usage = 0;
+
+	vf2pf_info->checksum =
+		amd_sriov_msg_checksum(
+		vf2pf_info, vf2pf_info->header.size, 0, 0);
+
+	return 0;
+}
+
+void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device, virt.vf2pf_work.work);
+
+	amdgpu_virt_read_pf2vf_data(adev);
+	amdgpu_virt_write_vf2pf_data(adev);
+
+	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
+}
+
+void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
+{
+	if (adev->virt.vf2pf_update_interval_ms != 0) {
+		DRM_INFO("clean up the vf2pf work item\n");
+		flush_delayed_work(&adev->virt.vf2pf_work);
+		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+	}
+}
+
+void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
+{
 	uint64_t bp_block_offset = 0;
 	uint32_t bp_block_size = 0;
-	struct amdgim_pf2vf_info_v2 *pf2vf_v2 = NULL;
+	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
 
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
+	adev->virt.vf2pf_update_interval_ms = 0;
+
+	if (adev->fw_vram_usage.va != NULL) {
+		adev->virt.vf2pf_update_interval_ms = 2000;
 
-	if (adev->mman.fw_vram_usage_va != NULL) {
 		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)(
-			adev->mman.fw_vram_usage_va + AMDGIM_DATAEXCHANGE_OFFSET);
-		AMDGPU_FW_VRAM_PF2VF_READ(adev, header.size, &pf2vf_size);
-		AMDGPU_FW_VRAM_PF2VF_READ(adev, checksum, &checksum);
-		AMDGPU_FW_VRAM_PF2VF_READ(adev, feature_flags, &adev->virt.gim_feature);
-
-		/* pf2vf message must be in 4K */
-		if (pf2vf_size > 0 && pf2vf_size < 4096) {
-			if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
-				pf2vf_v2 = (struct amdgim_pf2vf_info_v2 *)adev->virt.fw_reserve.p_pf2vf;
-				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_L & 0xFFFFFFFF) |
-						((((uint64_t)pf2vf_v2->bp_block_offset_H) << 32) & 0xFFFFFFFF00000000);
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->fw_vram_usage.va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+		adev->virt.fw_reserve.p_vf2pf =
+			(struct amd_sriov_msg_vf2pf_info_header *)
+			(adev->fw_vram_usage.va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+
+		amdgpu_virt_read_pf2vf_data(adev);
+		amdgpu_virt_write_vf2pf_data(adev);
+
+		/* bad page handling for version 2 */
+		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
+				pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
+
+				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
+						((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
 				bp_block_size = pf2vf_v2->bp_block_size;
 
 				if (bp_block_size && !adev->virt.ras_init_done)
@@ -450,37 +610,11 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 				if (adev->virt.ras_init_done)
 					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
 			}
+	}
 
-			checkval = amdgpu_virt_fw_reserve_get_checksum(
-				adev->virt.fw_reserve.p_pf2vf, pf2vf_size,
-				adev->virt.fw_reserve.checksum_key, checksum);
-			if (checkval == checksum) {
-				adev->virt.fw_reserve.p_vf2pf =
-					((void *)adev->virt.fw_reserve.p_pf2vf +
-					pf2vf_size);
-				memset((void *)adev->virt.fw_reserve.p_vf2pf, 0,
-					sizeof(amdgim_vf2pf_info));
-				AMDGPU_FW_VRAM_VF2PF_WRITE(adev, header.version,
-					AMDGPU_FW_VRAM_VF2PF_VER);
-				AMDGPU_FW_VRAM_VF2PF_WRITE(adev, header.size,
-					sizeof(amdgim_vf2pf_info));
-				AMDGPU_FW_VRAM_VF2PF_READ(adev, driver_version,
-					&str);
-#ifdef MODULE
-				if (THIS_MODULE->version != NULL)
-					strcpy(str, THIS_MODULE->version);
-				else
-#endif
-					strcpy(str, "N/A");
-				AMDGPU_FW_VRAM_VF2PF_WRITE(adev, driver_cert,
-					0);
-				AMDGPU_FW_VRAM_VF2PF_WRITE(adev, checksum,
-					amdgpu_virt_fw_reserve_get_checksum(
-					adev->virt.fw_reserve.p_vf2pf,
-					pf2vf_size,
-					adev->virt.fw_reserve.checksum_key, 0));
-			}
-		}
+	if (adev->virt.vf2pf_update_interval_ms != 0) {
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
+		schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 082fb0736645..8dd624c20f89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -125,45 +125,6 @@ struct amdgim_pf2vf_info_v1 {
 	unsigned int checksum;
 } __aligned(4);
 
-/* TODO: below struct is duplicated to amd_sriov_msg_pf2vf_info */
-struct  amdgim_pf2vf_info_v2 {
-	/* header contains size and version */
-	struct amd_sriov_msg_pf2vf_info_header header;
-	/* use private key from mailbox 2 to create chueksum */
-	uint32_t checksum;
-	/* The features flags of the GIM driver supports. */
-	uint32_t feature_flags;
-	/* max_width * max_height */
-	uint32_t uvd_enc_max_pixels_count;
-	/* 16x16 pixels/sec, codec independent */
-	uint32_t uvd_enc_max_bandwidth;
-	/* max_width * max_height */
-	uint32_t vce_enc_max_pixels_count;
-	/* 16x16 pixels/sec, codec independent */
-	uint32_t vce_enc_max_bandwidth;
-	/* Bad pages block position in BYTE */
-	uint32_t bp_block_offset_L;
-	uint32_t bp_block_offset_H;
-	/* Bad pages block size in BYTE */
-	uint32_t bp_block_size;
-	/* MEC FW position in kb from the start of VF visible frame buffer */
-	uint32_t mecfw_kboffset_L;
-	uint32_t mecfw_kboffset_H;
-	/* MEC FW size in KB */
-	uint32_t mecfw_ksize;
-	/* UVD FW position in kb from the start of VF visible frame buffer */
-	uint32_t uvdfw_kboffset_L;
-	uint32_t uvdfw_kboffset_H;
-	/* UVD FW size in KB */
-	uint32_t uvdfw_ksize;
-	/* VCE FW position in kb from the start of VF visible frame buffer */
-	uint32_t vcefw_kboffset_L;
-	uint32_t vcefw_kboffset_H;
-	/* VCE FW size in KB */
-	uint32_t vcefw_ksize;
-	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 0, 0, (18 + sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 0)];
-} __aligned(4);
-
 struct amdgim_vf2pf_info_v1 {
 	/* header contains size and version */
 	struct amd_sriov_msg_vf2pf_info_header header;
@@ -225,32 +186,6 @@ struct amdgim_vf2pf_info_v2 {
 	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 64, 0, (12 + sizeof(struct amd_sriov_msg_vf2pf_info_header)/sizeof(uint32_t)), 0)];
 } __aligned(4);
 
-/* TODO: below macro and typedef will cause compile error, need to remove */
-#define AMDGPU_FW_VRAM_VF2PF_VER 2
-typedef struct amd_sriov_msg_vf2pf_info amdgim_vf2pf_info;
-
-#define AMDGPU_FW_VRAM_VF2PF_WRITE(adev, field, val) \
-	do { \
-		((amdgim_vf2pf_info *)adev->virt.fw_reserve.p_vf2pf)->field = (val); \
-	} while (0)
-
-#define AMDGPU_FW_VRAM_VF2PF_READ(adev, field, val) \
-	do { \
-		(*val) = ((amdgim_vf2pf_info *)adev->virt.fw_reserve.p_vf2pf)->field; \
-	} while (0)
-
-#define AMDGPU_FW_VRAM_PF2VF_READ(adev, field, val) \
-	do { \
-		if (!adev->virt.fw_reserve.p_pf2vf) \
-			*(val) = 0; \
-		else { \
-			if (adev->virt.fw_reserve.p_pf2vf->version == 1) \
-				*(val) = ((struct amdgim_pf2vf_info_v1 *)adev->virt.fw_reserve.p_pf2vf)->field; \
-			if (adev->virt.fw_reserve.p_pf2vf->version == 2) \
-				*(val) = ((struct amdgim_pf2vf_info_v2 *)adev->virt.fw_reserve.p_pf2vf)->field; \
-		} \
-	} while (0)
-
 struct amdgpu_virt_ras_err_handler_data {
 	/* point to bad page records array */
 	struct eeprom_table_record *bps;
@@ -274,7 +209,7 @@ struct amdgpu_virt {
 	struct work_struct		flr_work;
 	struct amdgpu_mm_table		mm_table;
 	const struct amdgpu_virt_ops	*ops;
-	struct amdgpu_vf_error_buffer   vf_errors;
+	struct amdgpu_vf_error_buffer	vf_errors;
 	struct amdgpu_virt_fw_reserve	fw_reserve;
 	uint32_t gim_feature;
 	uint32_t reg_access_mode;
@@ -282,6 +217,10 @@ struct amdgpu_virt {
 	bool tdr_debug;
 	struct amdgpu_virt_ras_err_handler_data *virt_eh_data;
 	bool ras_init_done;
+
+	/* vf2pf message */
+	struct delayed_work vf2pf_work;
+	uint32_t vf2pf_update_interval_ms;
 };
 
 #define amdgpu_sriov_enabled(adev) \
@@ -330,11 +269,9 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
 int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
-int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
-					unsigned int key,
-					unsigned int chksum);
 void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
+void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
