Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88326C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 17:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA3C112D69;
	Tue, 30 Apr 2024 17:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bYXwsKhs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386AF112D56
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mbv4pEmjVcMzg54iJpr6JvH+RErOBDwdIkJ4UHrmXHw=; b=bYXwsKhsAy3pAe4e3pZ0XNlaGF
 PTH+W57zBa+5ktbHgf+rljcMDqzOwldrFG8dVxHlGwGxUZ16NakppevN8sqE/WjaQlVaXbvFk/J7n
 t+6ZfnX89OHmtwOOxt03QYoK2I3kGnC56B2vA3cKBQbzQu6ZDOVfc+nKW2EWuJ2I66boMd7wBYEaP
 xqEXoLGbd7AmzoSUUFuD/ZBxAmXN+aiJE8N24BQ8aenuTR9qL7U7u2/ihda+eLQmx4CvlN98AJk14
 1wXPiy+hslLk+KL3kqD4giyAEtudbP5XXymHTQGOx3DZnkSfuYoiSLDV+DfTU4YSQmbTMF50kRzvm
 Kop2a2Zw==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s1r5q-001sCB-TC; Tue, 30 Apr 2024 19:16:38 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: Reduce mem_type to domain double
 indirection
Date: Tue, 30 Apr 2024 18:16:36 +0100
Message-ID: <20240430171636.61526-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429164707.49196-2-tursulin@igalia.com>
References: <20240429164707.49196-2-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

All apart from AMDGPU_GEM_DOMAIN_GTT memory domains map 1:1 to TTM
placements. And the former be either AMDGPU_PL_PREEMPT or TTM_PL_TT,
depending on AMDGPU_GEM_CREATE_PREEMPTIBLE.

Simplify a few places in the code which convert the TTM placement into
a domain by checking against the current placement directly.

In the conversion AMDGPU_PL_PREEMPT either does not have to be handled
because amdgpu_mem_type_to_domain() cannot return that value anyway.

v2:
 * Remove AMDGPU_PL_PREEMPT handling.

v3:
 * Rebase.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com> # v1
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com> # v2
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 29 +++++++++------------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 055ba2ea4c12..0b3b10d21952 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -165,8 +165,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		if (r)
 			return ERR_PTR(r);
 
-	} else if (!(amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) &
-		     AMDGPU_GEM_DOMAIN_GTT)) {
+	} else if (bo->tbo.resource->mem_type != TTM_PL_TT) {
 		return ERR_PTR(-EBUSY);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b2a83c802bbd..c581e4952cbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -983,12 +983,11 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 
 	ttm_bo_pin(&bo->tbo);
 
-	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
-	if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
+	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
 		atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
 		atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
 			     &adev->visible_pin_size);
-	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
+	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
 		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
 	}
 
@@ -1289,7 +1288,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 	struct ttm_resource *res = bo->tbo.resource;
 	uint64_t size = amdgpu_bo_size(bo);
 	struct drm_gem_object *obj;
-	unsigned int domain;
 	bool shared;
 
 	/* Abort if the BO doesn't currently have a backing store */
@@ -1299,21 +1297,20 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 	obj = &bo->tbo.base;
 	shared = drm_gem_object_is_shared_for_memory_stats(obj);
 
-	domain = amdgpu_mem_type_to_domain(res->mem_type);
-	switch (domain) {
-	case AMDGPU_GEM_DOMAIN_VRAM:
+	switch (res->mem_type) {
+	case TTM_PL_VRAM:
 		stats->vram += size;
-		if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
+		if (amdgpu_res_cpu_visible(adev, res))
 			stats->visible_vram += size;
 		if (shared)
 			stats->vram_shared += size;
 		break;
-	case AMDGPU_GEM_DOMAIN_GTT:
+	case TTM_PL_TT:
 		stats->gtt += size;
 		if (shared)
 			stats->gtt_shared += size;
 		break;
-	case AMDGPU_GEM_DOMAIN_CPU:
+	case TTM_PL_SYSTEM:
 	default:
 		stats->cpu += size;
 		if (shared)
@@ -1326,7 +1323,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 			stats->requested_visible_vram += size;
 
-		if (domain != AMDGPU_GEM_DOMAIN_VRAM) {
+		if (res->mem_type != TTM_PL_VRAM) {
 			stats->evicted_vram += size;
 			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 				stats->evicted_visible_vram += size;
@@ -1600,20 +1597,18 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	u64 size;
 
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
-		unsigned int domain;
 
-		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
-		switch (domain) {
-		case AMDGPU_GEM_DOMAIN_VRAM:
+		switch (bo->tbo.resource->mem_type) {
+		case TTM_PL_VRAM:
 			if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 				placement = "VRAM VISIBLE";
 			else
 				placement = "VRAM";
 			break;
-		case AMDGPU_GEM_DOMAIN_GTT:
+		case TTM_PL_TT:
 			placement = "GTT";
 			break;
-		case AMDGPU_GEM_DOMAIN_CPU:
+		case TTM_PL_SYSTEM:
 		default:
 			placement = "CPU";
 			break;
-- 
2.44.0

