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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C40C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B957664DBA
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B957664DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E1A26E94E;
	Tue,  2 Feb 2021 16:13:17 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE60F6E94E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:13:15 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id a7so20257263qkb.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EdFtol0Gs+q/SnQEA1D60qXXSh24rgxbI0DqQ0fG0YE=;
 b=Yv6hRSAO2eiSTOPbn5T4qbBbbBEPerap4WvZ8FbUbibGujHRAh589VcX9crB3+tsf/
 SAsDqxhLIcwnCa9RBWn9Rybr3TBYl+txwB36WNVwVFai8ugLyu2482LUsWgUud6JHgWq
 EqFw00SQqlBqnUoaefHWehvZ2ofayFEqjeq9Z+2g9Lk9WT3fS+zevx5ERgtoZbsBSZm1
 7s3cpW1cf3xT51Z2vSiQ28GaNpGl+ibibso9iHPGiWCgOQJp+qG2l8oaOAABzabSCnqc
 bLbcXV4Hpp/B3n79hdZJeJwnHVZ8T+22B6GM6WkCnJMTqe30PIUcymqwv1sc8yzd0KKf
 slZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EdFtol0Gs+q/SnQEA1D60qXXSh24rgxbI0DqQ0fG0YE=;
 b=NXlZMtIvGoAZyq1DTf6XmBL5C4nwmWSD0cyqJZk4R0K2m+Ga5Hov5zruhYnd1SuUeZ
 akVTPsc9PYKtkVdKrQNXtDexWnGz6OvfWAYg5I7v01LG7Td1fXEWcgFucDyaxipr3r8a
 hg3slCgfs3qpF6gxNVL36m/JgdrMR8eP3VG9fGSoetUqPFgNj3SbrVjnR1y1DArk+0hC
 C8WHESXmX7DXKMHnEwW5A9jPX/Xm3Ap5uPiVXpCObofSJaArOfBwOqWgW6wyuWc0JMzM
 FhQzh+YrXxvV2XUjOmPOF8KZZxqNZ6Osk0Pxn7xlkEfcynTe2oy1SWO/1OhQYvp6liqc
 DlVw==
X-Gm-Message-State: AOAM530N1dpW6WmuAEzan25Vq4lRmBqo4Ivq10bo5XQYtm1/TwqMXyNe
 JoDwsCVyZilsrBd4SxCtoyDgXxRQDPU=
X-Google-Smtp-Source: ABdhPJxhTmZ4/URPCoO1830XR5GSTSuBCn7IdlA5oi3p5Sa5ej0cK06dMkWEfJj9QUZl9LuNVU3V6g==
X-Received: by 2002:a37:8fc3:: with SMTP id
 r186mr22769106qkd.253.1612282394455; 
 Tue, 02 Feb 2021 08:13:14 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id z128sm14539078qke.70.2021.02.02.08.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 08:13:14 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: add video decode/encode cap tables and asic
 callbacks (v3)
Date: Tue,  2 Feb 2021 11:13:00 -0500
Message-Id: <20210202161303.538281-2-alexander.deucher@amd.com>
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

For each asic family.  Will be used to populate tables
for the new INFO ioctl query.

v2: add max_pixels_per_frame to handle the portrait case
v3: fix copy paste typos

Reviewed-by: Leo Liu <leo.liu@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c   |  75 ++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c    | 179 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/si.c    | 109 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c | 230 +++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vi.c    | 188 +++++++++++++++++++++++
 5 files changed, 781 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 13737b317f7c..12ed86deaa84 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -70,6 +70,80 @@
 #include "amdgpu_amdkfd.h"
 #include "dce_virtual.h"
 
+static const struct amdgpu_video_codec_info cik_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs cik_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(cik_video_codecs_encode_array),
+	.codec_array = cik_video_codecs_encode_array,
+};
+
+static const struct amdgpu_video_codec_info cik_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 41,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 4,
+	},
+};
+
+static const struct amdgpu_video_codecs cik_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(cik_video_codecs_decode_array),
+	.codec_array = cik_video_codecs_decode_array,
+};
+
+static int cik_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_BONAIRE:
+	case CHIP_HAWAII:
+	case CHIP_KAVERI:
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
+		if (encode)
+			*codecs = &cik_video_codecs_encode;
+		else
+			*codecs = &cik_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Indirect registers accessor
  */
@@ -1944,6 +2018,7 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
 	.get_pcie_replay_count = &cik_get_pcie_replay_count,
 	.supports_baco = &cik_asic_supports_baco,
 	.pre_asic_init = &cik_pre_asic_init,
+	.query_video_codecs = &cik_query_video_codecs,
 };
 
 static int cik_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 66279f0c6808..64c973cd9088 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -64,6 +64,184 @@
 
 static const struct amd_ip_funcs nv_common_ip_funcs;
 
+/* Navi */
+static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs nv_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(nv_video_codecs_encode_array),
+	.codec_array = nv_video_codecs_encode_array,
+};
+
+/* Navi1x */
+static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs nv_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(nv_video_codecs_decode_array),
+	.codec_array = nv_video_codecs_decode_array,
+};
+
+/* Sienna Cichlid */
+static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_AV1,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs sc_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(sc_video_codecs_decode_array),
+	.codec_array = sc_video_codecs_decode_array,
+};
+
+static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				 const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_VANGOGH:
+		if (encode)
+			*codecs = &nv_video_codecs_encode;
+		else
+			*codecs = &sc_video_codecs_decode;
+		return 0;
+	case CHIP_NAVI10:
+	case CHIP_NAVI14:
+	case CHIP_NAVI12:
+		if (encode)
+			*codecs = &nv_video_codecs_encode;
+		else
+			*codecs = &nv_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Indirect registers accessor
  */
@@ -825,6 +1003,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.supports_baco = &nv_asic_supports_baco,
 	.pre_asic_init = &nv_pre_asic_init,
 	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
+	.query_video_codecs = &nv_query_video_codecs,
 };
 
 static int nv_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 3cf0589bfea5..da258ff75042 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -905,6 +905,114 @@ static const u32 hainan_mgcg_cgcg_init[] =
 	0x3630, 0xfffffff0, 0x00000100,
 };
 
+/* XXX: update when we support VCE */
+#if 0
+/* tahiti, pitcarin, verde */
+static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(tahiti_video_codecs_encode_array),
+	.codec_array = tahiti_video_codecs_encode_array,
+};
+#else
+static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+#endif
+/* oland and hainan don't support encode */
+static const struct amdgpu_video_codecs hainan_video_codecs_encode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+/* tahiti, pitcarin, verde, oland */
+static const struct amdgpu_video_codec_info tahiti_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 41,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 4,
+	},
+};
+
+static const struct amdgpu_video_codecs tahiti_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(tahiti_video_codecs_decode_array),
+	.codec_array = tahiti_video_codecs_decode_array,
+};
+
+/* hainan doesn't support decode */
+static const struct amdgpu_video_codecs hainan_video_codecs_decode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+static int si_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				 const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_VERDE:
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+		if (encode)
+			*codecs = &tahiti_video_codecs_encode;
+		else
+			*codecs = &tahiti_video_codecs_decode;
+		return 0;
+	case CHIP_OLAND:
+		if (encode)
+			*codecs = &hainan_video_codecs_encode;
+		else
+			*codecs = &tahiti_video_codecs_decode;
+		return 0;
+	case CHIP_HAINAN:
+		if (encode)
+			*codecs = &hainan_video_codecs_encode;
+		else
+			*codecs = &hainan_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static u32 si_pcie_rreg(struct amdgpu_device *adev, u32 reg)
 {
 	unsigned long flags;
@@ -1897,6 +2005,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
 	.supports_baco = &si_asic_supports_baco,
 	.pre_asic_init = &si_pre_asic_init,
+	.query_video_codecs = &si_query_video_codecs,
 };
 
 static uint32_t si_get_rev_id(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2396be16c28e..a81fd7de72b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -83,6 +83,234 @@
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL                                                             0x01ba
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX                                                    0
 
+/* Vega, Raven, Arcturus */
+static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs vega_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(vega_video_codecs_encode_array),
+	.codec_array = vega_video_codecs_encode_array,
+};
+
+/* Vega */
+static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs vega_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(vega_video_codecs_decode_array),
+	.codec_array = vega_video_codecs_decode_array,
+};
+
+/* Raven */
+static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs rv_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(rv_video_codecs_decode_array),
+	.codec_array = rv_video_codecs_decode_array,
+};
+
+/* Renoir, Arcturus */
+static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs rn_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(rn_video_codecs_decode_array),
+	.codec_array = rn_video_codecs_decode_array,
+};
+
+static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				    const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+	case CHIP_VEGA10:
+	case CHIP_VEGA12:
+		if (encode)
+			*codecs = &vega_video_codecs_encode;
+		else
+			*codecs = &vega_video_codecs_decode;
+		return 0;
+	case CHIP_RAVEN:
+		if (encode)
+			*codecs = &vega_video_codecs_encode;
+		else
+			*codecs = &rv_video_codecs_decode;
+		return 0;
+	case CHIP_ARCTURUS:
+	case CHIP_RENOIR:
+		if (encode)
+			*codecs = &vega_video_codecs_encode;
+		else
+			*codecs = &rn_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Indirect registers accessor
  */
@@ -988,6 +1216,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
 	.pre_asic_init = &soc15_pre_asic_init,
+	.query_video_codecs = &soc15_query_video_codecs,
 };
 
 static const struct amdgpu_asic_funcs vega20_asic_funcs =
@@ -1009,6 +1238,7 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
 	.pre_asic_init = &soc15_pre_asic_init,
+	.query_video_codecs = &soc15_query_video_codecs,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index d56b474b3a21..462368d2804b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -79,6 +79,193 @@
 #include "mxgpu_vi.h"
 #include "amdgpu_dm.h"
 
+/* Topaz */
+static const struct amdgpu_video_codecs topaz_video_codecs_encode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+/* Tonga, CZ, ST, Fiji */
+static const struct amdgpu_video_codec_info tonga_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs tonga_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(tonga_video_codecs_encode_array),
+	.codec_array = tonga_video_codecs_encode_array,
+};
+
+/* Polaris */
+static const struct amdgpu_video_codec_info polaris_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs polaris_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(polaris_video_codecs_encode_array),
+	.codec_array = polaris_video_codecs_encode_array,
+};
+
+/* Topaz */
+static const struct amdgpu_video_codecs topaz_video_codecs_decode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+/* Tonga */
+static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+};
+
+static const struct amdgpu_video_codecs tonga_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(tonga_video_codecs_decode_array),
+	.codec_array = tonga_video_codecs_decode_array,
+};
+
+/* CZ, ST, Fiji, Polaris */
+static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs cz_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(cz_video_codecs_decode_array),
+	.codec_array = cz_video_codecs_decode_array,
+};
+
+static int vi_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				 const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_TOPAZ:
+		if (encode)
+			*codecs = &topaz_video_codecs_encode;
+		else
+			*codecs = &topaz_video_codecs_decode;
+		return 0;
+	case CHIP_TONGA:
+		if (encode)
+			*codecs = &tonga_video_codecs_encode;
+		else
+			*codecs = &tonga_video_codecs_decode;
+		return 0;
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+	case CHIP_VEGAM:
+		if (encode)
+			*codecs = &polaris_video_codecs_encode;
+		else
+			*codecs = &cz_video_codecs_decode;
+		return 0;
+	case CHIP_FIJI:
+	case CHIP_CARRIZO:
+	case CHIP_STONEY:
+		if (encode)
+			*codecs = &tonga_video_codecs_encode;
+		else
+			*codecs = &cz_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Indirect registers accessor
  */
@@ -1093,6 +1280,7 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 	.get_pcie_replay_count = &vi_get_pcie_replay_count,
 	.supports_baco = &vi_asic_supports_baco,
 	.pre_asic_init = &vi_pre_asic_init,
+	.query_video_codecs = &vi_query_video_codecs,
 };
 
 #define CZ_REV_BRISTOL(rev)	 \
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
