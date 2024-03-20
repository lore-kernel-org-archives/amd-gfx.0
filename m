Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A14C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 17:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F1310E362;
	Wed, 20 Mar 2024 17:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="H9I1vSdV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6CB10E362
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0E2bDt9rUppJ8qCd/rU5mIYpdU0XdpgU3LtH6lO0XBw=; b=H9I1vSdVxNDXOwU5oER1ew6zkl
 ihGxtbQFygmDFqnC/6EEu3EM9H4w8Ue3cLLP5oPQbP7ZRVKaz0pIqxUyobF75zVPgreZGyglTo2Sr
 sgcuyifVNINvGipO/K8cnqb+4Mnd9HZ5xfrjydXf7h7FIzJv7VyJ+H6bBCI/DT7zwm3W6jUP6BzsE
 qcCfuATrnmQJZ0IzYX9BRA0Ky/Ir40MoT/KfkJFo2Fl1j2zK70XvDnXksci+x2KU9IpJo5Gime2GV
 lhlTXMbXd1k8S7XsSeVVFVt4tCNtTxtDjCTRlGkEQIpCfXSeZX67415qgYwPOHKKZeFFGBApkJPqE
 cbd0MBZQ==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rmzUB-00D2FO-GU; Wed, 20 Mar 2024 18:12:19 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Beyond Wang <Wang.Beyond@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix use after free in trace_amdgpu_bo_move
Date: Wed, 20 Mar 2024 17:12:16 +0000
Message-ID: <20240320171216.48248-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320144038.46706-1-tursulin@igalia.com>
References: <20240320144038.46706-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tursulin@ursulin.net>

Pipelined object migration will free up the old bo->resource, meaning
the tracepoint added in 94aeb4117343 ("drm/amdgpu: fix ftrace event
amdgpu_bo_move always move on same heap") will trigger an use after free
when it dereferences the cached old_mem.

Fix it by caching the memory type locally, which is the only thing
tracepoint wants to know about.

While at it convert the whole function to use the cached memory types for
consistency.

v2:
 * Fix compilation.

Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171
Cc: Beyond Wang <Wang.Beyond@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
Beware this is a speculative fix for now based only on source code
analysis and backtraces from 3171. It is also a bit on the churny side so
I am happy to minimize it. But most importantly, given how I don't have
any experience in amdgpu, I am looking for domain experts to either
confirm or disprove my analysis.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 47 ++++++++++++-------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8722beba494e..81189aab5a04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -452,10 +452,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	struct amdgpu_device *adev;
 	struct amdgpu_bo *abo;
 	struct ttm_resource *old_mem = bo->resource;
+	uint32_t new_mem_type = new_mem->mem_type;
+	uint32_t old_mem_type;
 	int r;
 
-	if (new_mem->mem_type == TTM_PL_TT ||
-	    new_mem->mem_type == AMDGPU_PL_PREEMPT) {
+	if (new_mem_type == TTM_PL_TT || new_mem_type == AMDGPU_PL_PREEMPT) {
 		r = amdgpu_ttm_backend_bind(bo->bdev, bo->ttm, new_mem);
 		if (r)
 			return r;
@@ -464,20 +465,18 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	abo = ttm_to_amdgpu_bo(bo);
 	adev = amdgpu_ttm_adev(bo->bdev);
 
-	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
-			 bo->ttm == NULL)) {
+	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM && bo->ttm == NULL)) {
 		ttm_bo_move_null(bo, new_mem);
 		goto out;
 	}
-	if (old_mem->mem_type == TTM_PL_SYSTEM &&
-	    (new_mem->mem_type == TTM_PL_TT ||
-	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+	old_mem_type = old_mem->mem_type;
+	if (old_mem_type == TTM_PL_SYSTEM &&
+	    (new_mem_type == TTM_PL_TT || new_mem_type == AMDGPU_PL_PREEMPT)) {
 		ttm_bo_move_null(bo, new_mem);
 		goto out;
 	}
-	if ((old_mem->mem_type == TTM_PL_TT ||
-	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
-	    new_mem->mem_type == TTM_PL_SYSTEM) {
+	if ((old_mem_type == TTM_PL_TT || old_mem_type == AMDGPU_PL_PREEMPT) &&
+	    new_mem_type == TTM_PL_SYSTEM) {
 		r = ttm_bo_wait_ctx(bo, ctx);
 		if (r)
 			return r;
@@ -488,22 +487,22 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		goto out;
 	}
 
-	if (old_mem->mem_type == AMDGPU_PL_GDS ||
-	    old_mem->mem_type == AMDGPU_PL_GWS ||
-	    old_mem->mem_type == AMDGPU_PL_OA ||
-	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
-	    new_mem->mem_type == AMDGPU_PL_GDS ||
-	    new_mem->mem_type == AMDGPU_PL_GWS ||
-	    new_mem->mem_type == AMDGPU_PL_OA ||
-	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
+	if (old_mem_type == AMDGPU_PL_GDS ||
+	    old_mem_type == AMDGPU_PL_GWS ||
+	    old_mem_type == AMDGPU_PL_OA ||
+	    old_mem_type == AMDGPU_PL_DOORBELL ||
+	    new_mem_type == AMDGPU_PL_GDS ||
+	    new_mem_type == AMDGPU_PL_GWS ||
+	    new_mem_type == AMDGPU_PL_OA ||
+	    new_mem_type == AMDGPU_PL_DOORBELL) {
 		/* Nothing to save here */
 		ttm_bo_move_null(bo, new_mem);
 		goto out;
 	}
 
 	if (bo->type == ttm_bo_type_device &&
-	    new_mem->mem_type == TTM_PL_VRAM &&
-	    old_mem->mem_type != TTM_PL_VRAM) {
+	    new_mem_type == TTM_PL_VRAM &&
+	    old_mem_type != TTM_PL_VRAM) {
 		/* amdgpu_bo_fault_reserve_notify will re-set this if the CPU
 		 * accesses the BO after it's moved.
 		 */
@@ -511,10 +510,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	}
 
 	if (adev->mman.buffer_funcs_enabled) {
-		if (((old_mem->mem_type == TTM_PL_SYSTEM &&
-		      new_mem->mem_type == TTM_PL_VRAM) ||
-		     (old_mem->mem_type == TTM_PL_VRAM &&
-		      new_mem->mem_type == TTM_PL_SYSTEM))) {
+		if (((old_mem_type == TTM_PL_SYSTEM && new_mem_type == TTM_PL_VRAM) ||
+		     (old_mem_type == TTM_PL_VRAM && new_mem_type == TTM_PL_SYSTEM))) {
 			hop->fpfn = 0;
 			hop->lpfn = 0;
 			hop->mem_type = TTM_PL_TT;
@@ -540,7 +537,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 	}
 
-	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
+	trace_amdgpu_bo_move(abo, new_mem_type, old_mem_type);
 out:
 	/* update statistics */
 	atomic64_add(bo->base.size, &adev->num_bytes_moved);
-- 
2.44.0

