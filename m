Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B7CC61DD5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75CA410F00A;
	Thu, 27 Aug 2026 12:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A4femNbh";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6196110F02A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:25 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso18934345e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834964; x=1788439764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f8es3QxEoZJPjHBPnjj/yQAPL6vDi03o7vqK4xCLI6U=;
 b=A4femNbhOpfnUgcw07F0cS7c1bBIq2Dlkuxma8PWnlcxmIQtiUI0ZfPvBkQIT1+3sy
 tCJJveIxHM07NC1WvTmUXtR1m+ef5pQ7j698zBlfbIYZ/dn38U4Jjy9S43KQDlMqOrV0
 ixv/D/IqbCKwUCT9aBeUzDfxEYbWsjPFRdfZO38YWUx5MaduCXXroOqFuszBjkHPOeLv
 74ZStlEyKQ7Vevb3N2PUUl1X2LrlVAyt/Q3vj4go4nLflK0EkZZdAqvrpmNcU5hKeCjk
 go9D+4Tf6IW9b0K+Pk8q6mt4AEw97r5f7SU6Ui5HCkF3+iXqI8OlHMPqrY+iRDlSAZQT
 u16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834964; x=1788439764;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f8es3QxEoZJPjHBPnjj/yQAPL6vDi03o7vqK4xCLI6U=;
 b=o/fGl152EV+0tkZUiIEn0vLnMyH32f2IYGyfWi0USC6etUSfwfHYjbGNrPizcw3IKe
 Nu0x4TTXjgfOFfQkax6RwBBv4ujI//rC15NNXO9w51ZTPBELUbS9hYK8jfO7G3e1uqN+
 lFNH51O3yNtQHQk8CHRrh0F5Itawcm/iSsMUAgmMpstaif/6AxXTaf+9A7Xs3Njdoxbh
 q4QK0oJb/12MI467wUJRq3unrz9eqlUPfR72VWDxBgYCfWvJUyX/ACFu/Lz6glN1xhgz
 wPLXAvzBAVZk0l01Y/jFyFOd57wzuvVkK3npRPY0drqf64xmUGhcsk9buetJ2leMcZlR
 1gPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoW4YLxuo3afLO1RWjuae2xOnSDQ+Lpk8ZIa/YVTgmwD9gOncjdXmbLGIHdulnduDq/kjyikM8g@lists.freedesktop.org
X-Gm-Message-State: AFuF++mgvKj7ky+SU6QlWKeRr/SSn6/ZzhJT2i+r0rRP7cf15j7vdzoy
 V8Wv632ZCT4LJIw6WqFSx0m343S8QSZEcMLBOWTHMFn/+xLgkSuGTqBf
X-Gm-Gg: AR+sD10M0ca2Lg89H3gxEXk6NftHbz5nFosLv7ph6L+sfZc4inBChIauRBpyZeI9rNw
 qprOamM2gP/8k3cYtZcMlRjNDHf6OpKjCH2mi0n6LA+uIGv0sVdMhJpuubbl514Ef29rj27Qs5A
 ZsfudqrvjILZ1kUXoGkYO20eK7Zs93xy7bMwV+R8E9CF5QCkjHTocZhMmI3MOIDSwuVi/zshsAD
 2QGkj6isk4gBeHOFj+iWIKNBwoq+BD5BCJX2sU++nx6AmFkQZ0OB1qHoH9qel3cleX1nUTvH1Sy
 Ljp4/achCuBFOLTtVhV+MBdT0jraJgZP7CIPmmRlcOEjm2hgu+LcV5dYHFVB8BFYwDpUto8OGJH
 syjb+eUYhsUkfZeA+DOzju+HvHEe7WpusXNmvw7OlkpulKKPNe7LPnkEco5iPvC0yEP2iDNd0W2
 m8zRuQCYT1jhKo/Zb0wPTgHytjQIaEzYtbX+5wOOBuRrq7zhueywg6CZkxptpTUQbg3YCpkODWe
 A==
X-Received: by 2002:a05:600c:1d1d:b0:499:737c:8a8b with SMTP id
 5b1f17b1804b1-499dc81eb1emr176161465e9.12.1787834963628; 
 Thu, 27 Aug 2026 05:49:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/10] dma-buf: Inline dma_resv_init and remove allocated flag
Date: Thu, 27 Aug 2026 14:38:58 +0200
Message-ID: <20260827124910.2245-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827124910.2245-1-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that all users have migrated to dma_resv_alloc(), inline the
initialization code directly into dma_resv_alloc() and remove the
dma_resv_init() function entirely.

Additionally, remove the 'allocated' flag from struct dma_resv since
all dma_resv objects are now dynamically allocated. This simplifies
the reference counting logic - dma_resv_release() now always frees
the object unconditionally.

The last remaining use of dma_resv_init() in dma_resv_lockdep() has
been converted to use dma_resv_alloc() instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/dma-buf/dma-resv.c | 41 ++++++++++++++++----------------------
 include/linux/dma-resv.h   | 10 ----------
 2 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 48798cec6ce7..a3586e79c2eb 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -132,26 +132,13 @@ static void dma_resv_list_free(struct dma_resv_list *list)
 	kfree_rcu(list, rcu);
 }
 
-/**
- * dma_resv_init - initialize a reservation object
- * @obj: the reservation object
- */
-void dma_resv_init(struct dma_resv *obj)
-{
-	kref_init(&obj->refcount);
-	obj->allocated = false;
-	ww_mutex_init(&obj->lock, &reservation_ww_class);
-
-	RCU_INIT_POINTER(obj->fences, NULL);
-}
-EXPORT_SYMBOL(dma_resv_init);
-
 /*
  * dma_resv_release - release function for kref
  * @kref: the kref inside the dma_resv object
  *
  * This is called when the last reference to a dma_resv object is released.
- * Cleans up the object and frees it if it was allocated by dma_resv_alloc().
+ * All dma_resv objects are now dynamically allocated, so this always frees
+ * the object after cleanup.
  */
 static void dma_resv_release(struct kref *kref)
 {
@@ -159,8 +146,7 @@ static void dma_resv_release(struct kref *kref)
 
 	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
 	ww_mutex_destroy(&obj->lock);
-	if (obj->allocated)
-		kfree(obj);
+	kfree(obj);
 }
 
 /**
@@ -181,8 +167,9 @@ struct dma_resv *dma_resv_alloc(void)
 	if (!obj)
 		return NULL;
 
-	dma_resv_init(obj);
-	obj->allocated = true;
+	kref_init(&obj->refcount);
+	ww_mutex_init(&obj->lock, &reservation_ww_class);
+	RCU_INIT_POINTER(obj->fences, NULL);
 
 	return obj;
 }
@@ -838,23 +825,28 @@ static int __init dma_resv_lockdep(void)
 {
 	struct mm_struct *mm = mm_alloc();
 	struct ww_acquire_ctx ctx;
-	struct dma_resv obj;
+	struct dma_resv *obj;
 	struct address_space mapping;
 	int ret;
 
 	if (!mm)
 		return -ENOMEM;
 
-	dma_resv_init(&obj);
+	obj = dma_resv_alloc();
+	if (!obj) {
+		mmput(mm);
+		return -ENOMEM;
+	}
+
 	address_space_init_once(&mapping);
 
 	mmap_read_lock(mm);
 	ww_acquire_init(&ctx, &reservation_ww_class);
-	ret = dma_resv_lock(&obj, &ctx);
+	ret = dma_resv_lock(obj, &ctx);
 	if (ret) {
 		/* Only EDEADLK from the error injection is possible here */
 		WARN_ON(ret != -EDEADLK);
-		dma_resv_lock_slow(&obj, &ctx);
+		dma_resv_lock_slow(obj, &ctx);
 	}
 	fs_reclaim_acquire(GFP_KERNEL);
 	/* for unmap_mapping_range on trylocked buffer objects in shrinkers */
@@ -868,10 +860,11 @@ static int __init dma_resv_lockdep(void)
 	__dma_fence_might_wait();
 #endif
 	fs_reclaim_release(GFP_KERNEL);
-	ww_mutex_unlock(&obj.lock);
+	ww_mutex_unlock(&obj->lock);
 	ww_acquire_fini(&ctx);
 	mmap_read_unlock(mm);
 
+	dma_resv_put(obj);
 	mmput(mm);
 
 	return 0;
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index 4d12519df34e..cf689d3d4ba6 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -162,15 +162,6 @@ struct dma_resv {
 	 */
 	struct kref refcount;
 
-	/**
-	 * @allocated:
-	 *
-	 * True if this object was allocated by dma_resv_alloc(), false if
-	 * embedded in another structure. Used to determine whether to free
-	 * the object memory in the release function.
-	 */
-	bool allocated;
-
 	/**
 	 * @lock:
 	 *
@@ -482,7 +473,6 @@ static inline void dma_resv_unlock(struct dma_resv *obj)
 	ww_mutex_unlock(&obj->lock);
 }
 
-void dma_resv_init(struct dma_resv *obj);
 struct dma_resv *dma_resv_alloc(void);
 struct dma_resv *dma_resv_get(struct dma_resv *obj);
 void dma_resv_put(struct dma_resv *obj);
-- 
2.43.0

