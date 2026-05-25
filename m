Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422D9CD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DA110E253;
	Mon, 25 May 2026 11:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z9ukcosD";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1375710E253
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:33:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso81603235e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779708805; x=1780313605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wL8k57vYlbi3U9YokjW8P89P7GkelY1c0R9HWfsyeNE=;
 b=Z9ukcosD4gjliUpIkfgaZKoJjoCqF+/03p5Ff9qq7ebN8YTClq71d/bId/vIARVj/E
 pEETE5Z/+QtqX9C2R0rjL6xbqlf+RP5Z1REXnITvX6sZd4ftoXdAfFOnFvFsTNE9viWE
 tRReKXqX1YHTm7o1zg0Xc3E3GLTBUFTSmGnt92yZ/KzeWAz+XC/NYQKFO4bCkf8vgcRR
 uDMIjIK2lx3ArgpsMMx9woztmZczRJhntzpPVuR4Rv8yCdgKMZf696J7AqkKgEaN5ys+
 UXfinA2hmlbtZyqd3xWlM2aSFj/v/ekMDGe+Zniikv/OlbKw07xK7maJFfMw+Y7ZGcuC
 9EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779708805; x=1780313605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wL8k57vYlbi3U9YokjW8P89P7GkelY1c0R9HWfsyeNE=;
 b=RABEaY5LTLaro48VM7pJYXJ8DDJa8pjj3pL+ZiAlKO/pVSAXTarrdUQ7VJlBuOf/2X
 lTcrc5OdKVDmBh5XBG49rHzC7vk+WjShu1mUJ2sUpPzzTrsz888hX3sKHMMkEDBpKIY4
 Mdt6zjdJie5btp3Lu9C77XJXPZAgZ0R3PEPWwXwsbTNK/MXzgeZ+i0y/ci2d9maE0yQ4
 7pskG3+lqK2Z1oe94o4c+JJdWzJazc0a23fWnCE9bEJ6vsJ07K5Sdb4U6tHUlqHmSDZT
 nujy8IR0YvMQKLfrYpC3dZHaLLEXvmgB9oI8NyLFzT1yn+Fblp81PZeaM7A7f5Yzekey
 QGkQ==
X-Gm-Message-State: AOJu0Yy+M0R2fxa+DrBYOTEDJAKPXNcD5gbG3OAeBZoFWXoVfMclIN4c
 WLTDDIZuMBWUnu0+wQCqZL/4fAT/kANNhUXjqEnAqkwja9x3MZpsm1lk+sk8Dw==
X-Gm-Gg: Acq92OEJh9nCQAKqorgc80zdyZ8rDw+kLaZjgh9SOrO6ZJ83Q5xdh6+V2/Z/l2x3/dE
 n9fARnfLFLbhavqnzsdwEwUan+eku/rkwF9g00wMcsrk6xCpZ43VRMwVS1+sqGlFXmQ4m7qXXaa
 q+l9G7U00j5Ly82GmWID1rMmWz1irsIZdn5qESMiGtAje/Njg6OY3i00nWISZ9xSeW/OhbKGBIm
 8qEFH+9hKwhLnFtljUmHiX0U3BKVKUIiSvvwhS/yxIsJ1K6n1JJvDvZkh005ASKCeMB5SnGcO39
 iUByPHsLfHcbB57wIJ1+osxiG2UYr27xeIKXyTee9zvvh0OvZLTZ/xPfVNEQHRsR22PkjgKTRTZ
 YSC98GWM/K8ghHdkNKmCzxtIEVV5LvbfGhQEtfWKgesaUMOJFJ9eE0WdbbUbeEV4r4yYFxheb6V
 J1LepGABAcAtxf/wDaGIkhQr9E8ybR0i39TRw3Jv2Wp+/q7LJmpqMF72PWZ6gh8FH2YjuQPD3j1
 d4=
X-Received: by 2002:a05:600c:8217:b0:490:51e9:deba with SMTP id
 5b1f17b1804b1-49051e9e233mr147714375e9.27.1779708805180; 
 Mon, 25 May 2026 04:33:25 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm241047845e9.0.2026.05.25.04.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:33:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/4] drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem
 are both GTT
Date: Mon, 25 May 2026 13:33:18 +0200
Message-ID: <20260525113321.17953-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525113321.17953-1-timur.kristof@gmail.com>
References: <20260525113321.17953-1-timur.kristof@gmail.com>
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

The UVD code relies on GTT to GTT moves in order to ensure
that its BOs don't cross 256M segments.

Fixes: bfe5e585b44f ("drm/ttm: move last binding into the drivers.")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6c6ab4dd6ea9..f80371bc74d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -515,6 +515,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
 	if (new_mem->mem_type == TTM_PL_TT ||
 	    new_mem->mem_type == AMDGPU_PL_PREEMPT) {
+		if (old_mem && (old_mem->mem_type == TTM_PL_TT ||
+				old_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+			r = ttm_bo_wait_ctx(bo, ctx);
+			if (r)
+				return r;
+
+			amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
+		}
+
 		r = amdgpu_ttm_backend_bind(bo->bdev, bo->ttm, new_mem);
 		if (r)
 			return r;
@@ -549,6 +558,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		ttm_bo_assign_mem(bo, new_mem);
 		return 0;
 	}
+	if ((old_mem->mem_type == TTM_PL_TT ||
+	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
+	    (new_mem->mem_type == TTM_PL_TT ||
+	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		amdgpu_bo_move_notify(bo, evict, new_mem);
+		ttm_resource_free(bo, &bo->resource);
+		ttm_bo_assign_mem(bo, new_mem);
+		return 0;
+	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
-- 
2.54.0

