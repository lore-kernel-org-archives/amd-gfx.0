Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B27C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 16:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D6060234
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 16:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D6060234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E536E850;
	Mon,  1 Feb 2021 16:56:18 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9846E84F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 16:56:17 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id a7so16854220qkb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Feb 2021 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=szLtBxA82rf8gRpC8JXx2vFQfvEGxG6EktmUTDT8+gU=;
 b=KNS0X0454hqGKxKwozWTgsevlN5T8v7uzlNcUQDzbcPpS+urJWYqxVYbxaB6XmSuOi
 9aLebcWLqPqqv2mG/xubKtrUeJ3EuteUnxc+xPLirVDSyDTuALjDggFG4lEFZud8lz+v
 EUVsINkECfTR6xJaiKGPE2JOFb1E+mtX/92yE45cNrJORqdIeU5eptjWodcT3oro4xPm
 7FOtW3XvrctGjRZDP4+ay+wr1379QHcdfFwDpaO/vVe5+fRGBi8/VkrszbjVJ6yzSfce
 HzTm4n48Rs49YXdkBblyNwI/9jWjOSvNrlfMY9uf1ekYyhkPhczYH23u2wzuuJNwx6H4
 HGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=szLtBxA82rf8gRpC8JXx2vFQfvEGxG6EktmUTDT8+gU=;
 b=lI1UXwEy51NWD0fEhbHMp/UQIWPxf8o5X1GitH0ux1tJiU/4hyHLB/5pH5n5zNNoOk
 M91D2YCNlD3KCZJKz/oX+SDflD1grJ8dCmGWyiyNdau166rt4jdgb9OH4oCO9dQ49JZX
 yYO+HHdnIEb0n21EXYK9aO2sO22qGjtRFE1byx/1jKDl2Mn1PhWcaFuj0pU2JZZ1D0nA
 2bQujjYjADIqdS1ii53eoPJw1hy23czo/5h8cd0ACqeVbJdwKauU68pVKLI1zZzFc0SQ
 US2785/BKwx2idrV8y2+HLY7LX835OUeo34+6nuJy3vNy7z5cvGmZ5tTgSNDIaUoAdtz
 t9nA==
X-Gm-Message-State: AOAM531iHAtAMKSKiWcLaQyAoDfMme1buFCF7jpgmLb/5awQM96mvOnM
 6aQ60H4W9Obx2pu83gaRWMiXpGejIY4=
X-Google-Smtp-Source: ABdhPJxuownBwCojeu+uxuR+KmcDOqebdzgMGbvZ6qtC2mb7i8irIQvcm9mRUc+JNldP0Op3auIkWA==
X-Received: by 2002:a05:620a:cf5:: with SMTP id
 c21mr17244370qkj.207.1612198576128; 
 Mon, 01 Feb 2021 08:56:16 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id v145sm15022479qka.27.2021.02.01.08.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 08:56:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: add INFO ioctl support for querying video
 caps (v3)
Date: Mon,  1 Feb 2021 11:56:04 -0500
Message-Id: <20210201165605.465228-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201165605.465228-1-alexander.deucher@amd.com>
References: <20210201165605.465228-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We currently hardcode these in mesa, but querying them from
the kernel makes more sense since there may be board specific
limitations that the kernel driver is better suited to
determining.

Userpace patches that use this interface:
https://gitlab.freedesktop.org/leoliu/drm/-/commits/info_video_caps
https://gitlab.freedesktop.org/leoliu/mesa/-/commits/info_video_caps

v2: reorder the codecs to better align with mesa
v3: add max_pixels_per_frame to handle the portrait case, squash in
    memory leak fix

Reviewed-by: Leo Liu <leo.liu@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 58 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 34 +++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3c37cf1ae8b7..390362beda0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -983,6 +983,64 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				min_t(u64, size, sizeof(ras_mask))) ?
 			-EFAULT : 0;
 	}
+	case AMDGPU_INFO_VIDEO_CAPS: {
+		const struct amdgpu_video_codecs *codecs;
+		struct drm_amdgpu_info_video_caps *caps;
+		int r;
+
+		switch (info->video_cap.type) {
+		case AMDGPU_INFO_VIDEO_CAPS_DECODE:
+			r = amdgpu_asic_query_video_codecs(adev, false, &codecs);
+			if (r)
+				return -EINVAL;
+			break;
+		case AMDGPU_INFO_VIDEO_CAPS_ENCODE:
+			r = amdgpu_asic_query_video_codecs(adev, true, &codecs);
+			if (r)
+				return -EINVAL;
+			break;
+			break;
+		default:
+			DRM_DEBUG_KMS("Invalid request %d\n",
+				      info->video_cap.type);
+			return -EINVAL;
+		}
+
+		caps = kzalloc(sizeof(*caps), GFP_KERNEL);
+		if (!caps)
+			return -ENOMEM;
+
+		for (i = 0; i < codecs->codec_count; i++) {
+			int idx = codecs->codec_array[i].codec_type;
+
+			switch (idx) {
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG2:
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4:
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC:
+			case AMDGPU_VIDEO_CODEC_TYPE_VC1:
+			case AMDGPU_VIDEO_CODEC_TYPE_HEVC:
+			case AMDGPU_VIDEO_CODEC_TYPE_JPEG:
+			case AMDGPU_VIDEO_CODEC_TYPE_VP9:
+			case AMDGPU_VIDEO_CODEC_TYPE_AV1:
+				caps->codec_info[idx].valid = 1;
+				caps->codec_info[idx].max_width =
+					codecs->codec_array[i].max_width;
+				caps->codec_info[idx].max_height =
+					codecs->codec_array[i].max_height;
+				caps->codec_info[idx].max_pixels_per_frame =
+					codecs->codec_array[i].max_pixels_per_frame;
+				caps->codec_info[idx].max_level =
+					codecs->codec_array[i].max_level;
+				break;
+			default:
+				break;
+			}
+		}
+		r = copy_to_user(out, caps,
+				 min((size_t)size, sizeof(*caps))) ? -EFAULT : 0;
+		kfree(caps);
+		return r;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7fb9c09ee93f..728566542f8a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -782,6 +782,12 @@ struct drm_amdgpu_cs_chunk_data {
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
 /* query ras mask of enabled features*/
 #define AMDGPU_INFO_RAS_ENABLED_FEATURES	0x20
+/* query video encode/decode caps */
+#define AMDGPU_INFO_VIDEO_CAPS			0x21
+	/* Subquery id: Decode */
+	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
+	/* Subquery id: Encode */
+	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
 
 /* RAS MASK: UMC (VRAM) */
 #define AMDGPU_INFO_RAS_ENABLED_UMC			(1 << 0)
@@ -878,6 +884,10 @@ struct drm_amdgpu_info {
 		struct {
 			__u32 type;
 		} sensor_info;
+
+		struct {
+			__u32 type;
+		} video_cap;
 	};
 };
 
@@ -1074,6 +1084,30 @@ struct drm_amdgpu_info_vce_clock_table {
 	__u32 pad;
 };
 
+/* query video encode/decode caps */
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2			0
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4			1
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1			2
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC		3
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC			4
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG			5
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9			6
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1			7
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT			8
+
+struct drm_amdgpu_info_video_codec_info {
+	__u32 valid;
+	__u32 max_width;
+	__u32 max_height;
+	__u32 max_pixels_per_frame;
+	__u32 max_level;
+	__u32 pad;
+};
+
+struct drm_amdgpu_info_video_caps {
+	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
+};
+
 /*
  * Supported GPU families
  */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
