Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A953EC021A6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D9110E2C4;
	Mon, 24 Feb 2025 13:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EeoIbI4F";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9392A10E372
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nGrxB+8lsviFl6u4uxkHMfrYcC9UNkNTn3sjGYxryjg=; b=EeoIbI4FcWqz2gPWvZM9zwD6ev
 gcZH1zqBsWnW+UrMe7td7IZwNqIRLY8XRpjIZJw/ngieXN9N9mLEQMDOHV+v2Eb/eiBbHkf2bA1y/
 KEH5hWNZgfkvOLPrWoEM+kcigFIt19XGH+tFzvmQdqRxlTYblBsokmz9zGAsKPQoWWTSCGDJFNjsA
 vM2cbllRTO4vrqzZQ5/y5QuwZ0rP2CZyvbX1pN2rBKPRHxj96xjDRDcnNx+0CHBpyvvP/ZLSDGguo
 tbBCZ6ibpj65dgefgOLOUd8JlV7VtfBZ5tedkWt7mlIso+F5xNXVUSQ2jjJ7SoDPD5SDhkBuZZ4dP
 KDPKY6HQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tmXEh-00HTAo-0U; Mon, 24 Feb 2025 13:07:04 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 2/2] drm/amdgpu: Reduce holes in struct amdgpu_job
Date: Mon, 24 Feb 2025 12:06:44 +0000
Message-ID: <20250224120644.40148-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250224120644.40148-1-tvrtko.ursulin@igalia.com>
References: <20250224120644.40148-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Feb 2025 13:35:11 +0000
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

