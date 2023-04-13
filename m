Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89919C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 14:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37F010EAF2;
	Thu, 13 Apr 2023 14:25:09 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65EBD10EAEC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 14:25:07 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f080f53fc6so6234895e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681395904; x=1683987904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axcV6WkGfelXKA16FDyPRsfFdln52Afafk+78X2rUlQ=;
 b=V4OBMI7EEBB7zg9/sdBfr1/fTvXtbqe3H1rbJ/izgikeBiep3VqfnEicPrHNxzZL0m
 yHJpqZKoPQUbQ0bc89ghpB1E8Dij6FTGRahUFn761TnfxKRwNepif34TUokfIT0k/drX
 rf+7KSp1KD+ezRw7jKunxa+oI60zy+ZgpDz99xkJY/aa7yt4xrd33mLrr1CvcfA4Qh9+
 ql+4CBPmtJ5p0he31cU7bOpIZWoPqGyq0yfK8QrqS188SmhEYQvgqvN2zdDf3iogWN9z
 KCMHREKohEY0jo7oO1vTJ9qeAzYpONyHK1WALhsBBytIxcqAXUnu5eNm4EP9/WmKvKuN
 +YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681395904; x=1683987904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axcV6WkGfelXKA16FDyPRsfFdln52Afafk+78X2rUlQ=;
 b=E7VzwSOtphcX8VMMcp2YKCkxbHPKvRjvRWVRRB54LIIck9JwSgBtmlxyVJOmMxTvQI
 MXs9gWZKzQ4qlz33ZuOR0JPAFG02090G3vDf4u6QiRrBgn9RQpvHMqgMjocwmXHR0Dhu
 eA5vbCYCSY8o6w1zLA9kJJjijzuE7mMkgKfncl5WBZsYPSRliOBExD5v2YIJx0ahB5Ya
 j9IojEB+FsQEf9pe+WOTQ923z3bntxIWLLdJJgnL1ZgtUWCyRTWR0OnHKvZueRwheoUY
 VqFPiJACQuWZ+Dsy1CsA/AalTthAVUQzHCyZvSD0ejAXehe9SN/kzs7JsUl4n/ZuX4ds
 miFA==
X-Gm-Message-State: AAQBX9d8QCGnH4jzaTBDI0U4Ne3L27xMw+4f9glslxLh9e8kHReEU1d1
 bpjClEjQ1dYTIhby5n4dkO4Sj55jqahuwgTjhn6HDw==
X-Google-Smtp-Source: AKy350YhWwqSYkrcWQvqueTAxh01mKdVCaOkdAdP3kNysrBLTRC/qNOnQ5tF9E24Ef5yfWsv5zAOgg==
X-Received: by 2002:adf:fe4d:0:b0:2c7:1c4e:1d16 with SMTP id
 m13-20020adffe4d000000b002c71c4e1d16mr1391437wrs.0.1681395904385; 
 Thu, 13 Apr 2023 07:25:04 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a056000120b00b002e45f6ffe63sm1401186wrx.26.2023.04.13.07.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Apr 2023 07:25:03 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 3/3] drm/amdgpu: Add support for querying the max ibs in a
 submission. (v3)
Date: Thu, 13 Apr 2023 16:22:53 +0200
Message-Id: <20230413142253.414333-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
References: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 christian.koenig@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This info would be used by radv to figure out when we need to
split a submission into multiple submissions. radv currently has
a limit of 192 which seems to work for most gfx submissions, but
is way too high for e.g. compute or sdma.

Userspace is available at
https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/ib-rejection-v3

v3: Completely rewrote based on suggestion of making it a separate query.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0efb38539d70..1a2e342af1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1140,6 +1140,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		kfree(caps);
 		return r;
 	}
+	case AMDGPU_INFO_MAX_IBS: {
+		uint32_t max_ibs[AMDGPU_HW_IP_NUM];
+
+		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+			max_ibs[i] = amdgpu_ring_max_ibs(i);
+
+		return copy_to_user(out, max_ibs,
+				    min((size_t)size, sizeof(max_ibs))) ? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..6981e59a9401 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -876,6 +876,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
 	/* Subquery id: Encode */
 	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
+/* Query the max number of IBs per gang per submission */
+#define AMDGPU_INFO_MAX_IBS			0x22
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
-- 
2.40.0

