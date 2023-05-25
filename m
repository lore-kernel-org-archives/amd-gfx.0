Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2060C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 21:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6053410E768;
	Thu, 25 May 2023 21:13:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EAFD10E765
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685048460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tJfvnTa7LvHqmI8tQ9doB+bZM4q5v1Nf/27PBhPpK8Q=;
 b=YxRRSXdKdeV/Tx3RFwNyrx3bp/V3ZueojiFDfVi6hHYygnqL5nZkiWCGk3DROWI1CxYeCT
 kETZaCrC47AtGn6xaff1dXvED2T7xQKlCpHThc0zCm5BKIIvX2BUL1IYvNVTs+4COv504H
 0hVijxAApsKwrdX7P/obZmvDeioqWIg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-cqV-1N_XOKelapRPTlVCFw-1; Thu, 25 May 2023 17:00:57 -0400
X-MC-Unique: cqV-1N_XOKelapRPTlVCFw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75b185c9736so8040485a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 14:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685048457; x=1687640457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tJfvnTa7LvHqmI8tQ9doB+bZM4q5v1Nf/27PBhPpK8Q=;
 b=A7tsdS67PTRcKckCs5QGCE0E05gLT2flKEvgR7paRyajTXweIzRqDPx0n5SkcWp3oB
 Y3qYe9USdDVDc3oYssLSL1KpQRoDlwNjPYcGFTgmRx/qxG4MlhZbz5wGsQOJX99rAKEn
 jZkPKoi0mtQg7ugaXjYYOS1aRQM2ohj0l0WN51KOEi6KniSan0R94Zi7CH2AYCUy14KT
 ypkbmShyRf6PYTY7OGY6Ff6cNS60+gctsBsmleub5nAmDDy01qwwI1vWupNEgto/7tfM
 nYqQmOmZMtB68VFUspFekvswIGjcSk7qz+Pq8i04P0uwTB8upXISr12qZfBRxvtR5OOh
 nx+A==
X-Gm-Message-State: AC+VfDyhf6aACwalJ0Q4qRLhU/mOTt211QuJGN8Sydn65bbPzr2kLs04
 kmZ5NOebCKDTO/woe+kk9SEQV4OxUo7tpLLI5BxZxluqw/nR3DOssygsaBSl1dLJtstu2H4l1BX
 NYMl1NObjNlxEL5ktoooG4UllqA==
X-Received: by 2002:a05:620a:4894:b0:75b:23a0:d9c7 with SMTP id
 ea20-20020a05620a489400b0075b23a0d9c7mr2660qkb.29.1685048456901; 
 Thu, 25 May 2023 14:00:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xll8jco9wkwI9OOHu1rNZaj2ifaVP4j38rDEla1Dsbharx5BlkOzrgfF9xnXt6hzd5Vaefg==
X-Received: by 2002:a05:620a:4894:b0:75b:23a0:d9c7 with SMTP id
 ea20-20020a05620a489400b0075b23a0d9c7mr2648qkb.29.1685048456666; 
 Thu, 25 May 2023 14:00:56 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 o15-20020ae9f50f000000b0075b0c1f4ad6sm684847qkg.0.2023.05.25.14.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 14:00:56 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: remove unused variable rbo
Date: Thu, 25 May 2023 17:00:54 -0400
Message-Id: <20230525210054.3233539-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 May 2023 21:13:03 +0000
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

gcc with W=1 reports
drivers/gpu/drm/radeon/radeon_ttm.c:200:27: error: variable
  ‘rbo’ set but not used [-Werror=unused-but-set-variable]
  200 |         struct radeon_bo *rbo;
      |                           ^~~
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 4eb83ccc4906..de4e6d78f1e1 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -197,7 +197,6 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 {
 	struct ttm_resource *old_mem = bo->resource;
 	struct radeon_device *rdev;
-	struct radeon_bo *rbo;
 	int r;
 
 	if (new_mem->mem_type == TTM_PL_TT) {
@@ -210,7 +209,6 @@ static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (r)
 		return r;
 
-	rbo = container_of(bo, struct radeon_bo, tbo);
 	rdev = radeon_get_rdev(bo->bdev);
 	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
 			 bo->ttm == NULL)) {
-- 
2.27.0

