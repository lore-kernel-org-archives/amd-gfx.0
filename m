Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113C6FD7077
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73EE10E1D7;
	Tue, 17 Mar 2026 10:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RYDxx9bA";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786FE10E584
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:05 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so588571f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744904; x=1774349704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=am7OxFkbQ1vOwAYbboJBNRE2CKyB8VntnimNtf7qZ+M=;
 b=RYDxx9bAseSEWAJ9X42SYrvRlEKaUlMnV7AYaV5KmTkooKSDD8LKiplOtev9CoY3m2
 Y0HckjM3uafD8took+IsXjaz8yxUyS0oGmRkURti/+isaMwbSdarox6w0odCItHzou1P
 S337cJeIqUz5UL4o2QONBfUUh8VsyrE12fwajOX+Z8ujgGRknx97/J0ldyKX3xIvhHJK
 100Yyflg7xVVhr+dmOCSWpfu/+2C4s1TQoEfHQepN3iktTy5B3yPqC3Yn3TRLT7WoGEp
 na3WhtU+opJn1pmJtvEIT3rFGj9RDSTvDn5PqStifW5CEFlFJ26zULDbEYv2UlEGDH1Q
 +OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744904; x=1774349704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=am7OxFkbQ1vOwAYbboJBNRE2CKyB8VntnimNtf7qZ+M=;
 b=OVkEFamQ3VAE6xRuuN+p8WpnmgZoM/24tbfYxn/wpFYnPKzAxRb90uggbB0zV2rYUF
 lwtGCeQ6nZdyLoY+IWgL9+bVqSqmiiJHi1uqpLZIypStxoubDVOPY8j0iUA3qt9XmUWo
 yzG1CWY9qKy950lkrVowJjjuEiFescHO+Ri+xTjVVpf9n8RonT/0Zk2+kxGdJpHem8vP
 LdIKQq1TYrtrUsVoeBO60Uvz+gbAKms6PpsVMdcJvDuEu9LmgpgPyOWr9aul+djrdbKI
 Z9nmxDWhKIiWsWEUBfKL+KgIh8fsLttHK9CPmndhS33beSIbhus2TlerJ37qO3uxZHgk
 oItA==
X-Gm-Message-State: AOJu0Yxehyh45D+2C46muaw9sSfKSpaFQ12esJfeSt/JIjFMW6D/4yMy
 hGTTKv2ywTj1rMu4E8Mkqf8S2ggmft8TDXKQ55fUGVKwo3F4TkEU9MkL
X-Gm-Gg: ATEYQzy590Wlh9NXBxExhvKgoR13W0oEW++1qZkNlXj1VRKlThNKZiOuEX0swj9hZF0
 8RLfTNTAocd2n3D0EB0w5zTKAkjSzNvl6bUOKkadmmFBpNkgwHjSvL2mOWTdlcplLsxtlEiPBKW
 VZcsL+bS9svg4IEnSEED10JIPSbzXdmbf94oA7sO34Xx4ZEaIEYjSvejv8X5xWBRk4FvBcHR++1
 kg9uolGcJyfLYfz3l58ot4W5i+BMVoiDJppdk7YjMyJM6VlP1zMHX5nxjdST1xUYFlWK2pWfdDd
 +rierX6/DnXJbCDlpbjNKlOl+Q2n9BjZM6gLfBDLVihCVSnJ2BijOuXoypl0u4MX4Rx12n5Fzkm
 gHwgNjE42BJdTYRv4Sw5S+Lmwc9fFuiXAZ7sK9UCBP/yBLl0KZa1iP2628GbwcTbFMyEPI5edxM
 +TF/qt3hgfP29Sqvdr+QX1FYERL9/Hw5zCqeA0
X-Received: by 2002:a05:6000:290f:b0:43b:4703:9dcf with SMTP id
 ffacd0b85a97d-43b498268a7mr5240610f8f.15.1773744902581; 
 Tue, 17 Mar 2026 03:55:02 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/10] drm/amdgpu: completely rework eviction fence handling v2
Date: Tue, 17 Mar 2026 11:54:51 +0100
Message-ID: <20260317105501.21479-1-christian.koenig@amd.com>
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

Well that was broken on multiple levels.

First of all a lot of checks were placed at incorrect locations, especially if
the resume worker should run or not.

Then a bunch of code was just mid-layering because of incorrect assignment who
should do what.

And finally comments explaining what happens instead of why.

Just re-write it from scratch, that should at least fix some of the hangs we
are seeing.

Use RCU for the eviction fence pointer in the manager, the spinlock usage was
mostly incorrect as well. Then finally remove all the nonsense checks and
actually add them in the correct locations.

v2: some typo fixes and cleanups suggested by Sunil

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 212 ++++++------------
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  54 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  29 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +-
 7 files changed, 110 insertions(+), 206 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c50f054f1c1..bc0c62c312ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2952,9 +2952,9 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 	int idx;
 
 	if (fpriv && drm_dev_enter(dev, &idx)) {
-		fpriv->evf_mgr.fd_closing = true;
-		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+		amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..69698cb60778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -25,9 +25,6 @@
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
 
-#define work_to_evf_mgr(w, name) container_of(w, struct amdgpu_eviction_fence_mgr, name)
-#define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, evf_mgr)
-
 static const char *
 amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
 {
@@ -43,127 +40,66 @@ amdgpu_eviction_fence_get_timeline_name(struct dma_fence *f)
 	return ef->timeline_name;
 }
 
-int
-amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				    struct drm_exec *exec)
+static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
 {
-	struct amdgpu_eviction_fence *old_ef, *new_ef;
-	struct drm_gem_object *obj;
-	unsigned long index;
-	int ret;
-
-	if (evf_mgr->ev_fence &&
-	    !dma_fence_is_signaled(&evf_mgr->ev_fence->base))
-		return 0;
-	/*
-	 * Steps to replace eviction fence:
-	 * * lock all objects in exec (caller)
-	 * * create a new eviction fence
-	 * * update new eviction fence in evf_mgr
-	 * * attach the new eviction fence to BOs
-	 * * release the old fence
-	 * * unlock the objects (caller)
-	 */
-	new_ef = amdgpu_eviction_fence_create(evf_mgr);
-	if (!new_ef) {
-		DRM_ERROR("Failed to create new eviction fence\n");
-		return -ENOMEM;
-	}
-
-	/* Update the eviction fence now */
-	spin_lock(&evf_mgr->ev_fence_lock);
-	old_ef = evf_mgr->ev_fence;
-	evf_mgr->ev_fence = new_ef;
-	spin_unlock(&evf_mgr->ev_fence_lock);
+	struct amdgpu_eviction_fence *ev_fence = to_ev_fence(f);
 
-	/* Attach the new fence */
-	drm_exec_for_each_locked_object(exec, index, obj) {
-		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-
-		if (!bo)
-			continue;
-		ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
-		if (ret) {
-			DRM_ERROR("Failed to attch new eviction fence\n");
-			goto free_err;
-		}
-	}
-
-	/* Free old fence */
-	if (old_ef)
-		dma_fence_put(&old_ef->base);
-	return 0;
-
-free_err:
-	kfree(new_ef);
-	return ret;
+	schedule_work(&ev_fence->evf_mgr->suspend_work);
+	return true;
 }
 
+static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
+	.get_driver_name = amdgpu_eviction_fence_get_driver_name,
+	.get_timeline_name = amdgpu_eviction_fence_get_timeline_name,
+	.enable_signaling = amdgpu_eviction_fence_enable_signaling,
+};
+
 static void
 amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 {
-	struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
-	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
+	struct amdgpu_eviction_fence_mgr *evf_mgr =
+		container_of(work, struct amdgpu_eviction_fence_mgr,
+			     suspend_work);
+	struct amdgpu_fpriv *fpriv =
+		container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_eviction_fence *ev_fence;
+	struct dma_fence *ev_fence;
 
 	mutex_lock(&uq_mgr->userq_mutex);
-	spin_lock(&evf_mgr->ev_fence_lock);
-	ev_fence = evf_mgr->ev_fence;
-	if (ev_fence)
-		dma_fence_get(&ev_fence->base);
-	else
-		goto unlock;
-	spin_unlock(&evf_mgr->ev_fence_lock);
-
-	amdgpu_userq_evict(uq_mgr, ev_fence);
+	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
+	amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
 
-	mutex_unlock(&uq_mgr->userq_mutex);
-	dma_fence_put(&ev_fence->base);
-	return;
-
-unlock:
-	spin_unlock(&evf_mgr->ev_fence_lock);
+	/*
+	 * Signaling the eviction fence must be done while holding the
+	 * userq_mutex. Otherwise we won't resume the queues before issuing the
+	 * next fence.
+	 */
+	dma_fence_signal(ev_fence);
+	dma_fence_put(ev_fence);
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
 
-static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
+void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				 struct amdgpu_bo *bo)
 {
-	struct amdgpu_eviction_fence_mgr *evf_mgr;
-	struct amdgpu_eviction_fence *ev_fence;
-
-	if (!f)
-		return true;
-
-	ev_fence = to_ev_fence(f);
-	evf_mgr = ev_fence->evf_mgr;
-
-	schedule_delayed_work(&evf_mgr->suspend_work, 0);
-	return true;
-}
-
-static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
-	.get_driver_name = amdgpu_eviction_fence_get_driver_name,
-	.get_timeline_name = amdgpu_eviction_fence_get_timeline_name,
-	.enable_signaling = amdgpu_eviction_fence_enable_signaling,
-};
+	struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
+	struct dma_resv *resv = bo->tbo.base.resv;
 
-void amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				  struct amdgpu_eviction_fence *ev_fence)
-{
-	spin_lock(&evf_mgr->ev_fence_lock);
-	dma_fence_signal(&ev_fence->base);
-	spin_unlock(&evf_mgr->ev_fence_lock);
+	dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
+	dma_fence_put(ev_fence);
 }
 
-struct amdgpu_eviction_fence *
-amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
+int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
+			 struct drm_exec *exec)
 {
 	struct amdgpu_eviction_fence *ev_fence;
+	struct drm_gem_object *obj;
+	unsigned long index;
 
+	/* Create and initialize a new eviction fence */
 	ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
 	if (!ev_fence)
-		return NULL;
+		return -ENOMEM;
 
 	ev_fence->evf_mgr = evf_mgr;
 	get_task_comm(ev_fence->timeline_name, current);
@@ -171,56 +107,22 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
 	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
 			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
 			 atomic_inc_return(&evf_mgr->ev_fence_seq));
-	return ev_fence;
-}
-
-void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
-{
-	struct amdgpu_eviction_fence *ev_fence;
-
-	/* Wait for any pending work to execute */
-	flush_delayed_work(&evf_mgr->suspend_work);
-
-	spin_lock(&evf_mgr->ev_fence_lock);
-	ev_fence = evf_mgr->ev_fence;
-	spin_unlock(&evf_mgr->ev_fence_lock);
-
-	if (!ev_fence)
-		return;
 
-	dma_fence_wait(&ev_fence->base, false);
+	/* Remember it for newly added BOs */
+	dma_fence_put(evf_mgr->ev_fence);
+	evf_mgr->ev_fence = &ev_fence->base;
 
-	/* Last unref of ev_fence */
-	dma_fence_put(&ev_fence->base);
-}
-
-int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				 struct amdgpu_bo *bo)
-{
-	struct amdgpu_eviction_fence *ev_fence;
-	struct dma_resv *resv = bo->tbo.base.resv;
-	int ret;
-
-	if (!resv)
-		return 0;
+	/* And add it to all existing BOs */
+	drm_exec_for_each_locked_object(exec, index, obj) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
-	ret = dma_resv_reserve_fences(resv, 1);
-	if (ret) {
-		DRM_DEBUG_DRIVER("Failed to resv fence space\n");
-		return ret;
+		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
 	}
-
-	spin_lock(&evf_mgr->ev_fence_lock);
-	ev_fence = evf_mgr->ev_fence;
-	if (ev_fence)
-		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
-	spin_unlock(&evf_mgr->ev_fence_lock);
-
 	return 0;
 }
 
-void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				  struct amdgpu_bo *bo)
+void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				 struct amdgpu_bo *bo)
 {
 	struct dma_fence *stub = dma_fence_get_stub();
 
@@ -229,13 +131,25 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	dma_fence_put(stub);
 }
 
-int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
+void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
-	/* This needs to be done one time per open */
 	atomic_set(&evf_mgr->ev_fence_seq, 0);
 	evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
-	spin_lock_init(&evf_mgr->ev_fence_lock);
+	evf_mgr->ev_fence = dma_fence_get_stub();
 
-	INIT_DELAYED_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
-	return 0;
+	INIT_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
+}
+
+void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
+{
+	evf_mgr->shutdown = true;
+	flush_work(&evf_mgr->suspend_work);
+}
+
+void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
+{
+	dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
+		       false);
+	flush_work(&evf_mgr->suspend_work);
+	dma_fence_put(evf_mgr->ev_fence);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..527de3a23583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -25,6 +25,8 @@
 #ifndef AMDGPU_EV_FENCE_H_
 #define AMDGPU_EV_FENCE_H_
 
+#include <linux/dma-fence.h>
+
 struct amdgpu_eviction_fence {
 	struct dma_fence base;
 	spinlock_t	 lock;
@@ -35,35 +37,35 @@ struct amdgpu_eviction_fence {
 struct amdgpu_eviction_fence_mgr {
 	u64			ev_fence_ctx;
 	atomic_t		ev_fence_seq;
-	spinlock_t		ev_fence_lock;
-	struct amdgpu_eviction_fence *ev_fence;
-	struct delayed_work	suspend_work;
-	uint8_t fd_closing;
-};
-
-/* Eviction fence helper functions */
-struct amdgpu_eviction_fence *
-amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-void
-amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr);
-
-int
-amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
-			     struct amdgpu_bo *bo);
+	/*
+	 * Only updated while holding the VM resv lock.
+	 * Only signaled while holding the userq mutex.
+	 */
+	struct dma_fence __rcu	*ev_fence;
+	struct work_struct	suspend_work;
+	bool			shutdown;
+};
 
-void
-amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
-			     struct amdgpu_bo *bo);
+static inline struct dma_fence *
+amdgpu_evf_mgr_get_fence(struct amdgpu_eviction_fence_mgr *evf_mgr)
+{
+	struct dma_fence *ev_fence;
 
-int
-amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
+	rcu_read_lock();
+	ev_fence = dma_fence_get_rcu_safe(&evf_mgr->ev_fence);
+	rcu_read_unlock();
+	return ev_fence;
+}
 
-void
-amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
-			     struct amdgpu_eviction_fence *ev_fence);
+void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				 struct amdgpu_bo *bo);
+int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
+			 struct drm_exec *exec);
+void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				 struct amdgpu_bo *bo);
+void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
+void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr);
+void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-int
-amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				    struct drm_exec *exec);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5c90de58cc28..e28abfd04867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -263,13 +263,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 
-	/* attach gfx eviction fence */
-	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
-	if (r) {
-		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
-		amdgpu_bo_unreserve(abo);
-		return r;
-	}
+	amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
 	drm_exec_fini(&exec);
 
 	/* Validate and add eviction fence to DMABuf imports with dynamic
@@ -337,7 +331,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	}
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
-		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
+		amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
 
 	bo_va = amdgpu_vm_bo_find(vm, bo);
 	if (!bo_va || --bo_va->ref_count)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 45cdcbb68143..d88e4994c8c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1522,10 +1522,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			 "Failed to init usermode queue manager (%d), use legacy workload submission only\n",
 			 r);
 
-	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
-	if (r)
-		goto error_vm;
-
+	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7a8f9d86f275..5bc804636015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -472,17 +472,16 @@ void
 amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 			     struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
-	struct amdgpu_eviction_fence *ev_fence;
+	struct dma_fence *ev_fence;
 
 retry:
 	/* Flush any pending resume work to create ev_fence */
 	flush_delayed_work(&uq_mgr->resume_work);
 
 	mutex_lock(&uq_mgr->userq_mutex);
-	spin_lock(&evf_mgr->ev_fence_lock);
-	ev_fence = evf_mgr->ev_fence;
-	spin_unlock(&evf_mgr->ev_fence_lock);
-	if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
+	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
+	if (dma_fence_is_signaled(ev_fence)) {
+		dma_fence_put(ev_fence);
 		mutex_unlock(&uq_mgr->userq_mutex);
 		/*
 		 * Looks like there was no pending resume work,
@@ -491,6 +490,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 		schedule_delayed_work(&uq_mgr->resume_work, 0);
 		goto retry;
 	}
+	dma_fence_put(ev_fence);
 }
 
 int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
@@ -1197,7 +1197,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 		dma_fence_wait(bo_va->last_pt_update, false);
 	dma_fence_wait(vm->last_update, false);
 
-	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
+	ret = amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
 	if (ret)
 		drm_file_err(uq_mgr->file, "Failed to replace eviction fence\n");
 
@@ -1217,11 +1217,13 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 {
 	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct dma_fence *ev_fence;
 	int ret;
 
-	flush_delayed_work(&fpriv->evf_mgr.suspend_work);
-
 	mutex_lock(&uq_mgr->userq_mutex);
+	ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
+	if (!dma_fence_is_signaled(ev_fence))
+		goto unlock;
 
 	ret = amdgpu_userq_vm_validate(uq_mgr);
 	if (ret) {
@@ -1237,6 +1239,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
+	dma_fence_put(ev_fence);
 }
 
 static int
@@ -1312,11 +1315,8 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 }
 
 void
-amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
-		   struct amdgpu_eviction_fence *ev_fence)
+amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool schedule_resume)
 {
-	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
-	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	int ret;
 
@@ -1329,10 +1329,7 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 	if (ret)
 		dev_err(adev->dev, "Failed to evict userqueue\n");
 
-	/* Signal current eviction fence */
-	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
-
-	if (!evf_mgr->fd_closing)
+	if (schedule_resume)
 		schedule_delayed_work(&uq_mgr->resume_work, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 54e1997b3cc0..82306d489064 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -133,7 +133,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_userq_obj *userq_obj);
 
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
-			struct amdgpu_eviction_fence *ev_fence);
+			bool schedule_resume);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
-- 
2.43.0

