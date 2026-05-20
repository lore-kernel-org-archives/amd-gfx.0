Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC94CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 02:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3495010E083;
	Wed, 20 May 2026 02:53:23 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F007910E083
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 02:53:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64K2r9o41866862; Wed, 20 May 2026 08:23:09 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64K2r9cT1866861;
 Wed, 20 May 2026 08:23:09 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/userq: clean amdgpu_userq_destroy_object
Date: Wed, 20 May 2026 08:22:55 +0530
Message-Id: <20260520025258.1866776-1-sunil.khatri@amd.com>
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

amdgpu_userq_destroy_object does not use userq_mgr
reference and hence cleaning that up.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 10 ++++------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 798998d65e17..0607b7078518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -526,8 +526,7 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
-				 struct amdgpu_userq_obj *userq_obj)
+void amdgpu_userq_destroy_object(struct amdgpu_userq_obj *userq_obj)
 {
 	amdgpu_bo_kunmap(userq_obj->obj);
 	amdgpu_bo_unpin(userq_obj->obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 033b8a0de6b1..fe89e35b0d85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -155,8 +155,7 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
 			       struct amdgpu_userq_obj *userq_obj,
 			       int size);
 
-void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
-				 struct amdgpu_userq_obj *userq_obj);
+void amdgpu_userq_destroy_object(struct amdgpu_userq_obj *userq_obj);
 
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2d95203ec58e..69b36ebfe7ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -432,10 +432,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return 0;
 
 free_ctx:
-	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	amdgpu_userq_destroy_object(&queue->fw_obj);
 
 free_mqd:
-	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
+	amdgpu_userq_destroy_object(&queue->mqd);
 
 free_props:
 	kfree(userq_props);
@@ -445,11 +445,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
-
-	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	amdgpu_userq_destroy_object(&queue->fw_obj);
 	kfree(queue->userq_prop);
-	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
+	amdgpu_userq_destroy_object(&queue->mqd);
 }
 
 static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
-- 
2.34.1

