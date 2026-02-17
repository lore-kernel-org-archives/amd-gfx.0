Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0260E6815C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 10:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266B610E4B5;
	Tue, 17 Feb 2026 10:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XGI2nZb4";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB14F10E4B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 10:01:17 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48372efa020so28585555e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 02:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771322476; x=1771927276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4dPUQviCs32U22KArsETHy1litVl5ymocnjL9FdNd/Q=;
 b=XGI2nZb4QbUisigh1PYmCmZzzsYCW36zlBK6FL6U2P/TF1rpXYMbeYXseD5nicb00Z
 G8pOeI2XAxJfxdG4b7YFfwxqT/S0lkxW3olHBe8PyZ/0F/bEzAAFITbbsEWa4Zz/E8mk
 +bpGf368U7juwdF+7phYMQn5m0OsA3J/VEEjNeuCxC6JxEyqJef7SQ2PezGOgvyfdD4H
 JebedtgF1BDRnR6L1Wh7d4ikvaysh8iwNgV0bMIg1QD/qbW55+rqG2+Nh90rSkE1fYa8
 VfaMo6lUCgLCX8JdtijwJ2YnbMaMvYudKHGLpb7G7h/pOcTKxl0BZyTduAmTwKYXLMSh
 iJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771322476; x=1771927276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dPUQviCs32U22KArsETHy1litVl5ymocnjL9FdNd/Q=;
 b=QggP22UhSByndLN9FgjsdrVcX/UMJwVyRM0t1FvPjNHmPiqaKXPTMT6OoyIUSnHWkI
 vjv6NvkZHF26AxR3scAk2/dWG8MbJ/s84+oO6E+5qM4QOaWCKAL2qtDfBlb17B69UKbl
 04CBYmG7mtj3TVbPDR0418Vauxt6mEIiFMUR03NfALB3kzJZo3oYJ+xx2xAQ4T77ve3r
 v2UogbqDUuG7TQYXExhQlGH0wo7phYPq4ONNY6KWw6bXdvN6NjXT2HoweW28wSne80mS
 Tw+lHKuEQY27J+kKVwuh/u0uSbFhL4+4My9oSJd5TykXWcjJy4wS9RmJK9sdijCJ6B/6
 ELEw==
X-Gm-Message-State: AOJu0YzNifxtqeQnsDzbEURlpzcGa+Ri1J03DNaYyEHt6P+eRzu9mPcC
 PItm47q/QEOVwOeKHqtRXpcrVVoR2y5Kb1JpIs07y6TQwClJBO0MxmMt
X-Gm-Gg: AZuq6aLSWEx7aMHT9cdyQGPjPDOoVs51U3pcf140kSl3Uz9PuXu5sHPLTwp5ImyBkkL
 6GKoFyuP96asmLSetnhinhfioGqMxWhSqONPPgAPJZif0BjC38GYMj3foQAlhwjHraJV4Hvu7jl
 KSIpHrJ2Vtm0L9Mzx/Ar6WXiolDOirIX0QtHwOBnl1uvLU9w1NZWjpyRpYILpqpE+kgpo0RnKLL
 v1cHdyJN0EITRI/E/l80piqAauXHSk1WromNvbzkkcwoyfXmhhnH0Oj+vBK1N78HyAikwKf47o0
 u+icxpxZ5Tbu+YYFNTK4XllU4B+i16aAdN5ISTsbEqpEARN3DHMrsht4noJoq2WwO5ods09KRrd
 DvtpxfiDz45j1s+/8ysUD4CVB7/104hrHIWNKhEvplQKmmUxEWLHnN/Vtl2SFNR4J7U6laCA3o6
 y8hgu5nUZxIco+ZZZbdFdpNNKJlT/eRXbPNWLz
X-Received: by 2002:a05:600c:4e93:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-48379bbcbd0mr175650635e9.12.1771322475810; 
 Tue, 17 Feb 2026 02:01:15 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15d0:7700:9cb3:3809:125f:c312])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d92267bsm759059255e9.0.2026.02.17.02.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 02:01:15 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Philip.Yang@amd.com,
	Felix.Kuehling@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix 4-level paging if GMC supports 57-bit VA v2
Date: Tue, 17 Feb 2026 11:01:14 +0100
Message-ID: <20260217100114.2019-1-christian.koenig@amd.com>
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

It turned that using 4 level page tables on GMC generations which support
57bit VAs actually doesn't work at all.

Background is that the GMC actually can't switch between 4 and 5 levels,
but rather just uses a subset of address space when less than 5 levels are
selected.

Philip already removed the automatically switch to 4levels, now fix it as
well should it be enabled by module parameters.

v2: fix AMDGPU_GMC_HOLE_MASK as well, fix off by one issue pointed out
    by Philip

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e8e8bfa098c3..0e8a52d96573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -33,9 +33,9 @@
 #include "amdgpu_ras.h"
 
 /* VA hole for 48bit and 57bit addresses */
-#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.max_level == 4 ?\
 				0x0100000000000000ULL : 0x0000800000000000ULL)
-#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.max_level == 4 ?\
 				0xff00000000000000ULL : 0xffff800000000000ULL)
 
 /*
@@ -45,8 +45,8 @@
  * This mask is used to remove the upper 16bits of the VA and so come up with
  * the linear addr value.
  */
-#define AMDGPU_GMC_HOLE_MASK	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
-				0x00ffffffffffffffULL : 0x0000ffffffffffffULL)
+#define AMDGPU_GMC_HOLE_MASK	(adev->vm_manager.max_level == 4 ?\
+				0x01ffffffffffffffULL : 0x0000ffffffffffffULL)
 
 /*
  * Ring size as power of two for the log of recent faults.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dfad7d11826c..c6fd3a091613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2409,6 +2409,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	}
 
 	adev->vm_manager.max_pfn = (uint64_t)vm_size << 18;
+	adev->vm_manager.max_level = max_level;
 
 	tmp = roundup_pow_of_two(adev->vm_manager.max_pfn);
 	if (amdgpu_vm_block_size != -1)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..806d62ed61ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -456,6 +456,7 @@ struct amdgpu_vm_manager {
 	bool					concurrent_flush;
 
 	uint64_t				max_pfn;
+	uint32_t				max_level;
 	uint32_t				num_level;
 	uint32_t				block_size;
 	uint32_t				fragment_size;
-- 
2.43.0

