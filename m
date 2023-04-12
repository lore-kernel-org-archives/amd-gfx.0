Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD13C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 12:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACCF10E2A0;
	Wed, 12 Apr 2023 12:20:44 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E12F10E2A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 12:20:42 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f080f4fbe1so4426865e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681302041; x=1683894041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axcV6WkGfelXKA16FDyPRsfFdln52Afafk+78X2rUlQ=;
 b=O5ImjvV9QVGPw9JfxCovlFltE4bF+KJub0Obv/h44u4zfwWpWjLxNZDm+I0zGoWlEf
 rVs1P43T8K+AW865oIOUT4YTX7iQEuOzFCtD/KZ+tg3hG7UI9vbY3jVuapvBFqRURUzI
 hDewLB6ImKNmxcb/kWSuhj3kNFvHpSR/mDTzvZl+FF34GEqnp6RQ9uJZpKNkRupSiPTA
 A61NvOCJ1Ax2HoqSypqkAQtbFKZ0vmF70hwEvuJGeve5yjDMoH+YNkiGzrjMRtVt2xPj
 PY0ERWpyfAS0YF5LdKKWVZ9A5QCiT1vXU7iytX5/O0VV/XLjvgsHwotM2EHy4FaPwMfl
 t39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681302041; x=1683894041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axcV6WkGfelXKA16FDyPRsfFdln52Afafk+78X2rUlQ=;
 b=ojFbfU0o2KwGqdwK/TBtq7nUq2sRHCgnspnhmu7nEl+kw3sbZ3XE/Qx6I396g3lw8i
 rMSYUs9sTLyaVD5uJlrTFdu6DMCEtLHxUzQmKwTqRKkHw8kZq7VIYzWf9yFaoElmrBZx
 3oxnp+b+jDogpGssizK0NqFLGqm+MiZqsGacaUi9poME0NzfFWKvkRrfnRvNHKhXPBs/
 nBwLWx0uPAAv/1uVKIG7N96EzkeoO7l7oZAld2ci4eGlFoRmksFVslKjvInL7QhCfEy4
 El0Bq4Q08RQJG0Y3dKPhXbxVTpBZnZRdRohMU7uo/zP3Ur5vAz79q44kznMi7Fzp/fmy
 wU4g==
X-Gm-Message-State: AAQBX9entklI+o7ZdNXClZuOI7jxMK6KI8S1sINx9JRmYME1O9jJCKGZ
 cBumhgTLEw1Ze62V5LX6EXWBTnVhn3IFUo9Wcn9vew==
X-Google-Smtp-Source: AKy350aPJm4hTMGs0PHqo1TABXCOhrnnsi8lnIN4gn+O1Hleryml6TYljMO5kWdQpPQ713ZLr9kvow==
X-Received: by 2002:a05:600c:3109:b0:3ef:7795:e5b1 with SMTP id
 g9-20020a05600c310900b003ef7795e5b1mr12169261wmo.4.1681302040852; 
 Wed, 12 Apr 2023 05:20:40 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b003f09fd301ddsm1366428wmq.1.2023.04.12.05.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Apr 2023 05:20:40 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/2] drm/amdgpu: Add support for querying the max ibs in a
 submission. (v3)
Date: Wed, 12 Apr 2023 14:18:27 +0200
Message-Id: <20230412121827.1122035-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
References: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
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

