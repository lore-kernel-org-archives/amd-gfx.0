Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A21BCD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 07:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7571112AD2;
	Fri,  5 Jun 2026 07:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a53XU4z1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A1410E5EE;
 Thu,  4 Jun 2026 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566651; x=1812102651;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Jza6mxy5CFobueQBU5MXCjifhlqHrSL/hJl4KW3I3GE=;
 b=a53XU4z1jyPiSGFgfWVVJLDbqxWP65x0gS4RjEJPx1RhViBXSQUT/7Xl
 LrKqogeuCi5vb58jwV8WvSUr3ObPFBZ5msu+58A4+r0OE52zM5UU1+Sy/
 bhI6zDQSrUVfPkBxEOQ931wA7yvYGEfqGRCjy256sjj4uI+ne6zvRuPHj
 FQG5nZ2d7a1kl2uwjkpTOosFADdRQmjY7SyFy8eJQ1/T3TG06jO8aIMOw
 jcW50PEACUf4CSaczJtkRbC8GTuT6aIrcruCykxzTQw0yMddAIAQ5Ez9+
 X+LqTrPdYvwfULv8hoGo8y6t1n7lJvOi8p6oqNn4gg18yIDYqWS1ExkX0 g==;
X-CSE-ConnectionGUID: LWKG/cu+THKkNDo+hhYV/w==
X-CSE-MsgGUID: tBfzAnzvS+681dSkR+NebQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92876472"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="92876472"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:51 -0700
X-CSE-ConnectionGUID: nbYgU2gvQtKiXV+nwwsq0A==
X-CSE-MsgGUID: EzyxdFuAR4CpVCD/9AcPXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="249423464"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
 by orviesa005.jf.intel.com with ESMTP; 04 Jun 2026 02:50:49 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Nitin Gote <nitin.r.gote@intel.com>,
 stable@vger.kernel.org, Christian Konig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/amdgpu: Fix UAF in amdgpu_gem_prime_import() on attach
 failure
Date: Thu,  4 Jun 2026 15:56:37 +0530
Message-ID: <20260604102636.1816829-2-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Jun 2026 07:35:12 +0000
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

amdgpu_dma_buf_create_obj() creates the importer BO with obj->resv
pointing at the exporter's dma_buf->resv. If dma_buf_dynamic_attach()
fails, no dma_buf reference is held and the exporter can be freed
before ttm_bo_delayed_delete() runs, causing a UAF on dma_resv_lock().

Switch obj->resv to the BO's private _resv under lru_lock before
dropping the last reference, mirroring ttm_bo_individualize_resv().
The BO carries no fences and is not yet visible to other users, so
the switch is safe.

This is the amdgpu counterpart to the xe fix:
  ("drm/xe: Fix UAF in xe_gem_prime_import() on attach failure")

Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Cc: stable@vger.kernel.org # v6.8+
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
Hi,
This is the amdgpu counterpart to the xe fix:
  ("drm/xe: Fix UAF in xe_gem_prime_import() on attach failure")
  https://patchwork.freedesktop.org/series/167647/
- Nitin

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..6a24cf2e3666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -568,6 +568,16 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
 					&amdgpu_dma_buf_attach_ops, obj);
 	if (IS_ERR(attach)) {
+		/*
+		 * Attach failed with no dma_buf ref held; switch resv to the BO's
+		 * private _resv under lru_lock before the last put, so
+		 * ttm_bo_delayed_delete() doesn't dereference the stale exporter
+		 * resv.
+		 */
+		spin_lock(&gem_to_amdgpu_bo(obj)->tbo.bdev->lru_lock);
+		obj->resv = &obj->_resv;
+		spin_unlock(&gem_to_amdgpu_bo(obj)->tbo.bdev->lru_lock);
+
 		drm_gem_object_put(obj);
 		return ERR_CAST(attach);
 	}
-- 
2.50.1

