Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8DAD0BB7D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 09:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1488910E8D8;
	Thu, 24 Oct 2024 09:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="E5unR9N1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD6710E8DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=US1tJACMdRT4EdH4pEZ1FM0SAdWz97PmxnS6YjWdvts=; b=E5unR9N1Nq0pr5lfx1gJ188RpV
 VdCrDaohfQ/gDKwnuRkK/npR84jxQ0rcGiTYEAp+FeFYG0Z3QcXmy/nV4i2LjjlepgyqJgg3geeHh
 WVz703ZhQ3txoarc/s6nWLEcYq9RA1oibrfVmF1zXuedWtY6UihH5/hqAHGd1WjJ3CYFGf16MSmQE
 pQTZIcv6LIjTOMD9KW8NzysK94K2LRZ8Qw9BYds25wOtrhCNg5bsSyy0wRZ89Z9eJzgHIwQspgmj8
 3iC31VgTJZyE7LYsxtDuUtV333ldyTGdnNJCfqzfDgS4uIJhgdaPIpD7uxfoxB/bmY4XXWpDYhidy
 AzIQN2Ig==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1t3u4I-00ERF8-69; Thu, 24 Oct 2024 11:23:46 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Yunxiang Li <Yunxiang.Li@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: make drm-memory-* report resident memory
Date: Thu, 24 Oct 2024 10:23:38 +0100
Message-ID: <20241024092342.98760-2-tursulin@igalia.com>
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

The old behavior reports the resident memory usage for this key and the
documentation say so as well. However this was accidentally changed to
include buffers that was evicted.

Fixes: a2529f67e2ed ("drm/amdgpu: Use drm_print_memory_stats helper from fdinfo")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 00a4ab082459..8281dd45faaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -33,6 +33,7 @@
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -95,11 +96,11 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 
 	/* Legacy amdgpu keys, alias to drm-resident-memory-: */
 	drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
-		   stats[TTM_PL_VRAM].total/1024UL);
+		   stats[TTM_PL_VRAM].drm.resident/1024UL);
 	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n",
-		   stats[TTM_PL_TT].total/1024UL);
+		   stats[TTM_PL_TT].drm.resident/1024UL);
 	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n",
-		   stats[TTM_PL_SYSTEM].total/1024UL);
+		   stats[TTM_PL_SYSTEM].drm.resident/1024UL);
 
 	/* Amdgpu specific memory accounting keys: */
 	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1e6a044e3143..d41686a8e5ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1224,7 +1224,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 
 	/* DRM stats common fields: */
 
-	stats[type].total += size;
 	if (drm_gem_object_is_shared_for_memory_stats(obj))
 		stats[type].drm.shared += size;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 7260349917ef..a5653f474f85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -142,7 +142,6 @@ struct amdgpu_bo_vm {
 struct amdgpu_mem_stats {
 	struct drm_memory_stats drm;
 
-	uint64_t total;
 	uint64_t visible;
 	uint64_t evicted;
 	uint64_t evicted_visible;
-- 
2.46.0

