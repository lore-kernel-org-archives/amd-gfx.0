Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39FCC28B25
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 13:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD05410EB5C;
	Fri,  7 Mar 2025 13:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LZa6wO+X";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FCE10EB5A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 13:48:20 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-43bc38bb6baso11112545e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741355299; x=1741960099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O+C29FQAAsqcq/eSCAC8m1g/I0pkefooPYlJKiIkZ6k=;
 b=LZa6wO+Xexg3+Ib8dM/C6DXVsJnFkY6PJ/hGznbId4bwLs8pNJRF5HFx93BoP8KoEw
 65byQtUS7x0oSJWKHfdtGkSv62v9Md8IIvNgkXi4tC9rZv0xLF/u41VAQ165UJb1iTJY
 ja2g6ZBdL6t3AnnxqYQlP/3V7Pom1AGXaz7RdNiy3kkBswhdCsZL/hDib47EJ0OpY7IG
 c2mygxydSh9aORREmYWNx/F5KLhWRcN2Yd9ZnIGm3UnpknIzOVk3NgwjM8/cC6yR1hPt
 0x44qUqc6UQRukzMAY1tDT7d7zyxlXVuO0XUzegrCzvfM+T71AVPqzj3ZmJIS6aYbmqP
 ud7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741355299; x=1741960099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+C29FQAAsqcq/eSCAC8m1g/I0pkefooPYlJKiIkZ6k=;
 b=wzh8j/x8UhWgvyUEeRhFobMGuTxp3iRQHra9yhGvagxZbGnznOFZywCbgG43MtO6H5
 F3OT7fQ4mp892syAwlBztCaozX4QWGiRHb1HT3WesVfw+XkaxrfLC/uB1D8GayHYt1Mj
 yppSm6k4cuZk1IiYldb7WaajB2bI1Cw8MsMBiS05UecNsb2byc0yzYtgpfa1R1I5QYsY
 +5lGzTqdRx8VgtGWh/bq36juPoihkGZ+GPz4imeAw1yLwK3QYN15q6vzoP+4KadFPLwq
 Zids+p+nS8pX5BCUSBW6SjYHcN5V/Ydzat/790Y+RgmFKpQ/AIbFbAQYY1fJ1QQzYhzb
 z0Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0t+ud1jUl6NFi+eNfleW6DqLMTOfOU9B1+7iNeHIS8Ctm4hoOVvr6CMcbHSFETJ54eQvAYxP5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8Amazx/ZA3lYEr2muE35+XFrJNaz9LrNS012Uh5leUT1NSu9y
 JhRGjYuJTatIo5Aj0nDFvFIgrorhnkjmzdiKsV8OJ2b6bkpi/6YX
X-Gm-Gg: ASbGncsbiJS5KkoyZaYocJo6Svv4lBB+qzCiZIgherPRGfw+HL9JocebZaiEIXJg8pW
 2fcZdrYj2fA7vxQl4BtdbFdayS/ueaAUY7afq60jbsrpiVXW0GH4kLLrk0jWs1wkA6+sq52FEwB
 9HQaMSXi4iRqODzv6zaMjghZW4Em9lvpgxawNSTN4pYy70ErWroFNTpLP980SuUYcDxhSCNscko
 DGVAPZYwtOUY3zm4uT8RwjjbBnjR1ZJq7iH7FdR6NTZGyh1rUdsZR9d5kINoclk7Rn+i0hyygq7
 9AmIa6e9KcFVIlYu4rTxTbVxyKAtc7+ro8OPmF07q7+i7t0zqPdAmzn62g==
X-Google-Smtp-Source: AGHT+IECd3ZtABaTjsyWsqlLygYtKJXA+T9QFmRamPq4cqObOma5V1RhHF7eKxVjdNqGz1fRoMH74Q==
X-Received: by 2002:a05:600c:35d1:b0:43b:da2b:762d with SMTP id
 5b1f17b1804b1-43c601d90c8mr25385285e9.7.1741355298455; 
 Fri, 07 Mar 2025 05:48:18 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:14d3:5e00:ab55:e6a0:3a3d:9571])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm70613345e9.7.2025.03.07.05.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 05:48:18 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Subject: [PATCH 3/8] drm/amdgpu: overwrite signaled fence in amdgpu_sync
Date: Fri,  7 Mar 2025 14:48:11 +0100
Message-Id: <20250307134816.1422-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307134816.1422-1-christian.koenig@amd.com>
References: <20250307134816.1422-1-christian.koenig@amd.com>
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

This allows using amdgpu_sync even without peeking into the fences for a
long time.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 86c17a8946f5..bfe12164d27d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -135,11 +135,16 @@ static bool amdgpu_sync_add_later(struct amdgpu_sync *sync, struct dma_fence *f)
 	struct amdgpu_sync_entry *e;
 
 	hash_for_each_possible(sync->fences, e, node, f->context) {
-		if (unlikely(e->fence->context != f->context))
-			continue;
+		if (dma_fence_is_signaled(e->fence)) {
+			dma_fence_put(e->fence);
+			e->fence = dma_fence_get(f);
+			return true;
+		}
 
-		amdgpu_sync_keep_later(&e->fence, f);
-		return true;
+		if (likely(e->fence->context == f->context)) {
+			amdgpu_sync_keep_later(&e->fence, f);
+			return true;
+		}
 	}
 	return false;
 }
-- 
2.34.1

