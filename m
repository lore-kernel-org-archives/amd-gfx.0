Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BCE106F308
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 08:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7748E10EA34;
	Thu, 26 Mar 2026 08:56:21 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C4C10EA37
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 08:56:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62Q8u7hu2665284; Thu, 26 Mar 2026 14:26:07 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62Q8u7ZU2665283;
 Thu, 26 Mar 2026 14:26:07 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v1 3/4] drm/amdgpu/userq: no need to use local variable here
 for return
Date: Thu, 26 Mar 2026 14:26:00 +0530
Message-Id: <20260326085601.2665215-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326085601.2665215-1-sunil.khatri@amd.com>
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
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

In function amdgpu_userq_gem_va_unmap_validate use function
return value directly in the if condition instead
of local variable ret.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2b07c3941927..48cb2e21ce56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1478,7 +1478,6 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_bo_va *bo_va = mapping->bo_va;
 	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
-	int ret = 0;
 
 	if (!ip_mask)
 		return 0;
@@ -1493,9 +1492,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 	 * the eviction fence is always unsignaled.
 	 */
 	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
-		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
-					    MAX_SCHEDULE_TIMEOUT);
-		if (ret <= 0)
+		if (dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
+					    MAX_SCHEDULE_TIMEOUT) <= 0)
 			return -EBUSY;
 	}
 
-- 
2.34.1

