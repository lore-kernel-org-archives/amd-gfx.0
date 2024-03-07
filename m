Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E6FC54E58
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 19:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2968010ED33;
	Thu,  7 Mar 2024 19:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=froggi.es header.i=@froggi.es header.b="arrrh9dW";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE9210E38B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 19:04:54 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-413129b0cc2so6346155e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Mar 2024 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1709838293; x=1710443093; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJitx3GushnQPx39r/QJ9b/HXKTpuDcX2u8DXI7Aa3w=;
 b=arrrh9dW/weBn6GDU6yhZIXjxkh3254F4eJh7tFQt8j7aetrbLc6tzzKZ34o4MV9qC
 rOpOsI0uFAdOOw6yVsnpo4919ItEHRSFLGeMvTrdgtIQ7sFAcS0kd5QdiaIrY/GVg8+0
 341X7w3jGZbyNvx6aC2qG6VFu76M6W9GNsQVrN182r1MwmIv0CNd4fa2nhpPxbFLcB2f
 DrO8uio+nY26e0UcRVXwLQLwFMHLBhHG/ap8VI0Bdm5dJrKU4Sk+UeOo5O3UQV7xHrZf
 UQ4v0Xxhuk0WWDhaYCiLMbHiaZphndTZDuTm+fj/lelMOxnITNaQQ2VHfH5qhAPqfWW7
 Dglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709838293; x=1710443093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJitx3GushnQPx39r/QJ9b/HXKTpuDcX2u8DXI7Aa3w=;
 b=R13dyNEfRI2ZpqpyQmr5YZlWvCvDlOYtcuNDDEoLOI2vlbvOK4sSsHlx4qGuXxH7Yc
 C5jPf6qNxdUmu2XH3kmaTf6KXiFRT/wVZwhJrHW2GNQa0ALqyNTjiY3zZPDd72/i92/c
 3xTC9eOJQzpDrEO0rKyxhlgMAuD4H72LhIIwgTbLq6gobQIm4Da5MnTLN65tw10lRLDv
 5EVDzAZiLwksYxG3wcK2XNSCFVDoSpij8jK4aA8RE3PU+dfSAP4IWC64sKTBwGrD0FfR
 cmaPf8KBz70HT0iG9UTQWm8qjwa8LFF1Ox6+d/OI1jZ4xiO4MxMyQQwipH8+dwR0pfYo
 fPdw==
X-Gm-Message-State: AOJu0YyJtNsrjxu75aonjnjvGD0CEv/FrDu6ZD3amxCn1Zp2YUAfEgEo
 D0Oq+5Ht9uNeMoNues0K5TH3YeZ2VbUaFTd3oNkhVjKvWIUYuPcdwjNUE8ylS66dlclcVQPD/IT
 N2uo=
X-Google-Smtp-Source: AGHT+IF+DSKHr6PlK/tMrh1ta5X/S3H5YLAKelTF7nKs4v6C5XUKQU+eaCHTYwsq2j+/y4Lc7skvfQ==
X-Received: by 2002:adf:e54b:0:b0:33d:73de:c1a0 with SMTP id
 z11-20020adfe54b000000b0033d73dec1a0mr11916466wrm.18.1709838292633; 
 Thu, 07 Mar 2024 11:04:52 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a5d44d1000000b0033e5b28c97csm4105713wrr.37.2024.03.07.11.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 11:04:52 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>, Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
Subject: [PATCH 3/3] drm/amdgpu: Increase soft recovery timeout to .5s
Date: Thu,  7 Mar 2024 19:04:33 +0000
Message-ID: <20240307190447.33423-3-joshua@froggi.es>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307190447.33423-1-joshua@froggi.es>
References: <20240307190447.33423-1-joshua@froggi.es>
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

Results in much more reliable soft recovery on
Steam Deck.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 57c94901ed0a..be99db0e077e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -448,7 +448,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	spin_unlock_irqrestore(fence->lock, flags);
 
 	atomic_inc(&ring->adev->gpu_reset_counter);
-	deadline = ktime_add_us(ktime_get(), 10000);
+	deadline = ktime_add_ms(ktime_get(), 500);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
 		ring->funcs->soft_recovery(ring, vmid);
-- 
2.44.0

