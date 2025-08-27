Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC91CCA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 09:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C29210E79C;
	Wed, 27 Aug 2025 09:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iGPMr9/k";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E8F10E79C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 09:59:53 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45a1b0d231eso39971015e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756288792; x=1756893592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mkidaow2bgn+S7WfziXO5PSd4Q6VR04lnRba13s+bx8=;
 b=iGPMr9/k5t1z7krLBUmjJ8uJRkOt6pP6ikkHbjRCOxmTfaFcfN8oXCkBaeUsxEi2Ap
 Mx/MLneGcHnhdtwo+bGAWYUocGQ09KOKQ+hb+gpaTypVfixCXcCojgdvEYhsLnsTdsQa
 ySiV7LTBKJ54SCcQdGnrdXDWvsX/O2SELFLmVht7YexMzpqoxOKExre1lv2oxHO3Ngg6
 jPAoBN4mHN2xXhkL2nP2P86fsB5Tc7pdMn1fzVvhDdAe9ZP9K3rA5NEUG776pDTIzjtp
 QQ1+1YQ/glW4Ek7Re3w4InRNRS3LJsRCLyHoXDop7vPnkhSGhtWF/658V1ikqY8kZ9yw
 XAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756288792; x=1756893592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mkidaow2bgn+S7WfziXO5PSd4Q6VR04lnRba13s+bx8=;
 b=WWGqlhf9gLmfOMagKMS5zkDB5l79FDetJd3PgnCEAyJF9dtbI3dMNikw9eiaW0yot8
 MQbBV9oi/DRIZGYxeBOnyfdy9O6+CzfHgLVGih9/AUfbBDF8oXzDVqR7zVGxEdBIWZ0T
 a1RKOFfT+scLGIWiJzZR8nw8fmPxSQhGduZJ5xn9xDWb8T5G0VWK0NYmmjUnG+pne3R1
 RcKT8BSpgKnkfpbDpscDbSVRwG8tLNN1WaY5I8InVphHMmcwS2vkYu4U3YYOOuYtmyh6
 NWK5e9tGceb6gZIkvyBrnEHerNxP5atA+J80luo9EczX0qHuD5L4erVEXUtaJQjOPBzU
 wF/w==
X-Gm-Message-State: AOJu0YyGnfgFE666XU8tJbxSEiVhht623N7KMxubz+QKp/YDfPBAlYCw
 ui5flglgshU/h1fGgiXLrFVODzpjJOx15PPuIF8Li0+5uQ2GgbWrRVNGF52rb8MP
X-Gm-Gg: ASbGncsNCMSlV+9JL+nSUUkD1eUC/3wwxf+A3SRGZvMbd6u8NpbH+EmM/sE1RkueCno
 48Z0parYYZ/snf/w+WnM2mKY0eOK/6YyttW9tETCZXJTdHLzVuCVqIvUmhiYCgDC6fecsdcgFtb
 XYSk+9JnT4Kij+6NF2nsvwE0HyppI7edv282Xf6HTT4twBm9h36j1jBNngBj+oghKPrAIQuLQH+
 g/QdWWthNKIbMMEVT1KC0FWDyQsSUQx8Fo4Z8aHFQ7FbdeYgYZ8D5rsvB5LtfTogXgFmxu3CIoG
 bgOjpMqaL/CsAA8i6PdB9qZsj92fcWjKn7yOjSvvO9bugcvGqNdP5KOP+647/3KvY64EJjNH7/r
 xAdLupztevCjm4tOXhohYjt+Sz/Brf/21mLE=
X-Google-Smtp-Source: AGHT+IGrqUD5V1duC+uusVLCDzY2rqJ/jx5RM5I6n4f4dRhXXqD3/yEfjmJlDhC9rhZZIE20fsNeGQ==
X-Received: by 2002:a05:600c:1d0c:b0:456:fc1:c286 with SMTP id
 5b1f17b1804b1-45b66eaddc9mr40468945e9.1.1756288791437; 
 Wed, 27 Aug 2025 02:59:51 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1498:5800:1e25:9081:2109:a4cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6db6sm25236415e9.2.2025.08.27.02.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 02:59:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: fix userq VM validation
Date: Wed, 27 Aug 2025 11:59:48 +0200
Message-ID: <20250827095950.2672-1-christian.koenig@amd.com>
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

That was actually complete nonsense and not validating the BOs
at all. The code just cleared all VM areas were it couldn't grab the
lock for a BO.

Try to fix this. Only compile tested at the moment.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 97 +++++++++--------------
 1 file changed, 37 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 424831997cb1..3b1aae26a6c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -546,32 +546,52 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 }
 
 static int
-amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
+amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
+			  struct amdgpu_vm *vm)
 {
 	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
 	int ret;
 
-	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->invalidated)) {
+		bo_va = list_first_entry(&vm->invalidated,
+					 struct amdgpu_bo_va,
+					 base.vm_status);
+		spin_unlock(&vm->status_lock);
+
+		bo = bo_va->base.bo;
+		ret = drm_exec_lock_obj(exec, &bo->tbo.base);
+		if (unlikely(ret))
+			return ret;
 
-	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (ret)
-		DRM_ERROR("Fail to validate\n");
+		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (ret)
+			return ret;
 
-	return ret;
+		/* This moves the bo_va to the done list */
+		ret = amdgpu_vm_bo_update(adev, bo_va, false);
+		if (ret)
+			return ret;
+
+		spin_lock(&vm->status_lock);
+	}
+	spin_unlock(&vm->status_lock);
+
+	return 0;
 }
 
 static int
-amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_update_vm(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
-	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_va *bo_va;
-	struct ww_acquire_ctx *ticket;
 	struct drm_exec exec;
 	struct amdgpu_bo *bo;
-	struct dma_resv *resv;
-	bool clear, unlock;
 	int ret = 0;
 
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
@@ -594,59 +614,16 @@ amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 			if (unlikely(ret))
 				goto unlock_all;
 		}
-	}
-
-	spin_lock(&vm->status_lock);
-	while (!list_empty(&vm->moved)) {
-		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
-					 base.vm_status);
-		spin_unlock(&vm->status_lock);
 
-		/* Per VM BOs never need to bo cleared in the page tables */
-		ret = amdgpu_vm_bo_update(adev, bo_va, false);
+		ret = amdgpu_userq_validate_bos(adev, &exec, vm);
+		drm_exec_retry_on_contention(&exec);
 		if (ret)
 			goto unlock_all;
-		spin_lock(&vm->status_lock);
 	}
 
-	ticket = &exec.ticket;
-	while (!list_empty(&vm->invalidated)) {
-		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
-					 base.vm_status);
-		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->status_lock);
-
-		bo = bo_va->base.bo;
-		ret = amdgpu_userq_validate_vm_bo(NULL, bo);
-		if (ret) {
-			drm_file_err(uq_mgr->file, "Failed to validate BO\n");
-			goto unlock_all;
-		}
-
-		/* Try to reserve the BO to avoid clearing its ptes */
-		if (!adev->debug_vm && dma_resv_trylock(resv)) {
-			clear = false;
-			unlock = true;
-		/* The caller is already holding the reservation lock */
-		} else if (dma_resv_locking_ctx(resv) == ticket) {
-			clear = false;
-			unlock = false;
-		/* Somebody else is using the BO right now */
-		} else {
-			clear = true;
-			unlock = false;
-		}
-
-		ret = amdgpu_vm_bo_update(adev, bo_va, clear);
-
-		if (unlock)
-			dma_resv_unlock(resv);
-		if (ret)
-			goto unlock_all;
-
-		spin_lock(&vm->status_lock);
-	}
-	spin_unlock(&vm->status_lock);
+	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
+	if (ret)
+		goto unlock_all;
 
 	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
 	if (ret)
@@ -667,7 +644,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
-	ret = amdgpu_userq_validate_bos(uq_mgr);
+	ret = amdgpu_userq_update_vm(uq_mgr);
 	if (ret) {
 		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
 		goto unlock;
-- 
2.43.0

