Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71B3C61DC2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 12:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D227F10EFFA;
	Thu, 27 Aug 2026 12:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="GcxNkzC1";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA3910E393
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 09:01:15 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-39266382df6so406636a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1787821275; x=1788426075; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rgBLolzdPT4tsDrmX6mCnbe4xBVr2san57ni3P7/sf0=;
 b=GcxNkzC1/FrP/d057bn5IvXi3Z0v3HpCkJjBkRgpGDEcqKHvpeRzSfwK515GlqDH0x
 pMZXmURUOTK8kq0RQMEUouuBp/W+LvgWHLkKWmWzl/fcWsZuCLd0loRr9Bfy0uJ4OW3J
 zrVqThTS6a20B0huSqKBlQ2lZx2Qv+ilHAvAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821275; x=1788426075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rgBLolzdPT4tsDrmX6mCnbe4xBVr2san57ni3P7/sf0=;
 b=f9WngR13sCH37AjistXMKAbmrXz+HfrCCTJ6Q+IQB6fZQ0jf6ojjINl19NHnXKlb46
 3BiHCFR5zd/DJ7BVMYtfpd6pgHJ0RKbfRDUXbOxNDDEX3a5gjtBApdiMjndsVlp4F7Y1
 StdsUqJfeBXDYAvKoNpyFQOpmh5fgFTyn8dtlsF+iO1WL4qhWyLvrhxIpd0BXYoyiLUz
 KFJt1OlqFJwlJhcAqXahiBsPirflFNHBTcQsMIkRnJRflgVEGz/WZNH5QzlTB1r9Nps5
 I4YZ2mqM7sW0NIf26L5fQvKjvh2yttgM6iEsWjxwdT8ItUKzMZAzTS67a2hFnGB54H/j
 2DyA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqa9+bBKk3s8mwmKpeUabC8EmN7IQJyxHANgrsRHCFQmnFjzRypbgiq/9cDnzFlpRpKWQqTjnTO@lists.freedesktop.org
X-Gm-Message-State: AFuF++nAdIB8iKJNIUCWgMIBSM5J/O0yzaRoLS66+oH3DYrhyE0dc/gc
 SmqQacy4h2ded2Jm2TZ3FDbC/XIFlzEStqp62ZisLTzeGzCWE6uqWhoqJ/LfCVff6rU=
X-Gm-Gg: AR+sD12cK/4oXGpBf1e43UOmJzKo5TlJnCpDxeDONa1CjBNTJ9hSCS+JQHc5EJeW0Ki
 5uoN3rbNuTFqNq/vtiLrHNIoSodut3ooYeLGLhwzAZRsKJeKGNg4RZdGugqS5fTJh3gDKnvbPl1
 TWzglVDv2wCcXo3+Vjmn6LkNQotVrUjXbJVzhAC3iZtVmx4WFhXohu5UPGJkkT9+5d/Nj1sx621
 AoLwrCpA4IpHX7x7iLXrBzOcnsHtfeDnNlXnJLgnB67zhC099A1mhiym13ktNk1U9pOz5M3OQJl
 ZfqS4JIVJMppQDVxMddj6MM1trlatZrGKcbrKMEjaOJhb+Dn7xiNRduDUozQGckpVHzV1rCuO+n
 n7glKpII7N+xI7wQiOcQ+qw5yr9HUDSs/U9xd6au1L/dWx2pMdUNA2PU9BGS05T0EMp2vcTzh+k
 I8a4Ev6TFalGSneHDG27Gvpp2d/BqDz8zKgSs4HcgLFnlUgV7O7Moc7S9LAw==
X-Received: by 2002:a17:90a:d2c6:b0:392:c80b:8eff with SMTP id
 98e67ed59e1d1-3966d866cc8mr28689376a91.11.1787821273852; 
 Thu, 27 Aug 2026 02:01:13 -0700 (PDT)
Received: from 1c1aead48890.. ([49.142.45.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b112b57bsm2062845a91.17.2026.08.27.02.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 02:01:13 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Seongjun Hong <hsj0512@snu.ac.kr>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: switch from get_user_pages to pin_user_pages
Date: Thu, 27 Aug 2026 09:00:59 +0000
Message-ID: <20260827090100.428302-1-hsj0512@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 12:47:25 +0000
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

Switch old api get_user_pages to pin_user_pages according to [1].
It guarantees these DMA pages are pinned.

[1] Documentation/core-api/pin_user_pages.rst

Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index e7ab8162ac69..22fc35a0e8d8 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -349,7 +349,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_device *bdev, struct ttm_tt *ttm
 		uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
 		struct page **pages = ttm->pages + pinned;
 
-		r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
+		r = pin_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
 				   pages);
 		if (r < 0)
 			goto release_pages;
@@ -377,7 +377,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_device *bdev, struct ttm_tt *ttm
 	kfree(ttm->sg);
 
 release_pages:
-	release_pages(ttm->pages, pinned);
+	unpin_user_pages(ttm->pages, pinned);
 	return r;
 }
 
@@ -404,7 +404,7 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_device *bdev, struct ttm_tt *
 			set_page_dirty(page);
 
 		mark_page_accessed(page);
-		put_page(page);
+		unpin_user_page(page);
 	}
 
 	sg_free_table(ttm->sg);
-- 
2.43.0

