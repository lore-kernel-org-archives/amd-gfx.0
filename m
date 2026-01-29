Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64635D61014
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B42B410E858;
	Thu, 29 Jan 2026 12:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dKVYzsOg";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8635D10E856
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 12:53:32 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so9736145e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769691211; x=1770296011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3fq3qpxZuGZLIJ11CS08+hUglco0UdZJMRQsbapPe90=;
 b=dKVYzsOgtnGxuIguvd59sRPHLDxEGRzbaRGZxfs6Nv0NKEDKudt1YGm6k9kn14PG2C
 QwM//3fYF75bJO51vXOPvLf0FP5fjMzoWh9YW/d9/i8Qt6pM7EQSyz1t3ShrMUg+yAaW
 AEaY99dbOb8YEgdKD64IzXS7Qq7Lb7dHIvqv/y/A53XL28t4wgH3zkBCmweTuNbMWraw
 snk5NqPJM6eOytz6z/ZaBnFQmwFnKJD7MUFAUwDmc92gKX0w/x6eCtbaglJtp6k0cPlU
 6W3tK/MfDZFS9T+lcyRTCvAeJp5Nnu3z2Zd6RdJciTPbiAMUWhZatrTfMMe9l+kWeUzw
 J4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769691211; x=1770296011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3fq3qpxZuGZLIJ11CS08+hUglco0UdZJMRQsbapPe90=;
 b=dMEihtBKL5qfBt0Vs4JskUMdVq2+W6pksbXjV0LEZZTT6LqH0LwGNIDGnr7c33YhE6
 qRP17T4stZ+tOegfC75aF1szaRtUgWU2uEOzENEW8a6/KdLUxMS1GGmaF9HUDvWTh2UZ
 GfNV8B64lgqVIFjGUUdUPYo0BIQD7qq8Gh+tWJAd2k7El6CsqtGHSer+uqvuIiu4RKAn
 +sM9wgAoK4slmmV2ikisz2T9BdFzJ5FkJPYu6t/zRHIsCm0iJ0TBh2vwuU8v4MeZno9Q
 d4/n6yBbGADVplDtvNrVI5ZkPUfOkKmTGbuglw7QqJePknmpR1IkfZ/XSPAZHZ/l1GKd
 G7gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqObeC8U225KyfHAabkmR28GOlREVpBQBOiDOfCaKZ+R4rblH0DBjC3snixgD1G0LCwqUl+4+f@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfMLvJ06UmI9YriAzm/1E3J9aNjO4jRXGWgffUEUmAYh9b/EBa
 cTGL38yziNalnw6ggkA6JJkuuBp+C9RyEUEeF7+rYSsBXXjo8428a90n
X-Gm-Gg: AZuq6aJqj1zBdsEinCw0B8alT5yhrJWHC9DZaog8GjG/qzbCikScorf23Exi9+Ky6n6
 1Pwzdv+IoM72hn3Kw+ibdaEYAPj/rvlgjp1QhOM3GNx+MPUuTyMEBg+jAZnrKVHQOajBdoIS6dh
 Ox+GI8c6SQu6vsXUIAyd08bLnD31RxGzL/JRgLNToqwb6yfcv3E24SOu7d4WFJSzJzYcx1vRhwX
 0HkTmyJNWh8C9HiT5tmTPHRkZ2dG/snScVZWWlX23cGVof3uWb5jGeKyUcxcKp2XAWzEwljYXM8
 75dMUiQX6CsYFjV0n8hxq7j8m+6u3YOBkQqpXFjQLta6MUYp1kmo7tuPseyyY+UwCKkg+DRxfux
 kI9KxoYe39KfWA7tGFMlsfN18vI0enFq/UvkpEBmsoWW6OywKnrwmAuTlHkUA9jbsSZxD9w50X9
 q5O0n7Y1+xm19/Qc/Zo9iHq1Dc
X-Received: by 2002:a05:600c:4f82:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-48069c16213mr119207765e9.2.1769691210828; 
 Thu, 29 Jan 2026 04:53:30 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1522:e200:97e2:f9c5:ae8b:8e89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354114sm15442569f8f.42.2026.01.29.04.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:53:30 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: completely rework eviction fence handling
Date: Thu, 29 Jan 2026 13:53:24 +0100
Message-ID: <20260129125327.11786-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129125327.11786-1-christian.koenig@amd.com>
References: <20260129125327.11786-1-christian.koenig@amd.com>
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

First of all a lot of checks where placed at incorrect locations, especially if
the resume worker should run or not.

Then a bunch of code was just mid-layering because of incorrect assignment who
should do what.

And finally comments explaining what happens instead of why.

Just re-write it from scratch, that should at least fix some of the hangs we
are seeing.

Use RCU for the eviction fence pointer in the manager, the spinlock usage was
mostly incorrect as well. Then finally remove all the nonsense checks and
actually add them in the correct locations.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 213 ++++++------------
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  54 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  29 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +-
 7 files changed, 112 insertions(+), 205 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d6d0a6e34c6b..02abe85624a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2975,9 +2975,9 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
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
index 23d7d0b0d625..8fe9f91f9551 100644
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
@@ -43,102 +40,14 @@ amdgpu_eviction_fence_get_timeline_name(struct dma_fence *f)
 	return ef->timeline_name;
 }
 
-int
-amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				    struct drm_exec *exec)
-{
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
-
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
-}
-
-static void
-amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
-{
-	struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
-	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
-	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_eviction_fence *ev_fence;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	spin_lock(&evf_mgr->ev_fence_lock);
-	ev_fence = evf_mgr->ev_fence;
-	if (ev_fence)
-		dma_fence_get(&ev_fence->base);
-	else
-		goto unlock;
-	spin_unlock(&evf_mgr->ev_fence_lock);
-
-	amdgpu_userq_evict(uq_mgr, ev_fence);
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	dma_fence_put(&ev_fence->base);
-	return;
-
-unlock:
-	spin_unlock(&evf_mgr->ev_fence_lock);
-	mutex_unlock(&uq_mgr->userq_mutex);
-}
-
 static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
 {
 	struct amdgpu_eviction_fence_mgr *evf_mgr;
 	struct amdgpu_eviction_fence *ev_fence;
 
-	if (!f)
-		return true;
-
 	ev_fence = to_ev_fence(f);
 	evf_mgr = ev_fence->evf_mgr;
-
-	schedule_delayed_work(&evf_mgr->suspend_work, 0);
+	schedule_work(&evf_mgr->suspend_work);
 	return true;
 }
 
@@ -148,22 +57,52 @@ static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
 	.enable_signaling = amdgpu_eviction_fence_enable_signaling,
 };
 
-void amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
-				  struct amdgpu_eviction_fence *ev_fence)
+static void
+amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 {
-	spin_lock(&evf_mgr->ev_fence_lock);
-	dma_fence_signal(&ev_fence->base);
-	spin_unlock(&evf_mgr->ev_fence_lock);
+	struct amdgpu_eviction_fence_mgr *evf_mgr =
+		container_of(work, struct amdgpu_eviction_fence_mgr,
+			     suspend_work);
+	struct amdgpu_fpriv *fpriv =
+		container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct dma_fence *ev_fence;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
+	amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
+
+	/*
+	 * Signaling the eviction fence must be done while holding the
+	 * userq_mutex. Otherwise we won't resume the queues before issuing the
+	 * next fence.
+	 */
+	dma_fence_signal(ev_fence);
+	dma_fence_put(ev_fence);
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
+void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				 struct amdgpu_bo *bo)
+{
+	struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
+	struct dma_resv *resv = bo->tbo.base.resv;
+
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
@@ -171,56 +110,22 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
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
-
-	dma_fence_wait(&ev_fence->base, false);
 
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
+	/* Remember it for newly added BOs */
+	dma_fence_put(evf_mgr->ev_fence);
+	evf_mgr->ev_fence = &ev_fence->base;
 
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
 
@@ -229,13 +134,25 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
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
index f69332eed051..f512b6ec6c53 100644
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
index af3922e9caea..e007f10a6c1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -480,17 +480,16 @@ void
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
@@ -499,6 +498,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 		schedule_delayed_work(&uq_mgr->resume_work, 0);
 		goto retry;
 	}
+	dma_fence_put(ev_fence);
 }
 
 int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
@@ -1214,7 +1214,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 		dma_fence_wait(bo_va->last_pt_update, false);
 	dma_fence_wait(vm->last_update, false);
 
-	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
+	ret = amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
 	if (ret)
 		drm_file_err(uq_mgr->file, "Failed to replace eviction fence\n");
 
@@ -1234,11 +1234,13 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
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
@@ -1254,6 +1256,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
+	dma_fence_put(ev_fence);
 }
 
 static int
@@ -1317,11 +1320,8 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
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
 
@@ -1334,10 +1334,7 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
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
index 5845d8959034..095c09f3d96c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -127,7 +127,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_userq_obj *userq_obj);
 
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
-			struct amdgpu_eviction_fence *ev_fence);
+			bool schedule_resume);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
-- 
2.43.0

