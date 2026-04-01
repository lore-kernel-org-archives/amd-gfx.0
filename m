Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B791D3514E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 07:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EF810EE9A;
	Wed,  1 Apr 2026 07:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bXNn8vX/";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2A710EDD4
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 07:36:45 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a1307438ddso7189686e87.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775029004; x=1775633804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QcdqkcoFWcnZRoFYPOodBex3IYIVOtQ1sm2KoOI9YB0=;
 b=bXNn8vX/xmaS2XLddn+JuqGbwsjANMBJ1KjF4q2LUvi4ANsfqAshYz0CVAxaMDNDM9
 6YikUGH2spl5oBhQvPK2vdP92PTAf/4nElanpalFzCTpdMrr/eVrl4Kdf7JCts5FhiSa
 j75e6p95RizKQPvZ8Skhp96oJCcoF7hiMdikulKPN6W3tawosijyZz+OgVvC2x7alHgF
 wdYq4KKfBxufoAuATE/oDSlm5UACKBmLqW+j4dMdcOyMP4R3ExZ79HHyr3VwxMlXhCJX
 VPZ+w+iAlF+OxIwG+Pg7nfqoh7vF+IJA5pYQ4jR3V+sQYcn+ao1rGExotFPauNEDxd4y
 J1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775029004; x=1775633804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcdqkcoFWcnZRoFYPOodBex3IYIVOtQ1sm2KoOI9YB0=;
 b=VyeJacJe1jcMvUfUIk2gqYcrDnx6a+yp6rms0xxSDEzsuzaj2h/v1QA0ccognkcboh
 /ikTbr5KjUOamnprwtL75vfHO3Z2UPm35abawypfkZSECLwOrcsEyoYL7pXfl4g3X7BU
 avurR1wp58rBRRprzZVjIdr3yYSQb4uNwnv0IdcZQUiCY96G9ZPAVMoyIvitoEdcRZjK
 VEB8F7Z8jfQ8MsMc1igZQO6sVjkyK0HMpDof3d2ODMw80qItPHUjFYBV8ZGoqZp2kMo0
 105eMgUApS0D+CCVTvVWXULKknl/4p/TXnb6kPt27j5yp7ojmfFoQvIGJAi6I9vAIvso
 jyJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsnjXUjIeLd3uF/oQ48Y8zZhV6THb0jMtIPAINhPs2EVusvhNOnOrFKYJJJ7d/egvbM5oKXakX@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4YYXrKG7EVcq7O1r0iUpp7DyPSbh/NhlhL7lHKBo1GtWKsvIF
 F6XPBhJG8/EGaCprJ8IHmnwSgmn1R/hUt3XmoCq259XxtQTu7SPDIOYJ
X-Gm-Gg: ATEYQzy/UcnCng1llGCbypDUpJxrkRDQOlycO+35nBoQk+2449hmDR9NBPL/ytm99pb
 wHPPmJgdLs3srikzi5VzxoeSOkcO7JGJkW7DttSpCOimladDvNqToy2K8jVGt3QL2UeRf12Bo0h
 rlEgFAeI3RXaT62Lu1fvCGlaKsEuGl+igyPHXGzFyqYECEneZETMZwuQzf5w+pT2/SxCKqOtF9K
 lGXGByRzQo6pvW4w1vEePxHJjG9nydp9G4s0W/nSCwd1HA+Be5qev5VziWXjU+dagopi18ynjVP
 joIiQkOHCL85WIeOKC3yETg+ZVcgo4XEWRwkWCi6jL9OLX3/MlpGuFWuyy1UBdNxCdfrIg0yfqV
 NZ9615Gb/aINvibX1P+UuZKPPPOebViWjHeUhvOzXY4wHutUY7esXMQojFAFxPSOPSkvsgZ1yVE
 rCGkP2Wx0HXiuANfGYBLG7baKpIZzpS6l21w==
X-Received: by 2002:a05:6512:1152:b0:5a2:7d1a:4043 with SMTP id
 2adb3069b0e04-5a2c1f1972amr911388e87.20.1775029003339; 
 Wed, 01 Apr 2026 00:36:43 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1443f23sm3230048e87.42.2026.04.01.00.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:36:42 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amdgpu: use IRQ-safe xarray API for PASID management
Date: Wed,  1 Apr 2026 12:36:32 +0500
Message-ID: <20260401073632.101796-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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

xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
regardless of XA_FLAGS_LOCK_IRQ — the flag only affects lockdep
annotations, not runtime locking.

Switch to xa_alloc_cyclic_irq() and xa_erase_irq() which use
xa_lock_irq/xa_unlock_irq internally, fixing the IRQ safety issue
for amdgpu_pasid_free() called from hardirq via fence callbacks.

Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index a6ac3b4ce0df..64d0da28441f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	if (bits == 0)
 		return -EINVAL;
 
-	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
 			    XA_LIMIT(1, (1U << bits) - 1),
 			    &amdgpu_pasid_xa_next, GFP_KERNEL);
 	if (r < 0)
@@ -85,7 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
-	xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_erase_irq(&amdgpu_pasid_xa, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
-- 
2.53.0

