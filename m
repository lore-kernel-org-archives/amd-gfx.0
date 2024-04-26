Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D105C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 16:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FF310F6AC;
	Fri, 26 Apr 2024 16:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nnKigo0/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A96510F90F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lQKai9fdpJTjfmIAibQCS1lyHpZaTO5Z8T8woftoyOA=; b=nnKigo0/qAh5oZgCAcRjOe82Wn
 I2dHEF3vvgbLwXCErq80w4FkT/M0frKboRx30GakhQbltSpkY65wnI+CMnhWjCcLTw1iKX+7JsO7+
 apzrC8FBbt7nznw33BRnV0pRYSc70MA6VNV2HMPMk9rWRkPGbTblGx9CiXA/gG1z+L/0SR2fztWKq
 WOTiRVh+Dy0AwwLSTgRY/w6SZoaKIvycZAKNxgq2gxlT5lLq2DoZlhwUrL/sQZ9kwUIsaGiFQwEaq
 WpOEYeeBL89+VAT1G3OEY8dcrSSsQmydyluoBoI88utJpANZtLDxsv82F4vffyFEYu4DbMI5kDtOT
 5rCW1x7g==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s0OgP-000CGp-K0; Fri, 26 Apr 2024 18:44:21 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 2/3] drm/amdgpu: Reduce mem_type to domain double indirection
Date: Fri, 26 Apr 2024 17:43:54 +0100
Message-ID: <20240426164355.1563-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426164355.1563-1-tursulin@igalia.com>
References: <20240426164355.1563-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

All apart from AMDGPU_GEM_DOMAIN_GTT memory domains map 1:1 to TTM
placements. And the former be either AMDGPU_PL_PREEMPT or TTM_PL_TT,
depending on AMDGPU_GEM_CREATE_PREEMPTIBLE.

Simplify a few places in the code which convert the TTM placement into
a domain by checking against the current placement directly.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 30 ++++++++++-----------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 055ba2ea4c12..ff83f8d8628c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -165,8 +165,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		if (r)
 			return ERR_PTR(r);
 
-	} else if (!(amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) &
-		     AMDGPU_GEM_DOMAIN_GTT)) {
+	} else if (bo->tbo.resource->mem_type != TTM_PL_TT &&
+		   bo->tbo.resource->mem_type != AMDGPU_PL_PREEMPT) {
 		return ERR_PTR(-EBUSY);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8bc79924d171..fb984669fc3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -976,12 +976,12 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 
 	ttm_bo_pin(&bo->tbo);
 
-	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
-	if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
+	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
 		atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
 		atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
 			     &adev->visible_pin_size);
-	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
+	} else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
+		   bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
 		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
 	}
 
@@ -1280,7 +1280,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 {
 	uint64_t size = amdgpu_bo_size(bo);
 	struct drm_gem_object *obj;
-	unsigned int domain;
 	bool shared;
 
 	/* Abort if the BO doesn't currently have a backing store */
@@ -1290,21 +1289,21 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 	obj = &bo->tbo.base;
 	shared = drm_gem_object_is_shared_for_memory_stats(obj);
 
-	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
-	switch (domain) {
-	case AMDGPU_GEM_DOMAIN_VRAM:
+	switch (bo->tbo.resource->mem_type) {
+	case TTM_PL_VRAM:
 		stats->vram += size;
 		if (amdgpu_bo_in_cpu_visible_vram(bo))
 			stats->visible_vram += size;
 		if (shared)
 			stats->vram_shared += size;
 		break;
-	case AMDGPU_GEM_DOMAIN_GTT:
+	case TTM_PL_TT:
+	case AMDGPU_PL_PREEMPT:
 		stats->gtt += size;
 		if (shared)
 			stats->gtt_shared += size;
 		break;
-	case AMDGPU_GEM_DOMAIN_CPU:
+	case TTM_PL_SYSTEM:
 	default:
 		stats->cpu += size;
 		if (shared)
@@ -1317,7 +1316,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 			stats->requested_visible_vram += size;
 
-		if (domain != AMDGPU_GEM_DOMAIN_VRAM) {
+		if (bo->tbo.resource->mem_type != TTM_PL_VRAM) {
 			stats->evicted_vram += size;
 			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 				stats->evicted_visible_vram += size;
@@ -1592,19 +1591,18 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	u64 size;
 
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
-		unsigned int domain;
-		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
-		switch (domain) {
-		case AMDGPU_GEM_DOMAIN_VRAM:
+		switch (bo->tbo.resource->mem_type) {
+		case TTM_PL_VRAM:
 			if (amdgpu_bo_in_cpu_visible_vram(bo))
 				placement = "VRAM VISIBLE";
 			else
 				placement = "VRAM";
 			break;
-		case AMDGPU_GEM_DOMAIN_GTT:
+		case TTM_PL_TT:
+		case AMDGPU_PL_PREEMPT:
 			placement = "GTT";
 			break;
-		case AMDGPU_GEM_DOMAIN_CPU:
+		case TTM_PL_SYSTEM:
 		default:
 			placement = "CPU";
 			break;
-- 
2.44.0

