Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13E7C433E9
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DC464F59
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DC464F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C16786E955;
	Tue,  2 Feb 2021 16:13:17 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A48E6E94E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:13:16 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id r20so11725642qtm.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pvxMsZfEUHTdF3vX0hoEFDl6720YTq3tj43UXaMdLX8=;
 b=pmimRLqJm5gy8QVpnWDnfM09HP0cDuDI039oydSTUh1Og8HWRVb9c2Cd1//14KoK6U
 uQfIaS4B28gt7lSbsjtHfHMvl8uORiZcPC6fdMXCNwwTG/m6ZXOsCAboTSEVyOTTJrEa
 L3fTSKorpj355o1mDfkz1H3Kf2+I7s7BxGjeXqG3a8jqppp8qXrR56r4WQDZjW8uUW1v
 fBDqj44Fm7H1YesBYa0H+h18QR45KKb0GmcvhVQ61hUlQ8JXL0f2QDauM+eRaansPEXD
 N5zZ4fMuywUXMD9GimbW8Cn/SzkxiR01AA1L0sOxPsvhnFk+w1TNLGbv2Cnw3KyoFLJ1
 XLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pvxMsZfEUHTdF3vX0hoEFDl6720YTq3tj43UXaMdLX8=;
 b=ZiBYXg9CXxuZ25y9mAQWd4WBiMO1nAexn+fW1WNeWLWs5YUyBGmXJ9EU04XbKmFHF8
 A5UysZdV9mvG9e9HomIkwnrMQhCtMQITBgx0T1Q+Hg89n5YlKW3DmEW0ijNOTwZ0Fijo
 Fbj+2uzGl0mqdE2CMRTZNvXeF6A/lWyvcXJXdXIYNa3XK99SC1OBj04HkahxyN/S8mfb
 Hor2JLXKhMjCwg0U54R0lBGW8o7xKnl3JmUcRlapsYbQmBesN+UtRnJ5HTGf1gb+JA0V
 Aj0WkBK+d0AcQnVSWJ5sEWXUPURvW0+E1QGG9eu8d4LQNmWFt4qDhFFZ6pRGXBqGJBwx
 seGg==
X-Gm-Message-State: AOAM533D8yPiDszCr6qTKEHP69odKTcHJhx98Kz0hiZ7sUXNpHMBBFFR
 2cqNJWRyCvi+UGNkDI9D9UoFe19x0IA=
X-Google-Smtp-Source: ABdhPJwUQPxeREZWAPMQKkXpObPzf3Kgvr2Q2xo6+3p4TovFY/hOoV5QRytLmWHw1BlulSJiaSYd1g==
X-Received: by 2002:a05:622a:10f:: with SMTP id
 u15mr20658187qtw.198.1612282395222; 
 Tue, 02 Feb 2021 08:13:15 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id z128sm14539078qke.70.2021.02.02.08.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 08:13:14 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: add INFO ioctl support for querying video
 caps (v4)
Date: Tue,  2 Feb 2021 11:13:01 -0500
Message-Id: <20210202161303.538281-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202161303.538281-1-alexander.deucher@amd.com>
References: <20210202161303.538281-1-alexander.deucher@amd.com>
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
v4: drop extra break

Reviewed-by: Leo Liu <leo.liu@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 57 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 34 +++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d7cf9bb044ee..04b9cd75f7b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -989,6 +989,63 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
