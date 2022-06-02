Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EA7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 15:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABAA11301B;
	Thu,  2 Jun 2022 15:47:39 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777C411301B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 15:47:37 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 n124-20020a1c2782000000b003972dfca96cso2972094wmn.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5/3ODEwNpXVEXMtxqIUxmCz194OqrYeKl2LUZ6J7wv0=;
 b=KgYzY8o+rM/PQQLI+a57I+mX19hkwlbY4smk1d+wkSY4Chy07vxvhAhhh+DvKXstHm
 LVJti1ChqauUd8qJ5c4+5SCvUBJM7E5+EkOQwq7M7ZVLG11hoh6PPSUqloxbFlCETXwe
 ex1YEHjyM+kvoqRdD503OwktP9kl8fKYN2dm+gYdLs8NwNwgJLhNlmEJCu6z18rTttB/
 o1txoa+pDvWB0s0JCKeVDHoKYhK3hX8BWzuq37qSszf4ze8irgeqR7JJEHNPtnRz8wNo
 dxlqdZVE8NW8fhgMc/dzPEBoi/ek0Lj/1VTIYIXujHF/iTTE6kb/T7s/7BLEfCaCSj3p
 SZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5/3ODEwNpXVEXMtxqIUxmCz194OqrYeKl2LUZ6J7wv0=;
 b=eS/J6Lr5yxIYvmvAUsLb+ezqoeLvVQf8x0mxB1z4EDUGyHP81/Kgkf5TYyGNyTos94
 rJZoxFEQPVHtQSfYNBivs1WdnG/TBsxa1aDm31hXURlb48GpP+SyQPcWi4vXTuVzCN8a
 2kim75nTbwNXSM5WZFvpSpt5bgmLS7DwzVJ6O+hfWRCTMUNSOTFljmAMgp63zvdPwLLM
 7GEDMjX7EsuE+w7h+QwYjbHMG72Iz4fJOMBIH73shQBBK6bkyGncC8cUoneuhMjTa3eR
 c66k5xvDGmr5FaqbKIiNABilXpYKy6BXVEI/LxbAzf2E0mOwHtHiK96lHn07wj33iE6M
 /VmQ==
X-Gm-Message-State: AOAM530z8VmVfKAvLiQOw8U/Lm5goz4nnr5Niwqz2VKy10bFQQ5IVpfP
 Z5z22dYqRSQiursL+rJWXU2wD3RdNKjfMw==
X-Google-Smtp-Source: ABdhPJyUzlCwVIpMrGmM7oIg4GTJijPY/gkhAy3GNnx825+gYEa1PC2vjEApx2pKLO2o10A2shmjZQ==
X-Received: by 2002:a05:600c:601e:b0:397:5d88:648c with SMTP id
 az30-20020a05600c601e00b003975d88648cmr4562151wmb.122.1654184855900; 
 Thu, 02 Jun 2022 08:47:35 -0700 (PDT)
Received: from baker.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
 by smtp.gmail.com with ESMTPSA id
 bg20-20020a05600c3c9400b0039c15861001sm3067520wmb.21.2022.06.02.08.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 08:47:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Arunpravin.PaneerSelvam@amd.com
Subject: [PATCH] drm/ttm: fix bulk move handling during resource init
Date: Thu,  2 Jun 2022 17:47:34 +0200
Message-Id: <20220602154734.7854-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The resource must be on the LRU before ttm_lru_bulk_move_add() is called.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 65889b3caf50..928b9140f3c5 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -169,15 +169,17 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
 	res->bus.is_iomem = false;
 	res->bus.caching = ttm_cached;
 	res->bo = bo;
-	INIT_LIST_HEAD(&res->lru);
 
 	man = ttm_manager_type(bo->bdev, place->mem_type);
 	spin_lock(&bo->bdev->lru_lock);
 	man->usage += res->num_pages << PAGE_SHIFT;
-	if (bo->bulk_move)
+	if (bo->bulk_move) {
+		list_add_tail(&res->lru, &man->lru[bo->priority]);
 		ttm_lru_bulk_move_add(bo->bulk_move, res);
-	else
+	} else {
+		INIT_LIST_HEAD(&res->lru);
 		ttm_resource_move_to_lru_tail(res);
+	}
 	spin_unlock(&bo->bdev->lru_lock);
 }
 EXPORT_SYMBOL(ttm_resource_init);
-- 
2.25.1

