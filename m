Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D547BE9E300
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 12:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D6510E0C3;
	Wed, 11 Feb 2026 12:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnDzqAXg";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB49510E0C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 12:36:43 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so20910365e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 04:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770813402; x=1771418202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JDMWxh8UEPeKjXR3p4W9eVqNH4sNPeNN2xnwNi6YR8I=;
 b=lnDzqAXgt8KwD40SoJVPMx7lUjA4qE+2izt/bUH7/5SkEk/02DB4GgZF+rG8N/fwNA
 qcV2fQqlsTCePjO1tNO8zSducmLfOZVRE6Z50jVeGCvLkAR1/NilB5MtSs268jVLRf6M
 e0Xt5jsx0MqBekEVDgu19/QV41UESHj1PrKQlLSfp1xngLq4KVf9n29WOFSEYv+RAviK
 JA9W76M0pXApHoUqE8+kVmob5mIXsfzZpxIJoVeMv9Vth2j/FA8C0mSfEuIGiB8TFw5M
 vP4TR8sCJqRurt0pDeo9YUxMhxA2/ZYbotsxjxxN20YEcRl/g3AnNBAMOy623GUOxBTG
 wsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770813402; x=1771418202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDMWxh8UEPeKjXR3p4W9eVqNH4sNPeNN2xnwNi6YR8I=;
 b=JAcYkEs+z91ibtHS/PdAQco+41g/KHVN0YMteWleXfV5uP/VvEdHOSZfbcjt/ZejAR
 l4vibdf7YgnRw7td3Cx7i4tlnMf1O9+SSNjET/PLx9K0ntqEXjZFjwyyrgeOaAVLvfch
 irqTLTUDCV6Le4C+l7LcM4j4UmkRxqD89+fvIUNNdm+VZ0y6k3F/8CL9/VtdS90JVZl5
 Wzrv3RBi3UI/t+2/qk4GQxlBThyL0qdYq4Fwr5oTi4N3xP7ACNVxfwxHYELhPPUCnuNf
 Oy+ehfL+VdAQh6JaeoOsBwd6zKvhX4W6wajQYRg+NhBWI0lnWeN7TGC7nIIrGOU86p94
 iO0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+M2jmAlOgywru8PbFH4V1/RdAqxNpNsmSwSA3pqZekKGUhYQ0ckI7rIalO94IPImptOER33H3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMGudF9TRGkPUSl4pQ15eOp+vNjA3W0LMx1q8n/4AMo+7YJ0Va
 RmVCnR24Tgfd9LG5FY9df0erUD9GRBGptP6qJXLOc8xU6OGNYzqmEC1laE23GTHE
X-Gm-Gg: AZuq6aKE2Wgug11qM435GmvsIIWSU8qOFEHbqNKX0pxhd/aZGBUKgzmLHtPPWhlU7Rj
 iCHUP8nO2IBXpLLdnGkKLFqqzWF1J4X3QQQc+Tm2J+F+MQO+yjkHuga6X71TfcqnhmrrDgQcXMv
 ylCGuYa0bEYfOcULvdlkL8+Zz5fJTAFNHJtKzq2yYvJ6zrEHf1V4ts7oykTzb/VrB6FEEPKIjK5
 F1b77PzVv/uSWN6GE7/pMDZpjb/l8eNX9WLP1ymOXwpe5oZclzMZ/oJoylwKcMB+8WYtS+Elkdq
 REDGbLnagNnQFig3kKiZnCevAWrYIHDTd1DweUEGdDQZ7G/7pr9f2zkoRAfoWsyNQSpC5d/UtQq
 z0A4l5xWJfZtpLVlbiHlQ9fUSyghGJherPzjOLZr0c1E+I/+2kmFGW2akFZEcCMmcLH1/rZuwaY
 DycX0zH2kNoJF2TcfE43577Jkznw/Qw9UkCA==
X-Received: by 2002:a05:600d:6445:10b0:483:4807:210c with SMTP id
 5b1f17b1804b1-4834807228amr99000375e9.24.1770813401901; 
 Wed, 11 Feb 2026 04:36:41 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1543:fd00:4328:d3c1:69:53e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d835f6bsm110523505e9.14.2026.02.11.04.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 04:36:41 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Philip.Yang@amd.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix 4-level paging if GMC supports 57-bit VA
Date: Wed, 11 Feb 2026 13:36:40 +0100
Message-ID: <20260211123640.14782-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e8e8bfa098c3..3b9ca5667de4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -33,9 +33,9 @@
 #include "amdgpu_ras.h"
 
 /* VA hole for 48bit and 57bit addresses */
-#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+#define AMDGPU_GMC_HOLE_START	(adev->vm_manager.max_level == 5 ?\
 				0x0100000000000000ULL : 0x0000800000000000ULL)
-#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.root_level == AMDGPU_VM_PDB3 ?\
+#define AMDGPU_GMC_HOLE_END	(adev->vm_manager.max_level == 5 ?\
 				0xff00000000000000ULL : 0xffff800000000000ULL)
 
 /*
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

