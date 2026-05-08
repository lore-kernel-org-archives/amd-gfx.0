Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C1DCD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 10:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFC410E320;
	Fri,  8 May 2026 10:39:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEEA10E320
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 10:39:16 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 648AdCuQ2442215; Fri, 8 May 2026 16:09:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 648AdC9s2442214;
 Fri, 8 May 2026 16:09:12 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/userq: pin mqd and fw object bo to avoid
 eviction
Date: Fri,  8 May 2026 16:09:10 +0530
Message-Id: <20260508103910.2442183-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508103910.2442183-1-sunil.khatri@amd.com>
References: <20260508103910.2442183-1-sunil.khatri@amd.com>
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

mqd and fw objects are queue core objects which should remain
valid and never be unmapped and evicted for user queues to work
properly.

During eviction if these buffers are evicted the hw continue to
use the invalid addresses and caused page faults and system hung.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 06b7b4228065..813df2d87dc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -504,16 +504,20 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_obj;
 	}
 
+	r = amdgpu_bo_pin(userq_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
+	if (r)
+		goto unresv;
+
 	r = amdgpu_ttm_alloc_gart(&(userq_obj->obj)->tbo);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc GART for userqueue object (%d)", r);
-		goto unresv;
+		goto unpin_bo;
 	}
 
 	r = amdgpu_bo_kmap(userq_obj->obj, &userq_obj->cpu_ptr);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to map BO for userqueue (%d)", r);
-		goto unresv;
+		goto unpin_bo;
 	}
 
 	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
@@ -521,11 +525,13 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
 	memset(userq_obj->cpu_ptr, 0, size);
 	return 0;
 
+unpin_bo:
+	amdgpu_bo_unpin(userq_obj->obj);
 unresv:
 	amdgpu_bo_unreserve(userq_obj->obj);
-
 free_obj:
 	amdgpu_bo_unref(&userq_obj->obj);
+
 	return r;
 }
 
@@ -533,6 +539,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_userq_obj *userq_obj)
 {
 	amdgpu_bo_kunmap(userq_obj->obj);
+	amdgpu_bo_unpin(userq_obj->obj);
 	amdgpu_bo_unref(&userq_obj->obj);
 }
 
-- 
2.34.1

