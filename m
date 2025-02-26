Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF2C021BC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 10:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA0010E178;
	Wed, 26 Feb 2025 10:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VSeQ6SFV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B0C10E160
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nGrxB+8lsviFl6u4uxkHMfrYcC9UNkNTn3sjGYxryjg=; b=VSeQ6SFVhgg4O6eqYVg2lpBhBL
 ZV4ZtPxpRBhl0yEKKKBGCE7o5nbl/Iiq4FKJEglX0YZIaWWu8uPXX3T7RY8vGfBucKAePesaTuScp
 N/XwuRcPyCu8TyuMxgudE3M4if34inqqRZYuoHMiSUsTiEkiCZ01S4snRPZLsB5a+5J3SM9BhCRrb
 Kzp6d5/ZsGEGt5i3UU2Se1AsPxMRTyS/qHpurpOMgzAnQmAja/5E7bGoDQWn/XlraJAVjKObJILxd
 738DmvtpjjAOOnDXl5Phky9iKEp7bety6I3QiNQhHPZoeQeKSV53nZPz1cKm4rwoiZE+SCXdaRy1t
 gq+hoSXg==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tnEMm-000tOO-KW; Wed, 26 Feb 2025 11:10:18 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 2/3] drm/amdgpu: Reduce holes in struct amdgpu_job
Date: Wed, 26 Feb 2025 10:10:14 +0000
Message-ID: <20250226101015.27117-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250226101015.27117-1-tvrtko.ursulin@igalia.com>
References: <20250226101015.27117-1-tvrtko.ursulin@igalia.com>
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

Lets group same width types closer together to reduce the number and size
of the holes in the struct.

Before:

        /* size: 480, cachelines: 8, members: 30 */
        /* sum members: 469, holes: 3, sum holes: 11 */
        /* forced alignments: 1 */
        /* last cacheline: 32 bytes */

After:

        /* size: 472, cachelines: 8, members: 30 */
        /* sum members: 469, holes: 1, sum holes: 3 */
        /* forced alignments: 1 */
        /* last cacheline: 24 bytes */

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index ce6b9ba967ff..7e5fe3d73a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -50,17 +50,22 @@ struct amdgpu_job {
 	struct amdgpu_sync	explicit_sync;
 	struct dma_fence	hw_fence;
 	struct dma_fence	*gang_submit;
-	uint32_t		preamble_status;
-	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
 	bool			gds_switch_needed;
 	bool			spm_update_needed;
-	uint64_t		vm_pd_addr;
+	bool			enforce_isolation;
+	bool			init_shadow;
 	unsigned		vmid;
 	unsigned		pasid;
+	uint32_t		num_ibs;
+	uint32_t		preamble_status;
+	uint32_t                preemption_status;
 	uint32_t		gds_base, gds_size;
 	uint32_t		gws_base, gws_size;
 	uint32_t		oa_base, oa_size;
+	/* job_run_counter >= 1 means a resubmit job */
+	uint32_t		job_run_counter;
+	uint64_t		vm_pd_addr;
 	uint64_t		generation;
 
 	/* user fence handling */
@@ -71,15 +76,7 @@ struct amdgpu_job {
 	uint64_t		shadow_va;
 	uint64_t		csa_va;
 	uint64_t		gds_va;
-	bool			init_shadow;
 
-	/* job_run_counter >= 1 means a resubmit job */
-	uint32_t		job_run_counter;
-
-	/* enforce isolation */
-	bool			enforce_isolation;
-
-	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
 };
 
-- 
2.48.0

