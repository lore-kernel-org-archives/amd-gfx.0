Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D294ECD4F52
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A4610EB19;
	Tue, 19 May 2026 08:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTtJeMtI";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 814C310E378
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:22:09 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so15007875e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779178928; x=1779783728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjK8PkbjxXTymhLUI+I/9V07duGvqZH4cgPbogqvhWo=;
 b=bTtJeMtI3IvbiG5ZVJYiiV+w6T6bewIeNsNd0HVsyGphpOG/X/Xz2u8xmrwY4GhpNj
 tLrQ7LABhCHN8oc9kX4Nukuc4r4VYEMxz6DEP5EPBytTrxGfxuYMB+IOkTj6qM5kbuQI
 f4tuTFOg7jcMfYYgaad0fcaRlkbEA2aqO7W1ZEx0CbtE4M7eN+1RtYCP0XgnnVbcGUqA
 9K+OOj1U0Pf0+9yQzEPDU1OHB8sZLYsIuxByjXkXuJOX2fjvQNlAA3WWSo7eoSIKRcwd
 MDUApa4omTTXWWU2t5CVutH1lAa67jgzylzux4iLEyxnPsokiC84bJ0IsokY2LWIlIaP
 /u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178928; x=1779783728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hjK8PkbjxXTymhLUI+I/9V07duGvqZH4cgPbogqvhWo=;
 b=gofDA2vOSS8Ko5AefW7rNogxMTKpH4hecGhtdEkzlNRIc3NBrwICNtO10jQ88rYwkG
 foZ/8guE88+TJe75IKiK8jhaXEIfnenbQYWqCZa2xPy6+Zh7KFpJnNcC0UlOfGplG4fe
 1i76sZ2uY31SpfPmVg/zHUcgfv/Iz9da3ehffEOuA41vQgT/lZt3cjOtt7KN06saTaKl
 THCC01ji7lb2T0RFZ0Bxc8WtGWPVdgQxzFxTIGH5CSNTpkI6zQlUQY4QdjdY03QSFxzP
 oLWmjhCT/6l8GfrgHpWzrEejNbbxTYtc9rwF94td2VVhf5rfc3orUvV2TB/COdN4vIhs
 pUQQ==
X-Gm-Message-State: AOJu0Yyg2f/irZlseF/aU8/cH1tyc20hoN+s0kMmV7/pK8DkDHDBfL04
 r56B7ZDAzl5ql9kwNAYQQo435F6dXtE0ysSN7Z9+hAXcN0xmDeKMK5Fz0POCUw==
X-Gm-Gg: Acq92OFrxRM9e7Oxuo1AMPMvf/ZaYS9cjQ+Ed0hPNOlqog4Wllg4IEZunR+kcCsa2ao
 J3zCQuXMKZXPFTfsnO6jSBOQ0hPue1lio9ZNHi0jrSsAGYn9CMoryYqNo94Xa2T3YqldoJn4Rk4
 lapluKaJXOQbiZHmC5d/ghxXdozcGm5AWmtai4KR11I25FVcDvGmwK5YxPUg6M3yT9hyEpCCf0u
 03e1epCLdrZ8eQEr+BuxH5SzcMSS9TZBsHRxlYujDjJB53RMO5yGa68B54wwDCdSC+NWSbojJy7
 9Usb2jRMYEgI9No7fF2vx4OgNNwUV75PzGGagRQ4xAWKYbJ7/sd+YTU31n2FiuqpPOz9OFEflg5
 iXwD7EiA6HfOeVZIbT/hRRzx079yMNLyxQt9sRuoViG+AAf7BvFO9/RTXfbXLXSaZD0/yiL0uOT
 ggGvmgB1TjZ+hG6d0HPRYC544+n9hLs8sTwG1MfcNd8B0nBU3WJgK0iYwwRW9iS7Lv
X-Received: by 2002:a05:600c:a406:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-48fe6514713mr223647365e9.22.1779178927949; 
 Tue, 19 May 2026 01:22:07 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm101575685e9.13.2026.05.19.01.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:22:07 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/5] drm/amdgpu: Respect placement requirements in
 amdgpu_gtt_mgr functions
Date: Tue, 19 May 2026 10:22:00 +0200
Message-ID: <20260519082204.60811-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519082204.60811-1-timur.kristof@gmail.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
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

