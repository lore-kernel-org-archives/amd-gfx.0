Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8BFC5AC7D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C367C10F1DE;
	Thu,  6 Aug 2026 13:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Uejlkja0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E6F10F1D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=hf3trfcqkn+Cdg+LDxNv78ue2AOFcZ31q0LIlFCxDe8=; b=
 Uejlkja0JCgcexFbKg/Vcff4QqquPyk0+8buqEjgzyuceNo60EPe8rvdhiU4efkQ5HxWvFDNgoU1T
 YyFfAU1JL3EduuEOUIYBEsaXHQyjmc/4p3v15MV4sYZlmtJBfzfeaCtKzapKX5JXfedcqzmJ16sKq
 kqQcCF2Sd7olshTJH1nGt+mV+6O2xjL/OVfGAIAhlX+B79EOhCg2ZAoL14nwWrtfCNuq7/dZISYlb
 aeGQ63qPoPGiYiQxZXfXqxh20ivfnf11YSV96PjrD5E5Lv+Lniy79q66Lx0d87/4L+tk+PSpWPQiA
 cJqfbhBZ1oaH8+wokedJeoX5S4n/kp85qg==;
Received: from [83.105.121.4] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wryRQ-00Ewr1-7W; Thu, 06 Aug 2026 15:47:24 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 4/7] drm/amdgpu: Extend listing of buffer handles with the
 userptr object flag
Date: Thu,  6 Aug 2026 14:47:09 +0100
Message-ID: <20260806134712.91816-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806134712.91816-1-tvrtko.ursulin@igalia.com>
References: <20260806134712.91816-1-tvrtko.ursulin@igalia.com>
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
index 63fb4ea66a45..fad7bbd00edd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1204,14 +1204,23 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 
 		bo_entry = &bo_entries[bo_index];
 
-		bo_entry->size = amdgpu_bo_size(bo);
-		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
-		bo_entry->preferred_domains = bo->preferred_domains;
 		bo_entry->gem_handle = id;
-		bo_entry->alignment = bo->tbo.page_alignment;
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
+			bo_entry->alignment = bo->tbo.page_alignment;
+
+			if (bo->tbo.base.import_attach)
+				bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
+		}
 
 		bo_index += 1;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b32c72a662b6..9baa9a4b6b3d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -838,6 +838,7 @@ struct drm_amdgpu_gem_op {
 };
 
 #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
+#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR	(1 << 1)
 
 struct drm_amdgpu_gem_list_handles {
 	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
@@ -853,7 +854,7 @@ struct drm_amdgpu_gem_list_handles_entry {
 	/* gem handle of buffer object */
 	__u32 gem_handle;
 
-	/* Currently just one flag: IS_IMPORT */
+	/* AMDGPU_GEM_LIST_HANDLES_FLAG_* */
 	__u32 flags;
 
 	/* Size of bo */
@@ -862,11 +863,16 @@ struct drm_amdgpu_gem_list_handles_entry {
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
2.54.0

