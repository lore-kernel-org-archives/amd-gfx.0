Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60ECC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC4420707
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC4420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F4A6E536;
	Wed, 27 Jan 2021 05:32:46 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7C66E52F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 05:32:45 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id t63so750217qkc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 21:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PyJ4j3ApF/bdiTdqg+OQCNu9lF0/YWFH7VPZ1dVo1V0=;
 b=I4xinRgLTvLJUudQofhtGDyet6iFTNOQ/1KxolwMdffYY5TyAXVrZaKutRmgEakQ8R
 yvYOTPI51dC3ZZLjJeWKp6MVPdR8mGqJyxet5rmLZIiEI8tKOMqX3UggVyOJKxD9P96O
 cKuajBJ9LQwXjFza2t/EK0MSYu9eQ40pLUGaSla1abXDEpzFGIfL1o15Om0HR3iW3Ysy
 i4NvvEoWyYNvGfKA+99z57syThoP2zMwXqwr267gN9FtK+dYwDVHTJtg763ac51WzYDw
 +Jofy3GyZCVsQIIfDOL3A2nQCxR9YEwUbF3htoyhpWkxuRufwVFLAP0YYtfdjGcktspa
 DQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PyJ4j3ApF/bdiTdqg+OQCNu9lF0/YWFH7VPZ1dVo1V0=;
 b=IKewkVx1Gu60h4QzPNqMxGN06qOdLVdy0p954ifAnXMxq0k+r/bpdv6uIubkwMMAUW
 YMJArdDb+ydpCko+CHZhrXo8YJP/9bnnSkN40y2vxcXYj/Mc8TQ6+8mipwIrZNbZwfz4
 8mXNFD1c7zDJs1vuyEMtc+TJ/UnjswCKKHkkCTiUg1E3YVZr29q0NB6AWybfTkjgOF6G
 Jicf9MyRiQhTAgZzxcL7SjYyJC+dsq1q10W0hxbkYXFJ86CC8l6u9hkP7ZJdaoDQwdqc
 sCGZVLz2m133KUjMi1vniLYFilP5Tsu6lCKx9YXe9qw5hGBaN6Hg05VEshC3m724EZH7
 kzQA==
X-Gm-Message-State: AOAM532jCJBPmKk6xdXvCYWwn44/p3jYaLkhZFcAQs1CkFPNDaEkzdug
 XreLpnUkWhdshWUzM48EL/NaYoaOnkU=
X-Google-Smtp-Source: ABdhPJx01iGaUmyHZjATmkOC2xGZhk2AK8fQLXXl8SBTjED2yNqykYd9kSaXXrGge/2/OTVwgRMI/Q==
X-Received: by 2002:a37:5d07:: with SMTP id r7mr9133117qkb.335.1611725564515; 
 Tue, 26 Jan 2021 21:32:44 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id t184sm555982qkd.100.2021.01.26.21.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 21:32:43 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: add INFO ioctl support for querying video caps
Date: Wed, 27 Jan 2021 00:32:30 -0500
Message-Id: <20210127053231.202843-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127053231.202843-1-alexander.deucher@amd.com>
References: <20210127053231.202843-1-alexander.deucher@amd.com>
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

We currently hardcode these in mesa, but querying them from
the kernel makes more sense since there may be board specific
limitations that the kernel driver is better suited to
determining.

Userpace patches that use this interface:
https://gitlab.freedesktop.org/leoliu/drm/-/commits/info_video_caps
https://gitlab.freedesktop.org/leoliu/mesa/-/commits/info_video_caps

v2: reorder the codecs to better align with mesa

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 55 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 32 ++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3c37cf1ae8b7..84b666fcfaf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -983,6 +983,61 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				min_t(u64, size, sizeof(ras_mask))) ?
 			-EFAULT : 0;
 	}
+	case AMDGPU_INFO_VIDEO_CAPS: {
+		const struct amdgpu_video_codecs *codecs;
+		struct drm_amdgpu_info_video_caps *caps;
+		int r;
+
+	        caps = kzalloc(sizeof(*caps), GFP_KERNEL);
+		if (!caps)
+			return -ENOMEM;
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
index 7fb9c09ee93f..570767ea13e1 100644
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
 
@@ -1074,6 +1084,28 @@ struct drm_amdgpu_info_vce_clock_table {
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
+	__u32 max_level;
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
