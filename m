Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A301C5AC7A
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7E910F1F3;
	Thu,  6 Aug 2026 13:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="r1pLtmhS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC8E10F1E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=RKWoaB8t8/dn0blGiBXYBR/NHIQaa7LRyEHPCUSKOzA=; b=r1pLtmhSY5DdY8WUJeKt0Cn/mF
 4QQd8E05ctUaMSA6wdJ/zgL9X4H5lo+eMHuCHgFSlCe97X2/W4g9Z2Kf2ltrQcctZu7j7H0I50XJ7
 ZyCRtmdJTxZHrzyIHoWeMuZkVU5iBCV6n/3NP2HKptaLWNXItB5XLzVcJ/D42t8lLUb8wT6HM0Nfz
 CfVRjVhTp6rpeoQtYE/SrP6KNn0F16Y8eCZ4fWWxlaamfjx8Yg7b6048SqRp+FVBFxbjpeGEaZ/lq
 5NXeeiPnOG2avTw/4XZbIGAKD9R5ANxy/Mo++z2sE6AfZPaV0lWmwfNe43ppdIpQCWpiLeULIFMB3
 epL9jvfQ==;
Received: from [83.105.121.4] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wryRO-00Ewqj-Pa; Thu, 06 Aug 2026 15:47:22 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 2/7] drm/amdgpu: Move amdgpu_ttm_tt_is_userptr() under
 conditional compilation
Date: Thu,  6 Aug 2026 14:47:07 +0100
Message-ID: <20260806134712.91816-3-tvrtko.ursulin@igalia.com>
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

If userptr support is not compiled in there is no point to emit an out of
line function and respective calls which always returns false. Move the
declaration and implementation to the the already present conditional blocks.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  7 ++++++-
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f4cc1d8ac4c4..1dd15b556d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -787,6 +787,19 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 	return r;
 }
 
+/*
+ * amdgpu_ttm_tt_is_userptr - Have the pages backing by userptr?
+ */
+bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
+{
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
+
+	if (gtt == NULL || !gtt->usertask)
+		return false;
+
+	return true;
+}
+
 #endif
 
 /*
@@ -1394,19 +1407,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 	return true;
 }
 
-/*
- * amdgpu_ttm_tt_is_userptr - Have the pages backing by userptr?
- */
-bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
-{
-	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
-
-	if (gtt == NULL || !gtt->usertask)
-		return false;
-
-	return true;
-}
-
 /*
  * amdgpu_ttm_tt_is_readonly - Is the ttm_tt object read only?
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index ff9e2e346609..a47a6eae6713 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -210,12 +210,18 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 				 struct amdgpu_hmm_range *range);
+bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
 #else
 static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 					       struct amdgpu_hmm_range *range)
 {
 	return -EPERM;
 }
+
+static inline bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
+{
+	return false;
+}
 #endif
 
 /**
@@ -250,7 +256,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 				  unsigned long end, unsigned long *userptr);
 bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
 				       int *last_invalidated);
-bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
 bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
 uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
 uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
-- 
2.54.0

