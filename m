Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEB3C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6ED661214
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6ED661214
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D7589834;
	Mon, 23 Aug 2021 20:35:05 +0000 (UTC)
X-Greylist: delayed 496 seconds by postgrey-1.36 at gabe;
 Mon, 23 Aug 2021 20:35:03 UTC
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4967A89834
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 20:35:03 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id 3AB6918402F0; Mon, 23 Aug 2021 16:26:46 -0400 (EDT)
From: Bokun Zhang <bokun.zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Bokun Zhang <bokun.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add driver cap firmware for SRIOV guest driver
Date: Mon, 23 Aug 2021 16:26:43 -0400
Message-Id: <20210823202643.46899-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.20.1
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

Add driver cap firmware code path for SRIOV guest driver

Add a new function psp_init_sriov_microcode to make the
code flow more smooth instead of calling amdgpu_sriov_vf()
all over the place

remove the sriov check in psp_v11_0 navi asic since
it is redundant

Change-Id: I42bc8a2f92f09fccf795345e849e795992ce25cf
Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   | 14 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 99 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c     |  1 +
 include/uapi/drm/amdgpu_drm.h             |  2 +
 8 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 7e45640fbee0..24f6afed5aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -393,6 +393,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->ver = adev->psp.toc.fw_version;
 		fw_info->feature = adev->psp.toc.feature_version;
 		break;
+	case AMDGPU_INFO_FW_CAP:
+		fw_info->ver = adev->psp.cap_fw_version;
+		fw_info->feature = adev->psp.cap_feature_version;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1607,6 +1611,16 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	seq_printf(m, "TOC feature version: %u, firmware version: 0x%08x\n",
 		   fw_info.feature, fw_info.ver);
 
+	/* CAP */
+	if (adev->psp.cap_fw) {
+		query_fw.fw_type = AMDGPU_INFO_FW_CAP;
+		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
+		if (ret)
+			return ret;
+		seq_printf(m, "CAP feature version: %u, firmware version: 0x%08x\n",
+				fw_info.feature, fw_info.ver);
+	}
+
 	seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 23efdc672502..fe90947cbb3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -244,6 +244,33 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int psp_init_sriov_microcode(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret = 0;
+
+	/* NOTE: I may missed some SRIOV ASIC? */
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+		ret = psp_init_cap_microcode(psp, "vega10");
+		break;
+	case CHIP_NAVI12:
+		ret = psp_init_cap_microcode(psp, "navi12");
+		break;
+	case CHIP_SIENNA_CICHLID:
+		ret = psp_init_cap_microcode(psp, "sienna_cichlid");
+		break;
+	case CHIP_ALDEBARAN:
+		ret = psp_init_ta_microcode(psp, "aldebaran");
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return ret;
+}
+
 static int psp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -258,16 +285,16 @@ static int psp_sw_init(void *handle)
 		ret = -ENOMEM;
 	}
 
-	if (!amdgpu_sriov_vf(adev)) {
-		ret = psp_init_microcode(psp);
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_init_sriov_microcode(psp);
 		if (ret) {
-			DRM_ERROR("Failed to load psp firmware!\n");
+			DRM_ERROR("Failed to load sriov psp firmware!\n");
 			return ret;
 		}
-	} else if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_ALDEBARAN) {
-		ret = psp_init_ta_microcode(psp, "aldebaran");
+	} else {
+		ret = psp_init_microcode(psp);
 		if (ret) {
-			DRM_ERROR("Failed to initialize ta microcode!\n");
+			DRM_ERROR("Failed to load psp firmware!\n");
 			return ret;
 		}
 	}
@@ -336,6 +363,10 @@ static int psp_sw_fini(void *handle)
 		release_firmware(psp->ta_fw);
 		psp->ta_fw = NULL;
 	}
+	if (psp.cap_fw) {
+		release_firmware(adev->psp.cap_fw);
+		adev->psp.cap_fw = NULL;
+	}
 
 	if (adev->asic_type == CHIP_NAVI10 ||
 	    adev->asic_type == CHIP_SIENNA_CICHLID)
@@ -474,7 +505,10 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		DRM_WARN("psp gfx command (%s) failed and response status is (0x%X)\n",
 			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
 			 psp->cmd_buf_mem->resp.status);
-		if (!timeout) {
+		/* return failure for CAP firmware since PSP must response 0 under SRIOV
+		 * also return failure in case of timeout
+		 */
+		if ((ucode->ucode_id == AMDGPU_UCODE_ID_CAP) || !timeout) {
 			ret = -EINVAL;
 			goto exit;
 		}
@@ -2237,6 +2271,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type)
 {
 	switch (ucode->ucode_id) {
+	case AMDGPU_UCODE_ID_CAP:
+		*type = GFX_FW_TYPE_CAP;
+		break;
 	case AMDGPU_UCODE_ID_SDMA0:
 		*type = GFX_FW_TYPE_SDMA0;
 		break;
@@ -3380,6 +3417,54 @@ int psp_init_ta_microcode(struct psp_context *psp,
 	return err;
 }
 
+int psp_init_cap_microcode(struct psp_context *psp,
+			  const char *chip_name)
+{
+	struct amdgpu_device *adev = psp->adev;
+	char fw_name[PSP_FW_NAME_LEN];
+	int err = 0;
+	const struct psp_firmware_header_v1_0 *cap_hdr_v1_0;
+	struct amdgpu_firmware_info *info = NULL;
+
+	if (!chip_name) {
+		dev_err(adev->dev, "invalid chip name for cap microcode\n");
+		return -EINVAL;
+	}
+
+	if (!amdgpu_sriov_vf(adev)) {
+		dev_err(adev->dev, "cap microcode should only be loaded under SRIOV\n");
+		return -EINVAL;
+	}
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_cap.bin", chip_name);
+	err = request_firmware(&adev->psp.cap_fw, fw_name, adev->dev);
+	if (err)
+		goto out;
+
+	err = amdgpu_ucode_validate(adev->psp.cap_fw);
+	if (err)
+		goto out;
+
+	info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CAP];
+	info->ucode_id = AMDGPU_UCODE_ID_CAP;
+	info->fw = adev->psp.cap_fw;
+	cap_hdr_v1_0 = (const struct psp_firmware_header_v1_0 *)
+		adev->psp.cap_fw->data;
+	adev->firmware.fw_size += ALIGN(
+			le32_to_cpu(cap_hdr_v1_0->header.ucode_size_bytes), PAGE_SIZE);
+	adev->psp.cap_fw_version = le32_to_cpu(cap_hdr_v1_0->header.ucode_version);
+	adev->psp.cap_feature_version = le32_to_cpu(cap_hdr_v1_0->sos.fw_version);
+	adev->psp.cap_ucode_size = le32_to_cpu(cap_hdr_v1_0->header.ucode_size_bytes);
+
+	return 0;
+
+out:
+	dev_err(adev->dev, "fail to initialize cap microcode\n");
+	release_firmware(adev->psp.cap_fw);
+	adev->psp.cap_fw = NULL;
+	return err;
+}
+
 static int psp_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 8ef2d28af92a..4ab3dcc08772 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -303,6 +303,9 @@ struct psp_context
 	const struct firmware	*asd_fw;
 	struct psp_bin_desc		asd;
 
+	/* cap firmware */
+	const struct firmware           *cap_fw;
+
 	/* toc firmware */
 	const struct firmware		*toc_fw;
 
@@ -333,6 +336,10 @@ struct psp_context
 	struct psp_bin_desc		rap;
 	struct psp_bin_desc		securedisplay;
 
+	uint32_t			cap_fw_version;
+	uint32_t			cap_feature_version;
+	uint32_t			cap_ucode_size;
+
 	struct psp_asd_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
 	struct psp_ras_context		ras_context;
@@ -446,6 +453,8 @@ int psp_init_sos_microcode(struct psp_context *psp,
 			   const char *chip_name);
 int psp_init_ta_microcode(struct psp_context *psp,
 			  const char *chip_name);
+int psp_init_cap_microcode(struct psp_context *psp,
+			  const char *chip_name);
 int psp_get_fw_attestation_records_addr(struct psp_context *psp,
 					uint64_t *output_ptr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 7c2538db3cd5..40dffbac85a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -343,7 +343,8 @@ union amdgpu_firmware_header {
  * fw loading support
  */
 enum AMDGPU_UCODE_ID {
-	AMDGPU_UCODE_ID_SDMA0 = 0,
+	AMDGPU_UCODE_ID_CAP = 0,
+	AMDGPU_UCODE_ID_SDMA0,
 	AMDGPU_UCODE_ID_SDMA1,
 	AMDGPU_UCODE_ID_SDMA2,
 	AMDGPU_UCODE_ID_SDMA3,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index dd0dce254901..1f276ddd26e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -258,6 +258,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_SDMA6                           = 56,   /* SDMA6                    MI      */
 	GFX_FW_TYPE_SDMA7                           = 57,   /* SDMA7                    MI      */
 	GFX_FW_TYPE_VCN1                            = 58,   /* VCN1                     MI      */
+	GFX_FW_TYPE_CAP                             = 62,   /* CAP_FW                           */
 	GFX_FW_TYPE_REG_LIST                        = 67,   /* REG_LIST                 MI      */
 	GFX_FW_TYPE_MAX
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 29bf9f09944b..3062d2292d5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -53,11 +53,13 @@ MODULE_FIRMWARE("amdgpu/navi14_ta.bin");
 MODULE_FIRMWARE("amdgpu/navi12_sos.bin");
 MODULE_FIRMWARE("amdgpu/navi12_asd.bin");
 MODULE_FIRMWARE("amdgpu/navi12_ta.bin");
+MODULE_FIRMWARE("amdgpu/navi12_cap.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_sos.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_asd.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sos.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_ta.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_cap.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sos.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_asd.bin");
@@ -171,8 +173,6 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
 			return err;
-		if (amdgpu_sriov_vf(adev))
-			break;
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
 		err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
 		if (err) {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 1ed357cb0f49..01f3bcc62a6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -44,6 +44,7 @@
 
 MODULE_FIRMWARE("amdgpu/vega10_sos.bin");
 MODULE_FIRMWARE("amdgpu/vega10_asd.bin");
+MODULE_FIRMWARE("amdgpu/vega10_cap.bin");
 MODULE_FIRMWARE("amdgpu/vega12_sos.bin");
 MODULE_FIRMWARE("amdgpu/vega12_asd.bin");
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0cbd1540aeac..cc7c5da291ad 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -728,6 +728,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_FW_DMCUB		0x14
 	/* Subquery id: Query TOC firmware version */
 	#define AMDGPU_INFO_FW_TOC		0x15
+	/* Subquery id: Query CAP firmware version */
+	#define AMDGPU_INFO_FW_CAP		0x16
 
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
-- 
2.20.1

