Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A74DCD5BD0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0CD10E270;
	Mon, 25 May 2026 11:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="be7pd4PO";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4E910E0F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:33:25 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so28830765e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779708804; x=1780313604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cWd8jCos+ntEjSm3klATTqi8e59UcpdDLdMoCzpf3E=;
 b=be7pd4POHfqbZHxhm8L3nUAgdkxQf+SeYLmrh7BrbcmPNJdH5skoQ5CSAtD5B2xbbc
 DY1C9vbH2CYSwWK+4XXxeVEiE0w/1mnFQ/8ZSD3LCu08eu7s1FTw4HUtwbVqO9yheSfb
 HGHupNLC7PI4BBibLkzTB4+7SuwnEN0lRpP/YX1BaRhVODSUGp/YWBa6XvtJWhR4ShrN
 EDCnV3HglK+mVD3UHxBD0EYdRT+8/H8hqsn99BWIVBr75GuUDMVNWNzWIKRLsoZTV4vq
 R22TtxcOi9BN6+yEZ01T4Ztkd2ZTJukst+C6j79u/mSqV+LwI5wMN7NdrYevxuKowPd/
 Y5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779708804; x=1780313604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0cWd8jCos+ntEjSm3klATTqi8e59UcpdDLdMoCzpf3E=;
 b=DNUE1UFsEaRGimK6xKWJT6l1d7X0Z6L1AP/Jwl7zRx/dBu3oAXCMgqr0qo0CXf2SJF
 WUKQcm4tZErPv4HacuHHUJg/IDFQbDaIGGrCK4iSzoi9cTVPV6wje9UM+oao0Ae7i6n1
 XqfwiXPxJgW7RIauXbkA+UK2Jvcjd3s2rAEgEyC6X4B5pRB7jx+NXkzUcv5J4O1epUbt
 RLWGfvmP0FTNjX3La/UO9dZJUWFxWYvmZ3mIt3E+jsqN/aBsu7Qy/ZCx8OfXtMQ82khk
 yMnu134xYSKle2eSa236p6pGC9/iQnznmyQN36ItIgzev9ZiqspT/jJMId+pzopv+Hyi
 KkVg==
X-Gm-Message-State: AOJu0YyfVDm8lNWBqiZAN78U1fh7gZQNe1PScCbmYV7xppwDEDPa9WVv
 GUjrvDlokdSaUbsrTm4iOwiDECaq+wt65IzwNb5T55IJZagxQnRCYOk2w5H4hQ==
X-Gm-Gg: Acq92OFCsXDt2b+gFay3WTnxTehVaRP5KgmqXNGrq8QQsHGSEXF79pynyq2jwX3mEbX
 neGO/wSCWkQhDWiIA8uLDQluqFUBVW4H/gP/kE14yufyDWA4xUcRYdjNYaD83Y4o5TbWfkHV8Gl
 5Wakz0j6El8z8KLWR4AhvJOeyFdTU2LudjyxpgCac0F0YqjeQZYfxhAYLJTCAYXQBUGURfcGFBH
 LE/3SAmfE8R/uSRqFLaxW2qMuX85Tb4+ybP5W2H6sHXqVmbQvM/iSLSr+5iI5AUjykb/M+Kdy+n
 h5yKQH8gbCAuZ+ki2jzPwADVo7Hofkost/5IK2+Ljj1UmQ5VIBF2lUMEjLRzY2ZXqb2lcM9ngBf
 A/T3ZGLCxKVI4xlKS5ih77F5KeZ8NiFA3Ndmq9ccqR1IfVcJmPJNQ9E/T7fMOknFgLCzQb8Ku9A
 W3UXlVhaZBML+55ElMI0PI80NXlS6JbBsGhaf7zn6HqoiDu8C69mgKAuaSiVF/oTDn
X-Received: by 2002:a05:600c:4ecc:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490424b25abmr226005725e9.11.1779708804198; 
 Mon, 25 May 2026 04:33:24 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm241047845e9.0.2026.05.25.04.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:33:23 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/4] drm/amdgpu: Respect placement requirements in
 amdgpu_gtt_mgr functions
Date: Mon, 25 May 2026 13:33:17 +0200
Message-ID: <20260525113321.17953-2-timur.kristof@gmail.com>
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

When testing intersection and compatibility, respect
the actual placement requirements. This is a pre-requisite
for ensuring that UVD CS BOs do not cross 256M segments.

Fixes: ded910f368a5 ("drm/amdgpu: Implement intersect/compatible functions")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 30 +++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 02f85802f579..19b6770a877d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -272,7 +272,20 @@ static bool amdgpu_gtt_mgr_intersects(struct ttm_resource_manager *man,
 				      const struct ttm_place *place,
 				      size_t size)
 {
-	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	const struct drm_mm_node *const node = &to_ttm_range_mgr_node(res)->mm_nodes[0];
+	const u32 num_pages = PFN_UP(size);
+
+	if (!place->lpfn)
+		return true;
+
+	if (!amdgpu_gtt_mgr_has_gart_addr(res))
+		return false;
+
+	if (place->fpfn >= (node->start + num_pages) ||
+	    (place->lpfn && place->lpfn <= node->start))
+		return false;
+
+	return true;
 }
 
 /**
@@ -290,7 +303,20 @@ static bool amdgpu_gtt_mgr_compatible(struct ttm_resource_manager *man,
 				      const struct ttm_place *place,
 				      size_t size)
 {
-	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	const struct drm_mm_node *const node = &to_ttm_range_mgr_node(res)->mm_nodes[0];
+	const u32 num_pages = PFN_UP(size);
+
+	if (!place->lpfn)
+		return true;
+
+	if (!amdgpu_gtt_mgr_has_gart_addr(res))
+		return false;
+
+	if (node->start < place->fpfn ||
+	    (place->lpfn && (node->start + num_pages) > place->lpfn))
+		return false;
+
+	return true;
 }
 
 /**
-- 
2.54.0

