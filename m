Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B535CD37B6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 08:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21D010E06A;
	Wed, 13 May 2026 08:08:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A5210E06A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 08:08:10 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64D885Q61720252; Wed, 13 May 2026 13:38:05 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64D885Kf1720250;
 Wed, 13 May 2026 13:38:05 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: userq_vq_mapped should remain set once done
Date: Wed, 13 May 2026 13:38:04 +0530
Message-Id: <20260513080804.1720205-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Multiple queues needs these bo_va objects belonging to
the same uq_mgr. So once they are mapped lets not unmap
them as at any point of time any of the queues might be
using it.

Also userq_va_mapped should be a boolean than atomic.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 6 ++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 912c9afaf9e1..4d68732d6223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -96,7 +96,8 @@ struct amdgpu_bo_va {
 	 * if non-zero, cannot unmap from GPU because user queues may still access it
 	 */
 	unsigned int			queue_refcount;
-	atomic_t			userq_va_mapped;
+	/* Indicates if this buffer is mapped for any user queue. Once set, never reset. */
+	bool				userq_va_mapped;
 };
 
 struct amdgpu_bo {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 24b172a0d9ac..9225b3795e74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -227,7 +227,7 @@ static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 
 	INIT_LIST_HEAD(&va_cursor->list);
 	va_cursor->gpu_addr = addr;
-	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
+	va_map->bo_va->userq_va_mapped = true;
 	list_add(&va_cursor->list, &queue->userq_va_list);
 
 	return 0;
@@ -274,7 +274,7 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 
 	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
-	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
+	if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->userq_va_mapped)
 		r = true;
 	else
 		r = false;
@@ -303,8 +303,6 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
 					    struct amdgpu_userq_va_cursor *va_cursor)
 {
-	if (mapping)
-		atomic_set(&mapping->bo_va->userq_va_mapped, 0);
 	list_del(&va_cursor->list);
 	kfree(va_cursor);
 }
-- 
2.34.1

