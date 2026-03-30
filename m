Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8BEFF493A
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 05:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD8910E438;
	Mon, 30 Mar 2026 05:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilPfBF3q";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE1E10E43E
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 05:30:43 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-66bf15430ecso594181a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774848642; x=1775453442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
 b=ilPfBF3qwkb2vyVHwH8hXNXnBFinmYb77CIRjcWpKf+QCu0ZJ4pJsQo55AajdtCwSu
 DXVFV6R7favjCGJYjWAMjQ9JOaRjNV5IERMs7m0MsAhaK992D+WOpcosq4vTGR8t8TCh
 Ycx5avDeN4zpGjfS+4wRQSSyvktSJw/MeKLA0Apt0HvxujBF2uUxlIKH6EEiV+deBJkB
 rHVYfmRVoEzR61mMbJriA1410h0HZOmXn8xgV32h/oCBIa2SyP4cmhQzgUaOCjo5Vj93
 CK5R4v5GrqRxf9xXUvUAhygQSPwJW5dl01HiuynVlcyKeJWXHGFPYM/WZULnFbPftGgy
 Xkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774848642; x=1775453442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
 b=aXxVg7bw5Be1/iUHxfE2iuCnlacfi06/hp1S7NhKxFnRSCHQppATYz4sv2VS6bhll2
 mySYiIE11kWceLy8kFmthcQnDalMrPk6LCvLfuv4Toek9LNu5szicHYGw29NR0lRjMSI
 6aqERjtZvQ82tuiep8cyrDvZPr+PSnFm0DhAWtQB1s0lvD5d+fgfNtT/1dbsYM4rdOYd
 6Bz0sz12Nc/e6wLD4Ftj6aNoNt4b7rK5NS+7bruSMMaov24KcCn3bc6Qy+yfOnLc6aUy
 kFjnZfVlYRVsYijCGu/Dv+Go9SPxUKVAvQTeFf0+6qvYdLzW/BuHI6CCRnu/YF42El0/
 qtow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNykoY7KKXxdDqZbklKuo0WYCNLYdgJ8uNhxfrbGlqTyPYm4akuJzD+TGHpBufjAZ8eGzuIYyO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx70Dodag8MU0ExjgPH4cQjAtDQQPieEN3ofwjOrQfUE2tbeazE
 aLSPfSrhNBf0hMy9TyfqK1wIKjQ8taKMLL4cM3kkR2fowS3tKIdSyqTc
X-Gm-Gg: ATEYQzybAbO0xsQnjacTGfAoAtun3E6PlHYynIJcZo8WCNq0PIqoj7K3zLcw6MGX/xl
 ZcXv36byNIKMlIUPkNJkTSoT0tflvUH7ydGUjQdithFZdC+kmnQHIzJcJ4U7A/61buup18hKE/l
 tfItm3Ud+i9glVttGgXl9Dlq0HPGFTFw1vTX7zf5sHdp6NimH7fzVGjVyXO8Ledm2ujUq4UDggf
 cuHYd5s5yfWgVqE9b7oyDMGzRzbagfe3tuNuYWKYc7Mxm9Na4bEZjoqFlKOeQcIZTPrvZyysgmc
 VZTvUAoNbF0AFqOky/VlLHIgPWSIhjLRnZsmaAZFzkMPjOMFTOLqYKwwERcERILDuuIesmCQfB7
 cpZxmCWAcwUZ7JX79/IjYhDkYZiBOdvepS6ER64kKxftP8t3MZgq4ldsMTClQfTN3t+4o3Fc2eB
 3NGR9E0fVKxEQf1GstBHA7rHM9QCPBlzYZ
X-Received: by 2002:a17:907:3d52:b0:b98:6984:661c with SMTP id
 a640c23a62f3a-b9b50301618mr717804066b.10.1774848641892; 
 Sun, 29 Mar 2026 22:30:41 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5fc9sm240417066b.36.2026.03.29.22.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 22:30:40 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 1/2] drm/amdgpu: fix sleeping allocation under spinlock in
 PASID IDR
Date: Mon, 30 Mar 2026 10:30:24 +0500
Message-ID: <20260330053025.19203-2-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
References: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
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

Commit 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
switched from ida to idr_alloc_cyclic() protected by a spinlock, but
passes GFP_KERNEL to the allocator.  idr_alloc_cyclic() may need to
allocate radix-tree nodes, which with GFP_KERNEL can sleep — illegal
under a spinlock that disables preemption.  With CONFIG_PREEMPT or
lockdep enabled this triggers:

  BUG: sleeping function called from invalid context at
       ./include/linux/sched/mm.h:323
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 570
  ...
  #1: ffffffffc2cd24f8 (amdgpu_pasid_idr_lock){+.+.}-{3:3},
      at: amdgpu_pasid_alloc+0x24/0x210 [amdgpu]
  ...
  kmem_cache_alloc_noprof+0x41d/0x780
  radix_tree_node_alloc.constprop.0+0x56/0x3a0
  idr_get_free+0x330/0x830
  idr_alloc_u32+0x14a/0x2e0
  idr_alloc_cyclic+0xd3/0x1d0
  amdgpu_pasid_alloc+0x51/0x210 [amdgpu]

A mutex is not an option because amdgpu_pasid_free() is reachable from
dma-fence callbacks (amdgpu_pasid_free_cb) which may run in IRQ context.

Use idr_preload(GFP_KERNEL) before taking the spinlock to pre-allocate
radix-tree nodes, then pass GFP_NOWAIT inside the critical section so
the allocator draws from the preloaded pool and never sleeps.  This is
the standard kernel pattern for IDR allocation under a spinlock.

Fixes: 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..515775eab2ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -67,10 +67,12 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	if (bits == 0)
 		return -EINVAL;
 
+	idr_preload(GFP_KERNEL);
 	spin_lock(&amdgpu_pasid_idr_lock);
 	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_KERNEL);
+				 1U << bits, GFP_NOWAIT);
 	spin_unlock(&amdgpu_pasid_idr_lock);
+	idr_preload_end();
 
 	if (pasid >= 0)
 		trace_amdgpu_pasid_allocated(pasid);
-- 
2.53.0

