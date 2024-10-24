Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C99BD0BB7E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 09:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C16D10E8DD;
	Thu, 24 Oct 2024 09:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CJpM5Nha";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DBF10E8DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 09:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GsNN/vFPo6ZLJKa8uD9lSOvAhMZGql8jehNxH5r5rW0=; b=CJpM5NhaLYt4xjD6Slo4fx6/Hx
 IUN3zWD+13fR1/fh5BzIgryBbR/0WvgggtQq1IJVQsZowGAc6mfOaJDcqAKbdui3IWsRiKsewdScN
 MfmNUdL+9lPOJ3TwY6bgVlrq4yylu5W07VdYBi1W+Z9eYfPgRD58PYwPaptLdW8+dn4moKOmi5NrX
 YH2sEIMk6tdWrVckpbNMJqDjxK6mzhgSv+DNIOAzwk7HUpKhc2Y7euBrBqRY2IGZqKNvtrXeb2u03
 abnG9DnMyAHoUh0AMPyoFXVebkVlrXqVXoHSapQtumADCdxpnxsHvgIPK8hArpXkD3PwP1ydHYtLp
 g/5VHHWA==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1t3u4I-00ERFE-St; Thu, 24 Oct 2024 11:23:46 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Yunxiang Li <Yunxiang.Li@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 2/4] drm/amdgpu: stop tracking visible memory stats
Date: Thu, 24 Oct 2024 10:23:39 +0100
Message-ID: <20241024092342.98760-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241024092342.98760-1-tursulin@igalia.com>
References: <20241024092342.98760-1-tursulin@igalia.com>
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

From: Yunxiang Li <Yunxiang.Li@amd.com>

Since on modern systems all of vram can be made visible anyways, to
simplify the new implementation, drops tracking how much memory is
visible for now. If this is really needed we can add it back on top of
the new implementation, or just report all the BOs as visible.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 ++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 10 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 11 ++++++++++-
 4 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 8281dd45faaa..7a9573958d87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -103,16 +103,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		   stats[TTM_PL_SYSTEM].drm.resident/1024UL);
 
 	/* Amdgpu specific memory accounting keys: */
-	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
-		   stats[TTM_PL_VRAM].visible/1024UL);
 	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
 		   stats[TTM_PL_VRAM].evicted/1024UL);
-	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
-		   stats[TTM_PL_VRAM].evicted_visible/1024UL);
 	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
 		   stats[TTM_PL_VRAM].requested/1024UL);
-	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
-		   stats[TTM_PL_VRAM].requested_visible/1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
 		   stats[TTM_PL_TT].requested/1024UL);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d41686a8e5ec..0d3fb6b4212e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -40,6 +40,7 @@
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_vram_mgr.h"
+#include "amdgpu_vm.h"
 
 /**
  * DOC: amdgpu_object
@@ -1236,23 +1237,14 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			stats[type].drm.active += size;
 		else if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
 			stats[type].drm.purgeable += size;
-
-		if (type == TTM_PL_VRAM && amdgpu_res_cpu_visible(adev, res))
-			stats[type].visible += size;
 	}
 
 	/* amdgpu specific stats: */
 
 	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
 		stats[TTM_PL_VRAM].requested += size;
-		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-			stats[TTM_PL_VRAM].requested_visible += size;
-
-		if (type != TTM_PL_VRAM) {
+		if (type != TTM_PL_VRAM)
 			stats[TTM_PL_VRAM].evicted += size;
-			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-				stats[TTM_PL_VRAM].evicted_visible += size;
-		}
 	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
 		stats[TTM_PL_TT].requested += size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index a5653f474f85..be6769852ece 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -139,16 +139,6 @@ struct amdgpu_bo_vm {
 	struct amdgpu_vm_bo_base        entries[];
 };
 
-struct amdgpu_mem_stats {
-	struct drm_memory_stats drm;
-
-	uint64_t visible;
-	uint64_t evicted;
-	uint64_t evicted_visible;
-	uint64_t requested;
-	uint64_t requested_visible;
-};
-
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
 {
 	return container_of(tbo, struct amdgpu_bo, tbo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index c5b41e3ed14f..5d119ac26c4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -42,7 +42,6 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
-struct amdgpu_mem_stats;
 
 /*
  * GPUVM handling
@@ -322,6 +321,16 @@ struct amdgpu_vm_fault_info {
 	unsigned int	vmhub;
 };
 
+struct amdgpu_mem_stats {
+	struct drm_memory_stats drm;
+
+	/* buffers that requested this placement */
+	uint64_t requested;
+	/* buffers that requested this placement
+	 * but are currently evicted */
+	uint64_t evicted;
+};
+
 struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
-- 
2.46.0

