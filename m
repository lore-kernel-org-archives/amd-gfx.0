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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA87C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6E220707
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6E220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E926E532;
	Wed, 27 Jan 2021 05:32:45 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14E06E52F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 05:32:44 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id x81so755716qkb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 21:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6ngLOO/xdq0yi/mZiqskwjMi/qyzWlfDrxMNwEVF4uo=;
 b=MuM9RwV/5ilevr+HxAx2EWmiNeS4S63WAVQdel6WHC19bgt+HYSSCIf1Rff6jcB1I0
 akzHAosWgERGnmxEmhxBbUNo6w3akxkRo2c7xoh6aaGYyXXGf5SDtxEtb67ixevQn3Nw
 HiinhMwXxBc6PuNl90Esar4zjQsn7Y+oGvjkeNZBfLkYZ6Toc7+geR1Yl3um4u4Bpsat
 xeAqN4fxleWvpb+SJnggtfg6go5yKeZJhu5arO+OJmOsvyNda0XuqA5k8owDr+isdFOX
 2ZC55Aha/mDRtFeESANvY0UsFzMXHQ2wH9I1ZsB75U4VmQxdG7Uqu4Se83yLbv2q7b6R
 b8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ngLOO/xdq0yi/mZiqskwjMi/qyzWlfDrxMNwEVF4uo=;
 b=G/tOvsPYAFx2iEkDrwOXw4YkqvWoAKK07KHsXZG0K2JI9ghjPJC3kwBcu4wFbxsvFa
 +RBj4C92oE/RmW4G+laprd8UPeU+aB/jxwrRmeG+lb+GrmSEthssU//15g9Dxx4XGfz6
 Ki9c19MOYUDF50CEV589XhuPUUZ8EX+fPPV1wrfTWTsWO76sNTAKwG/IFDN18rIkKJt0
 BEyMK3I9VdRx83pyLWZPXPhdXWs5mSVBK0ie2kY5+J4IoLAFkrzBF0dMc7kXaDs7kFLN
 B7zbrzRi5j2OJyU1ZmFcJDv240lu/HXeiffLdK4yffyHFhxsjAPLfV1a5vbpq1d3AkJz
 +pLw==
X-Gm-Message-State: AOAM530a1hujJe/gudJoDYWTlgu2mZ4yCm6x0V1cR7DPZXm7Nqq3ZgIU
 W0xarE6Fu0w7CXfvoRQOnIxez9kQgPw=
X-Google-Smtp-Source: ABdhPJwUMPvYzOP/3UvU6e/nOdON/Yzp/TcJrln0GtDolMg3QHMbX532J73RUL5arojh7yrK51HFcQ==
X-Received: by 2002:a37:458c:: with SMTP id s134mr9549408qka.142.1611725563464; 
 Tue, 26 Jan 2021 21:32:43 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id t184sm555982qkd.100.2021.01.26.21.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 21:32:43 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: add video decode/encode cap tables and asic
 callbacks
Date: Wed, 27 Jan 2021 00:32:29 -0500
Message-Id: <20210127053231.202843-2-alexander.deucher@amd.com>
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

For each asic family.  Will be used to populate tables
for the new INFO ioctl query.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c   |  70 ++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c    | 162 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/si.c    | 104 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c | 208 +++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vi.c    | 175 ++++++++++++++++++++++++
 5 files changed, 719 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 13737b317f7c..54c85297dba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -70,6 +70,75 @@
 #include "amdgpu_amdkfd.h"
 #include "dce_virtual.h"
 
+static const struct amdgpu_video_codec_info cik_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_level = 41,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 2048,
+		.max_height = 1152,
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
@@ -1944,6 +2013,7 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
 	.get_pcie_replay_count = &cik_get_pcie_replay_count,
 	.supports_baco = &cik_asic_supports_baco,
 	.pre_asic_init = &cik_pre_asic_init,
+	.query_video_codecs = &cik_query_video_codecs,
 };
 
 static int cik_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 66279f0c6808..eabc11bc33aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -64,6 +64,167 @@
 
 static const struct amd_ip_funcs nv_common_ip_funcs;
 
+/* Navi */
+static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_AV1,
+		.max_width = 8192,
+		.max_height = 4352,
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
@@ -825,6 +986,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.supports_baco = &nv_asic_supports_baco,
 	.pre_asic_init = &nv_pre_asic_init,
 	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
+	.query_video_codecs = &nv_query_video_codecs,
 };
 
 static int nv_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 3cf0589bfea5..242ddd9b5d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -905,6 +905,109 @@ static const u32 hainan_mgcg_cgcg_init[] =
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_level = 41,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 2048,
+		.max_height = 1152,
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
@@ -1897,6 +2000,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
 	.supports_baco = &si_asic_supports_baco,
 	.pre_asic_init = &si_pre_asic_init,
+	.query_video_codecs = &si_query_video_codecs,
 };
 
 static uint32_t si_get_rev_id(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2396be16c28e..3c8b595fb39a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -83,6 +83,212 @@
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL                                                             0x01ba
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX                                                    0
 
+/* Vega, Raven, Arcturus */
+static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 4096,
+		.max_height = 4096,
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
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
@@ -988,6 +1194,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
 	.pre_asic_init = &soc15_pre_asic_init,
+	.query_video_codecs = &soc15_query_video_codecs,
 };
 
 static const struct amdgpu_asic_funcs vega20_asic_funcs =
@@ -1009,6 +1216,7 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
 	.pre_asic_init = &soc15_pre_asic_init,
+	.query_video_codecs = &soc15_query_video_codecs,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index d56b474b3a21..ed9de0950849 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -79,6 +79,180 @@
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
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
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
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
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
@@ -1093,6 +1267,7 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
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
