Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532E6CD343F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 19:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A7E10E29B;
	Tue, 12 May 2026 19:30:53 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE9810E29B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:30:52 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64CJUltb1279843; Wed, 13 May 2026 01:00:47 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64CJUkYu1279842;
 Wed, 13 May 2026 01:00:46 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: remove va cursors for all mappings
Date: Wed, 13 May 2026 01:00:45 +0530
Message-Id: <20260512193045.1279817-1-sunil.khatri@amd.com>
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

va_cursor struct needs to be cleaned even if the mapping
has been removed already.

Also simplify it by make it a void function as return value
check isn't needed as its called during tear down.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f62163917f70..e325c7a350f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -303,13 +303,14 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
 					    struct amdgpu_userq_va_cursor *va_cursor)
 {
-	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
+	if (mapping)
+		atomic_set(&mapping->bo_va->userq_va_mapped, 0);
 	list_del(&va_cursor->list);
 	kfree(va_cursor);
 }
 
-static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
-						struct amdgpu_usermode_queue *queue)
+static void amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
+						 struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
 	struct amdgpu_bo_va_mapping *mapping;
@@ -319,15 +320,11 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
 
 	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
 		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
-		if (!mapping) {
-			return -EINVAL;
-		}
-		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
-			queue, va_cursor->gpu_addr);
+		if (mapping)
+			dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
+				queue, va_cursor->gpu_addr);
 		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
 	}
-
-	return 0;
 }
 
 static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
-- 
2.34.1

