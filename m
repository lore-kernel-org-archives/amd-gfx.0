Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9B8CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 06:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C1610EA83;
	Tue, 19 May 2026 06:21:18 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E11210EA82
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:21:16 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64J6LBxZ440793; Tue, 19 May 2026 11:51:11 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64J6LB6d440761;
 Tue, 19 May 2026 11:51:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 6/9] drm/amdgpu/userq: add amdgpu_bo_unpin when
 amdgpu_ttm_alloc_gart fails
Date: Tue, 19 May 2026 11:51:04 +0530
Message-Id: <20260519062107.438653-7-sunil.khatri@amd.com>
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

Unping the wptr_obj->obj when amdgpu_ttm_alloc_gart fails.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 14db2124ff81..2d95203ec58e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -81,7 +81,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 	ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
 	if (ret) {
 		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
-		goto fail_map;
+		goto fail_alloc_gart;
 	}
 
 	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
@@ -89,6 +89,8 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 	drm_exec_fini(&exec);
 	return 0;
 
+fail_alloc_gart:
+	amdgpu_bo_unpin(wptr_obj->obj);
 fail_map:
 	amdgpu_bo_unref(&wptr_obj->obj);
 fail_lock:
-- 
2.34.1

