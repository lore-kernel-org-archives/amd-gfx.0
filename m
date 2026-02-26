Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80A2FC5908
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 07:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B76510E04D;
	Thu, 26 Feb 2026 07:42:52 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45AF310E04D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 07:42:50 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 61Q7giVn3150473; Thu, 26 Feb 2026 13:12:44 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 61Q7giMg3150472;
 Thu, 26 Feb 2026 13:12:44 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1] drm/amdgpu/userq: change queue id type to u32 from int
Date: Thu, 26 Feb 2026 13:12:41 +0530
Message-Id: <20260226074241.3150441-1-sunil.khatri@amd.com>
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

queue id always remain a positive value and should
be of type unsigned.

With this we also dont need to typecast the id to other
types specially in xarray functions.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b700c2b91465..e07b2082cf25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -447,7 +447,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 }
 
 static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
-				 int queue_id)
+				 u32 queue_id)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -461,7 +461,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
 	uq_funcs->mqd_destroy(queue);
 	amdgpu_userq_fence_driver_free(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
-	xa_erase_irq(&uq_mgr->userq_xa, (unsigned long)queue_id);
+	xa_erase_irq(&uq_mgr->userq_xa, queue_id);
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
@@ -471,7 +471,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
 }
 
 static struct amdgpu_usermode_queue *
-amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
+amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
 {
 	return xa_load(&uq_mgr->userq_xa, qid);
 }
@@ -625,7 +625,7 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static int
-amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
+amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
-- 
2.34.1

