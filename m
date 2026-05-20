Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A836CD5BAB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 02:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4128610EEC9;
	Wed, 20 May 2026 02:53:23 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC28810E053
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 02:53:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64K2rA8N1866877; Wed, 20 May 2026 08:23:10 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64K2rAtu1866876;
 Wed, 20 May 2026 08:23:10 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/userq: use amdgpu_userq_destroy_object for
 db_obj
Date: Wed, 20 May 2026 08:22:58 +0530
Message-Id: <20260520025258.1866776-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520025258.1866776-1-sunil.khatri@amd.com>
References: <20260520025258.1866776-1-sunil.khatri@amd.com>
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

Use amdgpu_userq_destroy_object to clean up the db_obj
if there is failure during queue creation.

Also amdgpu_userq_destroy_object also does kunmap but that
should be fine for the objects which are not kmapped too as
there is a check in amdgpu_bo_kunmap for not kmapped objects
and skip it.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7b86b70129af..551c49a4bf38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -827,10 +827,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 clean_mqd:
 	uq_funcs->mqd_destroy(queue);
 clean_doorbell_bo:
-	amdgpu_bo_reserve(queue->db_obj.obj, true);
-	amdgpu_bo_unpin(queue->db_obj.obj);
-	amdgpu_bo_unreserve(queue->db_obj.obj);
-	amdgpu_bo_unref(&queue->db_obj.obj);
+	amdgpu_userq_destroy_object(&queue->db_obj);
 clean_mapping:
 	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
-- 
2.34.1

