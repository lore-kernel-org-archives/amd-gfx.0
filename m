Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D740C61DC4
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 17:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89C810E8DA;
	Wed, 26 Aug 2026 17:58:52 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A238310E8DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 17:58:50 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 67QHwjfM560044; Wed, 26 Aug 2026 23:28:45 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 67QHwjod560043;
 Wed, 26 Aug 2026 23:28:45 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/userq: use fence_val instead or rptr
Date: Wed, 26 Aug 2026 23:28:41 +0530
Message-Id: <20260826175841.559992-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826175841.559992-1-sunil.khatri@amd.com>
References: <20260826175841.559992-1-sunil.khatri@amd.com>
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

rptr is a confusing variabile name as it is a fence
value written by the cp in the fence address and no
where related to the rptr.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index e862b65f5366..cee5b0241196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -316,12 +316,12 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
 {
 	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
 	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
-	u64 rptr, wptr;
+	u64 fence_val, wptr;
 
-	rptr = amdgpu_userq_fence_read(fence_drv);
+	fence_val = amdgpu_userq_fence_read(fence_drv);
 	wptr = fence->base.seqno;
 
-	if (rptr >= wptr)
+	if (fence_val >= wptr)
 		return true;
 
 	return false;
-- 
2.34.1

