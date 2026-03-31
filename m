Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764FB109B467
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 13:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C7C10EA80;
	Tue, 31 Mar 2026 13:47:09 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D5310E8FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 13:47:06 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62VDkuld2762862; Tue, 31 Mar 2026 19:16:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62VDkuHe2762855;
 Tue, 31 Mar 2026 19:16:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v5 4/5] drm/amdgpu/userq: call dma_resv_wait_timeout without
 test for signalled
Date: Tue, 31 Mar 2026 19:16:53 +0530
Message-Id: <20260331134654.2762805-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331134654.2762805-1-sunil.khatri@amd.com>
References: <20260331134654.2762805-1-sunil.khatri@amd.com>
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

In function amdgpu_userq_gem_va_unmap_validate call
dma_resv_wait_timeout directly. Also since we are waiting
forever we should not be having any return value and hence
no handling needed.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 ++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++------
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5c1ed4d0edbe..31f45bd2732c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1462,17 +1462,16 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 				       struct amdgpu_bo_va_mapping *mapping,
 				       uint64_t saddr)
 {
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_bo_va *bo_va = mapping->bo_va;
 	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
-	int ret = 0;
 
 	if (!ip_mask)
-		return 0;
+		return;
 
 	dev_warn_once(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
 	/**
@@ -1483,14 +1482,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 	 * unmap is only for one kind of userq VAs, so at this point suppose
 	 * the eviction fence is always unsignaled.
 	 */
-	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
-		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
-					    MAX_SCHEDULE_TIMEOUT);
-		if (ret <= 0)
-			return -EBUSY;
-	}
-
-	return 0;
+	dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP,
+				     false, MAX_SCHEDULE_TIMEOUT);
 }
 
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index a4d44abf24fa..d0c502268643 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -160,7 +160,7 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size);
-int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 				       struct amdgpu_bo_va_mapping *mapping,
 				       uint64_t saddr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 937a6dd3a4b5..cd27970844c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2003,12 +2003,8 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	 * during user requests GEM unmap IOCTL except for forcing the unmap
 	 * from user space.
 	 */
-	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
-		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
-		if (unlikely(r == -EBUSY))
-			dev_warn_once(adev->dev,
-				      "Attempt to unmap an active userq buffer\n");
-	}
+	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0))
+		amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
 
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
-- 
2.34.1

