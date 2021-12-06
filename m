Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22402C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 21:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D48B6EA41;
	Mon,  6 Dec 2021 21:15:01 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AB16EA41;
 Mon,  6 Dec 2021 21:14:59 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A514BB815A0;
 Mon,  6 Dec 2021 21:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6DBC341C9;
 Mon,  6 Dec 2021 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638825297;
 bh=43vaTSWzCeqdaVI0fvsU4SSsHbOGCmzqdI+/gtOBR5c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iULX6Z6tQCNUtnWtgx2eTG6xZoa2Rj+lQYTZyV5EnHzR5jGXC6rBAFFFbqoSWg0Ht
 RBOPYVXvzMXOPXFzDjet7Do6CpMgAtBdVNAi4Me6u49wzdclv3EHX/hEg3h8IFcHjn
 +bwpzYJju7CjfNhCCbNsrHksdfkMhALgQw8CF0R6BuAMufp0YAUTArmOEzJeLpmsM1
 +VDnn2Op+fz7S5Q2soJ80NhU2kbpLBdVsIgacqgszUa+7TdV9TJyE2uPgWwdBtZNT/
 qWVY5bte3bzH1jgW+u0b3841Gz84tcrJztmc2xi/DQUccx+qDBEwZLYvuygs/7B7Ns
 C43OOe9WGLJ0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 20/24] drm/amdkfd: fix double free mem structure
Date: Mon,  6 Dec 2021 16:12:25 -0500
Message-Id: <20211206211230.1660072-20-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211206211230.1660072-1-sashal@kernel.org>
References: <20211206211230.1660072-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Philip Yang <Philip.Yang@amd.com>,
 airlied@linux.ie, Felix Kuehling <Felix.Kuehling@amd.com>, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 494f2e42ce4a9ddffb5d8c5b2db816425ef90397 ]

drm_gem_object_put calls release_notify callback to free the mem
structure and unreserve_mem_limit, move it down after the last access
of mem and make it conditional call.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cdf46bd0d8d5b..ab36cce59d2e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1393,7 +1393,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct sg_table *sg = NULL;
 	uint64_t user_addr = 0;
 	struct amdgpu_bo *bo;
-	struct drm_gem_object *gobj;
+	struct drm_gem_object *gobj = NULL;
 	u32 domain, alloc_domain;
 	u64 alloc_flags;
 	int ret;
@@ -1503,14 +1503,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
-	drm_gem_object_put(gobj);
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
 	unreserve_mem_limit(adev, size, alloc_domain, !!sg);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
-	kfree(*mem);
+	if (gobj)
+		drm_gem_object_put(gobj);
+	else
+		kfree(*mem);
 err:
 	if (sg) {
 		sg_free_table(sg);
-- 
2.33.0

