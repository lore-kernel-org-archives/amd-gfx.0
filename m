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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95C0C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5BE64DBA
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5BE64DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAEB6E957;
	Tue,  2 Feb 2021 16:13:18 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384A16E95B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:13:18 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id d85so20284718qkg.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 08:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hOTvOf8PqgbUZeUELojgoTxK6WOkZ+CmmKShZCeJTIg=;
 b=ZrvBDULocotncbefjvUIN8051yifptGght3i6rvCh8GlKEwAUmZai/vW4PJPDekbkZ
 uhF+SSpAUg0uEbPcQFzahVTDf+2yArss4oJbCj/6m0vg9w6IeaE8QSe9Xggb+RjyHcSp
 Qz7xzwCFWl36rgkF6Y7zUr2YJ/nc+UJ8Z5idovcnQgxmvR1Eag7IKOD3pdk9jDxyoFPp
 gFywiW68uXD0++n+HN1lhmiM3x5gs7i2tcFOfXvWMmQ6CUuq2oIkSdjcVq4ACxZV8UE7
 B8qAm68YbAYSVtYQ+D9co3TEUqMfiDYsYLCHmVYEyYyB2mt9s1AXIOxkYmBZLXeJbrPR
 M9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hOTvOf8PqgbUZeUELojgoTxK6WOkZ+CmmKShZCeJTIg=;
 b=JfjUDMaL2a46STVT/JvN26qpI11ePGal6lgkAVECmNWgfRn+6eqZBW2SMt2FelGhr5
 IxxOVnho0pXBVR+x5xmRhHSRolN+ozLgqG+8xDw8Se7JHkrH+q8Jd7TSyOeecLrlXyMc
 wnMxbyFoHzjxnjjb/CkaTr+XG3zHPGPMeYb4fd03JnaLyTs+xd6+Vlbj7GOLVSFWagje
 K6+lxzc2AO/C5Y0ZnbD3FhayYV2AOICIFOtmHdACPmVELMdMmkHhXFOHnjTcR9PZjavg
 Iq6BBLmIFI1U3+rQHjztN04w7OeZ8lI42EmPUJYm+GwaS77164rW1GNcV+KLMi1OsLVF
 v1YQ==
X-Gm-Message-State: AOAM532M0Oe3VHemc8KG8y9Q0peDEldmbW8rZdM6kAab2JWhAmotcL1O
 bpMsAwk16ut0iHHkQ6jlHtxkWwJaSDM=
X-Google-Smtp-Source: ABdhPJxEXC/q7G0Sjso3yt0qCVoSfS0tXvm2+YxFZSKKRpJIRNKVhsOPWnqjqLworqScbovjq8Nw/Q==
X-Received: by 2002:a37:ac10:: with SMTP id e16mr21959884qkm.465.1612282397037; 
 Tue, 02 Feb 2021 08:13:17 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id z128sm14539078qke.70.2021.02.02.08.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 08:13:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu/codec: drop the internal codec index
Date: Tue,  2 Feb 2021 11:13:03 -0500
Message-Id: <20210202161303.538281-5-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And just use the ioctl index.  They are the same.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  9 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/cik.c        | 12 ++++---
 drivers/gpu/drm/amd/amdgpu/nv.c         | 36 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/si.c         | 12 ++++---
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 46 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vi.c         | 28 ++++++++-------
 7 files changed, 80 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4e4da872273f..fdfa88c7b171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -582,15 +582,6 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_BACO
 };
 
-#define AMDGPU_VIDEO_CODEC_TYPE_MPEG2			0
-#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4			1
-#define AMDGPU_VIDEO_CODEC_TYPE_VC1			2
-#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC		3
-#define AMDGPU_VIDEO_CODEC_TYPE_HEVC			4
-#define AMDGPU_VIDEO_CODEC_TYPE_JPEG			5
-#define AMDGPU_VIDEO_CODEC_TYPE_VP9			6
-#define AMDGPU_VIDEO_CODEC_TYPE_AV1			7
-
 struct amdgpu_video_codec_info {
 	u32 codec_type;
 	u32 max_width;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 04b9cd75f7b4..b78847fa769b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1019,14 +1019,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			int idx = codecs->codec_array[i].codec_type;
 
 			switch (idx) {
-			case AMDGPU_VIDEO_CODEC_TYPE_MPEG2:
-			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4:
-			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC:
-			case AMDGPU_VIDEO_CODEC_TYPE_VC1:
-			case AMDGPU_VIDEO_CODEC_TYPE_HEVC:
-			case AMDGPU_VIDEO_CODEC_TYPE_JPEG:
-			case AMDGPU_VIDEO_CODEC_TYPE_VP9:
-			case AMDGPU_VIDEO_CODEC_TYPE_AV1:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1:
 				caps->codec_info[idx].valid = 1;
 				caps->codec_info[idx].max_width =
 					codecs->codec_array[i].max_width;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 12ed86deaa84..6ee2c0e3ea50 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -73,7 +75,7 @@
 static const struct amdgpu_video_codec_info cik_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
@@ -90,28 +92,28 @@ static const struct amdgpu_video_codecs cik_video_codecs_encode =
 static const struct amdgpu_video_codec_info cik_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 41,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 64c973cd9088..e6878645df93 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -25,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -68,14 +70,14 @@ static const struct amd_ip_funcs nv_common_ip_funcs;
 static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
@@ -93,49 +95,49 @@ static const struct amdgpu_video_codecs nv_video_codecs_encode =
 static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
@@ -153,56 +155,56 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode =
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_AV1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index da258ff75042..7817e5156cb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -911,7 +913,7 @@ static const u32 hainan_mgcg_cgcg_init[] =
 static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
@@ -942,28 +944,28 @@ static const struct amdgpu_video_codecs hainan_video_codecs_encode =
 static const struct amdgpu_video_codec_info tahiti_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 41,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a81fd7de72b7..5ef2e2707754 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -25,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -87,14 +89,14 @@
 static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
@@ -112,42 +114,42 @@ static const struct amdgpu_video_codecs vega_video_codecs_encode =
 static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
@@ -165,49 +167,49 @@ static const struct amdgpu_video_codecs vega_video_codecs_decode =
 static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
@@ -225,49 +227,49 @@ static const struct amdgpu_video_codecs rv_video_codecs_decode =
 static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 4096 * 4096,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 462368d2804b..2bfead243335 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -24,6 +24,8 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -90,7 +92,7 @@ static const struct amdgpu_video_codecs topaz_video_codecs_encode =
 static const struct amdgpu_video_codec_info tonga_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
@@ -108,14 +110,14 @@ static const struct amdgpu_video_codecs tonga_video_codecs_encode =
 static const struct amdgpu_video_codec_info polaris_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
@@ -140,28 +142,28 @@ static const struct amdgpu_video_codecs topaz_video_codecs_decode =
 static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
@@ -179,42 +181,42 @@ static const struct amdgpu_video_codecs tonga_video_codecs_decode =
 static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
