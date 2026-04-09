Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD620E98FD2
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 13:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEED10E7F3;
	Thu,  9 Apr 2026 13:39:16 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BFB10E31E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 13:39:14 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 639Dd9lI1368260; Thu, 9 Apr 2026 19:09:09 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 639Dd9qO1368259;
 Thu, 9 Apr 2026 19:09:09 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu/userq: dont lock root bo with userq_mutex
 held
Date: Thu,  9 Apr 2026 19:09:03 +0530
Message-Id: <20260409133906.1368219-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409133906.1368219-1-sunil.khatri@amd.com>
References: <20260409133906.1368219-1-sunil.khatri@amd.com>
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

Do not hold reservation lock for root bo if userq_mutex
is already held in the call flow this cause a lock
issue with ttm_bo_delayed_delete.

Its better to lock the vm->root.bo first and then go ahead
with userq_mutex so userq_mutex threads dont get stuck until
the reservation lock is held.

In this case it helps in the function amdgpu_userq_buffer_vas_mapped
for each queue during restore_all.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9f7a08a6b018..cf8c8dfde721 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -270,15 +270,13 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 	struct amdgpu_bo_va_mapping *mapping;
 	bool r;
 
-	if (amdgpu_bo_reserve(vm->root.bo, false))
-		return false;
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 
 	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
 	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
 		r = true;
 	else
 		r = false;
-	amdgpu_bo_unreserve(vm->root.bo);
 
 	return r;
 }
@@ -991,10 +989,16 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id;
 	int ret = 0, r;
 
+
+	if (amdgpu_bo_reserve(vm->root.bo, false))
+		return false;
+
 	mutex_lock(&uq_mgr->userq_mutex);
 	/* Resume all the queues for this process */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
@@ -1012,6 +1016,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	}
 	mutex_unlock(&uq_mgr->userq_mutex);
+	amdgpu_bo_unreserve(vm->root.bo);
 
 	if (ret)
 		drm_file_err(uq_mgr->file,
-- 
2.34.1

