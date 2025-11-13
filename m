Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503ADCD6E78
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FA410E855;
	Thu, 13 Nov 2025 14:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GF0mqSEa";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3D0D10E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:50 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-640bd9039fbso1724929a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045629; x=1763650429; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VvIMk872eUcGrvr4oYbCLqZzU34y/qoctkmyPmiR2qE=;
 b=GF0mqSEaZ6FeeT0MGjhC2/gxOBEIJriunGSex220Pll8bEHQs0Ir/3PY8cVbPaKBXt
 HuC6+IWfbFvo6WAyJNM1o90uO0muqHMU1pjLuDzfa8A4V/elRs2NpbsL8+nF6t+UC09t
 bgW8FK/nL37XJj5rC41srmyX6Hnt5VB9LWTE2geOTgv21zWLeC5GqEfzKiXdCAgX0gnS
 xOrTl7uGoM2FAuNU1i4qD0KUMMxI/K+YfX+pqP6bWPQUOK0OOJT7KXwv92t2auyz6zbO
 Eu/2x9+9BjjAxuFGVxKNAWWuJuxFdoSy90B9Mh1JZ3q1GrtoGwVhSDNpPXueut6jHvBi
 fpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045629; x=1763650429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VvIMk872eUcGrvr4oYbCLqZzU34y/qoctkmyPmiR2qE=;
 b=JyyVib9vjC8aDzFYJRZnSs+WVdCrqWensCAij5yFFScV7lJ2h6C0+/+Y1WBjopsXWK
 y04wjrrwLZ1SBqFeLgCTQkVOo6iVuAZEtrkqa44VyAqXR+ZUrzyMyXG5zBbTtYALLY34
 m9tzEmadaMhOpB+WEN0/W/uZUyOV9NyeocSsScR2ne7/sabC8d5yJ90OxXw32f6f/cAw
 iu2gPPAnlDYzQg6movx7LqZd0QybpXXf0LendGMaQm3PHruCYxCga/iW9I520G+iA256
 OTDI2YDaUwCqOBD9oFHezHzpr5ZZKeZjT1VUw3ug70pHtNbyJkGAkIuG9DhF5n/bQ0rV
 xaqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXML4O77CdWJSSJw8XIJl8oEo/R8S1syJaBa0S2llqqebWx+hGPBNdvPOxZrIvs68GY32Xxpwbc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxptHtX8IOcg0c3fLsy+HngzHdCNqQ1HQ4YqxiuGVsrDy97noW1
 13oNGPUCQNcvLuqnqscUbWBRKulf+TqHIfJd3A+jAWdGD5woE8hwPEbs
X-Gm-Gg: ASbGncuJoLv/ldfiRwiEhcsM13sFOzmbjMwQEMTjpNC+YOwudr7OXV0g1nVGgIjJ9Ky
 jSSROPQezKZ1gIB4KRXCZpjQClmIj8dp/mX9eciGXLqiHIP4dQhvKt30ZYyhMRbXhfxwHs0K/0S
 ekU3Wx9LkwKjDCNaTcpmdtOIwnrwuq/Xty83JaBj/UjcZl6mEZeGFEHTTXvp3nsqpEblj+Y2wU0
 HfRLc8MNbjFslVfgKzaAIB2tACGvPGT3NRqAxqI9wxe+u5v+lk0nM+qQIxZaxy10wIT+JuCK/Ke
 h6PPTy6Zmyo8S0n3z3GkgZLr6yxKMLarPfbRrFDUlLpWHfrFZI6CO3Wxn4bhPuh8hkM4VzobhlR
 kaK/N3NPFM7t+dP1OL0HwVn4LAw1GnQCSz3672r9jBrH6uH8mWuXV9dSw2YqZ15x/kBhXkw3pr1
 pv/7/TUmUXawE=
X-Google-Smtp-Source: AGHT+IE/99yJLzL1YvwaBMM+Q6kz/sb5G9lncACbhK/4baxWDS2QRo+Q6OgU+cRk722RQAFO4cEcfw==
X-Received: by 2002:a17:907:705:b0:b73:1634:6d71 with SMTP id
 a640c23a62f3a-b73319af12amr827751866b.26.1763045629179; 
 Thu, 13 Nov 2025 06:53:49 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:48 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 18/18] drm/xe: Finish disconnect HW fences from module
Date: Thu, 13 Nov 2025 15:51:55 +0100
Message-ID: <20251113145332.16805-19-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113145332.16805-1-christian.koenig@amd.com>
References: <20251113145332.16805-1-christian.koenig@amd.com>
MIME-Version: 1.0
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

From: Matthew Brost <matthew.brost@intel.com>

Be safe when dereferencing fence->xe.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_fence.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
index f5fad4426729..8181dfc628e4 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.c
+++ b/drivers/gpu/drm/xe/xe_hw_fence.c
@@ -159,9 +159,7 @@ static struct xe_hw_fence_irq *xe_hw_fence_irq(struct xe_hw_fence *fence)
 
 static const char *xe_hw_fence_get_driver_name(struct dma_fence *dma_fence)
 {
-	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
-
-	return dev_name(fence->xe->drm.dev);
+	return "xe";
 }
 
 static const char *xe_hw_fence_get_timeline_name(struct dma_fence *dma_fence)
@@ -175,10 +173,13 @@ static bool xe_hw_fence_signaled(struct dma_fence *dma_fence)
 {
 	struct xe_hw_fence *fence = to_xe_hw_fence(dma_fence);
 	struct xe_device *xe = fence->xe;
-	u32 seqno = xe_map_rd(xe, &fence->seqno_map, 0, u32);
+	u32 seqno;
+
+	if (dma_fence->error)
+		return true;
 
-	return dma_fence->error ||
-		!__dma_fence_is_later(dma_fence, dma_fence->seqno, seqno);
+	seqno = xe_map_rd(xe, &fence->seqno_map, 0, u32);
+	return !__dma_fence_is_later(dma_fence, dma_fence->seqno, seqno);
 }
 
 static bool xe_hw_fence_enable_signaling(struct dma_fence *dma_fence)
-- 
2.43.0

