Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C47CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7493610E2BC;
	Wed,  5 Nov 2025 15:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ePaX+Tfk";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0736910E2BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iNpDZWutc+k85AVqT5gSMutLLpjt6v68MIp/ERA4lkk=; b=ePaX+Tfk9Mxib++qzvKRO9Lp64
 TdZd94K24BaHgTluFYqIUJpeH5tdgmLuYyD4TnDCGkcQKdbZD4nbpAqEBy0gBbgPZ8A4oxF4ThGzz
 nj8K5hW+CS3xh8b6P+zByBTo2CIfIBhOi8/Z/OZ+zcGHzonxjI0RCvdmKFlOKdnuhOmXbJDGt2zeA
 ZUjRWU76zPmAgjIAVk4Eb8ARApICJ6ohoYBGpkh4/0dpdudpZrtpiIsBF3eRcz9/zKa3zJ9wAH0/D
 0+ypMwW9ZbYS07rdU27hm1efrk38c7EGBXS1TnwhGcSzyZfHUR/SCj83fon7eXwHeLPQqZv8xvwwP
 PhE8QpCA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGfee-002VPm-7C; Wed, 05 Nov 2025 16:42:36 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC] drm/amdgpu: Streamline amdgpu_sync_resv() and amdgpu_sync_kfd()
Date: Wed,  5 Nov 2025 15:42:32 +0000
Message-ID: <20251105154232.13390-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
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

If we remove the amdgpu_sync_get_owner() helper and replace it with local
operations tailored for each of its two call sites, we get two benefits.

First is that in amdgpu_sync_resv() it enables us to avoid converting the
fence to scheduler fence twice, first time to get the owner, second to
check if it is coming from the same device.

While at it, we also refactor the mode check ladder a bit to allow
checking for the same device only once.

Second benefit of replacing the helper with local operations is that in
amdgpu_sync_kfd() we can now check for the only piece of information the
caller is interested in.

If the readability of the code is kept while reducing the lines of source,
while at the same time amdgpu_sync.o bloat-o-meter sees a reduction, all
should be good:

add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-106 (-106)
Function                                     old     new   delta
amdgpu_sync_kfd                              259     228     -31
amdgpu_sync_resv                             734     659     -75
Total: Before=3123, After=3017, chg -3.39%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
---
Regardless of whether the patch will be considered as improving or
reducing redability, another reason why I am sending it is becuase I
noticed in amdgpu_sync_resv() it peeks into the dma-fence-chain but it is
not passing it to amdgpu_sync_fence(). I was curious what is the reason
for this?

Would it not be better to keep the unwrapped latest fence in the hash? For
the case if it finds that it wants to sync to the fence, but if it is
may not see that it already has one from the same context in there.

TBH I did not find that it is happening in practice but maybe I just did
not find the right userspace to trigger it.

I did try passing the unwrapped fence from amdgpu_sync_test_fence() to
amdgpu_sync_fence() and nothing appeared to have broke.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 88 ++++++++----------------
 1 file changed, 29 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index d6ae9974c952..3b113d4cdf75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -58,49 +58,20 @@ void amdgpu_sync_create(struct amdgpu_sync *sync)
  * amdgpu_sync_same_dev - test if fence belong to us
  *
  * @adev: amdgpu device to use for the test
- * @f: fence to test
+ * @s_fence: scheduler fence to test
  *
  * Test if the fence was issued by us.
  */
 static bool amdgpu_sync_same_dev(struct amdgpu_device *adev,
-				 struct dma_fence *f)
+				 struct drm_sched_fence *s_fence)
 {
-	struct drm_sched_fence *s_fence = to_drm_sched_fence(f);
+	struct amdgpu_ring *ring;
 
-	if (s_fence) {
-		struct amdgpu_ring *ring;
+	if (!s_fence)
+		return false;
 
-		ring = container_of(s_fence->sched, struct amdgpu_ring, sched);
-		return ring->adev == adev;
-	}
-
-	return false;
-}
-
-/**
- * amdgpu_sync_get_owner - extract the owner of a fence
- *
- * @f: fence get the owner from
- *
- * Extract who originally created the fence.
- */
-static void *amdgpu_sync_get_owner(struct dma_fence *f)
-{
-	struct drm_sched_fence *s_fence;
-	struct amdgpu_amdkfd_fence *kfd_fence;
-
-	if (!f)
-		return AMDGPU_FENCE_OWNER_UNDEFINED;
-
-	s_fence = to_drm_sched_fence(f);
-	if (s_fence)
-		return s_fence->owner;
-
-	kfd_fence = to_amdgpu_amdkfd_fence(f);
-	if (kfd_fence)
-		return AMDGPU_FENCE_OWNER_KFD;
-
-	return AMDGPU_FENCE_OWNER_UNDEFINED;
+	ring = container_of(s_fence->sched, struct amdgpu_ring, sched);
+	return ring->adev == adev;
 }
 
 /**
@@ -183,7 +154,18 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 				   enum amdgpu_sync_mode mode,
 				   void *owner, struct dma_fence *f)
 {
-	void *fence_owner = amdgpu_sync_get_owner(f);
+	struct drm_sched_fence *s_fence;
+	void *fence_owner;
+
+	f = dma_fence_chain_contained(f);
+
+	s_fence = to_drm_sched_fence(f);
+	if (s_fence)
+		fence_owner = s_fence->owner;
+	else if (to_amdgpu_amdkfd_fence(f))
+		fence_owner = AMDGPU_FENCE_OWNER_KFD;
+	else
+		fence_owner = AMDGPU_FENCE_OWNER_UNDEFINED;
 
 	/* Always sync to moves, no matter what */
 	if (fence_owner == AMDGPU_FENCE_OWNER_UNDEFINED)
@@ -203,24 +185,16 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 		return false;
 
 	/* Ignore fences depending on the sync mode */
-	switch (mode) {
-	case AMDGPU_SYNC_ALWAYS:
+	if (mode == AMDGPU_SYNC_ALWAYS) {
 		return true;
-
-	case AMDGPU_SYNC_NE_OWNER:
-		if (amdgpu_sync_same_dev(adev, f) &&
-		    fence_owner == owner)
-			return false;
-		break;
-
-	case AMDGPU_SYNC_EQ_OWNER:
-		if (amdgpu_sync_same_dev(adev, f) &&
-		    fence_owner != owner)
-			return false;
-		break;
-
-	case AMDGPU_SYNC_EXPLICIT:
+	} else if (mode == AMDGPU_SYNC_EXPLICIT) {
 		return false;
+	} else if ((mode == AMDGPU_SYNC_NE_OWNER ||
+		    mode == AMDGPU_SYNC_EQ_OWNER) &&
+		   amdgpu_sync_same_dev(adev, s_fence)) {
+		if ((mode == AMDGPU_SYNC_NE_OWNER && fence_owner == owner) ||
+		    (mode == AMDGPU_SYNC_EQ_OWNER && fence_owner != owner))
+			return false;
 	}
 
 	WARN(debug_evictions && fence_owner == AMDGPU_FENCE_OWNER_KFD,
@@ -252,9 +226,7 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 	/* Implicitly sync only to KERNEL, WRITE and READ */
 	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
 		dma_fence_chain_for_each(f, f) {
-			struct dma_fence *tmp = dma_fence_chain_contained(f);
-
-			if (amdgpu_sync_test_fence(adev, mode, owner, tmp)) {
+			if (amdgpu_sync_test_fence(adev, mode, owner, f)) {
 				r = amdgpu_sync_fence(sync, f, GFP_KERNEL);
 				dma_fence_put(f);
 				if (r)
@@ -282,9 +254,7 @@ int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv)
 
 	dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
 	dma_resv_for_each_fence_unlocked(&cursor, f) {
-		void *fence_owner = amdgpu_sync_get_owner(f);
-
-		if (fence_owner != AMDGPU_FENCE_OWNER_KFD)
+		if (!to_amdgpu_amdkfd_fence(f))
 			continue;
 
 		r = amdgpu_sync_fence(sync, f, GFP_KERNEL);
-- 
2.48.0

