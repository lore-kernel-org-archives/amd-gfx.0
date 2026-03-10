Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A3AFD4F29
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 19:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117C910E2D6;
	Tue, 10 Mar 2026 19:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7Ppaw5r";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA9910E77F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 19:13:39 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso2186885e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773170018; x=1773774818; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BnJj5QHEpSddG2nK1WO8hg+Si/94+1hHmfM3oczxYjU=;
 b=S7Ppaw5rNmK8/r2exHFrS1TMC2efzOpaLi0506IUqnS8aPtw151rUCIz0sQl51wOi5
 4MsMNNFC9QQxIR7GT5KjePcTae9n8iWqg11zuEgpWroAJnEf6SZn7BFivDdfe/UnVFiX
 HK3ojwmDAcH2J7CCYxM2+TL86Ej6vkxo7tcrzJE+oK9A5jOsGuOkbTuFGTnk0EkELH4Q
 1miICvPRJsB4AjTjzm9awfEoIcCVNVyIVMAgLS42Jzmt7Lgmd2XNLGLDy+2/Ve9KAew6
 79R73FmmHLhFhJX0Gziu9Rx+Xn5n2/tQ+aUO2nno8f7JlLIg9LXMJiPabHM7Q8ScFTYs
 iyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773170018; x=1773774818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BnJj5QHEpSddG2nK1WO8hg+Si/94+1hHmfM3oczxYjU=;
 b=ImkUIem5ynO/dxobvvRkmBF/mLT6hY3TZDk8BAQ+VLsL7S113CjnRR3WKD5rC1hwrf
 nrudAIjP3golrcOpUtu0FoEWeMhdx8ID6y0JHSWVbYPmXcO7WJ0E0vNbBGtFr/OvEuMp
 F1eHIOLUe6O7OGJlo4R0UwyiK70rBz/ZQD2hJi1Al4trDVzJUivIMFXahXauavifQkql
 cXVnN3rNBAam2zdkvccFY1X2reT0VgT0wk6w4jyDnlLh9vyAz34d4SiwqG1Rk5Rn7Ceq
 GkMUFFYzvHoWSkhqARyhGoSFZEPmFifKsYWZTY/usJmPy/cJodzL5F0h4gX4uxJ2dJs2
 GXVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC/ucCUszqPXGSvqfIiERsVqu0Fy/DZmgt5x0qeZ6JhwcroC/V4rdP0ngiXbFAcOehR+gs8Xz3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRxfWs5E1xCmovy4EOWLCfVSwxKqhHH7TqFlYYWetamG7svac7
 wubaRYGjdC/QdaQwaTa2aska1vJ/yfHNGF6GBC6c5D+6osxip4af1Arf
X-Gm-Gg: ATEYQzwec5xSmJiZjhDl8CNT3IjsVHR6h/Trj86aqbz7GXCOHpXRbZEAxSznI4oSCax
 2xbuHO0HrAZcxOs4wbmCDRaFta/jv+w0nlbJofx1ZcjCMapI4PL/UUXhdo5d9QgnzryrqIu46r6
 DkCR4ZMZuGHQpDUERulbs5u/Qpok3/25lepLf9RYCKTFOY8ADFthSpED6rW/mp28aCfqodAre1J
 ggoKXZzy18C7BRRm3IbzGjay9EuFCxk8OEyPt2S51LpKS3VA0d12nz9HGylfW0SA+fmOzq5XTsz
 n1lTDExJrkzcPgOdh/6Y+2G3VBTm/FhlOcxE2jkdFuAt30UnxmO+0gy3tp7iFxCC9+mQrkRU+wA
 zypB6CJoIvKNbQOSMaZ72UqbFTjd/sNKJFcAXCtk7E6bmpLl9r+p319xhSF+oUtEq4pHErCb6fF
 aWsjx4A17SzQ69/SeCLFom0H+FkjhFMCKKoeo=
X-Received: by 2002:a05:600c:8488:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-485419b61a2mr69865865e9.6.1773170017515; 
 Tue, 10 Mar 2026 12:13:37 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d0:d800:5198:df3e:59ca:cf4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3079efsm2601625e9.7.2026.03.10.12.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:13:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/11] drm/amdgpu: fix some more bug in amdgpu_gem_va_ioctl
Date: Tue, 10 Mar 2026 20:13:26 +0100
Message-ID: <20260310191327.2279-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310191327.2279-1-christian.koenig@amd.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
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

