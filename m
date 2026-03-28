Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587DEF3D5FE
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C7310E2F8;
	Sun, 29 Mar 2026 09:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rMzqlMDu";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2056110E083
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 21:39:07 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-66b957dd76dso684415a12.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774733945; x=1775338745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
 b=rMzqlMDufg8m8KuP4UKMMCdVpUqWT3ToeqnVoR72vQEIrD2JGArek3zpOEq2eIQ/B6
 9yBVzMb/zABJ6JTCIKRmKvIIrXKEUroCB9gXe1R3hF2A3URY3tRlEZnlQD6IhZ66SGiy
 tlvCRdLSM7RQJMNBF0GqlRsT8HeHC5T+pyU7ZQMf28HvHDAF7QO8glokwpqbSB/JVxLx
 XqXmSJQs4KI+oZGGRVEeTHz4FPICL8BssBA9BVZN05tEy0+Ct4xVJcBUf6Xa1fMFgfPx
 N+CtLvKSiACePgKRtBZpCEyWY8LD1nRYZILR8FEq+fcZehNjlncGPwPRONGVz44Gr6q7
 seCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774733945; x=1775338745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
 b=QAxnkAGiY+OOmFFUX7o1BQRFeplhukE2qBIeNj4Wjm3196GbOkA2cqDDp/4KwwugBh
 se6W1hkFXslUVGa65iLQQP0DD1CC7Ig/jClHYYWequzSPpINNSyNJl6x/cXlXGeBJkRb
 /UJIhmw9+hINkwqL1xiz++qXQjNY153jGFpy8Ddt9a97JGGJqV3mEUK0zsafUSxaXzGr
 2WjXVx88f/bdLWt1tvnYhIunBRuG78nLB38nKa+DudrKDL3TqdkjyVGZXTUFAPurabgu
 f7EgdnMZ7iXGjb/XuRGAEk/cVyK+VZwZdpBdFwDkE3V60TgKhqnW9GhJ3EXE9GXUcUew
 WFFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLSTiBfXV9bZhTkQ1yOztYfxgVDeabjRqcRpeoBHBjPBfpRLBytBw4G0HjO3Jji5YZ2TxjS5/t@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyamEn1agA5LN31DQlAoux+jw3fVTAEoDGDXSdwrBIqh8lyR+cE
 8iGS4ZL0lDK2SfECTZJEpGNSY+SZ5aCsx/GxLBnnWcwC8SI1kzfeiwfT
X-Gm-Gg: ATEYQzyAyRniWVV7cJpdCY0eaKpS2it5HvALA5OSCh5Cv9TlwTIGYLOqjox/HHmzf2O
 6gL9JQWmgb+bma1pHi6qfP0dtC9M7EgChUnVPvtyjWHQKuC+JLrfy8JBzU6wD+K78c0kes9r49r
 5WA+F0inuRw9LI5f1tMmOJkua1v79f0w/cK/Lrkr/qOq4CdzJAGzZp8Nna9GaYs8vqit35tfMQt
 fVfj6OYDanv9zjrb6D/xws8oQWg/hUf86fiuCaT+MP+AIM4+OzESy8F9qmamZFWqH1DGSJXINSV
 9Zu5IQMi6QLyTqyrWhBstsFfuALae8icPKj8VjMCGP1/xwpeAVF7zkyK6Id3TTNO5G+KYyfxuSW
 8cYXj2cwta4xffNF9bA7JyeAUpRXieJE3oNYObEKoPpXP4J+AIw8YmZ0/xwrYo6k++Nd2cQ5o9d
 7AhK2i7xOS0b/6gr2aO6scV2UzoTGQJJxd
X-Received: by 2002:a05:6402:4618:b0:665:e9f:9021 with SMTP id
 4fb4d7f45d1cf-66b2855f8d5mr3612343a12.9.1774733945154; 
 Sat, 28 Mar 2026 14:39:05 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66b75f84708sm909093a12.21.2026.03.28.14.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 14:39:04 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amdgpu: fix sleeping allocation under spinlock in PASID
 IDR
Date: Sun, 29 Mar 2026 02:39:00 +0500
Message-ID: <20260328213900.19255-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:57:18 +0000
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

