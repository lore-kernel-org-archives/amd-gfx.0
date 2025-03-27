Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C59C36017
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F4310E94C;
	Thu, 27 Mar 2025 20:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LxDF+qvF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D708210E941
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B61B6614BF;
 Thu, 27 Mar 2025 20:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F825C4CEDD;
 Thu, 27 Mar 2025 20:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107952;
 bh=q7qVmWgilCjoVG4z9xaMuIVDP3GuSV4ZIy2+8JG42lg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LxDF+qvFpV+DJafURFY+Bbtxz+A97Rn1PdAIx6uKfjkfiku52A2dZwLokjbbkCSqu
 z1u5piKEy0iKhwrXe8gy/iRHPJlnxi7gZ94DTQFIzngkXRtGUuQuEepwiQgZDp8Swr
 bKrpcnOmlsWNl7Ykd+invefHd+MTiWGZzDoKuciwtQT3q3GyWVPcMiDuMuyTT/Oikl
 3aiL7SfGhhpqheQ2y+umAL4gS16pAryXptIDLJGnvINcGxO8tXxZQiU64stWS/c23Z
 vQPSpYvNEyNiXnALPTdasz9flPr+mFUW8AsFPQFpKLZ9TXZJm6ovKS0bpy5Z5OUqxA
 r27COuWBe7qCw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 07/14] drm/amd: Add a 'struct amdgpu_device' argument to all
 header printers
Date: Thu, 27 Mar 2025 15:38:51 -0500
Message-ID: <20250327203858.3796086-8-superm1@kernel.org>
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

To allow header printing to reflect the correct GPU, pass the device
into all functions.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 14 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 24 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     | 21 ++++++++++------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 14 +++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  6 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  8 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 10 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 10 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c    |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  2 +-
 27 files changed, 81 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 004a6a9d6b9fa..c9df887579545 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -373,7 +373,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		}
 
 		hdr = (const struct smc_firmware_header_v1_0 *)	adev->pm.fw->data;
-		amdgpu_ucode_print_smc_hdr(&hdr->header);
+		amdgpu_ucode_print_smc_hdr(adev, &hdr->header);
 		adev->pm.fw_version = le32_to_cpu(hdr->header.ucode_version);
 		ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes);
 		ucode_start_address = le32_to_cpu(hdr->ucode_start_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4b01ef000256..68d00e8cdaaf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2546,7 +2546,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	}
 
 	hdr = (const struct gpu_info_firmware_header_v1_0 *)adev->firmware.gpu_info_fw->data;
-	amdgpu_ucode_print_gpu_info_hdr(&hdr->header);
+	amdgpu_ucode_print_gpu_info_hdr(adev, &hdr->header);
 
 	switch (hdr->version_major) {
 	case 1:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dbc3313fc1419..6be3692561f6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2710,31 +2710,31 @@ static void psp_print_fw_hdr(struct psp_context *psp,
 	case AMDGPU_UCODE_ID_SDMA7:
 		hdr = (struct common_firmware_header *)
 			adev->sdma.instance[ucode->ucode_id - AMDGPU_UCODE_ID_SDMA0].fw->data;
-		amdgpu_ucode_print_sdma_hdr(hdr);
+		amdgpu_ucode_print_sdma_hdr(adev, hdr);
 		break;
 	case AMDGPU_UCODE_ID_CP_CE:
 		hdr = (struct common_firmware_header *)adev->gfx.ce_fw->data;
-		amdgpu_ucode_print_gfx_hdr(hdr);
+		amdgpu_ucode_print_gfx_hdr(adev, hdr);
 		break;
 	case AMDGPU_UCODE_ID_CP_PFP:
 		hdr = (struct common_firmware_header *)adev->gfx.pfp_fw->data;
-		amdgpu_ucode_print_gfx_hdr(hdr);
+		amdgpu_ucode_print_gfx_hdr(adev, hdr);
 		break;
 	case AMDGPU_UCODE_ID_CP_ME:
 		hdr = (struct common_firmware_header *)adev->gfx.me_fw->data;
-		amdgpu_ucode_print_gfx_hdr(hdr);
+		amdgpu_ucode_print_gfx_hdr(adev, hdr);
 		break;
 	case AMDGPU_UCODE_ID_CP_MEC1:
 		hdr = (struct common_firmware_header *)adev->gfx.mec_fw->data;
-		amdgpu_ucode_print_gfx_hdr(hdr);
+		amdgpu_ucode_print_gfx_hdr(adev, hdr);
 		break;
 	case AMDGPU_UCODE_ID_RLC_G:
 		hdr = (struct common_firmware_header *)adev->gfx.rlc_fw->data;
-		amdgpu_ucode_print_rlc_hdr(hdr);
+		amdgpu_ucode_print_rlc_hdr(adev, hdr);
 		break;
 	case AMDGPU_UCODE_ID_SMC:
 		hdr = (struct common_firmware_header *)adev->pm.fw->data;
-		amdgpu_ucode_print_smc_hdr(hdr);
+		amdgpu_ucode_print_smc_hdr(adev, hdr);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 3d9e9fdc10b47..a28cd5e962cce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -30,7 +30,8 @@
 
 #define AMDGPU_UCODE_NAME_MAX		(128)
 
-static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
+static void amdgpu_ucode_print_common_hdr(struct amdgpu_device *adev,
+					  const struct common_firmware_header *hdr)
 {
 	DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
 	DRM_DEBUG("header_size_bytes: %u\n", le32_to_cpu(hdr->header_size_bytes));
@@ -45,7 +46,8 @@ static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *h
 	DRM_DEBUG("crc32: 0x%08x\n", le32_to_cpu(hdr->crc32));
 }
 
-void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr)
+void amdgpu_ucode_print_mc_hdr(struct amdgpu_device *adev,
+			       const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
@@ -66,7 +68,8 @@ void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr)
 	}
 }
 
-void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr)
+void amdgpu_ucode_print_smc_hdr(struct amdgpu_device *adev,
+				const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
@@ -101,7 +104,8 @@ void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr)
 	}
 }
 
-void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr)
+void amdgpu_ucode_print_gfx_hdr(struct amdgpu_device *adev,
+				const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
@@ -128,7 +132,8 @@ void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr)
 	}
 }
 
-void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
+void amdgpu_ucode_print_rlc_hdr(struct amdgpu_device *adev,
+				const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
@@ -291,7 +296,8 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 	}
 }
 
-void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr)
+void amdgpu_ucode_print_sdma_hdr(struct amdgpu_device *adev,
+				 const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
@@ -337,7 +343,8 @@ void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr)
 	}
 }
 
-void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr)
+void amdgpu_ucode_print_psp_hdr(struct amdgpu_device *adev,
+				const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
@@ -484,7 +491,8 @@ void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr)
 	}
 }
 
-void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr)
+void amdgpu_ucode_print_gpu_info_hdr(struct amdgpu_device *adev,
+				     const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index e7fe4fd25e601..bb3e534719c72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -602,13 +602,20 @@ struct amdgpu_firmware {
 	uint64_t fw_buf_mc;
 };
 
-void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr);
-void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr);
-void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr);
-void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
-void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
-void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
-void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
+void amdgpu_ucode_print_mc_hdr(struct amdgpu_device *adev,
+			       const struct common_firmware_header *hdr);
+void amdgpu_ucode_print_smc_hdr(struct amdgpu_device *adev,
+			       const struct common_firmware_header *hdr);
+void amdgpu_ucode_print_gfx_hdr(struct amdgpu_device *adev,
+			       const struct common_firmware_header *hdr);
+void amdgpu_ucode_print_rlc_hdr(struct amdgpu_device *adev,
+			       const struct common_firmware_header *hdr);
+void amdgpu_ucode_print_sdma_hdr(struct amdgpu_device *adev,
+			       const struct common_firmware_header *hdr);
+void amdgpu_ucode_print_psp_hdr(struct amdgpu_device *adev,
+			       const struct common_firmware_header *hdr);
+void amdgpu_ucode_print_gpu_info_hdr(struct amdgpu_device *adev,
+			       const struct common_firmware_header *hdr);
 __printf(4, 5)
 int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 			 enum amdgpu_ucode_required required, const char *fmt, ...);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 9e8715b4739da..327424d93b461 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -539,7 +539,7 @@ static int cik_sdma_load_microcode(struct amdgpu_device *adev)
 		if (!adev->sdma.instance[i].fw)
 			return -EINVAL;
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
-		amdgpu_ucode_print_sdma_hdr(&hdr->header);
+		amdgpu_ucode_print_sdma_hdr(adev, &hdr->header);
 		fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
 		adev->sdma.instance[i].fw_version = le32_to_cpu(hdr->header.ucode_version);
 		adev->sdma.instance[i].feature_version = le32_to_cpu(hdr->ucode_feature_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a63ce747863f1..e93567e87fd93 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5499,7 +5499,7 @@ static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
-	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+	amdgpu_ucode_print_rlc_hdr(adev, &hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
 			   le32_to_cpu(hdr->header.ucode_array_offset_bytes));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 39c9ac74d5f8a..b0bad4e55ae26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2351,7 +2351,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
-	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+	amdgpu_ucode_print_rlc_hdr(adev, &hdr->header);
 
 	version_major = le16_to_cpu(hdr->header.header_version_major);
 	version_minor = le16_to_cpu(hdr->header.header_version_minor);
@@ -3065,7 +3065,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	pfp_hdr = (const struct gfx_firmware_header_v1_0 *)
 		adev->gfx.pfp_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &pfp_hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.pfp_fw->data +
 		le32_to_cpu(pfp_hdr->header.ucode_array_offset_bytes));
@@ -3112,7 +3112,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	pfp_hdr = (const struct gfx_firmware_header_v2_0 *)
 		adev->gfx.pfp_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &pfp_hdr->header);
 
 	/* instruction */
 	fw_ucode = (const __le32 *)(adev->gfx.pfp_fw->data +
@@ -3283,7 +3283,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	me_hdr = (const struct gfx_firmware_header_v1_0 *)
 		adev->gfx.me_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &me_hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.me_fw->data +
 		le32_to_cpu(me_hdr->header.ucode_array_offset_bytes));
@@ -3330,7 +3330,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	me_hdr = (const struct gfx_firmware_header_v2_0 *)
 		adev->gfx.me_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &me_hdr->header);
 
 	/* instruction */
 	fw_ucode = (const __le32 *)(adev->gfx.me_fw->data +
@@ -3793,7 +3793,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	gfx_v11_0_cp_compute_enable(adev, false);
 
 	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
-	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &mec_hdr->header);
 
 	fw_data = (const __le32 *)
 		(adev->gfx.mec_fw->data +
@@ -3845,7 +3845,7 @@ static int gfx_v11_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 	gfx_v11_0_cp_compute_enable(adev, false);
 
 	mec_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.mec_fw->data;
-	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &mec_hdr->header);
 
 	fw_ucode = (const __le32 *) (adev->gfx.mec_fw->data +
 				le32_to_cpu(mec_hdr->ucode_offset_bytes));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 80a16cc13e80c..52af71147b0b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1990,7 +1990,7 @@ static int gfx_v12_0_rlc_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
-	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+	amdgpu_ucode_print_rlc_hdr(adev, &hdr->header);
 
 	version_major = le16_to_cpu(hdr->header.header_version_major);
 	version_minor = le16_to_cpu(hdr->header.header_version_minor);
@@ -2302,7 +2302,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	pfp_hdr = (const struct gfx_firmware_header_v2_0 *)
 		adev->gfx.pfp_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &pfp_hdr->header);
 
 	/* instruction */
 	fw_ucode = (const __le32 *)(adev->gfx.pfp_fw->data +
@@ -2446,7 +2446,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	me_hdr = (const struct gfx_firmware_header_v2_0 *)
 		adev->gfx.me_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &me_hdr->header);
 
 	/* instruction */
 	fw_ucode = (const __le32 *)(adev->gfx.me_fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 9c6453b458b00..b2bb8a33ab5df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1963,9 +1963,9 @@ static int gfx_v6_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	ce_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.ce_fw->data;
 	me_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.me_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
-	amdgpu_ucode_print_gfx_hdr(&ce_hdr->header);
-	amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &pfp_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &ce_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &me_hdr->header);
 
 	/* PFP */
 	fw_data = (const __le32 *)
@@ -2530,7 +2530,7 @@ static int gfx_v6_0_rlc_resume(struct amdgpu_device *adev)
 	fw_data = (const __le32 *)
 		(adev->gfx.rlc_fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
-	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+	amdgpu_ucode_print_rlc_hdr(adev, &hdr->header);
 
 	for (i = 0; i < fw_size; i++) {
 		WREG32(mmRLC_UCODE_ADDR, i);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 6eb48ebd3f4ed..3292ed7442f84 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2403,9 +2403,9 @@ static int gfx_v7_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	ce_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.ce_fw->data;
 	me_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.me_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
-	amdgpu_ucode_print_gfx_hdr(&ce_hdr->header);
-	amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &pfp_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &ce_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &me_hdr->header);
 	adev->gfx.pfp_fw_version = le32_to_cpu(pfp_hdr->header.ucode_version);
 	adev->gfx.ce_fw_version = le32_to_cpu(ce_hdr->header.ucode_version);
 	adev->gfx.me_fw_version = le32_to_cpu(me_hdr->header.ucode_version);
@@ -2663,7 +2663,7 @@ static int gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
-	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &mec_hdr->header);
 	adev->gfx.mec_fw_version = le32_to_cpu(mec_hdr->header.ucode_version);
 	adev->gfx.mec_feature_version = le32_to_cpu(
 					mec_hdr->ucode_feature_version);
@@ -3424,7 +3424,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct rlc_firmware_header_v1_0 *)adev->gfx.rlc_fw->data;
-	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+	amdgpu_ucode_print_rlc_hdr(adev, &hdr->header);
 	adev->gfx.rlc_fw_version = le32_to_cpu(hdr->header.ucode_version);
 	adev->gfx.rlc_feature_version = le32_to_cpu(
 					hdr->ucode_feature_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 283c14e42c450..a8d9875a46e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3149,7 +3149,7 @@ static int gfx_v9_0_rlc_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
-	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+	amdgpu_ucode_print_rlc_hdr(adev, &hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
 			   le32_to_cpu(hdr->header.ucode_array_offset_bytes));
@@ -3252,9 +3252,9 @@ static int gfx_v9_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	me_hdr = (const struct gfx_firmware_header_v1_0 *)
 		adev->gfx.me_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
-	amdgpu_ucode_print_gfx_hdr(&ce_hdr->header);
-	amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &pfp_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &ce_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &me_hdr->header);
 
 	gfx_v9_0_cp_gfx_enable(adev, false);
 
@@ -3463,7 +3463,7 @@ static int gfx_v9_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	gfx_v9_0_cp_compute_enable(adev, false);
 
 	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
-	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &mec_hdr->header);
 
 	fw_data = (const __le32 *)
 		(adev->gfx.mec_fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 53fbf6ca7cdb9..a26159d749aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1559,7 +1559,7 @@ static int gfx_v9_4_3_xcc_rlc_load_microcode(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
-	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+	amdgpu_ucode_print_rlc_hdr(adev, &hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
 			   le32_to_cpu(hdr->header.ucode_array_offset_bytes));
@@ -1716,7 +1716,7 @@ static int gfx_v9_4_3_xcc_cp_compute_load_microcode(struct amdgpu_device *adev,
 	gfx_v9_4_3_xcc_cp_compute_enable(adev, false, xcc_id);
 
 	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
-	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &mec_hdr->header);
 
 	fw_data = (const __le32 *)
 		(adev->gfx.mec_fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b4567d619d098..19b93ee70fffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -155,7 +155,7 @@ static int gmc_v6_0_mc_load_microcode(struct amdgpu_device *adev)
 
 	hdr = (const struct mc_firmware_header_v1_0 *)adev->gmc.fw->data;
 
-	amdgpu_ucode_print_mc_hdr(&hdr->header);
+	amdgpu_ucode_print_mc_hdr(adev, &hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
 	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index a8d5795084fc9..18cac87b99fa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -186,7 +186,7 @@ static int gmc_v7_0_mc_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct mc_firmware_header_v1_0 *)adev->gmc.fw->data;
-	amdgpu_ucode_print_mc_hdr(&hdr->header);
+	amdgpu_ucode_print_mc_hdr(adev, &hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
 	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 99ca08e9bdb58..2594b19235015 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -296,7 +296,7 @@ static int gmc_v8_0_tonga_mc_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct mc_firmware_header_v1_0 *)adev->gmc.fw->data;
-	amdgpu_ucode_print_mc_hdr(&hdr->header);
+	amdgpu_ucode_print_mc_hdr(adev, &hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
 	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 33ed2b158fcd5..e3888d7bdfeea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1351,7 +1351,7 @@ static int sdma_v4_0_load_microcode(struct amdgpu_device *adev)
 			return -EINVAL;
 
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
-		amdgpu_ucode_print_sdma_hdr(&hdr->header);
+		amdgpu_ucode_print_sdma_hdr(adev, &hdr->header);
 		fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
 
 		fw_data = (const __le32 *)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 688a720bbbbd8..0613f50715483 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -926,7 +926,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
 			return -EINVAL;
 
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
-		amdgpu_ucode_print_sdma_hdr(&hdr->header);
+		amdgpu_ucode_print_sdma_hdr(adev, &hdr->header);
 		fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
 
 		fw_data = (const __le32 *)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index e1348b6d9c6a6..37f094df9518c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -891,7 +891,7 @@ static int sdma_v5_0_load_microcode(struct amdgpu_device *adev)
 			return -EINVAL;
 
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
-		amdgpu_ucode_print_sdma_hdr(&hdr->header);
+		amdgpu_ucode_print_sdma_hdr(adev, &hdr->header);
 		fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
 
 		fw_data = (const __le32 *)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 964f12afac9e3..371eb640c9ff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -738,7 +738,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 			return -EINVAL;
 
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
-		amdgpu_ucode_print_sdma_hdr(&hdr->header);
+		amdgpu_ucode_print_sdma_hdr(adev, &hdr->header);
 		fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
 
 		fw_data = (const __le32 *)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 00dd7bfff01a2..95adacf386c87 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -716,7 +716,7 @@ static int sdma_v6_0_load_microcode(struct amdgpu_device *adev)
 		for (i = 0; i < adev->sdma.num_instances; i++) {
 			/* load Control Thread microcode */
 			hdr = (const struct sdma_firmware_header_v2_0 *)adev->sdma.instance[0].fw->data;
-			amdgpu_ucode_print_sdma_hdr(&hdr->header);
+			amdgpu_ucode_print_sdma_hdr(adev, &hdr->header);
 			fw_size = le32_to_cpu(hdr->ctx_jt_offset + hdr->ctx_jt_size) / 4;
 
 			fw_data = (const __le32 *)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 767d72d07b566..ba132e9ae014a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -691,7 +691,7 @@ static int sdma_v7_0_load_microcode(struct amdgpu_device *adev)
 
 	hdr = (const struct sdma_firmware_header_v3_0 *)
 		adev->sdma.instance[0].fw->data;
-	amdgpu_ucode_print_sdma_hdr(&hdr->header);
+	amdgpu_ucode_print_sdma_hdr(adev, &hdr->header);
 
 	fw_data = (const __le32 *)(adev->sdma.instance[0].fw->data +
 			le32_to_cpu(hdr->ucode_offset_bytes));
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
index c712899c44cac..3cfe01576607a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
@@ -220,7 +220,7 @@ int amdgpu_si_load_smc_ucode(struct amdgpu_device *adev, u32 limit)
 
 	hdr = (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
 
-	amdgpu_ucode_print_smc_hdr(&hdr->header);
+	amdgpu_ucode_print_smc_hdr(adev, &hdr->header);
 
 	adev->pm.fw_version = le32_to_cpu(hdr->header.ucode_version);
 	ucode_start_address = le32_to_cpu(hdr->ucode_start_addr);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 78391d8f35a9c..1d100165ddf98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -111,7 +111,7 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 		goto out;
 
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	amdgpu_ucode_print_smc_hdr(&hdr->header);
+	amdgpu_ucode_print_smc_hdr(adev, &hdr->header);
 	adev->pm.fw_version = le32_to_cpu(hdr->header.ucode_version);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ba5a9012dbd5e..8c651b7ae0ab2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -109,7 +109,7 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 		goto out;
 
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	amdgpu_ucode_print_smc_hdr(&hdr->header);
+	amdgpu_ucode_print_smc_hdr(adev, &hdr->header);
 	adev->pm.fw_version = le32_to_cpu(hdr->header.ucode_version);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9264dc33ee7e9..9aab77127d888 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -464,7 +464,7 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 		goto out;
 
 	hdr = (const struct common_firmware_header *)adev->pm.fw->data;
-	amdgpu_ucode_print_smc_hdr(hdr);
+	amdgpu_ucode_print_smc_hdr(adev, hdr);
 
 	/* SMU v13.0.6 binary file doesn't carry pptables, instead the entries
 	 * are used to carry p2s tables.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 76c1adda83dbc..1271a207956b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -85,7 +85,7 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
 		goto out;
 
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	amdgpu_ucode_print_smc_hdr(&hdr->header);
+	amdgpu_ucode_print_smc_hdr(adev, &hdr->header);
 	adev->pm.fw_version = le32_to_cpu(hdr->header.ucode_version);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-- 
2.43.0

