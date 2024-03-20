Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39198C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 12:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FAB410E17D;
	Wed, 20 Mar 2024 12:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O79V6Yn5";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1998F10E17D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 12:49:50 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-a4644bde1d4so874925066b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710938988; x=1711543788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=03yn12LHvCFhq7YwJQm+rB8ShAs7Hyqq+ivm/vzUxZM=;
 b=O79V6Yn548U2lQlNycwju+OtgOZi24I16rH+nM/heLgCiwYI4W8Z2tBIxIIJRwR4DY
 18hbqjM5piGc1FBATNW2L0qKfq53OLKdsRLy9aaT4Zq8yxjgAK+rJ61ZxUspGZRpdPW5
 i8+28PLPAFaKLgl5iSCigXe0PxbWStw+jGHnX2uv18Jv042G/hNlNwSsoIFMkNUHWcfH
 QINwzJvw7K2uhet9YP7jQWeZYgLBUdZZcWzhcltqk6SDXPv4AuXfjxHZE5NqaMV4snIS
 27M8Y19NguRYb33pL6hdHqfJjFQI5uwi35ZNEkNTLo8Fb+7Q85KXeHnpCVD8ceJnoHQB
 xclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938988; x=1711543788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03yn12LHvCFhq7YwJQm+rB8ShAs7Hyqq+ivm/vzUxZM=;
 b=E4JItOspKVknUhol4lcYOyzR2bbVqaxl7yNdtm56tbaiI9aNzwzK4w5qUWnmeWv0AG
 9HBlP42SGXatiN6YEauYngsD+o5J3ogNq42e9+dg2zoT5G/7jUumUFkiEi1TCYHxS+TI
 +NjxJrtTO0z+03UVkQAaeUDKYr2aSM97Mo3CiJdlDTLADILK6PIwK2p/pKfGiu4nHPwR
 JwBoqDIMOtmFS6CyLrSV+6vMe3gw9YVk1u+0VVqBr1KV1bBE0vpxN1hROhPA1TsotLNh
 XhhAwbT5tNJNu116uKr0VvgbG+VlzZPmOLQEqU2WbdP2Rqabq5Lzxuyk61x9srkETdpM
 w2eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPr7IQs1/cTosHCKBEfB/MJaNXkod8m/QQvnwRDER54tzpxPblo6V0OReYKFh946zKzxhsf2Ti8WVREq1wKse3UdLJE7ewxMudajoeZA==
X-Gm-Message-State: AOJu0YwIkZbKhU/nuHOWeVtaHhZyXkpLJZbSbWfm9OxHJKC0G9HBHBPR
 mVKT5m+rkRYiT9ovR3D74xwBWCoLbacBtX/yl2xovcmNa7l+N9xl3HdYOuQBfU3jjg==
X-Google-Smtp-Source: AGHT+IFHEEUj6WDum7gcknGZJR3Fjdbzc0u3SgDkzUH92WrysM9Dl51Wcz2KIOIMuJxRuCwwKg10rg==
X-Received: by 2002:a17:906:2c18:b0:a46:f9ba:a0ab with SMTP id
 e24-20020a1709062c1800b00a46f9baa0abmr923458ejh.56.1710938988093; 
 Wed, 20 Mar 2024 05:49:48 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151e:2a00:fcb0:c9ea:8fd1:3165])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170906390500b00a46d6e51a6fsm2267078eje.63.2024.03.20.05.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:49:47 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com, xenia.ragiadakou@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: amaranath.somalapuram@amd.com
Subject: [PATCH] drm/amdgpu: remove invalid resource->start check
Date: Wed, 20 Mar 2024 13:49:46 +0100
Message-Id: <20240320124946.2816-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

The majority of those where removed in the patch aed01a68047b
drm/amdgpu: Remove TTM resource->start visible VRAM condition v2

But this one was missed because it's working on the resource and not the
BO. Since we also no longer use a fake start address for visible BOs
this will now trigger invalid mapping errors.

Fixes: aed01a68047b ("drm/amdgpu: Remove TTM resource->start visible VRAM condition v2")
Signed-off-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b0ed10f4de60..6bd7e71c5ff6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -573,9 +573,6 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		break;
 	case TTM_PL_VRAM:
 		mem->bus.offset = mem->start << PAGE_SHIFT;
-		/* check if it's visible */
-		if ((mem->bus.offset + bus_size) > adev->gmc.visible_vram_size)
-			return -EINVAL;
 
 		if (adev->mman.aper_base_kaddr &&
 		    mem->placement & TTM_PL_FLAG_CONTIGUOUS)
-- 
2.34.1

