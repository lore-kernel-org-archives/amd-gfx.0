Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036BEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 13:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7814410E7CE;
	Tue, 14 Mar 2023 13:13:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8301910E7D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 13:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678799228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hMEgWvZUG6qO1PqKglF/V8CaNHty0qtVjMQOxDeWDFc=;
 b=IdP0cXG+wRLq2kZWHkH5HUG/+g5YjYN3CFE/UltMYAzkbHLvUwuiMrN7YrEFwJ01QB3FZU
 g0jeoRbi5LrXIF3XZo0ZKVOt4oeJC9cTwRtrif2zs7wniAPdC7fjMtBI6dskrTCC//MFFk
 xNTGfvdiySPLUIr/TupRPkwZvrkMbWU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-hBWWxG8WM0e_ON-hO0kBLQ-1; Tue, 14 Mar 2023 09:06:42 -0400
X-MC-Unique: hBWWxG8WM0e_ON-hO0kBLQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 az31-20020a05620a171f00b00745746178e2so3360732qkb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 06:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678799182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMEgWvZUG6qO1PqKglF/V8CaNHty0qtVjMQOxDeWDFc=;
 b=hxcwROVutTfVY4Q9+jFJrJ0vYKjma63uBha3Oy+nw4GLBG2QU7dhgbPGzzRvPKH6gT
 PNT9TAmiois4P8H42EdkzeiM5IRF8hLCBz5GOfeA7XWb6poGIIWIbg3hNEcE8R2KJro/
 bswD8OSY0+od+RfEiBq5azmCEhjeFsrts6SfRGCjNy5YjNkRxrv0N3i3ZWLRobeGmMnZ
 gNSbuwJNFjK93lRkh+fHT90Dvtm6WscqkkdMc32ip0FOmCptpHUTtJnsMp7NlIkm/I1+
 SaqQCfgZaLiCA6H7xH9LH7rA9UcO6J5PbW688ahTmJFk+84ThcN1T20UsY10aFYG78qg
 ApCA==
X-Gm-Message-State: AO0yUKURs0nGfk6cqEIOnf3XR9iHtyGvEGYslj4teEn58N+mXU1bXY2p
 okZ6rCtILv+BeqAxsR0SxF/BsRPL2wSJY8BA2D2EDESeGWHpxxhi8eG7ahjGzWgUi3InzIYRzQq
 /HIObg6HbgsxRo4wE4aWvoWafzA==
X-Received: by 2002:ac8:5e08:0:b0:3bf:c83d:5d4c with SMTP id
 h8-20020ac85e08000000b003bfc83d5d4cmr59779107qtx.64.1678799182206; 
 Tue, 14 Mar 2023 06:06:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set9k9IedTfQ65vtzZ6gDRjmULVgJGaURZvyzzIxUwogrHRw3OQKTz3pFVe2b8l6tkgGNH294DA==
X-Received: by 2002:ac8:5e08:0:b0:3bf:c83d:5d4c with SMTP id
 h8-20020ac85e08000000b003bfc83d5d4cmr59779062qtx.64.1678799181828; 
 Tue, 14 Mar 2023 06:06:21 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 185-20020a3706c2000000b0070648cf78bdsm1731416qkg.54.2023.03.14.06.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Mar 2023 06:06:21 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: remove unused variable rbo
Date: Tue, 14 Mar 2023 09:06:16 -0400
Message-Id: <20230314130616.2170856-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Mar 2023 13:13:50 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1 reports this error
drivers/gpu/drm/radeon/radeon_ttm.c:201:27: error:
  variable ‘rbo’ set but not used [-Werror=unused-but-set-variable]
  201 |         struct radeon_bo *rbo;
      |                           ^~~

rbo use was removed with
commit f87c1f0b7b79 ("drm/ttm: prevent moving of pinned BOs")
Since the variable is not used, remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 2220cdf6a3f6..0ea430ee5256 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -198,7 +198,6 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 {
 	struct ttm_resource *old_mem = bo->resource;
 	struct radeon_device *rdev;
-	struct radeon_bo *rbo;
 	int r;
 
 	if (new_mem->mem_type == TTM_PL_TT) {
@@ -211,7 +210,6 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (r)
 		return r;
 
-	rbo = container_of(bo, struct radeon_bo, tbo);
 	rdev = radeon_get_rdev(bo->bdev);
 	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
 			 bo->ttm == NULL)) {
-- 
2.27.0

