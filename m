Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B3CFD7079
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E698E10E5CE;
	Tue, 17 Mar 2026 10:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kBRuBxk4";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1308410E5CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:11 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48374014a77so60994625e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744909; x=1774349709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1OXV7f/J/VtZV20P+A8h+u/YtXEHq2+dqJPkGR7eZ8=;
 b=kBRuBxk4KzcGl1bzYF1WuQ0XyUjRsxYYM/Qo4k8QLt4rYv2S0yW3cpOBc+Zfd4EW6L
 G1RZiM3UVsNBZrh8NcCbewg6PeTMEKMpOYrLPPHQRGTzdOu9Y1V6G4AyF/TVMXLyoI4C
 bYm9Vv82fW940Oh+0fEeL4pbF057EWO9AsBArpWKhX744sC0enCS/sTGCnYcfGNAtBvW
 p4U4HERG8LtUESH4QwvZ7tCqXLK0gKvuEpRH/tqAQdtyEcqr5+3kaldydhhEWnsSPbkb
 8DS/fIS+4Kk/+4CbocSl8dp4/oPwpBn8Oq6yDa+Ehy+bmGEa8i2XD3HC9I1wgA0l2XJM
 AcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744909; x=1774349709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b1OXV7f/J/VtZV20P+A8h+u/YtXEHq2+dqJPkGR7eZ8=;
 b=FIlN7SX86iReEPU/gYTvQCSMrmQKTHjTjz+5QO8TPIGso/rVEzjF3/dNaFM8JXLi4J
 wMPc9E9QYdNsoK3wcEMZyJPrVDdKlvY/9Ko0Wg0VKm0ue/8x6/AETGeH6RJZPcTSK56w
 gvbvWDhwDhyW8x1f7AzZ83tekvJ4+oM2XKwS8JDpJH3/U3sPfPygdl3bXgIA4VcapU1+
 98MUYaX3hp0W5wBdgR+EoutoGQGe+A1cW+QGGhnr0qbLp2TcDgoUzDhDk2qB3xK/IDtI
 dmTVjvuKkm1895+1wrw7RvKKAdbOP9kIBnneFWX9SP052LY/yHo/YXyxqZx+HdwVqyt7
 iOhQ==
X-Gm-Message-State: AOJu0YygRGJUrLbPjptLbMpCbyZKOEyd0IkQfsHnEfWRy0beOqRJDtbW
 TFQ041daFTz/crDNa17NnQPM8STSSvaoy8SRPQStrhTvb62l7noOdXoT
X-Gm-Gg: ATEYQzw8hBEeriivMBSWqi8m/JdCrUXrzKwyRlXw91y8/97s9ra7868+56tEafhRoZf
 mDXAb/pRHdPfzuqOLoNvkXyidDd5dIXZNGahpgrFKXcXigeN11zgpoR8lfOI5SrKJ9ybn9WjFMu
 aZA54QHpR/SsT4t0CAM2SUwQ5TYL0+BaasfcJJ5TvHHIVAFyLtOOuBhYfDkIL8g05AXUJ+mb69J
 xeAF1mhR5Ak8w9+yoBFYfwtrkjFHBGjkHo5aB8dAcoC96TzhBN6L9rIWcpPIJZXDy4I4YgFbzlq
 uzRs6RTHSn19AiFZvSqWOjPfSsPBuxksNsmKHD51xKP5OAqB0obQUk9RI320Iqq14pf89u+vdAk
 /1HqUxaDsCUxzc+9m7Wmf2kZZdnN+bHTUyRkRcEZ0wg5Ycb6P317aq0urT5jedm8WkPqOY614SG
 JsM9tzqWEFAhWmZZvQIMzVpy/z916ODrSRwrQg
X-Received: by 2002:a05:600c:8b45:b0:485:35ba:1d81 with SMTP id
 5b1f17b1804b1-48556703194mr267165415e9.21.1773744908337; 
 Tue, 17 Mar 2026 03:55:08 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:07 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/10] drm/amdgpu: fix some more bug in amdgpu_gem_va_ioctl
Date: Tue, 17 Mar 2026 11:54:57 +0100
Message-ID: <20260317105501.21479-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317105501.21479-1-christian.koenig@amd.com>
References: <20260317105501.21479-1-christian.koenig@amd.com>
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

Some illegal combination of input flags were not checked and we need to
take the PDEs into account when returning the fence as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 76 +++++++++++--------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 88a21400ae09..98276b55ad3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -30,6 +30,7 @@
 #include <linux/pagemap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-fence-unwrap.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
@@ -741,11 +742,10 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	struct dma_fence *fence;
 	int r = 0;
 
-	/* Always start from the VM's existing last update fence. */
-	fence = dma_fence_get(vm->last_update);
-
+	/* If the VM is not ready return only a stub. */
 	if (!amdgpu_vm_ready(vm))
-		return fence;
+		return dma_fence_get_stub();
+
 
 	/*
 	 * First clean up any freed mappings in the VM.
@@ -754,7 +754,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	 * schedules GPU work. If nothing needs clearing, @fence can remain as
 	 * the original vm->last_update.
 	 */
-	r = amdgpu_vm_clear_freed(adev, vm, &fence);
+	r = amdgpu_vm_clear_freed(adev, vm, &vm->last_update);
 	if (r)
 		goto error;
 
@@ -771,47 +771,34 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	/*
-	 * Decide which fence best represents the last update:
-	 *
-	 * MAP/REPLACE:
-	 *   - For always-valid mappings, use vm->last_update.
-	 *   - Otherwise, export bo_va->last_pt_update.
-	 *
-	 * UNMAP/CLEAR:
-	 *   Keep the fence returned by amdgpu_vm_clear_freed(). If no work was
-	 *   needed, it can remain as vm->last_pt_update.
-	 *
-	 * The VM and BO update fences are always initialized to a valid value.
-	 * vm->last_update and bo_va->last_pt_update always start as valid fences.
-	 * and are never expected to be NULL.
-	 */
-	switch (operation) {
-	case AMDGPU_VA_OP_MAP:
-	case AMDGPU_VA_OP_REPLACE:
+	if ((operation == AMDGPU_VA_OP_MAP ||
+	     operation == AMDGPU_VA_OP_REPLACE) &&
+	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
+
 		/*
-		 * For MAP/REPLACE, return the page table update fence for the
-		 * mapping we just modified. bo_va is expected to be valid here.
+		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
+		 * bo_va->last_pt_update and vm->last_update or otherwise we
+		 * potentially miss the PDE updates.
 		 */
-		dma_fence_put(fence);
-
-		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
-			fence = dma_fence_get(vm->last_update);
-		else
-			fence = dma_fence_get(bo_va->last_pt_update);
-		break;
-	case AMDGPU_VA_OP_UNMAP:
-	case AMDGPU_VA_OP_CLEAR:
-	default:
-		/* keep @fence as returned by amdgpu_vm_clear_freed() */
-		break;
+		fence = dma_fence_unwrap_merge(vm->last_update,
+					       bo_va->last_pt_update);
+		if (!fence) {
+			/* As fallback in OOM situations */
+			dma_fence_wait(vm->last_update, false);
+			dma_fence_wait(bo_va->last_pt_update, false);
+			fence = dma_fence_get_stub();
+		}
+	} else {
+		fence = dma_fence_get(vm->last_update);
 	}
 
+	return fence;
+
 error:
 	if (r && r != -ERESTARTSYS)
 		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
 
-	return fence;
+	return dma_fence_get(vm->last_update);
 }
 
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
@@ -832,7 +819,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct amdgpu_bo_va *bo_va;
 	struct drm_syncobj *timeline_syncobj = NULL;
 	struct dma_fence_chain *timeline_chain = NULL;
-	struct dma_fence *fence;
 	struct drm_exec exec;
 	uint64_t vm_size;
 	int r = 0;
@@ -884,6 +870,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	if (args->flags & AMDGPU_VM_DELAY_UPDATE &&
+	    args->vm_timeline_syncobj_out)
+		return -EINVAL;
+
 	if ((args->operation != AMDGPU_VA_OP_CLEAR) &&
 	    !(args->flags & AMDGPU_VM_PAGE_PRT)) {
 		gobj = drm_gem_object_lookup(filp, args->handle);
@@ -973,11 +963,13 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	 * that represents the last relevant update for this mapping. This
 	 * fence can then be exported to the user-visible VM timeline.
 	 */
-	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
+	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) &&
+	    (!adev->debug_vm || timeline_syncobj)) {
+		struct dma_fence *fence;
+
 		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
 						args->operation);
-
-		if (timeline_syncobj && fence) {
+		if (timeline_syncobj) {
 			if (!args->vm_timeline_point) {
 				/* Replace the existing fence when no point is given. */
 				drm_syncobj_replace_fence(timeline_syncobj,
-- 
2.43.0

