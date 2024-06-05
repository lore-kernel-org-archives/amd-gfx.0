Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E7C27C53
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60FB810E2B5;
	Wed,  5 Jun 2024 12:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RwH7AjbU";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4FE10E12C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 12:32:02 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4213870aafdso35153785e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jun 2024 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717590721; x=1718195521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PizG16P+RWVf5FnyeRiV/y4YlubP/re3a+rN9iPlQSg=;
 b=RwH7AjbU9Y+hUkF2Vr1RzVsmMdrcMuZRRJU3r5gBM4Mtq3hriCDNypVKuafunsyORx
 5O+frVccBT1bDUSGxhRn1Z3Kzx6RXCahjmk6x/VZR0OHtoPBpAK60VIVu5ZT8Gp4T0Sm
 /LI9xpH4jxzrnBOgfefoEs9Xrj49PuwqpUIcu9hA0G13MYuw62U2PU1nJo5a52yM5ON7
 8OqFUUn2m+QPgp75naY5JKWiJf5zk0GNgtwgMJD0nTBvFIj1POiZ/og5XynV4bg5ZT3t
 I8uOah/1cW9wXUCtRFNQRk80R4XT/4mLUux3KHG1odDbVgQ0wRfmesQrht+8BIpQjbS5
 nzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717590721; x=1718195521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PizG16P+RWVf5FnyeRiV/y4YlubP/re3a+rN9iPlQSg=;
 b=qxhlr4MGRTexyEYGWbCq3vyvHX9Q6tBuTN2u3+m3PBI7hn9FEQHsu2BfWRp+EBnpEc
 lOjw2lGrsVIIL/LiJeZ1Lw3TvVni7L3yId9iYToR+rUYO3LjADQf7JHNw8p1h/3HFCEv
 wJCAzCEAg6Z1fmQGhQ/Oaz3VNAevqP09p4VPZGTyDprrKCsxFGpsOYJAXMdudFmqQXW/
 RygRIuSxosacY2uIkR4HITM+FB4jqI9d/trgN5gmIzTql2e9nDOjLR8ekNW95ODNsX+N
 ZHJ/AKYN73E6LqEY6P0QNUICrRqkDdU+9rpjkwyqLQMgC/cu8z5DiTAH+iHeOqpUh9Cu
 RGYg==
X-Gm-Message-State: AOJu0Yza2Hm3Byvzix8jDfs471YvMcRwDW9qLZyJlpi1+MFn+wWfoltn
 IinMeOH7g6VioAjOO2ABGqcIDnR9xk9RdSNPna9vPommdlzpaFo/
X-Google-Smtp-Source: AGHT+IHjdgW9yINVjjvP4UaMJbn/lwmtp1XXURpVVfa15SXIpX/OIAhrcGpu4GNTGNruppHKvbJMmg==
X-Received: by 2002:adf:a1d9:0:b0:354:f142:65b0 with SMTP id
 ffacd0b85a97d-35e8e1a4b95mr1685493f8f.37.1717590720778; 
 Wed, 05 Jun 2024 05:32:00 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:158c:d00:524a:4439:6e4c:f7e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04caf05sm14316452f8f.42.2024.06.05.05.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 05:32:00 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com,
	shashank.sharma@amd.com,
	Pierre.Jabbour@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: revert "take runtime pm reference when we attach
 a buffer"
Date: Wed,  5 Jun 2024 14:31:59 +0200
Message-Id: <20240605123159.90950-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

This reverts commit b8c415e3bf989be1b749409951debe6b36f5c78c and
commit 425285d39afddaf4a9dab36045b816af0cc3e400.

Taking a runtime pm reference for DMA-buf is actually completely
unnecessary.

When the buffer is in GTT it is still accessible even when the GPU
is powered down and when it is in VRAM the buffer gets migrated to
GTT before powering down.

The only use case which would make it mandatory to keep the runtime
pm reference would be if we pin the buffer into VRAM, and that's not
something we currently do.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 33 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   | 15 ----------
 3 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 0b3b10d21952..ab848047204c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -41,8 +41,6 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
-#include <linux/pm_runtime.h>
-#include "amdgpu_trace.h"
 
 /**
  * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
@@ -63,37 +61,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	trace_amdgpu_runpm_reference_dumps(1, __func__);
-	if (r < 0)
-		goto out;
-
 	return 0;
-
-out:
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-	trace_amdgpu_runpm_reference_dumps(0, __func__);
-	return r;
-}
-
-/**
- * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
- *
- * @dmabuf: DMA-buf where we remove the attachment from
- * @attach: the attachment to remove
- *
- * Called when an attachment is removed from the DMA-buf.
- */
-static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
-				  struct dma_buf_attachment *attach)
-{
-	struct drm_gem_object *obj = dmabuf->priv;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-	trace_amdgpu_runpm_reference_dumps(0, __func__);
 }
 
 /**
@@ -266,7 +234,6 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
-	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 10832b470448..bc3ac73b6b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -181,7 +181,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
-	trace_amdgpu_runpm_reference_dumps(1, __func__);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
 		struct dma_fence *old;
@@ -309,7 +308,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		trace_amdgpu_runpm_reference_dumps(0, __func__);
 	} while (last_seq != seq);
 
 	return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index f539b1d00234..2fd1bfb35916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -554,21 +554,6 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
 		      __entry->value)
 );
 
-TRACE_EVENT(amdgpu_runpm_reference_dumps,
-	    TP_PROTO(uint32_t index, const char *func),
-	    TP_ARGS(index, func),
-	    TP_STRUCT__entry(
-			     __field(uint32_t, index)
-			     __string(func, func)
-			     ),
-	    TP_fast_assign(
-			   __entry->index = index;
-			   __assign_str(func, func);
-			   ),
-	    TP_printk("amdgpu runpm reference dump 0x%x: 0x%s\n",
-		      __entry->index,
-		      __get_str(func))
-);
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.34.1

