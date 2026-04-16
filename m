Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B722F8D77A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 20:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99BB10E27F;
	Thu, 16 Apr 2026 20:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pl5Lrs2R";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD10910E258
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 20:26:50 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso78818335e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776371209; x=1776976009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EktLkkWHp2YI4RhOzgxtOAStFMO/KNSMHNiz0TKOXE=;
 b=pl5Lrs2RizBMxo8oVVOpXGuWbOhQjpKVy7sii6/5cOw8SlCTI0N0p7vzOIXE10C6yW
 yXJNq7wTbJqo5sUgZzbmgcXeqFW8Xu++rjKh1mJWVmy1DVR8MxtzsD0Mt6TnicjAjawZ
 kKR2So/Ps/5Kk6JyzKK3rg49DhlFZd7yqvwbmcxMMZu4SeZCdYJHGKzJao9kBus7Zu2S
 csymZ1mUCAejz8drBkxED9ZyvEEduBbjAUV2Iuom783eyH+W02KGIsLJ0N5ZR834Czf6
 +KJT+6gYSfa5jIJC5WlzCMCEp1hZaMglLuKWv90Dn/xEQ9SRSLk15YHI6icnOOecFlKq
 7qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776371209; x=1776976009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8EktLkkWHp2YI4RhOzgxtOAStFMO/KNSMHNiz0TKOXE=;
 b=jbhFUZPCWVt3+hLFbcN1J+r00nDMy09714xzhG0U/yHSuiyau1zYi3DVdC1PT6eLHp
 cShwFFcIqj53amXKAO72oj0tRs42zETAImxl3I5zbPG0Mn4O5wznAjzAlGN3p70bk16Y
 YhBkPtGRIwlelgfU6LtDZCSjoguc7I5k5z8gyv8gpPFJ3hWsPrQKBQp05A87M78uWGAW
 NjQvshUuHD31LxGwjAfOwtHLpojghwTx05+04o7qzHp7pkxByvnazP0uZ/0R8wJopiwB
 PDSJ723+1MuGyFVwV4pNhKZXdzHArkTcz9ou2hPXxxkqZZA+urWoBevh06ZNDoSqNtdw
 sjyA==
X-Gm-Message-State: AOJu0Yx7P8Ul5UXVFPLdNCFnwZBJwoNorSydOxFLZWESJ6CBfq0CdZ34
 BLn8UnLql8hnRvZJe9MdSKH8BN8hWfwVcPZGxeDMpbaAv+ewAWKzqcxPGQ8O2w==
X-Gm-Gg: AeBDietfDnpE39zqXbqrE5kzXpq5ThQcB3glufwY9I6OvYeEaeDNRrN0dLnV4z6JBql
 4CoOpNiCfAnX2W6NOPRuD4KrM+UpUlfJGw0ktGhTH3GdtYkryhgaqK3VVDni7fsRmbdj7mX6ALC
 eWmwZkslAUiTBsSG/+bzfdX2mcq6RUSD4dGBK4ckkdTTXNE7UFoMHPhVr4Vh8CxcTHtuT4+ZBPp
 1k6EpbXdULw/GW4TbF86en9KT/tVfHAZbLLc5dCULMAqfabQT3OdbnFa7rH2T4dyKc4veXZFGIa
 0bbw9xoGiplyjVb+0HhW0uhso4RDeQipTTeSFsPT3A5GutDrm9ayRKEtRloug3D0ssAI0QWpbbZ
 2oGmI6HMafCdHWeJHYnJHHmLnmQg6oUYsCcxWa/KCv/XutP6gDl5Q+RFlb2d+Pxp3nIhIMOYsTX
 5zEFMMiC0vCAEhFUPymK2Ozwk8qvM0+UqwZWnJ6ygPTO8gTamsqtl3TAgvTQTK6ngY7iD99NSv6
 3D7tA==
X-Received: by 2002:a05:600c:8115:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-488fb77e27cmr1206085e9.22.1776371208957; 
 Thu, 16 Apr 2026 13:26:48 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581b9fbsm76941355e9.5.2026.04.16.13.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 13:26:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/7] drm/amdgpu: Add alignment to
 amdgpu_gtt_mgr_alloc_entries()
Date: Thu, 16 Apr 2026 22:26:39 +0200
Message-ID: <20260416202643.25350-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416202643.25350-1-timur.kristof@gmail.com>
References: <20260416202643.25350-1-timur.kristof@gmail.com>
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

Add an argument to amdgpu_gtt_mgr_alloc_entries() so that
the caller can specify an alignment.

This is a pre-requisite for fixing the workaround for
ensuring that the VCE1 VCPU BO has a low 32-bit address.

Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     | 2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c       | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 9b0bcf6aca445..4fea81479264f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -188,6 +188,7 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
  * @mgr: The GTT manager object
  * @mm_node: The drm mm node to return the new allocation node information
  * @num_pages: The number of pages for the new allocation
+ * @alignment: Alignment of the allocation (in pages)
  * @mode: The new allocation mode
  *
  * Helper to dynamic alloc GART entries to map memory not accociated with
@@ -195,7 +196,7 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
  */
 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 				 struct drm_mm_node *mm_node,
-				 u64 num_pages,
+				 u64 num_pages, u64 alignment,
 				 enum drm_mm_insert_mode mode)
 {
 	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
@@ -203,7 +204,7 @@ int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 
 	spin_lock(&mgr->lock);
 	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
-					0, GART_ENTRY_WITHOUT_BO_COLOR, 0,
+					alignment, GART_ENTRY_WITHOUT_BO_COLOR, 0,
 					adev->gmc.gart_size >> PAGE_SHIFT,
 					mode);
 	spin_unlock(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b69e29e7cfc9b..de85bbb0a1efc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2029,7 +2029,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
 		return 0;
 
 	num_pages = num_gart_windows * AMDGPU_GTT_MAX_TRANSFER_SIZE;
-	r = amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_pages,
+	r = amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_pages, 0,
 					 DRM_MM_INSERT_BEST);
 	if (r) {
 		drm_sched_entity_destroy(&entity->base);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index f2f23a42b3cc4..f3b214502c1c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -147,7 +147,7 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
 
 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 				 struct drm_mm_node *mm_node,
-				 u64 num_pages,
+				 u64 num_pages, u64 alignment,
 				 enum drm_mm_insert_mode mode);
 void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
 				 struct drm_mm_node *mm_node);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 5b7b46d242c6d..2fe931366985a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -539,7 +539,7 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	int r;
 
 	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
-					 &adev->vce.gart_node, num_pages,
+					 &adev->vce.gart_node, num_pages, 0,
 					 DRM_MM_INSERT_LOW);
 	if (r)
 		return r;
-- 
2.53.0

