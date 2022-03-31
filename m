Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1802DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 09:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8195D10F294;
	Thu, 31 Mar 2022 09:47:40 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3181110F294
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 09:47:38 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id g20so27487808edw.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uMIheegwKrwDLTsJpUOj6Ewr2ZTOmwq22/TVu1cWHQ4=;
 b=IjhmnTounENzxYA8lmAQgtwS9YTzPK0I4XdZFf2I/V221YsI1d1RX8qGJIFNjlshKH
 0r9EtNBDCOF10yDHdYa5oKNhhzUvLKDHEdfZ3aClcB+EF2HkvqCaqEVKJHUpgMK6X1eh
 ZAIhuurrr4TbmiuaS0paNQGOhL5kXOay6pY+AOnuDJbAqpmqpm1OLFoaZyeTxPTOH8Ph
 oC+BpNLhUktUAupLVbCfa/2T8MYBoqXvmx62C/Faw5/dHQVS0D7HRcA4n2XsgDl5zTls
 W5fZJfeqCb79x0vhbbvGmXKzNzwW1dhywUYUfaSE53FsqtegSV/+kftxYpoEfLUgP7rb
 RyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uMIheegwKrwDLTsJpUOj6Ewr2ZTOmwq22/TVu1cWHQ4=;
 b=06puXJn7dnW68tAzASJ4TjA3ZkNlRcb/QaMHY+brhRW14QpphOG8TgypAKT6RaC3up
 q+Dicr0tgmT3boXEOwpD9lxJSocAhnlvcpwTPDTJ8NREtz4lH4vubACqFcT3bC0T0WtB
 qfpQGt23aJWb9T8G65yca+cCjKwhGFyFE2WivO6Qt4SnsWHE/h2/Bzxc34u8iflsUwix
 gmj8TUGu/QhgYycd3DE+LOEPPrDukw7GHnQKjb/++MBPgWB3tmBg11sUEAGRM5M+xdwi
 RIvxQTqkF/Xsk3hbjkhdHV+GE+6GFjLu174EQL41EnKy2xQaaHimFEisA6tf0vxTWpvQ
 d6Dw==
X-Gm-Message-State: AOAM532x82GkzkshGfAHx1ew/Ba+KhxqUguVTvGIJ1FWMkFWtlEDNdVD
 ALO3Bfd9aavj2xvBHiEjV/g=
X-Google-Smtp-Source: ABdhPJwiqmcjOSKxlyIJK/TeCZtqiV4ttDWTfCkg7uyYhzQ3l+dDQrcUQ7FG1ImPJUfBIeva7QVooQ==
X-Received: by 2002:a05:6402:26d3:b0:418:d202:d5dc with SMTP id
 x19-20020a05640226d300b00418d202d5dcmr15667271edd.138.1648720054353; 
 Thu, 31 Mar 2022 02:47:34 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 qk30-20020a1709077f9e00b006dfae33d969sm9249202ejc.216.2022.03.31.02.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 02:47:33 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: allow specifying a syncobj for VM map
 operations
Date: Thu, 31 Mar 2022 11:47:27 +0200
Message-Id: <20220331094727.27153-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331094727.27153-1-christian.koenig@amd.com>
References: <20220331094727.27153-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To improve synchronization of command submissions with page table updates RADV
wants to manually wait for the updates to be completed without affecting
parallel submissions.

Implement this by allowing to specify a drm_sync_obj handle and a timeline
point for the GEM_VA IOCTL.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 79 ++++++++++++++++++++-----
 include/uapi/drm/amdgpu_drm.h           |  5 +-
 2 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9cdfee67efeb..bf0092f629f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -33,6 +33,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_syncobj.h>
 #include <drm/drm_gem_ttm_helper.h>
 
 #include "amdgpu.h"
@@ -598,6 +599,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
  * @vm: vm to update
  * @bo_va: bo_va to update
  * @operation: map, unmap or clear
+ * @last_update: optional pointer to a dma_fence for the last VM update
  *
  * Update the bo_va directly after setting its address. Errors are not
  * vital here, so they are not reported back to userspace.
@@ -605,20 +607,21 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 				    struct amdgpu_vm *vm,
 				    struct amdgpu_bo_va *bo_va,
-				    uint32_t operation)
+				    uint32_t operation,
+				    struct dma_fence **last_update)
 {
 	int r;
 
 	if (!amdgpu_vm_ready(vm))
 		return;
 
-	r = amdgpu_vm_clear_freed(adev, vm, NULL);
+	r = amdgpu_vm_clear_freed(adev, vm, last_update);
 	if (r)
 		goto error;
 
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, last_update);
 		if (r)
 			goto error;
 	}
@@ -671,6 +674,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct drm_gem_object *gobj;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct dma_fence *fence = dma_fence_get_stub();
+	struct dma_fence_chain *chain = NULL;
+	struct drm_syncobj *syncobj = NULL;
 	struct amdgpu_bo *abo;
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_bo_list_entry vm_pd;
@@ -714,17 +720,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	switch (args->operation) {
-	case AMDGPU_VA_OP_MAP:
-	case AMDGPU_VA_OP_UNMAP:
-	case AMDGPU_VA_OP_CLEAR:
-	case AMDGPU_VA_OP_REPLACE:
-		break;
-	default:
-		dev_dbg(dev->dev, "unsupported operation %d\n",
-			args->operation);
-		return -EINVAL;
-	}
+	/* For debugging delay all VM updates till CS time */
+	if (!amdgpu_vm_debug)
+		args->flags |= AMDGPU_VM_DELAY_UPDATE;
 
 	INIT_LIST_HEAD(&list);
 	INIT_LIST_HEAD(&duplicates);
@@ -763,6 +761,30 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	if (args->syncobj) {
+		syncobj = drm_syncobj_find(filp, args->syncobj);
+		if (!syncobj) {
+			r = -EINVAL;
+			goto error_backoff;
+		}
+
+		if (args->timeline_point) {
+			chain = dma_fence_chain_alloc();
+			if (!chain) {
+				r = -ENOMEM;
+				goto error_put_syncobj;
+			}
+		}
+
+		/*
+		 * Update the VM once before to make sure there are no other
+		 * pending updates.
+		 */
+		if (!(args->flags & AMDGPU_VM_DELAY_UPDATE))
+			amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
+						args->operation, NULL);
+	}
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
@@ -786,17 +808,42 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 					     va_flags);
 		break;
 	default:
+		dev_dbg(dev->dev, "unsupported operation %d\n",
+			args->operation);
+		r = -EINVAL;
 		break;
 	}
-	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !amdgpu_vm_debug)
+	if (r)
+		goto error_free_chain;
+
+	if (!(args->flags & AMDGPU_VM_DELAY_UPDATE))
 		amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
-					args->operation);
+					args->operation, syncobj ?
+					&fence : NULL);
+
+	if (syncobj) {
+		if (chain) {
+			drm_syncobj_add_point(syncobj, chain, fence,
+					      args->timeline_point);
+			chain = NULL;
+		} else {
+			drm_syncobj_replace_fence(syncobj, fence);
+		}
+	}
+
+error_free_chain:
+	dma_fence_chain_free(chain);
+
+error_put_syncobj:
+	if (syncobj)
+		drm_syncobj_put(syncobj);
 
 error_backoff:
 	ttm_eu_backoff_reservation(&ticket, &list);
 
 error_unref:
 	drm_gem_object_put(gobj);
+	dma_fence_put(fence);
 	return r;
 }
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1d65c1fbc4ec..f84b5f2c817c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -533,7 +533,8 @@ struct drm_amdgpu_gem_op {
 struct drm_amdgpu_gem_va {
 	/** GEM object handle */
 	__u32 handle;
-	__u32 _pad;
+	/** Optional DRM Syncobj to signal when operation completes */
+	__u32 syncobj;
 	/** AMDGPU_VA_OP_* */
 	__u32 operation;
 	/** AMDGPU_VM_PAGE_* */
@@ -544,6 +545,8 @@ struct drm_amdgpu_gem_va {
 	__u64 offset_in_bo;
 	/** Specify mapping size. Must be correctly aligned. */
 	__u64 map_size;
+	/** Optional Syncobj timeline point to signal */
+	__u64 timeline_point;
 };
 
 #define AMDGPU_HW_IP_GFX          0
-- 
2.25.1

