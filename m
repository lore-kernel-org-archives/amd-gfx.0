Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E80C61DC6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 08:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC6610F2CE;
	Fri, 28 Aug 2026 08:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="N+Y/YQoB";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6077310F0F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 16:01:52 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ee1so109166b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1787846512; x=1788451312; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yLi7v7g15LnedtmXwdYoapwhUgM7Q6Gg36WKTShpPEs=;
 b=N+Y/YQoBe2v6gajdo2uvdxJj1cHegKzMz6ftZ3cY8+3gdmpootmqFIH6BgQjw1EXfH
 RF1WPHtxxg1Bip0QnjZtfdh6gXtYfWAPIemqrmwNJwtkH0r3+ItyWGeWIRyjMgDgPDIk
 kZ1MvMn2XVjnNzD/5rGJw5dgID9WgCH2JieGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787846512; x=1788451312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yLi7v7g15LnedtmXwdYoapwhUgM7Q6Gg36WKTShpPEs=;
 b=gEHmMUOsO9VC+HsMHUZsfqIcmiyvHhW85TOuZGDS/p+BNcYafwqaEi4bGUkSVjHCuo
 HsCHHCOvtOPl6QcryoNRNPrA9aYR8NVdjIGjUbgPODLKxOwOvOL+PSNmXj3kJQ/maN81
 nm93aW1wckdyZRKKGTwFeIli9TXbQ8hi33JCMX0EFqkuwoqc6T+RtVX1q26s1TH28Nyo
 PmMNxwXySjDoXIhe6jUBQNGMY7fOe2c6g80EG0E07d0KykDdtk+7n04j/He9mumCwqjk
 AtbZPwm1dkcn+gKWudDYQtXTx8nHPYRw4qohewqmF5GeRIFKXnZy7uONVSemoixpBYfQ
 ZZuA==
X-Gm-Message-State: AFuF++lCpORhbcJhmf3M2Izvc241bSHTzkooQLi5b2cn7u6DOc4bc+cG
 LhrbrfWkhib9eqF3DtaFrc8TVspGY14JKzj1cuN5QEQdLMCubLaOB8mplv4QLKtlMLc=
X-Gm-Gg: AR+sD10qHj7wFrA6yh3JFIk0vfpCZ3TTFh4JU71gkq2lySm6a0hiHnvYR/LhBQTVKzy
 U7HSlevC5svUYqSe6M8J2bztOhZcIQ9yfven3O0COuEj8gUHLye6HirIYaWVOhRbF5vvIEUR9gE
 2dxOeGklrvdjTJUqHKD59lu3fs2g2hRNdeY48f4kh235WU1KqjoS+A/CKaP8KIFh3iWrzcwA7SW
 EbNk8oHKY4d7Z6fdR8uXm98nSP/1+s/izF8n3xM9kKTtRkpCSLE57ErSDyEwIqn/mEDGYIW2N0G
 RBn35aHMvIJcnKHiyZAfq7m3kkvAz4Rg/6edLLxeXvFMQ46mpI7Svc7VKyj31hFcdwZ5dC9KeXj
 Y2lwVH2mqkPtTsbRB3ih1BBhJ0t79xLK3BwI+Uw0zAJqDVXKNDuBw5IXdaFKh1jiRSloaKELnw5
 00taShmfDGdESXp46vmYv4Kk//Iyr1pUCGC3mFnMPJTjhkb0AFJMbbaB6B2Q==
X-Received: by 2002:a05:6a21:4a97:b0:3d1:5c01:e6c0 with SMTP id
 adf61e73a8af0-3d15c01ef14mr12486129637.11.1787846511540; 
 Thu, 27 Aug 2026 09:01:51 -0700 (PDT)
Received: from 1c1aead48890.. ([49.142.45.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535a8bd941sm2178632b3a.18.2026.08.27.09.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:01:50 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>,
 Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH] drm/radeon: check radeon_ttm_tt_pin_userptr() return value in
 bind
Date: Thu, 27 Aug 2026 16:01:23 +0000
Message-ID: <20260827160124.679309-2-hsj0512@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827160124.679309-1-hsj0512@snu.ac.kr>
References: <20260827091532.340141F000E9@smtp.kernel.org>
 <20260827160124.679309-1-hsj0512@snu.ac.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:59:57 +0000
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

radeon_ttm_backend_bind() calls radeon_ttm_tt_pin_userptr() without
checking its return value. If pinning fails partway through (e.g.
sg_alloc_table_from_pages()/dma_map_sgtable() failure, or an invalid
userptr range), ttm->pages[] and gtt->ttm.dma_address[] are left
incompletely populated - containing stale entries left over from a
previous bind cycle, or uninitialized memory on the very first one.

radeon_ttm_backend_bind() proceeds anyway and calls
radeon_gart_bind(rdev, ..., ttm->pages, gtt->ttm.dma_address, flags),
which writes those stale/uninitialized DMA addresses straight into
the GPU's GART page table entries. This is not a bounds violation
(the table indices themselves stay in range), but it programs the
GPU to have DMA read/write access to whatever physical memory those
stale addresses happen to resolve to, which may since have been
freed and reused for something else.

Propagate the error and bail out before calling radeon_gart_bind().

Fixes: f72a113a71ab ("drm/radeon: add userptr support v8")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index cbc0339cf127..58bd1e73587a 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -431,7 +431,9 @@ static int radeon_ttm_backend_bind(struct ttm_device *bdev,
 		return 0;
 
 	if (gtt->userptr) {
-		radeon_ttm_tt_pin_userptr(bdev, ttm);
+		r = radeon_ttm_tt_pin_userptr(bdev, ttm);
+		if (r)
+			return r;
 		flags &= ~RADEON_GART_PAGE_WRITE;
 	}
 
-- 
2.43.0

