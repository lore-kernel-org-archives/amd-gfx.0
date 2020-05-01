Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D7C47253
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 17:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FE720731
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 17:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FE720731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BE76ED1D;
	Fri,  1 May 2020 17:57:18 +0000 (UTC)
X-Greylist: delayed 527 seconds by postgrey-1.36 at gabe;
 Fri, 01 May 2020 17:57:16 UTC
Received: from smcg.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9BE576ED1D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 17:57:16 +0000 (UTC)
Received: by smcg.amd.com (Postfix, from userid 0)
 id AA4404215A6; Fri,  1 May 2020 13:48:26 -0400 (EDT)
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] SWDEV-220451 - Query guest's information by VF2PF message -
 part 2
Date: Fri,  1 May 2020 13:48:18 -0400
Message-Id: <20200501174818.35669-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Guest side change

- Refactor and implement VF2PF information

- Share checksum function between guest and host

- Refactor code in amdgpu_virt.c since some of them are useless

Change-Id: I881989d8fb6b6af88209badf4c4070c281f65b6a
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 249 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 232 ++++++++++++-------
 3 files changed, 354 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a928fa9077c6..37f1d2669d51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3305,8 +3305,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
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
index 8c10084f44ef..b83212b76277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -27,6 +27,12 @@
 
 #include "amdgpu.h"
 
+#define POPULATE_UCODE_INFO(vf2pf_info, ucode, ver) \
+	do { \
+		vf2pf_info->ucode_info[ucode].id = ucode; \
+		vf2pf_info->ucode_info[ucode].version = ver; \
+	} while (0)
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
 	/* By now all MMIO pages except mailbox are blocked */
@@ -228,77 +234,212 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev)
 	adev->virt.mm_table.gpu_addr = 0;
 }
 
-
-int amdgpu_virt_fw_reserve_get_checksum(void *obj,
-					unsigned long obj_size,
-					unsigned int key,
-					unsigned int chksum)
+/*
+ * encode: obj.checksum = amd_sriov_msg_checksum(obj, size, key, 0)
+ * decode:            0 = amd_sriov_msg_checksum(obj, size, key, obj.checksum)
+ */
+unsigned int amd_sriov_msg_checksum(void *obj,
+				unsigned long obj_size,
+				unsigned int key,
+				unsigned int checksum)
 {
-	unsigned int ret = key;
+	unsigned int ret = 0;
 	unsigned long i = 0;
 	unsigned char *pos;
 
-	pos = (char *)obj;
-	/* calculate checksum */
+	/* calculate checksum of obj*/
+	pos = (unsigned char *)obj;
 	for (i = 0; i < obj_size; ++i)
 		ret += *(pos + i);
-	/* minus the chksum itself */
-	pos = (char *)&chksum;
-	for (i = 0; i < sizeof(chksum); ++i)
+
+	pos = (unsigned char *)&checksum;
+	for (i = 0; i < sizeof(checksum); ++i)
 		ret -= *(pos + i);
+
+	ret ^= key;
+
+	ret -= checksum;
+
 	return ret;
 }
 
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
+static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
+	uint32_t checksum;
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
+		checksum = amd_sriov_msg_checksum(
+			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+			adev->virt.fw_reserve.checksum_key, checksum);
+		if (checksum != 0) {
+			DRM_ERROR("invalid pf2vf message\n");
+			return -EINVAL;
+		}
+
+		adev->virt.vf2pf_update_interval_ms = 0;
+		adev->virt.gim_feature =
+			((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->feature_flags;
+		break;
+	case 2:
+		checksum = pf2vf_info->checksum;
+		checksum = amd_sriov_msg_checksum(
+			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+			0, checksum);
+		if (checksum != 0) {
+			DRM_ERROR("invalid pf2vf message\n");
+			return -EINVAL;
+		}
+
+		adev->virt.vf2pf_update_interval_ms =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->vf2pf_update_interval_ms;
+		adev->virt.gim_feature =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
+		break;
+	default:
+		DRM_ERROR("invalid pf2vf version\n");
+		return -EINVAL;
+	}
+
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
 {
-	uint32_t pf2vf_size = 0;
-	uint32_t checksum = 0;
-	uint32_t checkval;
-	char *str;
+	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
 
+	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
+
+	if (adev->virt.fw_reserve.p_vf2pf == NULL)
+		return -EINVAL;
+
+	memset(vf2pf_info, 0, sizeof(struct amd_sriov_msg_vf2pf_info));
+
+	vf2pf_info->header.size = sizeof(struct amd_sriov_msg_vf2pf_info);
+	vf2pf_info->header.version = AMDGPU_FW_VRAM_VF2PF_VER;
+
+#ifdef MODULE
+	if (THIS_MODULE->version != NULL)
+		strcpy(vf2pf_info->driver_version, THIS_MODULE->version);
+	else
+#endif
+		strcpy(vf2pf_info->driver_version, "N/A");
+
+	vf2pf_info->pf2vf_version_required = 0; // no requirement
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
+	/* TODO read dynamic info */
+	vf2pf_info->gfx_usage = 0;
+	vf2pf_info->gfx_health = 0;
+	vf2pf_info->compute_usage = 0;
+	vf2pf_info->compute_health = 0;
+	vf2pf_info->avc_enc_usage = 0;
+	vf2pf_info->avc_enc_health = 0;
+	vf2pf_info->hevc_enc_usage = 0;
+	vf2pf_info->hevc_enc_health = 0;
+
+	vf2pf_info->header.checksum =
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
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
+	adev->virt.vf2pf_update_interval_ms = 0;
 
 	if (adev->fw_vram_usage.va != NULL) {
+		/* default 2 second */
+		adev->virt.vf2pf_update_interval_ms = 2000;
+
 		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)(
-			adev->fw_vram_usage.va + AMDGIM_DATAEXCHANGE_OFFSET);
-		AMDGPU_FW_VRAM_PF2VF_READ(adev, header.size, &pf2vf_size);
-		AMDGPU_FW_VRAM_PF2VF_READ(adev, checksum, &checksum);
-		AMDGPU_FW_VRAM_PF2VF_READ(adev, feature_flags, &adev->virt.gim_feature);
-
-		/* pf2vf message must be in 4K */
-		if (pf2vf_size > 0 && pf2vf_size < 4096) {
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
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->fw_vram_usage.va + AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET);
+		adev->virt.fw_reserve.p_vf2pf =
+			(struct amd_sriov_msg_vf2pf_info_header *)
+			((void *)adev->virt.fw_reserve.p_pf2vf + AMD_SRIOV_MSG_SIZE);
+
+		amdgpu_virt_read_pf2vf_data(adev);
+		amdgpu_virt_write_vf2pf_data(adev);
+	}
+
+	if (adev->virt.vf2pf_update_interval_ms != 0) {
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
+		schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index de27308802c9..4f2f5481d7a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -35,6 +35,31 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
+enum amd_sriov_ucode_engine_id {
+	AMD_SRIOV_UCODE_ID_VCE = 0,
+	AMD_SRIOV_UCODE_ID_UVD,
+	AMD_SRIOV_UCODE_ID_MC,
+	AMD_SRIOV_UCODE_ID_ME,
+	AMD_SRIOV_UCODE_ID_PFP,
+	AMD_SRIOV_UCODE_ID_CE,
+	AMD_SRIOV_UCODE_ID_RLC,
+	AMD_SRIOV_UCODE_ID_RLC_SRLC,
+	AMD_SRIOV_UCODE_ID_RLC_SRLG,
+	AMD_SRIOV_UCODE_ID_RLC_SRLS,
+	AMD_SRIOV_UCODE_ID_MEC,
+	AMD_SRIOV_UCODE_ID_MEC2,
+	AMD_SRIOV_UCODE_ID_SOS,
+	AMD_SRIOV_UCODE_ID_ASD,
+	AMD_SRIOV_UCODE_ID_TA_RAS,
+	AMD_SRIOV_UCODE_ID_TA_XGMI,
+	AMD_SRIOV_UCODE_ID_SMC,
+	AMD_SRIOV_UCODE_ID_SDMA,
+	AMD_SRIOV_UCODE_ID_SDMA2,
+	AMD_SRIOV_UCODE_ID_VCN,
+	AMD_SRIOV_UCODE_ID_DMCU,
+	AMD_SRIOV_UCODE_ID__MAX
+};
+
 struct amdgpu_mm_table {
 	struct amdgpu_bo	*bo;
 	uint32_t		*cpu_addr;
@@ -73,11 +98,13 @@ struct amdgpu_virt_fw_reserve {
 	struct amd_sriov_msg_vf2pf_info_header *p_vf2pf;
 	unsigned int checksum_key;
 };
+
 /*
  * Defination between PF and VF
  * Structures forcibly aligned to 4 to keep the same style as PF.
  */
-#define AMDGIM_DATAEXCHANGE_OFFSET		(64 * 1024)
+#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET		(64 * 1024)
+#define AMD_SRIOV_MSG_SIZE				(1024)
 
 #define AMDGIM_GET_STRUCTURE_RESERVED_SIZE(total, u8, u16, u32, u64) \
 		(total - (((u8)+3) / 4 + ((u16)+1) / 2 + (u32) + (u64)*2))
@@ -95,14 +122,118 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_PP_ONE_VF = (1 << 4),
 };
 
+#pragma pack(push, 1)
+union amd_sriov_msg_feature_flags
+{
+	struct {
+		uint32_t  error_log_collect  : 1;
+		uint32_t  host_load_ucodes   : 1;
+		uint32_t  host_flr_vramlost  : 1;
+		uint32_t  mm_bw_management   : 1;
+		uint32_t  pp_one_vf_mode     : 1;
+		uint32_t  reserved           : 27;
+	} flags;
+	uint32_t      all;
+};
+
+union amd_sriov_msg_os_info
+{
+	struct {
+		uint32_t  windows            : 1;
+		uint32_t  reserved           : 31;
+	} info;
+	uint32_t      all;
+};
+
+/* PF to VF message header */
 struct amd_sriov_msg_pf2vf_info_header {
 	/* the total structure size in byte. */
 	uint32_t size;
 	/* version of this structure, written by the GIM */
 	uint32_t version;
+	/* 32 bit checksum */
+	uint32_t checksum;
 	/* reserved */
-	uint32_t reserved[2];
-} __aligned(4);
+	uint32_t reserved[1];
+};
+
+/* PF to VF message struct, libgv */
+struct  amd_sriov_msg_pf2vf_info {
+	/* header contains size and version */
+	struct amd_sriov_msg_pf2vf_info_header header;
+	/* frequency for VF to update the VF2PF area in msec, 0 = manual */
+	uint32_t vf2pf_update_interval_ms;
+	/* The features flags of the HOST driver supports */
+	union amd_sriov_msg_feature_flags feature_flags;
+	/* (max_width * max_height * fps) / (16 * 16) */
+	uint32_t hevc_enc_max_mb_per_second;
+	/* (max_width * max_height) / (16 * 16) */
+	uint32_t hevc_enc_max_mb_per_frame;
+	/* (max_width * max_height * fps) / (16 * 16) */
+	uint32_t avc_enc_max_mb_per_second;
+	/* (max_width * max_height) / (16 * 16) */
+	uint32_t avc_enc_max_mb_per_frame;
+	/* reserved */
+	uint32_t reserved[256-10];
+};
+
+/* VF to PF message header */
+struct amd_sriov_msg_vf2pf_info_header {
+	/* the total structure size in byte. */
+	uint32_t size;
+	/* version of this structure, written by the GIM */
+	uint32_t version;
+	/* 32 bit checksum */
+	uint32_t checksum;
+	/* reserved */
+	uint32_t reserved[1];
+};
+
+/* VF to PF message struct, libgv */
+struct amd_sriov_msg_vf2pf_info {
+	/* header contains size and version */
+	struct amd_sriov_msg_vf2pf_info_header header;
+	/* Version of PF2VF that VF understands */
+	uint32_t pf2vf_version_required;
+	/* driver version */
+	uint8_t  driver_version[64];
+	/* driver certification, 1=WHQL, 0=None */
+	uint32_t driver_cert;
+	/* guest OS type and version */
+	union amd_sriov_msg_os_info os_info;
+	/* guest fb information in the unit of MB */
+	uint32_t fb_size;
+	uint32_t fb_vis_size;
+	uint32_t fb_usage;
+	uint32_t fb_vis_usage;
+	/* guest gfx engine usage percentage */
+	uint32_t gfx_usage;
+	/* guest gfx engine health percentage */
+	uint32_t gfx_health;
+	/* guest compute engine usage percentage */
+	uint32_t compute_usage;
+	/* guest compute engine health percentage */
+	uint32_t compute_health;
+	/* guest avc engine usage percentage. 0xffff means N/A */
+	uint32_t avc_enc_usage;
+	/* guest avc engine health percentage. 0xffff means N/A */
+	uint32_t avc_enc_health;
+	/* guest hevc engine usage percentage. 0xffff means N/A */
+	uint32_t hevc_enc_usage;
+	/* guest hevc engine usage percentage. 0xffff means N/A */
+	uint32_t hevc_enc_health;
+	/* guest ucode data */
+	struct {
+		uint8_t  id;
+		uint32_t version;
+	} ucode_info[40];
+
+	/* reserved */
+	uint32_t reserved[256-85];
+};
+#pragma pack(pop)
+
+/* PF to VF message struct, amdgim */
 struct  amdgim_pf2vf_info_v1 {
 	/* header contains size and version */
 	struct amd_sriov_msg_pf2vf_info_header header;
@@ -122,46 +253,7 @@ struct  amdgim_pf2vf_info_v1 {
 	unsigned int checksum;
 } __aligned(4);
 
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
-	/* MEC FW position in kb from the start of VF visible frame buffer */
-	uint64_t mecfw_kboffset;
-	/* MEC FW size in KB */
-	uint32_t mecfw_ksize;
-	/* UVD FW position in kb from the start of VF visible frame buffer */
-	uint64_t uvdfw_kboffset;
-	/* UVD FW size in KB */
-	uint32_t uvdfw_ksize;
-	/* VCE FW position in kb from the start of VF visible frame buffer */
-	uint64_t vcefw_kboffset;
-	/* VCE FW size in KB */
-	uint32_t vcefw_ksize;
-	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 0, 0, (9 + sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 3)];
-} __aligned(4);
-
-
-struct amd_sriov_msg_vf2pf_info_header {
-	/* the total structure size in byte. */
-	uint32_t size;
-	/*version of this structure, written by the guest */
-	uint32_t version;
-	/* reserved */
-	uint32_t reserved[2];
-} __aligned(4);
-
+/* VF to PF message struct, amdgim */
 struct amdgim_vf2pf_info_v1 {
 	/* header contains size and version */
 	struct amd_sriov_msg_vf2pf_info_header header;
@@ -192,6 +284,7 @@ struct amdgim_vf2pf_info_v1 {
 	unsigned int checksum;
 } __aligned(4);
 
+/* VF to PF message struct, amdgim */
 struct amdgim_vf2pf_info_v2 {
 	/* header contains size and version */
 	struct amd_sriov_msg_vf2pf_info_header header;
@@ -223,49 +316,30 @@ struct amdgim_vf2pf_info_v2 {
 	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 64, 0, (12 + sizeof(struct amd_sriov_msg_vf2pf_info_header)/sizeof(uint32_t)), 0)];
 } __aligned(4);
 
-#define AMDGPU_FW_VRAM_VF2PF_VER 2
-typedef struct amdgim_vf2pf_info_v2 amdgim_vf2pf_info ;
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
+#define AMDGPU_FW_VRAM_VF2PF_VER 3
 
 /* GPU virtualization */
 struct amdgpu_virt {
 	uint32_t			caps;
 	struct amdgpu_bo		*csa_obj;
 	void				*csa_cpu_addr;
-	bool chained_ib_support;
+	bool				chained_ib_support;
 	uint32_t			reg_val_offs;
 	struct amdgpu_irq_src		ack_irq;
 	struct amdgpu_irq_src		rcv_irq;
 	struct work_struct		flr_work;
 	struct amdgpu_mm_table		mm_table;
 	const struct amdgpu_virt_ops	*ops;
-	struct amdgpu_vf_error_buffer   vf_errors;
+	struct amdgpu_vf_error_buffer	vf_errors;
 	struct amdgpu_virt_fw_reserve	fw_reserve;
-	uint32_t gim_feature;
-	uint32_t reg_access_mode;
-	int req_init_data_ver;
-	bool tdr_debug;
+	uint32_t			gim_feature;
+	uint32_t			reg_access_mode;
+	int				req_init_data_ver;
+	bool				tdr_debug;
+
+	/* vf2pf message */
+	struct delayed_work 		vf2pf_work;
+	uint32_t			vf2pf_update_interval_ms;
 };
 
 #define amdgpu_sriov_enabled(adev) \
@@ -314,13 +388,19 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
 int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
-int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
-					unsigned int key,
-					unsigned int chksum);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
+void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
+
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
 void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
+
+/* checksum function between host and guest */
+unsigned int amd_sriov_msg_checksum(void *obj,
+				unsigned long obj_size,
+				unsigned int key,
+				unsigned int checksum);
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
