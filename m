Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61297D35175
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 10:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E153010E1DB;
	Wed,  1 Apr 2026 10:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EFiIGYeP";
	dkim-atps=neutral
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62B310F04F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 10:49:06 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-38c01150eb2so55168971fa.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 03:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775040545; x=1775645345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F9UYWTpgkmHiwl2xz9cys6shKpNNbnLAJljb0/zu468=;
 b=EFiIGYeP0Hk7AMRcb0pW4wgp1LJHGADzNUctGzg9xceKh676OFZ++EwYu4y0xV5kwT
 TjC6WCaXc6oDzVBSLcp3JdMBUEtiUE83iGppcl4K5HIzjWvG+jRakxKsc0h2tvvdlfjM
 YCCuU+3ZtKBXBjVPcnotysmvBjUcKewPsUru7nHOCHDI4xpkUIcpeuAQsmvDEEikFTeA
 0ZxVDQP2yl8vjK00M8tgXdNq+RNIsFBC4cQ674bs+WjT55S3Pcn9BIBwcowl9d9i+dWS
 ac9jEz7G1VsLwtnvcciG2P2sU+gDQXe5/V8EK0Byr64Vk7zBuh0vAktjBBYDZ3YEeBm/
 ZE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775040545; x=1775645345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9UYWTpgkmHiwl2xz9cys6shKpNNbnLAJljb0/zu468=;
 b=GRPIiuZW8PXvsLG1OB782UPSs2ZlDyH/Wza0kkZTgQXFd1AH1oB2b+jR7zZJkyUNPf
 LU6xynArdNsNgDaPO0kMZqDtBgaAItOlW2Oaccvu42e4Es0ZoKI8MnIUyiI82QLLKdcU
 cvC1tJ0qS5vZDjf3281zsAjP7U/4NKFyynttoRvtJM58l4tjVI8glRpIY+WwBRx8lmdX
 pnwGp8n8sm6aL7abDfnrCMQz1TNYENPO1nRaIjmyBRSsiDMqCiVpJNeX2t3FosXigGF2
 i1XlGqtzbq4QkrsCQiqoOpuuskThSB2Ykx033c/h0e53y52hd81YNjrhYfPCcC4zg4M1
 xU4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTjX4XZj875QH3z6Oy5TUYrKVb00EedMhD9tykn257sFda82mN42F060O8UF1Qtk1fVuDPCXOT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxfuTuYhxEuC8W9r8aN76JC9GAwD1d6gum0o0TKByV9J0sUHOT
 NGOvypKeQv3AZ7PxESOXf/oKj3OuovrksVkYedKf8NhNyvqGt+HMS0P/
X-Gm-Gg: ATEYQzyPWv2tsz7GXNyT6W6/NeO0thS2nwt1VF99sm80xt1ihxYFs7WxXZXpYZ7ZHeq
 GR+fWkpxo4VdJCJzjQGcMMBWSiLMFf3PV9aZYlb2UGYUlC79filPJ193I9FLzyGv47tXz8Qfjv3
 Q2udMcVnCc3Yz17YSjusL3NPnfAXYJ1xAbR44CkiqSpoMHQrXdishuoCJbAdg6+IQIN9E3+UlX6
 5F40urNNNS8V7j48oV+WlLxBIn5pOCLU/w5HYDbFB7YkS8sBhIRcXjYewNEaTx22bwfoHi9IcNt
 gDTdCWl1SkNl/2h8RLkpvAWIUP2R+619rqYw9cu7kodQWa8un1I9eLsBPxY1XT0DjZdjDZENM5q
 90CzGYnumAqBoa8tvBq6ZPwBrsRrdHy3Q5hBxSkSDhKr2ifQWXAXkrocGcPn4qx6uNBQ40MfeQt
 XC2TJoBzUHMIF5kdwzrnpX4UFNvVT48tnvdQ==
X-Received: by 2002:a05:651c:41c6:b0:38b:f632:e0fc with SMTP id
 38308e7fff4ca-38cc2f199a2mr11399581fa.1.1775040544787; 
 Wed, 01 Apr 2026 03:49:04 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cc97315bcsm2632721fa.38.2026.04.01.03.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 03:49:04 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] drm/amdgpu: use IRQ-safe xarray API for PASID management
Date: Wed,  1 Apr 2026 15:48:59 +0500
Message-ID: <20260401104859.36990-1-mikhail.v.gavrilov@gmail.com>
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

Switch amdgpu_pasid_alloc() to xa_alloc_cyclic_irq() which uses
xa_lock_irq/xa_unlock_irq internally.

For amdgpu_pasid_free(), use explicit xa_lock_irqsave/__xa_erase/
xa_unlock_irqrestore since this function can be called from hardirq
context via amdgpu_pasid_free_cb, where xa_erase_irq()'s
xa_lock_irq/xa_unlock_irq would prematurely re-enable interrupts.

Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
    amdgpu_pasid_free() instead of xa_erase_irq(), since it can
    be called from hardirq context where xa_unlock_irq would
    prematurely re-enable interrupts. (Christian König)
v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index a6ac3b4ce0df..6fc6859d9329 100644
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
@@ -84,8 +84,19 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
-	xa_erase(&amdgpu_pasid_xa, pasid);
+
+	/*
+	 * Use irqsave because this can be called from IRQ context
+	 * via amdgpu_pasid_free_cb.  xa_erase_irq() is insufficient
+	 * as it uses xa_lock_irq which can prematurely re-enable
+	 * interrupts in hardirq context.
+	 */
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
-- 
2.53.0

