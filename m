Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5E010A62C6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 13:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D595710E0C6;
	Thu, 26 Mar 2026 13:24:11 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232AF10E9E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 13:24:09 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62QDNuZA2753883; Thu, 26 Mar 2026 18:53:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62QDNuoS2753882;
 Thu, 26 Mar 2026 18:53:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v2 3/3] drm/amdgpu/userq: dont check and call
 dma_resv_wait_timeout
Date: Thu, 26 Mar 2026 18:53:53 +0530
Message-Id: <20260326132353.2753833-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326132353.2753833-1-sunil.khatri@amd.com>
References: <20260326132353.2753833-1-sunil.khatri@amd.com>
MIME-Version: 1.0
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
dma_resv_wait_timeout directly.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +---
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d29620d3d0d2..e73c69026268 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1477,7 +1477,6 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_bo_va *bo_va = mapping->bo_va;
 	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
-	int ret = 0;
 
 	if (!ip_mask)
 		return 0;
@@ -1491,14 +1490,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
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
+	return dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP,
+				     true, MAX_SCHEDULE_TIMEOUT);
 }
 
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 937a6dd3a4b5..7aa5b8c457c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1978,7 +1978,6 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
-	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -2004,8 +2003,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	 * from user space.
 	 */
 	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
-		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
-		if (unlikely(r == -EBUSY))
+		if (amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr))
 			dev_warn_once(adev->dev,
 				      "Attempt to unmap an active userq buffer\n");
 	}
-- 
2.34.1

