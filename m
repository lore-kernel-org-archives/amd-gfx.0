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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073C0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 16:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9273564DAE
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 16:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9273564DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149F46E84E;
	Mon,  1 Feb 2021 16:56:17 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15606E84E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 16:56:15 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id d15so12701965qtw.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Feb 2021 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fw3F1nRAYYunXZdVeR2+zwnTKl3N4AsGGGfAhaqYtzw=;
 b=hgqXUorL4x4ZjrG5bmofwc56j/n/SRIGWJrSEk3sD4mb76o+5W14aF5VgmhTq+5gGz
 A0ygTdT7tT7tLcbIX9gARic7OPSOpi/OjD+WDsLzB1wXMIW7MmuSqSfC/DfXyztJs0x6
 eHKfpvXSQoPQK+fJgdsmngaEgWcChQJX8nD74/qhg8l8CGJvJU7guqyGEg8PkZ1MEbcA
 5Y+zeYARKzGzxmWK6QIniRdT/qJBoLPOl0bXx5aW5wQHvKqDiWTYoEtmwz8H3JjechxZ
 JPhH9QURJbZhFO8FdStAcEwD6m7vOWKJpEA0froQS5lYnUqFyhbEQsgPpjN6f9YIKwxT
 6QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fw3F1nRAYYunXZdVeR2+zwnTKl3N4AsGGGfAhaqYtzw=;
 b=tZcR/kVua0NSOOT2DsCOWheJodASbjM1GLQQDBlxlXIklhHw8rT+Q0CSZuUyO8lntF
 ev7bdF5QjCCs9ABED6F+h7MFG7FLQxcqMf6sOzjyo7VmK93Pe4887UP7oloXLKBqgh80
 L+4SMl0bxUlDEcdVl2jo8iuNjIkwyeLHKyL8gRpheZm7XyD1px8ltko1ECp01JxXmjtS
 ToPE6twQN7WAyBYnZnQnQw/vdE0pNs7vsMIdStkh0O4AjDET08uTP9EEDqRcgRvEUx46
 uz/L6dkaOH0VWEZ91rIaZ5bSFFdMM1+o0gLD3IFSSdQjtptWELilwBxYM3FM/al60Thw
 O4Ow==
X-Gm-Message-State: AOAM532CuQZXXOM/BaJTbDrg74vH/ISIXMSkr05gXpDSGHtd28T7Jwv5
 6ViWxPKt8XxK02eNpBhzZbzHRYSCr8c=
X-Google-Smtp-Source: ABdhPJz2M1KJ+T3mAbd2LXqzV2LZidz6XxVw5JevBboRdsfvEH1C0aRFJae4Jell/zLN3ai5WBfB3g==
X-Received: by 2002:ac8:738c:: with SMTP id t12mr16102978qtp.141.1612198574564; 
 Mon, 01 Feb 2021 08:56:14 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id v145sm15022479qka.27.2021.02.01.08.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 08:56:14 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: add asic callback for querying video codec
 info (v3)
Date: Mon,  1 Feb 2021 11:56:02 -0500
Message-Id: <20210201165605.465228-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

This will be used by a new INFO ioctl query to fetch the decode
and encode capabilities from the kernel driver rather than
hardcoding them in mesa.  This gives us more fine grained control
of capabilities using information that is only availabl in the
kernel (e.g., platform limitations or bandwidth restrictions).

v2: reorder the codecs to better align with mesa
v3: add max_pixels_per_frame to handle the portrait case

Reviewed-by: Leo Liu <leo.liu@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f4ff8ddb52d4..4e4da872273f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -582,6 +582,28 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_BACO
 };
 
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG2			0
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4			1
+#define AMDGPU_VIDEO_CODEC_TYPE_VC1			2
+#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC		3
+#define AMDGPU_VIDEO_CODEC_TYPE_HEVC			4
+#define AMDGPU_VIDEO_CODEC_TYPE_JPEG			5
+#define AMDGPU_VIDEO_CODEC_TYPE_VP9			6
+#define AMDGPU_VIDEO_CODEC_TYPE_AV1			7
+
+struct amdgpu_video_codec_info {
+	u32 codec_type;
+	u32 max_width;
+	u32 max_height;
+	u32 max_pixels_per_frame;
+	u32 max_level;
+};
+
+struct amdgpu_video_codecs {
+	const u32 codec_count;
+	const struct amdgpu_video_codec_info *codec_array;
+};
+
 /*
  * ASIC specific functions.
  */
@@ -626,6 +648,9 @@ struct amdgpu_asic_funcs {
 	void (*pre_asic_init)(struct amdgpu_device *adev);
 	/* enter/exit umd stable pstate */
 	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
+	/* query video codecs */
+	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs);
 };
 
 /*
@@ -1218,6 +1243,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
+#define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
