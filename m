Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D34C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 05:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68093613F6
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 05:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68093613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAFE6E81D;
	Thu, 13 May 2021 05:26:55 +0000 (UTC)
X-Greylist: delayed 422 seconds by postgrey-1.36 at gabe;
 Thu, 13 May 2021 05:26:53 UTC
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id D59786E81D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 05:26:53 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id 5570218402C5; Thu, 13 May 2021 01:19:51 -0400 (EDT)
From: Bokun Zhang <bokun.zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Complete multimedia bandwidth interface
Date: Thu, 13 May 2021 01:19:49 -0400
Message-Id: <20210513051949.6846-1-bokun.zhang@amd.com>
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
Cc: Bokun Zhang <bokun.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Update SRIOV PF2VF header with latest revision

- Extend existing function in amdgpu_virt.c to read MM bandwidth config
  from PF2VF message

- Add SRIOV Sienna Cichlid codec array and update the bandwidth with
  PF2VF message

Change-Id: Id0cfa2e1adb7a097997d53b34d41a6d36a390c00
Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  56 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  13 +++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  54 ++++++++--
 drivers/gpu/drm/amd/amdgpu/nv.c             | 110 +++++++++++++++++++-
 4 files changed, 226 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a57842689d42..c64e583347c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -432,6 +432,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 	uint32_t checksum;
 	uint32_t checkval;
 
+	uint32_t i;
+	uint32_t tmp;
+
 	if (adev->virt.fw_reserve.p_pf2vf == NULL)
 		return -EINVAL;
 
@@ -472,6 +475,27 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		adev->virt.reg_access =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
 
+		adev->virt.decode_max_dimension_pixels = 0;
+		adev->virt.decode_max_frame_pixels = 0;
+		adev->virt.encode_max_dimension_pixels = 0;
+		adev->virt.encode_max_frame_pixels = 0;
+		adev->virt.is_mm_bw_enabled = false;
+		for (i = 0; i < AMD_SRIOV_MSG_RESERVE_VCN_INST; i++) {
+			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].decode_max_dimension_pixels;
+			adev->virt.decode_max_dimension_pixels = max(tmp, adev->virt.decode_max_dimension_pixels);
+
+			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].decode_max_frame_pixels;
+			adev->virt.decode_max_frame_pixels = max(tmp, adev->virt.decode_max_frame_pixels);
+
+			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].encode_max_dimension_pixels;
+			adev->virt.encode_max_dimension_pixels = max(tmp, adev->virt.encode_max_dimension_pixels);
+
+			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].encode_max_frame_pixels;
+			adev->virt.encode_max_frame_pixels = max(tmp, adev->virt.encode_max_frame_pixels);
+		}
+		if((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
+			adev->virt.is_mm_bw_enabled = true;
+
 		break;
 	default:
 		DRM_ERROR("invalid pf2vf version\n");
@@ -744,3 +768,35 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 
 	return mode;
 }
+
+void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
+			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
+			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size)
+{
+	uint32_t i;
+
+	if (!adev->virt.is_mm_bw_enabled)
+		return;
+
+	if (encode) {
+		for (i = 0; i < encode_array_size; i++) {
+			encode[i].max_width = adev->virt.encode_max_dimension_pixels;
+			encode[i].max_pixels_per_frame = adev->virt.encode_max_frame_pixels;
+			if (encode[i].max_width > 0)
+				encode[i].max_height = encode[i].max_pixels_per_frame / encode[i].max_width;
+			else
+				encode[i].max_height = 0;
+		}
+	}
+
+	if (decode) {
+		for (i = 0; i < decode_array_size; i++) {
+			decode[i].max_width = adev->virt.decode_max_dimension_pixels;
+			decode[i].max_pixels_per_frame = adev->virt.decode_max_frame_pixels;
+			if (decode[i].max_width > 0)
+				decode[i].max_height = decode[i].max_pixels_per_frame / decode[i].max_width;
+			else
+				decode[i].max_height = 0;
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 383d4bdc3fb5..8d4c20bb71c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -233,8 +233,17 @@ struct amdgpu_virt {
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
 	uint32_t vf2pf_update_interval_ms;
+
+	/* multimedia bandwidth config */
+	bool     is_mm_bw_enabled;
+	uint32_t decode_max_dimension_pixels;
+	uint32_t decode_max_frame_pixels;
+	uint32_t encode_max_dimension_pixels;
+	uint32_t encode_max_frame_pixels;
 };
 
+struct amdgpu_video_codec_info;
+
 #define amdgpu_sriov_enabled(adev) \
 ((adev)->virt.caps & AMDGPU_SRIOV_CAPS_ENABLE_IOV)
 
@@ -307,4 +316,8 @@ int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
 void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
 
 enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *adev);
+
+void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
+			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
+			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index befd0b4b7bea..a434c71fde8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -56,6 +56,8 @@
 
 #define AMD_SRIOV_MSG_RESERVE_UCODE		24
 
+#define AMD_SRIOV_MSG_RESERVE_VCN_INST 4
+
 enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID_VCE = 0,
 	AMD_SRIOV_UCODE_ID_UVD,
@@ -98,10 +100,10 @@ union amd_sriov_msg_feature_flags {
 
 union amd_sriov_reg_access_flags {
 	struct {
-		uint32_t vf_reg_psp_access_ih    : 1;
-		uint32_t vf_reg_rlc_access_mmhub : 1;
-		uint32_t vf_reg_rlc_access_gc    : 1;
-		uint32_t reserved            : 29;
+		uint32_t vf_reg_access_ih 	 : 1;
+		uint32_t vf_reg_access_mmhub : 1;
+		uint32_t vf_reg_access_gc 	 : 1;
+		uint32_t reserved	         : 29;
 	} flags;
 	uint32_t all;
 };
@@ -114,6 +116,37 @@ union amd_sriov_msg_os_info {
 	uint32_t      all;
 };
 
+struct amd_sriov_msg_uuid_info {
+	union {
+		struct {
+			uint32_t did	: 16;
+			uint32_t fcn	: 8;
+			uint32_t asic_7 : 8;
+		};
+		uint32_t time_low;
+	};
+
+	struct {
+		uint32_t time_mid  : 16;
+		uint32_t time_high : 12;
+		uint32_t version   : 4;
+	};
+
+	struct {
+		struct {
+			uint8_t clk_seq_hi : 6;
+			uint8_t variant    : 2;
+		};
+		union {
+			uint8_t clk_seq_low;
+			uint8_t asic_6;
+		};
+		uint16_t asic_4;
+	};
+
+	uint32_t asic_0;
+};
+
 struct amd_sriov_msg_pf2vf_info_header {
 	/* the total structure size in byte */
 	uint32_t size;
@@ -160,10 +193,19 @@ struct amd_sriov_msg_pf2vf_info {
 	/* identification in ROCm SMI */
 	uint64_t uuid;
 	uint32_t fcn_idx;
-	/* flags which indicate the register access method VF should use */
+	/* flags to indicate which register access method VF should use */
 	union amd_sriov_reg_access_flags reg_access_flags;
+	/* MM BW management */
+	struct {
+		uint32_t decode_max_dimension_pixels;
+		uint32_t decode_max_frame_pixels;
+		uint32_t encode_max_dimension_pixels;
+		uint32_t encode_max_frame_pixels;
+	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
+	/* UUID info */
+	struct amd_sriov_msg_uuid_info uuid_info;
 	/* reserved */
-	uint32_t reserved[256-27];
+	uint32_t reserved[256 - 47];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 75d1f9b939b2..9f74060207a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -218,11 +218,114 @@ static const struct amdgpu_video_codecs sc_video_codecs_decode =
 	.codec_array = sc_video_codecs_decode_array,
 };
 
+/* SRIOV Sienna Cichlid, not const since data is controlled by host */
+static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+};
+
+static struct amdgpu_video_codecs sriov_sc_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
+	.codec_array = sriov_sc_video_codecs_encode_array,
+};
+
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array),
+	.codec_array = sriov_sc_video_codecs_decode_array,
+};
+
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+		if (amdgpu_sriov_vf(adev)) {
+			if (encode)
+				*codecs = &sriov_sc_video_codecs_encode;
+			else
+				*codecs = &sriov_sc_video_codecs_decode;
+		} else {
+			if (encode)
+				*codecs = &nv_video_codecs_encode;
+			else
+				*codecs = &sc_video_codecs_decode;
+		}
+		return 0;
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_VANGOGH:
@@ -1173,9 +1276,14 @@ static int nv_common_early_init(void *handle)
 static int nv_common_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_get_irq(adev);
+		amdgpu_virt_update_sriov_video_codec(adev,
+				sriov_sc_video_codecs_encode_array, ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
+				sriov_sc_video_codecs_decode_array, ARRAY_SIZE(sriov_sc_video_codecs_decode_array));
+	}
 
 	return 0;
 }
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
