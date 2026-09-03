Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEBEC624A4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFCC10F61D;
	Thu,  3 Sep 2026 13:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BKB1rV0a";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D7A10F61D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:25 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-484374f54d0so1485799f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443064; x=1789047864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZDZwxrcvycJHj1eGUeoFp0vnof78SH0cq5rrlezlWVM=;
 b=BKB1rV0a7yl55cpVCgViSJEsZkUw65ckvP2BOcULB5Rxx82jNR7sxXMnmunyMeM66w
 wXX8ErM+6EVJFAaJ+wC1Iohv6aJX10u2quQdupMyuaWM4X4hlxeeSize3r4tqAaDG73e
 6vOmXyH/mXCT9oALgNXFDwAgyt+qzsgq4Ilz5AsJJUhJ7dki8VqO0SnK6xNr1m9VAyih
 9sswggTqe6lGZ7jOtWwQEovoDXLTBTJJiJc4OACLqcsHMCplZw2WRPJaToBgYZlYz4Ya
 QvRw2On1q2DYl1quqMjg5+tNkLSnR+E/ZvK9Atf64EkonU13MgZQkCPX0dX2cLiMY1OI
 iSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443064; x=1789047864;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZDZwxrcvycJHj1eGUeoFp0vnof78SH0cq5rrlezlWVM=;
 b=cBeiO91MBkN6u9ed44/wAN6cXoY/DoiL/vdZSoPqGw5BiIAzoosOmAnWIpkVGOlzea
 D+wX+4ukagQ2BcxmBcGDDhTs8Q2HAKAeb2bJ6grXxNo1wQFL0o7Z/ef+b/kNbcpJ9C8r
 fxoS5FClYo+/Vcz56aHmMf5OxNfnlD2RQZfIJpQBOxyPWwUZAIRaGs5OX0HECdz3hjjg
 vyCaOTtfuB5ohepc6OY00lQwS1VFJmy467t6YMuwpbtoCWdoH6/k/youQ27SJhUJp+wl
 GUxW9gbna37CJLecuAzA/QezZh4YUkQ4H4GKLhQROMLBdzouftvSv8P6X7cM/ixRmU6/
 Ndbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2RlllELpje2a893AZkqgHomBVo+tVSIOTE5VnrCfQKGiFPgFQ9wKBt9xdUWgRYbYM5aEHqYlV@lists.freedesktop.org
X-Gm-Message-State: AFuF++lAgzRRp2y/AVxJVsTcInzNbe0VuXhmdX+KQ+kfqO4G9sgXDxmA
 S0ZVWecmp50jjvsH2v4JNalSg3BM4xOAEIvg4QTV5l3w3rH8LcmDYILE
X-Gm-Gg: AYBFou0d3dIUJbuJnmUrj2lWbwLi0F8+pTF2GlRjZ0cfaIieJOGTr7oCXLjAjG1+JFm
 zmuwFz8R9KP5ZEri779HO5Pps4nSsAlilaIowT2pHHJIznerWdnCwRO2Fi2bYsMTQ9LmHkiaJ1Y
 Z6n2GKlDZAdys0Jw2BqnEz6eszWjN95JPG0nvDw8BgicpdEK5A7aSmtac+BDl7xS1v0Ljdx6BEq
 LSXPVuwqUeiVyyCtiaqj68PJOtsR+PoMvtzbHUoKC6S82K8gjAqEviJS6TUbhRJh/JhlIAcsUoI
 FSULXR3v82+3mpkH989UyQABV0DBzsavP+PvjugXlKRoyqsp2mA+opTIK5qxrqmugZc2RO9rPy8
 f9W9fYl7ZMh+0wNwjrTcM8fRGQHpJkEJGqpTHbGiD7sQ6qZyI0gLAYq0QZg90QbEdnYhIOLL9pD
 n9MRuVwe7fpAOmw0xm+MzE/tDyS5019G6Jk0Wc9yKT2bijCQz/E+XRCpuSo6r93vtWJp5CD3X4D
 A==
X-Received: by 2002:a05:6000:4548:b0:485:8542:fee3 with SMTP id
 ffacd0b85a97d-4858542fffdmr2777779f8f.16.1788443064234; 
 Thu, 03 Sep 2026 06:44:24 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] dma-buf: Inline dma_resv_init and remove allocated flag
Date: Thu,  3 Sep 2026 15:28:06 +0200
Message-ID: <20260903134408.105317-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
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
 drivers/dma-buf/dma-resv.c | 43 +++++++++++++++-----------------------
 include/linux/dma-resv.h   | 10 ---------
 2 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 5ae5a4b40ae6..4a421b08cd98 100644
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
@@ -163,10 +150,7 @@ static void dma_resv_release(struct kref *kref)
 	 */
 	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
 	ww_mutex_destroy(&obj->lock);
-
-	/* TODO: Only as temporary workaround till dma_fence_init() is removed */
-	if (obj->allocated)
-		kfree(obj);
+	kfree(obj);
 }
 
 /**
@@ -187,8 +171,9 @@ struct dma_resv *dma_resv_alloc(void)
 	if (!obj)
 		return NULL;
 
-	dma_resv_init(obj);
-	obj->allocated = true;
+	kref_init(&obj->refcount);
+	ww_mutex_init(&obj->lock, &reservation_ww_class);
+	RCU_INIT_POINTER(obj->fences, NULL);
 
 	return obj;
 }
@@ -844,23 +829,28 @@ static int __init dma_resv_lockdep(void)
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
@@ -874,10 +864,11 @@ static int __init dma_resv_lockdep(void)
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

