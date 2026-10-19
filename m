Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C849CCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F9F10ECF1;
	Mon, 19 Oct 2026 13:02:25 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3515E10E9BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=qaVSoBsRBV3o1DJiU0VgNJOaDV08jgxyFXsRS2HtxaM=; b=QjdQpg+EHEKEb2UBUIfngXSrZo
 2tR8DFjpx3+sg7JQc94wdFUuopP2IkM7OpvwFhuaCe+5sA1wtpWNXTmtHLzA1kNZPUCztwyKa3qSr
 kUt5HuEm8hQGDWHcr6M3RD/tNzVNrXv9d5rJbjpT6rkCqL25c1/N3+5VpVuVcH95xDD7oJsCfjR6d
 P9q0MnNbtM1cJ9itZwf5b+lbpiMd9uj95HadgQbCjHnCg3Bau9cTktfWv3R/F5cBrvBuVz771C29V
 X6AVUQetaaU+7MWB99W/a2yHvr6nzrlgp41JjRB6Is98ROqye8LQK6YxCY1i+dDMm6098Bh7j9Z36
 5SWWCYvw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xIn0I-003UKS-8q; Mon, 19 Oct 2026 15:02:14 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 2/7] drm/amdgpu: Move amdgpu_ttm_tt_is_userptr() under
 conditional compilation
Date: Mon, 19 Oct 2026 14:01:54 +0100
Message-ID: <20261019130159.11739-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
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

If userptr support is not compiled in there is no point to emit an out of
line function and respective calls which always returns false. Move the
declaration and implementation to the the already present conditional blocks.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  7 ++++++-
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8acb12da6e8b..cebeabd0ee72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -802,6 +802,19 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 	return r;
 }
 
+/*
+ * amdgpu_ttm_tt_is_userptr - Have the pages backing by userptr?
+ */
+bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
+{
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
+
+	if (gtt == NULL || !gtt->usertask)
+		return false;
+
+	return true;
+}
+
 #endif
 
 /*
@@ -1409,19 +1422,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 	return true;
 }
 
-/*
- * amdgpu_ttm_tt_is_userptr - Have the pages backing by userptr?
- */
-bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
-{
-	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
-
-	if (gtt == NULL || !gtt->usertask)
-		return false;
-
-	return true;
-}
-
 /*
  * amdgpu_ttm_tt_is_readonly - Is the ttm_tt object read only?
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index adb6cfae5052..8d14d8a5c25c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -213,12 +213,18 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 				 struct amdgpu_hmm_range *range);
+bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
 #else
 static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 					       struct amdgpu_hmm_range *range)
 {
 	return -EPERM;
 }
+
+static inline bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
+{
+	return false;
+}
 #endif
 
 /**
@@ -253,7 +259,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 				  unsigned long end, unsigned long *userptr);
 bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
 				       int *last_invalidated);
-bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
 bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
 uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
 uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
-- 
2.56.0

