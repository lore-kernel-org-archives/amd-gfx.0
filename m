Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94447CCF2E6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2989310ECB3;
	Mon, 19 Oct 2026 13:02:25 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7A110ECF1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=I23yKdrq41A1nk7AW2LLMhWKyul7+XfcLjjn7B9q9Ak=; b=
 LINEWijzEk/3acDQ8TX5twbYvy6NwM7Of2SPTn+E622cxnNLbZZ2zm3vZceW23uj9DYUujehqUpVw
 tTsLPcP3N4QJcYqSeN5hwE/K9ZnwYwGZjekXVRBYo07cPzyjxUE55cUFrLffcyzR3FpbDf7+gmnWC
 YDQ0mKp3MZYUX21BXv67WaXfQTTbUb/jldRBZBopFac6ZK6b8z0vFgBiEKkXpXFg08fIQdJfz+1Pu
 XdE2NqK3TDK2ki8/EUuF4iZSaIFa/Vz3o/ISYf9yVeCigJ86XlV2jBhLj3qOWmor/SARdloDJYHq9
 T3kJcKjVzaVr+dkrsv0RaxWZKxIEl1CByg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xIn0J-003UKg-LQ; Mon, 19 Oct 2026 15:02:15 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 4/7] drm/amdgpu: Extend listing of buffer handles with the
 userptr object flag
Date: Mon, 19 Oct 2026 14:01:56 +0100
Message-ID: <20261019130159.11739-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
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

Add a new flag (AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR) to the
DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS ioctl.

This is required to allow for checkpoint and restore of userptr objects.

The existing struct drm_amdgpu_gem_list_handles_entry is used with the
userptr creation flags places in alloc_flags, while the alignment field
contains the userspace address.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++------
 include/uapi/drm/amdgpu_drm.h           | 14 ++++++++++----
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 385be1e0944c..e3d3e205a4fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1267,14 +1267,23 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 
 		bo_entry = &bo_entries[bo_index];
 
-		bo_entry->size = amdgpu_bo_size(bo);
-		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
-		bo_entry->preferred_domains = bo->preferred_domains;
 		bo_entry->gem_handle = id;
-		bo_entry->alignment = (u64)bo->tbo.page_alignment << PAGE_SHIFT;
+		bo_entry->size = amdgpu_bo_size(bo);
+		if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
+			u32 flags;
 
-		if (bo->tbo.base.import_attach)
-			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
+			bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR;
+			amdgpu_ttm_tt_get_userptr(&bo->tbo, &bo_entry->userptr,
+						  &flags);
+			bo_entry->alloc_flags = flags;
+		} else {
+			bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
+			bo_entry->preferred_domains = bo->preferred_domains;
+			bo_entry->alignment = (u64)bo->tbo.page_alignment << PAGE_SHIFT;
+
+			if (bo->tbo.base.import_attach)
+				bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
+		}
 
 		bo_index += 1;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde..7620d6acfa0a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -851,6 +851,7 @@ struct drm_amdgpu_gem_op {
 };
 
 #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
+#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR	(1 << 1)
 
 struct drm_amdgpu_gem_list_handles {
 	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
@@ -866,7 +867,7 @@ struct drm_amdgpu_gem_list_handles_entry {
 	/* gem handle of buffer object */
 	__u32 gem_handle;
 
-	/* Currently just one flag: IS_IMPORT */
+	/* AMDGPU_GEM_LIST_HANDLES_FLAG_* */
 	__u32 flags;
 
 	/* Size of bo */
@@ -875,11 +876,16 @@ struct drm_amdgpu_gem_list_handles_entry {
 	/* Preferred domains for GEM_CREATE */
 	__u64 preferred_domains;
 
-	/* GEM_CREATE flags for re-creation of buffer */
+	/* GEM_CREATE flags for re-creation of buffer or drm_amdgpu_gem_userptr.flags */
 	__u64 alloc_flags;
 
-	/* physical start_addr alignment in bytes for some HW requirements */
-	__u64 alignment;
+	union {
+		/* physical start_addr alignment in bytes for some HW requirements */
+		__u64 alignment;
+
+		/* drm_amdgpu_gem_userptr.addr for userptr objects */
+		__u64 userptr;
+	};
 };
 
 #define AMDGPU_VA_OP_MAP			1
-- 
2.56.0

