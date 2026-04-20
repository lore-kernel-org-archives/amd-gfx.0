Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5088EF36C58
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD1610E555;
	Mon, 20 Apr 2026 12:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YPKDgyyQ";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BD910E555
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:10:50 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so43768375e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776687049; x=1777291849; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WI6kmFXsVfxWjWvKG528ZR2T2CYTGPMvVKdaVnFMWKE=;
 b=YPKDgyyQ3b5befk2hw5JI0+XN3VOKLV6UYMazLXnm/Vrw8JbVzWxcWAxhJIzYBYnYX
 jl/qeWgrMY+bwkft84IH38iwIhjEKjkL3ojvpO7q6+2wY5twkq2qf06Gan2BPJzVEdNX
 NRKmXKWHG5Zb6eCgQX4KmW0ABLNvdNBoSeYAbTN20s88suokVj3wrXVtMQVOtoW+EBOy
 5pLnZi1Z4Tnnz+cRvljKpOFPIakg5c7SpKks6YpIakAJk3WE6vCjA65kjlv5LXUdazf9
 mJjCxly7P57KOT7y3gPEU9swxnM0STMpayerYPCO+Ykg9ZqE0owupH9kXgw4sjgs+sfK
 lqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687049; x=1777291849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WI6kmFXsVfxWjWvKG528ZR2T2CYTGPMvVKdaVnFMWKE=;
 b=UxePOTufBTw82wlFcA3h6Gx+g5hnhpJSM3Nqy2aMyxXRwFq+0a5XFvKPIMcdpoP5xZ
 JOCPmJZscboSbXZc+ovydldGiDQXhrIg96+VAW1nlpdSBsbTCHRIOrjNulRecQgQ9/L8
 rQe+Pqn+KMXlyKhs4hMTiUuHGBYSF2f9HSlBqjufHfbk+NcgQlOqwpduyqL2J0hWM3PA
 RFLld/O157J1vrHait+AFsQdTIvbh2qROGF6znbgjbu5bYDrTnCVu8t1NuqN6XFzf/eL
 mURX4HbaSOOYrZZN9DTWVcPRY+AkEKVtDraF1sp4yiAXaU3n6WszC9QqIukD7VLvJew0
 4dQA==
X-Gm-Message-State: AOJu0YyocW4G3H1gh2LHJC4B/RayGpoRZIu57cEn47gMhbg13ijtx8z+
 6jG7A+MIctfMA1xPm7YANmoJEDijfk9nLMC4wrtdK3UY7VIJA+CzeKYJQ9TXWA==
X-Gm-Gg: AeBDieseADqpdJaxoHlwypHEEMuMknEBg7+Xge+eJxLjtggLOIHfiPKrUtQPQlGPh0g
 WTjzgJib/gyM1C8TSqJecssxwhv6I61k4UMToLuSWTJ5F4X94jTKBlHRas0tGwd89vpfz7yg7ul
 Etj3F/fIiNyECym4HtenRGGf3DhebTO3q8I2dcLy/HLs/hpf82/YUEEpQ1CpXz6qtUf6GpXVoSi
 wYfu7BgLb85lyJ+6TBIVI6seII3KjH/2BnTbFYH0esYA0ITQseyXMcJObjx31ydEG7dl4FoP3Cs
 fqo73Aynzwj9TRJneiHeO8Nuj7xw9L9vKUGa2Qh/hFd3xYExSCq5L+P9P5StbSGI2gsT/41Kbuo
 69sHKYcx92hBsA5JurGfTWAB3v7XVjI7LkSoJgz8Cn3rd+bR1NQjm2oEv3o4Ig1LvVcTh5Yykp/
 yo4QdWbaey0ZchDZxQqWXfc9D3Ko1fWrDXbdAOIiF+X793x9gm+kqHQNwLOim0VSctuV11tsifx
 7GGfQ==
X-Received: by 2002:a05:600c:888b:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-488fb74bccbmr154710665e9.12.1776687048524; 
 Mon, 20 Apr 2026 05:10:48 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm129632265e9.5.2026.04.20.05.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/7] drm/amdgpu: Add alignment to
 amdgpu_gtt_mgr_alloc_entries()
Date: Mon, 20 Apr 2026 14:10:38 +0200
Message-ID: <20260420121044.155030-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420121044.155030-1-timur.kristof@gmail.com>
References: <20260420121044.155030-1-timur.kristof@gmail.com>
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
index 4c7d1917d9bb1..b7b6c4469937b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2026,7 +2026,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
 		return 0;
 
 	num_pages = num_gart_windows * AMDGPU_GTT_MAX_TRANSFER_SIZE;
-	r = amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_pages,
+	r = amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_pages, 0,
 					 DRM_MM_INSERT_BEST);
 	if (r) {
 		drm_sched_entity_destroy(&entity->base);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2d72fa2172745..09a524be64c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -148,7 +148,7 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
 
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

