Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CDCCA1013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 12:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C9510EB98;
	Fri,  5 Sep 2025 12:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X/ERdf8n";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A898F10E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 12:47:45 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-621b8b0893bso965237a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757076464; x=1757681264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g5HeiUHcW5ZLfaNaHZBIfLJcgfeFkprmNklDXjCAZ8o=;
 b=X/ERdf8nHVApk9LYQqE1wz9mYMb4yq0s82Jw4kyTxrN7CI01QzMnV0NJO/76w6RFwp
 G8HZxEkG+4NejM5wAPT++m4WbgHxrdM7v7RcH15nScAS7fGDNteRYIKB/cB7MtnpoEcc
 hMbf9WddoTWOjiidSw3+k0+0sK2rHqzWNUcU/RZxI7r+Yt+CdSQcqFxJdRNLQLFrVpmv
 bC/3JXg+6tkfZCPGXA0Xf02TRcJP11TGtl9iUAYoEk8hA34WNmVcqnKC+cm8qLZR/I+l
 HX5QsrXrmx32LfB+XFbTVr8rJtT3j8F3jUv4i+vSc0DpLP+mEniGGsiko0SM0iZi6F7b
 WM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757076464; x=1757681264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g5HeiUHcW5ZLfaNaHZBIfLJcgfeFkprmNklDXjCAZ8o=;
 b=UeBas6u4cx/AT5i2zmiFbMcu/EMwFDm9BGp31HbMONsxaEKE2+XATcGhwfzvMy3C01
 D4yhKUi+v+6dopYHsxfAjU/6gLp2sTQRHRz8kyTa5rNboRFPB8rTBg9HL51WfMP2x2DR
 tguNiGAr/AQwU4pg3mBulvv/lx0hUpmyidpd0UXeGhh+YB+zhAFtQliBQdLRrIk/2Z+w
 /kIWoU+mXLhZ/VH8PafcRkGEmuHMxHiP8nBElBeDGpDDw4cGxilauOHvGuZhUpQdk7kC
 u58Qhav/J7E8aeP/CJQppTrRSBqABWUpw+lumBSRLRQKzYh1+E/w3TUpEq1k4nJsh0qv
 PodA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgy0W+Qiy7tb/oeznz2aocWB9zMXXtkDSQQpbS3uUXclepZ4aBfogwiiAZpn3TSvea390y3hXw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDVEVJoIEdhqM7tG310AWCb529XgkJJu2DhTPeyGu5MPVNeN8d
 k5qUIjixTSyHAW/1jPWwu/+NNRX5yRVYFcFQQ+ON1zpprYK4dLrOurd+
X-Gm-Gg: ASbGnctHkvQcRFG0jeG+0pyKwptfyX3ia1F9ajb0xfERXibV5MXZgNt1JgoPh5nAip3
 9/CgZOlmH86Ny6Xdvfn8S83WaHoQ59Mb9snRGXnIQZtDxtBX8xjh5FFB+BynbVBS97/nVXlbGRO
 sqedsxWeWO4rmwVw/o1cDDTOEJb1Auv74nF1fGqh/AKZQvX0LTPEUVO74snBp+g+NUa35oOcNaT
 dB9Fxm4TAL9coE20V944cV/QdebvNlyXA8wSqrtOaWHlQBJuu2PKTsqApCsmQdqaji2paC81zLz
 u990NdGucOR5KqL2VYN+Di5COiDHRZjohHi+4tit4bNboFzgBMnRxYJscB/V6g+HW5CtY/VFUni
 8Q+bQGClaShzamhF/P3w8x+0fW/slfR/SZM8e
X-Google-Smtp-Source: AGHT+IGlA/k65F/KRZHV1EFTyVd7YKuKU8fOdzGlknWmPWFOi/ahwC/SzBAcwuZguaxe/69V2TDSnA==
X-Received: by 2002:a05:6402:2105:b0:61c:526e:e8bf with SMTP id
 4fb4d7f45d1cf-61d26c3e619mr21991783a12.22.1757076463907; 
 Fri, 05 Sep 2025 05:47:43 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bd:7900:c026:1908:2e29:be84])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-621421b9debsm1513006a12.34.2025.09.05.05.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 05:47:43 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: timur.kristof@gmail.com
Subject: [PATCH 1/2] drm/amdgpu: add AMDGPU_IDS_FLAGS_GANG_SUBMIT
Date: Fri,  5 Sep 2025 14:47:41 +0200
Message-ID: <20250905124742.11305-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a UAPI flag indicating if gang submit is supported or not.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
 include/uapi/drm/amdgpu_drm.h           | 9 +++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8a76960803c6..8676400834fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -939,6 +939,10 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
 
+		/* Gang submit is not supported under SRIOV currently */
+		if (!amdgpu_sriov_vf(adev))
+			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_GANG_SUBMIT;
+
 		if (amdgpu_passthrough(adev))
 			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_PT <<
 						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9cebd072a042..7a228c4d1325 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1084,10 +1084,11 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
  *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
  *
  */
-#define AMDGPU_IDS_FLAGS_FUSION         0x1
-#define AMDGPU_IDS_FLAGS_PREEMPTION     0x2
-#define AMDGPU_IDS_FLAGS_TMZ            0x4
-#define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD 0x8
+#define AMDGPU_IDS_FLAGS_FUSION			0x01
+#define AMDGPU_IDS_FLAGS_PREEMPTION		0x02
+#define AMDGPU_IDS_FLAGS_TMZ			0x04
+#define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD	0x08
+#define AMDGPU_IDS_FLAGS_GANG_SUBMIT		0x10
 
 /*
  *  Query h/w info: Flag identifying VF/PF/PT mode
-- 
2.43.0

