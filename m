Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707C6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 11:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2CD10E56A;
	Mon, 21 Feb 2022 11:05:06 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F08EF10E5AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 11:05:05 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id cm8so18917508edb.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 03:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=THXu3PibBCDuzuoZgCnCSGIrYzzcOXuBQ319mjrK08E=;
 b=UX6LMXNx8Fvj/8RgMMjRx2Wixrtwnu13nzKv2QUfj+fQ5h+1DF7/vZpWyadPIPSzbY
 3QIzOLF90K2XJuCNNG702mnhA+5KtzBL1reliSDBZ8Z0ic59DA0h9zI6r65bd8PLKBby
 HbNPq6BqOepdBwv9qiKh971/BHCG72j2hAJ9Xgm8ghciQ8oy6Kq/+CmfLxebG7/xMWdf
 kyqfWD5+WguovLheiCv92B+XccBEhy5Pub0+M/RMG4qojfuAJnLmOJWiQV+Go+unjNX1
 Zkfqt4iK7ILxCXpMU8tk6XBClcxASQT6F3KzzsGC6iMiosq6e1b2ARzL2izTvai7FMPN
 q+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=THXu3PibBCDuzuoZgCnCSGIrYzzcOXuBQ319mjrK08E=;
 b=QVY86uiEkw4Cce1Avtx6M3V2itf5Aw/LDUL1FGRLaUROZdT4T1XhJpb23FxuVCTl8G
 Ie3zslL/Bxf7DHG/LlbiGsex9M48B39o7LcTbm1HTn17WJzwDq6DNIMrPxMhOTxhHyLX
 L/x89Oa7c3+1smEpTEf/wlyuySTHDQCYi7XyuW5kZ2HaFciO/Hg6xFxut6v4e0xfEctg
 S3SOspSuzhFHDozH0yYLvgfAf4/jsmclBTf4LSAzM0oFNHNEyiuHomEsfRawHmL8F5/F
 2TFiPq6oDzNpEQegT+VaeIre4IcG+/761NPSGtjSnWCnbR62Ce3pbv0CThLzqhsQhCnn
 J9oA==
X-Gm-Message-State: AOAM5313ux1JBeau9FKTvB9YAmBF1zRS5YT8+DYcfbP+5Wg514RkxHSw
 sXkU9Dvy/BACDAojv9GDKRkEqfx4qqI=
X-Google-Smtp-Source: ABdhPJzhxURoE0luUADTnGILa2mNUR7cbJDtLGdWu4VKnBX/FkdUNv+fAvmUhZQ/T2Qu8AW8QPQI1A==
X-Received: by 2002:aa7:d648:0:b0:412:b567:3664 with SMTP id
 v8-20020aa7d648000000b00412b5673664mr17067503edr.296.1645441504444; 
 Mon, 21 Feb 2022 03:05:04 -0800 (PST)
Received: from able.fritz.box (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id s10sm5086518ejm.0.2022.02.21.03.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 03:05:04 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: fix variable type
Date: Mon, 21 Feb 2022 12:05:03 +0100
Message-Id: <20220221110503.2803-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When we switch to dma_resv_wait_timeout() the returned type changes as
well.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 89aae41d740f ("drm/radeon: use dma_resv_wait_timeout() instead of manually waiting")
---
 drivers/gpu/drm/radeon/radeon_uvd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 377f9cdb5b53..84013faa4756 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -470,8 +470,8 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 	int32_t *msg, msg_type, handle;
 	unsigned img_size = 0;
 	void *ptr;
-
-	int i, r;
+	long r;
+	int i;
 
 	if (offset & 0x3F) {
 		DRM_ERROR("UVD messages must be 64 byte aligned!\n");
@@ -481,13 +481,13 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 	r = dma_resv_wait_timeout(bo->tbo.base.resv, false, false,
 				  MAX_SCHEDULE_TIMEOUT);
 	if (r <= 0) {
-		DRM_ERROR("Failed waiting for UVD message (%d)!\n", r);
+		DRM_ERROR("Failed waiting for UVD message (%ld)!\n", r);
 		return r ? r : -ETIME;
 	}
 
 	r = radeon_bo_kmap(bo, &ptr);
 	if (r) {
-		DRM_ERROR("Failed mapping the UVD message (%d)!\n", r);
+		DRM_ERROR("Failed mapping the UVD message (%ld)!\n", r);
 		return r;
 	}
 
-- 
2.25.1

