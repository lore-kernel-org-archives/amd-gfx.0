Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB25606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 06:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2A310E35A;
	Mon, 26 Oct 2026 06:57:49 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30EF210E2F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 06:57:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69Q6vdgX3299070; Mon, 26 Oct 2026 12:27:39 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69Q6vdSJ3299069;
 Mon, 26 Oct 2026 12:27:39 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 3/3] drm/amdgpu/userq: remove extra blank lines
Date: Mon, 26 Oct 2026 12:27:35 +0530
Message-Id: <20261026065735.3299011-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026065735.3299011-1-sunil.khatri@amd.com>
References: <20261026065735.3299011-1-sunil.khatri@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove extra blank lines from so many functions.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1a2aa85c504e..4b3926241f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -52,7 +52,6 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
 				enum amdgpu_ring_type ring_type, int reset_type)
 {
-
 	if (ring_type < 0 || ring_type >= AMDGPU_RING_TYPE_MAX)
 		return false;
 
@@ -304,8 +303,6 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 	return true;
 }
 
-
-
 static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
@@ -458,8 +455,6 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 	dma_fence_put(ev_fence);
 }
 
-
-
 static int
 amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 				struct amdgpu_db_info *db_info,
@@ -962,7 +957,6 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	mutex_lock(&uq_mgr->userq_mutex);
 	/* Resume all the queues for this process */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 8c696e37d971..dd976a50e053 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -457,7 +457,6 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
 		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
 		amdgpu_userq_fence_write(fence_drv, wptr);
 		amdgpu_userq_fence_driver_process(fence_drv);
-
 	}
 }
 
@@ -821,7 +820,6 @@ amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *fil
 		dma_fence_put(fence);
 		if (r)
 			goto free_fences;
-
 	}
 
 	/* Lock all the GEM objects */
-- 
2.34.1

