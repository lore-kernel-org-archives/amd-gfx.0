Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E631CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2126610FCB0;
	Fri, 29 May 2026 10:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XJL8n1HQ";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9614910FCB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:31:06 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so4269195e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050665; x=1780655465; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SoGuDFNS1PU5RGWudUwntthN8i9NpsXLycSHvESMdU=;
 b=XJL8n1HQjWIVpRvz+SEJtRpuzBtMDpy+LL9aV3mDe2S0A7h1t8DMOClTi96RMnqSxJ
 PceZ2F4NkgTwWCF0WsNyqGCjgn9clEvNayZrlut8EVCuESPJpimKUOntAOwp45x1/1re
 ph2kSqjr4NlildQGNTUA6ZCl8CihFv93YcEIkRCjVO8MwgB0kN6kZUbP3OqNCBW3AxKn
 nbNzfsiO4vPgTqL+sMc9gXM3/LRWLZVAGLMsijcKxbQgQ+zRkaxuAvu9g/ZlBop48ZvI
 V7SZocr9DAbiWOPV8Jz5u42jEoj3jwSCRK6wRfJGq7yRmPKYX+N7gpDX/ticOpeou5XV
 wEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050665; x=1780655465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+SoGuDFNS1PU5RGWudUwntthN8i9NpsXLycSHvESMdU=;
 b=F/45W6dawVWFNXKxDwWpIMWi3zpJK+XPgH5/66Tv/he5mq50YrgntUl5wS6fkLrlP3
 stSRkswZPzkuGbJt5kk2Hgn9LmeRmhgHd8bzoT7vX4xScrCaNKIpt5Dp6UkG202b94Ld
 NQntUOo5VbGSZ4lc4kDsNBCZS9DeeoqZXQ5VhfU5oh+i/Yz6oTg8cXtxYOXRVQBa+VaE
 rclFjpqTxxgY0G3f1+yZdC99yGuRzaVCJOnTfSa5+p1z3m4gp7QLUOFVWNmJgih68gdM
 kE2ZzJQTwKjELcHaiJX7o16exh1Q8DbhECLFHJA9Fzi/SlaKlmp0WfYfd5sNLMrdM9Br
 2Q8w==
X-Gm-Message-State: AOJu0YzaWHh7h3wnBBJyjkk7dOa74l+LUZ0TeiSeJw9VhIcmCpmxj7vY
 Y6vuKvwmuJIzSf8OXB0EZhO+ezYHOreRq1ElP3TmJDXrqjjsJkn14cnruxM9wAW4bXg=
X-Gm-Gg: Acq92OEs1CEeOdUGoQxHQRNtWsVHWeejXqGCv3WFhUqeGhSSUT5WyQ/1VI3QfXoWGQk
 FDAsumrJmBrgy+Zw/gpp2vOg0fgeLnhm+iAXJuRsrrDnaOD5RyoS9u4rgRHidrtFZ53CUzoGYXV
 bAzu0bac3wRfVihqRwcmurCgLJgO5kaVwCFtWXhFWOC1LZH/VRFKgzz6Zqd+OVY70Jls0a/Gcjq
 pHGDAuo0RrX/v75BMXwkVlWf9EaPo7RSVR3fV9JiCQ5CzUVQuKoIf+meKuAJqPmkeNhbHTu55Vz
 GCd9kwBDgsOqIogvIVa62wOYeN0TIECrRomKwLaRxbFM6dy+3t3WJRbTPBMzU0vG+rvYaaVPf3u
 KDEedMa6flnccFkr25B4HZNWs0taZgWnM9gX2XJsgSytFtvw/a0HG19rO/HWdws2RrZoYedru9h
 WjsREWQ1+uHrykVt3Ff/f2gQuP0VzWVBtHjU029ln8Vtxuh66j502hIJdJy920R6SuiUtkTmnEk
 iBnSiWZZQj0vtDK
X-Received: by 2002:a05:600c:a55:b0:490:6869:46c3 with SMTP id
 5b1f17b1804b1-4909c0cfa37mr44713215e9.30.1780050664962; 
 Fri, 29 May 2026 03:31:04 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0a89sm40895945e9.7.2026.05.29.03.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:04 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/7] drm/amdgpu: ACK the retry CAM after VM update finishes
Date: Fri, 29 May 2026 12:30:54 +0200
Message-ID: <20260529103059.21470-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529103059.21470-1-timur.kristof@gmail.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
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

Add a fence callback to the VM update and ACK the retry CAM
after the VM update is finished. Previously, we would ACK it
immediately after calling amdgpu_vm_handle_fault() which
caused a race condition that was likely to trigger the same
interrupt again, causing the same fault to be handled
multiple times.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 28 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 26aea960e2759..21c8d87477448 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -545,6 +545,16 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 	} while (fault->timestamp < tmp);
 }
 
+static void amdgpu_gmc_retry_fault_handled(struct dma_fence *fence,
+					   struct dma_fence_cb *cb)
+{
+	struct amdgpu_fence_cb *afc = container_of(cb, struct amdgpu_fence_cb, cb);
+	struct amdgpu_device *adev = afc->adev;
+
+	/* CAM index is the array index of the current callback struct */
+	adev->irq.ih_funcs->retry_cam_ack(adev, afc - &adev->gmc.retry_cb[0]);
+}
+
 int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry,
 				  u64 addr,
@@ -552,6 +562,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 				  u32 node_id,
 				  bool write_fault)
 {
+	struct dma_fence *fence = NULL;
 	int ret;
 
 	if (adev->irq.retry_cam_enabled) {
@@ -564,8 +575,21 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 		}
 
 		ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
-					     addr, entry->timestamp, write_fault, NULL);
-		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
+					     addr, entry->timestamp, write_fault, &fence);
+
+		/* If the update is already done, ACK now, otherwise when it's done. */
+		if (fence) {
+			adev->gmc.retry_cb[cam_index].adev = adev;
+
+			if (dma_fence_add_callback(fence, &adev->gmc.retry_cb[cam_index].cb,
+						   amdgpu_gmc_retry_fault_handled))
+				adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
+
+			dma_fence_put(fence);
+		} else {
+			adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
+		}
+
 		if (ret)
 			return 1;
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 77eb153802845..3bfb06e011a86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -27,6 +27,7 @@
 #define __AMDGPU_GMC_H__
 
 #include <linux/types.h>
+#include <linux/dma-fence.h>
 
 #include "amdgpu_irq.h"
 #include "amdgpu_xgmi.h"
@@ -214,6 +215,11 @@ struct amdgpu_gmc_memrange {
 	int nid_mask;
 };
 
+struct amdgpu_fence_cb {
+	struct amdgpu_device *adev;
+	struct dma_fence_cb cb;
+};
+
 enum amdgpu_gart_placement {
 	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
 	AMDGPU_GART_PLACEMENT_HIGH,
@@ -305,6 +311,8 @@ struct amdgpu_gmc {
 	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
 	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
 
+	struct amdgpu_fence_cb retry_cb[16];
+
 	bool tmz_enabled;
 	bool is_app_apu;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8c3ba7213eb22..f5e9b97e92a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3035,7 +3035,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	r = amdgpu_vm_update_pdes(adev, vm, true);
 
-	*fence = vm->last_update;
+	*fence = dma_fence_get(vm->last_update);
 
 error_unlock:
 	amdgpu_bo_unreserve(root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 2eb64df6daa94..6e28f0e435bf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -132,7 +132,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 				   DMA_RESV_USAGE_BOOKKEEP);
 	}
 
-	if (fence && !p->immediate) {
+	if (fence) {
 		/*
 		 * Most hw generations now have a separate queue for page table
 		 * updates, but when the queue is shared with userspace we need
-- 
2.53.0

