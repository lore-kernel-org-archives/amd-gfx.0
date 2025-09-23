Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43C0CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 13:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C95410E607;
	Tue, 23 Sep 2025 13:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIF8ZzCb";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9270D10E12F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 13:10:30 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso4299970f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758633029; x=1759237829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6R3+OA4hbZd5m5maePLWIfVDEJNWvzakIpY1MnVc0HQ=;
 b=SIF8ZzCbBbQiVIf6O9vynhgBT1qTYZTisXXvJmEJ5QWlvh9bnM2mO5brNvTOqlA9/d
 mUmRUaczj5CdWOS5ZnmVKGxcUqLoNI4my9jRoMaRsRznrgV+h1HZNKJ3DU9p+XUXKlKj
 Eh7LdTeMYal6UDz2wJY9lGc7V3Y7JDMrxgBJvmQV8VP8W0hi2uFf84fhS8dlFFM43Mmh
 BRa+MyAuIAZsljU8Bmy4Nkj+1U/D1n8sfJjznunheLRLWheQtFKLwwqdd/yy+0BBFIvP
 lc8ZE2g6trj5rS4hl49xKozwTedpE65GUNr0DuPUNb6dpu/ykygtARpJZxRmPoEvauGZ
 LMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758633029; x=1759237829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6R3+OA4hbZd5m5maePLWIfVDEJNWvzakIpY1MnVc0HQ=;
 b=Fs5GnsPQYehijmvA8Gz+7axazPD7FNSZMjGf22S784CXYDrBP5kK9h3KY1rF4PZP5y
 ep3GNMFLan7BcJtWoSnRMKANrX3cJYdo/9q6y6FYHjztDfEIRolmbf5m7rdKEaPPHEbh
 XV3EW+rPGtCKE76SYMO86nFbA1GIm7oE9VedDSG9G4zmaZz5AP+IyemrPXzMMSpj7eiq
 YnchhrO7uIDn0PYfI2EAyBg+7EoKxSoIBr+uqotEsQZOHQ3mAqgR8C3dR3WO9up4Zcbo
 1zMZY0Bl/GQhRmINjFgO9OkSOlaM/P6rYrhnAea05Spz7UlOXNt7nRWPL2yun7KfXl7O
 JC1g==
X-Gm-Message-State: AOJu0Yx9yXW0exaUZxyh8M/vsUMFn4IFbczXEokGQiKvcGyQeEeDINM3
 zLJjWvMPM9hZ//Uk6GdqDSwdLi32LpRLuJiPUeUS/i8nlDMMlqMFi+e6
X-Gm-Gg: ASbGncuDA8ypeqhtB6PeSbxenizWV3m4w7Gb2wgl/KArX+WEpJD8JYTYBtzjNNXxwZI
 8UDiVCDRvVgE4Q1+f/ellOEg6xoQqQv/KkxiTHyIW5TeNMBPhds+ZoifYI869PJMn3cOM09kmIC
 8129or923DVO1GbgihMkb9SXdOTPmySgADpHAlQ+NyJv9yrkv2q5Pl/L/ru9QEzTNg26ozVsj79
 GpG5iY09eFarvtfNs1tChbfqioN0fV3jVs0i1Ccax5gBDy6lsqb5c7M5/vKdasZew5wsDydCr3K
 626b5PwETbmn4CUG+D/5F3FtGe9oWuu9FloSfAd+YL9C7x2P2nnAgxsBp93eXhd0bCm0dK9kO4r
 fv693vE2DW8WLVowyg2SnLkk79AC9H2DSxg==
X-Google-Smtp-Source: AGHT+IEMGUaAlagp5xReJDFWh7e2hsl1/rZJ7Qj2PENZ+O8qqXOYrkFUiwcgHbZJKhdK+URonsPBCA==
X-Received: by 2002:a5d:5d0b:0:b0:3e7:68b2:c556 with SMTP id
 ffacd0b85a97d-405c523c775mr2282771f8f.26.1758633028932; 
 Tue, 23 Sep 2025 06:10:28 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154b:6000:92aa:f6c5:aa55:21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f88de2d075sm12491740f8f.35.2025.09.23.06.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 06:10:27 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	Marek.Olsak@amd.com,
	timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: block CE CS if not explicitely allowed by
 module option
Date: Tue, 23 Sep 2025 15:10:25 +0200
Message-ID: <20250923131025.3268-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923131025.3268-1-christian.koenig@amd.com>
References: <20250923131025.3268-1-christian.koenig@amd.com>
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

The Constant Engine found on gfx6-gfx10 HW has been a notorious source of
problems.

RADV never used it in the first place, radeonsi only used it for a few
releases around 2017 for gfx6-gfx9 before dropping support for it as
well.

While investigating another problem I just recently found that submitting
to the CE seems to be completely broken on gfx9 for quite a while.

Since nobody complained about that problem it most likely means that
nobody is using any of the affected radeonsi versions on current Linux
kernels any more.

So to potentially phase out the support for the CE and eliminate another
source of problems block submitting CE IBs unless it is enabled again
using a debug flag.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 +++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..6f5b4a0e0a34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1290,6 +1290,7 @@ struct amdgpu_device {
 	bool                            debug_disable_gpu_ring_reset;
 	bool                            debug_vm_userptr;
 	bool                            debug_disable_ce_logs;
+	bool                            debug_enable_ce_cs;
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 744e6ff69814..322890e2c899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -364,6 +364,12 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	if (p->uf_bo && ring->funcs->no_user_fence)
 		return -EINVAL;
 
+	if (!p->adev->debug_enable_ce_cs &&
+	    chunk_ib->flags & AMDGPU_IB_FLAG_CE) {
+		dev_err_ratelimited(p->adev->dev, "CE CS is blocked, use debug=0x400 to override\n");
+		return -EINVAL;
+	}
+
 	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
 	    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
 		if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ece251cbe8c3..3b3fc734c0f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -144,7 +144,8 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
 	AMDGPU_DEBUG_SMU_POOL = BIT(7),
 	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
-	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9)
+	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9),
+	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10)
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2289,6 +2290,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: disable kernel logs of correctable errors\n");
 		adev->debug_disable_ce_logs = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_CE_CS) {
+		pr_info("debug: allowing command submission to CE engine\n");
+		adev->debug_enable_ce_cs = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
-- 
2.43.0

