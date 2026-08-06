Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43121C56208
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7C010F1D7;
	Thu,  6 Aug 2026 13:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jJ39B9Y0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FF210F1C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=MLBa0cs4ZYEUV9+MiBhDtK6z0C+wbFgwBwAhgWXCpeA=; b=jJ39B9Y0qAbAuUTFZC29F+yUJT
 dIM/VN9/CqNFLqq/qtBfCDSjIkglGm71WOq7GgCV+QHYveAKKUMpeFs6I4k+LDmTobGstOUNMJJAm
 qdHUYHBU+0dbSd3NWDKSMd1+4moONIPEQAlNyQRUJhc2zm3Xr3M5GAZJlrgls5qH2yUXYDlQhsaMg
 g9MiFcAJED3uI/E2O6SLEQhBGhXqtGtSDCJ0jbB1HRt6vLnfhWAYg+4YdPfgKJ1iPkVlcVdyk8OCG
 HAbSeD8P1M7RwIy6qYjDdyJaUaWxijP23gWN08t1CQ7vLqDcg/Tf3s+m/zt+ycZ1fI6SbsRjP3xI3
 ikex1hUw==;
Received: from [83.105.121.4] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wryRP-00Ewqo-Fy; Thu, 06 Aug 2026 15:47:23 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 3/7] drm/amdgpu: Extend amdgpu_ttm_tt_get_userptr() to
 return flags
Date: Thu,  6 Aug 2026 14:47:08 +0100
Message-ID: <20260806134712.91816-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806134712.91816-1-tvrtko.ursulin@igalia.com>
References: <20260806134712.91816-1-tvrtko.ursulin@igalia.com>
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

Extend amdgpu_ttm_tt_get_userptr() to also return userptr creation flags
so those can be queried from a subsequent patch.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 1dd15b556d68..deaae26fe982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1311,10 +1311,11 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
  * task
  *
  * @tbo: The ttm_buffer_object that contains the userptr
- * @user_addr:  The returned value
+ * @user_addr: Returned userptr address
+ * @user_flags: Returned userptr flags
  */
 int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
-			      uint64_t *user_addr)
+			      uint64_t *user_addr, uint32_t *user_flags)
 {
 	struct amdgpu_ttm_tt *gtt;
 
@@ -1323,6 +1324,7 @@ int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
 
 	gtt = (void *)tbo->ttm;
 	*user_addr = gtt->userptr;
+	*user_flags = gtt->userflags;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index a47a6eae6713..82f3b9fdfe83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -247,7 +247,7 @@ static inline u64 amdgpu_gtt_node_to_byte_offset(const struct drm_mm_node *gtt_n
 
 void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *range);
 int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
-			      uint64_t *user_addr);
+			      uint64_t *user_addr, uint32_t *user_flags);
 int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 			      uint64_t addr, uint32_t flags);
 bool amdgpu_ttm_tt_has_userptr(struct ttm_tt *ttm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 309510e23315..a6ed8efb4927 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2071,6 +2071,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 			struct kfd_criu_bo_bucket *bo_bucket;
 			struct kfd_criu_bo_priv_data *bo_priv;
 			int i, dev_idx = 0;
+			u32 user_flags;
 
 			kgd_mem = (struct kgd_mem *)mem;
 			dumper_bo = kgd_mem->bo;
@@ -2093,7 +2094,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 
 			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 				ret = amdgpu_ttm_tt_get_userptr(&dumper_bo->tbo,
-								&bo_priv->user_addr);
+								&bo_priv->user_addr,
+								&user_flags);
 				if (ret) {
 					pr_err("Failed to obtain user address for user-pointer bo\n");
 					goto exit;
-- 
2.54.0

