Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C08CD4F54
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 06:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E5810EA80;
	Tue, 19 May 2026 06:21:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9595C10EA84
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:21:16 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64J6LBVB440337; Tue, 19 May 2026 11:51:11 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64J6LBqs440290;
 Tue, 19 May 2026 11:51:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 3/9] drm/amdgpu: simplify return value in
 amdgpu_userq_get_doorbell_index
Date: Tue, 19 May 2026 11:51:01 +0530
Message-Id: <20260519062107.438653-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519062107.438653-1-sunil.khatri@amd.com>
References: <20260519062107.438653-1-sunil.khatri@amd.com>
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

Function amdgpu_userq_get_doorbell_index returns a uint64 type index
as well as a int type failure values. So simplifying that here and
using a int type return value and getting the index in input pointer
of type uint64 type.

Also since it is used just once here so lets make it local to the file
with static type.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 ---
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d3971bf9112b..d42a4d97e8e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -536,12 +536,13 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_bo_unref(&userq_obj->obj);
 }
 
-uint64_t
+static int
 amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 				struct amdgpu_db_info *db_info,
-				struct drm_file *filp)
+				struct drm_file *filp,
+				uint64_t *index)
 {
-	uint64_t index;
+	uint64_t doorbell_index;
 	struct drm_gem_object *gobj;
 	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
 	int r, db_size;
@@ -588,12 +589,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 		goto unpin_bo;
 	}
 
-	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
+	doorbell_index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
 					     db_info->doorbell_offset, db_size);
 	drm_dbg_driver(adev_to_drm(uq_mgr->adev),
-		       "[Usermode queues] doorbell index=%lld\n", index);
+		       "[Usermode queues] doorbell index=%lld\n", doorbell_index);
 	amdgpu_bo_unreserve(db_obj->obj);
-	return index;
+	*index = doorbell_index;
+	return 0;
 
 unpin_bo:
 	amdgpu_bo_unpin(db_obj->obj);
@@ -769,10 +771,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_bo_unreserve(fpriv->vm.root.bo);
 
 	/* Convert relative doorbell offset into absolute doorbell index */
-	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
-	if (index == (uint64_t)-EINVAL) {
+	r = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp, &index);
+	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
-		r = -EINVAL;
 		goto clean_mapping;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 49b33e2d6932..9c4d4220c353 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -163,9 +163,6 @@ void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-uint64_t amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
-					 struct amdgpu_db_info *db_info,
-					     struct drm_file *filp);
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
 bool amdgpu_userq_enabled(struct drm_device *dev);
-- 
2.34.1

