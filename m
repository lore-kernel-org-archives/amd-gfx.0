Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9929C9832F
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jan 2026 12:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3748E10E2C0;
	Sun, 18 Jan 2026 12:57:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mt7Q1hov";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2E710E2C0
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 12:57:51 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso452520266b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 04:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768741070; x=1769345870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T1WFJ5Czfrq3dH7fxrVkIISeAxeP5+0PLp8dOb7O5HQ=;
 b=Mt7Q1hovYlrVCjdX6EynEDAtXOTEnCpwcOtFRqrtJsJNsQ3U8oCOXSxYVO3qjKPW/b
 L00nHId6W2bOPnlPKAOa9UE8mEIREEa3aC4Lzl8v0S4+x8LCSbgF9kM1T+Tf8mYesCqM
 gBfFWiLXeVlK4CRj4f5Bj/C3AAY3XQBaCU60MerGJQRKdAvuV+hfj3EepKtj/Cw4EKIK
 ACGNimbcweUkek8Brz2Aslp4UYf9/pF9VyWwEUWkvfsBg8X8/TYawpRL8hqAeL0xsZ+a
 2dVtJeJ324pGX7cQxz7f1hfYYZQ0dq9WI6of4L3lz1MJ9HCcagulGRQewpwwrgomDB0P
 VyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768741070; x=1769345870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1WFJ5Czfrq3dH7fxrVkIISeAxeP5+0PLp8dOb7O5HQ=;
 b=W1BrGfbFSug/VPYbTkMr14j6oWJhIm2oRPNAUJDS7oUpNgFEReBQuje8q5MUFuo0Yd
 KSPaEe3lCL6TR0KZgwFnZ1zzxEA8hwhYKLNwHFGEsu/HEW3epYrak6BDRoCN3KIOHmZn
 Gknmtu/AxjvaabsTaBnvlqTASZ5szfOb6h/vH+ZMyr2pKU8xkoQSQuphLBUujBMC78+1
 sYX8/IMIGyT9eoizX1gZcd77ukhFhARUwQkFtWoM/dwU7Fgs6YgxQ+aeNDcGJc+AcGYl
 WJGTyV1yAo7zuJIhDHsVNOXbsceEkqdm4YVbnXBdMwoA7XRyMGyqLqyi8odWlrzmqxbp
 mqsQ==
X-Gm-Message-State: AOJu0Ywf8sXble2p3xNKR1wUyVXP32dWyUTGo7pWXc2w1tNuCXGj2Jal
 S8j6kWAepJ2EzPvsSEs9VpnaIZEIgxIMAkKzdc7QM1asGYVJr9Rl5WYyynQn8A==
X-Gm-Gg: AY/fxX4chNm0HuPj7vfs54zASPIWbNvbCz0PhLJ0ywnhjhKUg7KGBsu0sb/hKgz6Ddm
 0E9R36/8NFQbL87LCOp6oLxNHwcLAcKGpRQU+ODwInOl3xz3Gr/nvIHzvHivwb88/7XFOECAXZJ
 aFAc9QtmqqKZ8/O+ul52/k8UKtoTGL4ErB7I/tu3N5P0IQ/7CuVf0VkP/RcYI4gGRbv+6I8z3dh
 RLk3YT20YFx0l1WS9IGg79fpfr4k1CnYvcqjIIz2SkpSzGJQdyhHUwpsB1d9Mjm8XOSNJ3BYwCd
 fL6V9DRkVhJ+MhvRTsnnXPGLBN4RCSS0qw7hONyuqLg6k6VcUoFg7ru8+eJHD/6TnpW6x3jMf/Z
 bG3TRTcrFofbvMeb6nLCGgKH3lq2BW06AQ14a/nt6B1b2N2g3Y7WqN2WXZpasISu31gI11ARRPq
 vFKEJ2zNf6ysnERSw5TiBwsa8e6CmB9fxkf+TpdCihX3H6D8WRf+InyjQWlErGchP9wT7mlJf56
 eM6IKpe+GQn
X-Received: by 2002:a17:907:25c4:b0:b6d:67b0:ca0b with SMTP id
 a640c23a62f3a-b879324d5c6mr739493766b.61.1768741069899; 
 Sun, 18 Jan 2026 04:57:49 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a31fafsm777478166b.66.2026.01.18.04.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 04:57:49 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Date: Sun, 18 Jan 2026 13:57:46 +0100
Message-ID: <20260118125746.40221-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
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

When a function holds a lock and we return without unlocking it,
it deadlocks the kernel. We should always unlock before returning.

This commit fixes suspend/resume on SI.
Tested on two Tahiti GPUs: FirePro W9000 and R9 280X.

Fixes: bc2dea30038a ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 0e67fa4338ff..4fa24be1bf45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -769,7 +769,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	int r, cnt = 0;
+	int r = 0, cnt = 0;
 	uint32_t seq;
 
 	/*
@@ -782,7 +782,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
 
 		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
-			return 0;
+			goto error_unlock_reset;
 
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
@@ -797,7 +797,6 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 							 flush_type, all_hub,
 							 inst);
-		r = 0;
 	} else {
 		/* 2 dwords flush + 8 dwords fence */
 		ndw = kiq->pmf->invalidate_tlbs_size + 8;
-- 
2.52.0

