Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAD4D35176
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 11:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE7F10ED94;
	Wed,  1 Apr 2026 11:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKnzZlOO";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165C310ED94
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 11:39:17 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5a1307438ddso7446736e87.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775043555; x=1775648355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0KWyoy8ApK6QZuS34HPMQzVVH9UD7v2GU+JsVx6bs/I=;
 b=DKnzZlOOc2rpKdfRS7D0YFdFGEzZYqhLWaCNV+/alu//HACk3P/HpytVtl9JMZR6Ku
 OJtcKCpZPYXewcnYfJQCfC3lMU9YzC905pycLFWuDG+OpJy9cpCZKlwo/h+kscwXWBd3
 6/anA/ai+3uNC1Uo2BBCjrUWfMa57owaPe2zlnl00huSx4f/aPra6O4dEh6WNCML82B2
 OoixDeY/QwcnP1Wn3b4Q+ObQbzlUMSDaojOkxsxVFz2E6gsc2l1P5u0chXUCYHsClENx
 vmheo7IPl+o4U2EqGp+eWUYAshE3R7ydsbNghzuhFK3u9LraUvNMzupOKmRjPCII3zim
 F8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775043555; x=1775648355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KWyoy8ApK6QZuS34HPMQzVVH9UD7v2GU+JsVx6bs/I=;
 b=hg3WJi01TcRwIsRXbdoeOUTBe6QHaYm4jN7srCSJdl3356aCVKXaPSdDOUnR9131Ig
 JfK3D90h+3vieKL6NWbsB/f/gRZrefLZwf+VTLrcfmbnUBuHUUKdrcpRNWIfwsFs+miw
 mw0CEAiYmyfqqwGCKBzWDF5tLqpjGvIqeNzO80+I8TvXdumZw6+K7T00u/3ZXK6utFId
 XjjpxohuNH4JOlYCw3ymaxL33pncFluhXNcfkOGxNXDYy7dDMpqFOJOoKg0hifTFLJNW
 6mXtDcOZQE6ZgkttvtDFWEwN5ulPsXRqKLbSeTROCY9Q7+4D/IUp6A8BbIzDqCwOqq9F
 PZBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUla435plyJl70px11JgcXEIuN2d6OqhRl/7LTJGKUnjgOmhIwc7hGxz0K+EfkmP+Tzi84WlFKt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxY2R4wHpvBQ9WxinFemqtJG5jGCSPMMVmz0Dr5CNw6w73AAzr8
 4LJ6uaC0snqHf+8QquXnYI/z9RzgLnc9lcLKQWs/GZ84ukwLG1Yrsce6
X-Gm-Gg: ATEYQzxuGTqOnXWeezWEhn0OBLevEMMpxjHw4nro5m1dCWoFJ9MDjkxSDOCBcUUN9HG
 C8Scxa630PSD5J/XtfokS+1CbdjzGROhgtAkcBziO2gPbVHeT0LhdX/l3QWVI3CBelNufOXSu79
 02XD2QcFajjz/NJxvzu86A/8riTsviBD+CgOh6SC0bfRQI9guRuxQ7IafIGx5cirymxV4xPh/6P
 zYPpK8M4GXYCs9BoefvVoT3Sos1GurNz8S4tYq8J06scH+L6geWb1HDpkFB8ydbUDJit/h/Ps0P
 zVw5vfZGwJTmf+1SHRJZC/OaF5xbD4m5tmRu/LtVYbWRNLAuRmDvleRf9kTMW0Tqk7E8szzjK6t
 eT6Zu9GuqDjTdmhalnh/U29xq/DSsW3I4UpvB+fFFdcaaNqLpcKmyvIrAOufdZuctyESjUQfoVV
 adKfVs80sN2oNE0u7+SBgr5wDg9aERInxgSzDldFz92eRN
X-Received: by 2002:a05:6512:1592:b0:5a2:abbb:e1d with SMTP id
 2adb3069b0e04-5a2c1ee1943mr1414992e87.6.1775043555012; 
 Wed, 01 Apr 2026 04:39:15 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f4373sm3374990e87.6.2026.04.01.04.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 04:39:14 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v4] drm/amdgpu: use IRQ-safe xarray API for PASID management
Date: Wed,  1 Apr 2026 16:39:11 +0500
Message-ID: <20260401113911.593661-1-mikhail.v.gavrilov@gmail.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v4: Move comment to kerneldoc, add Reviewed-by. (Christian König)
v3: Shortened comment per Christian König.
    https://lore.kernel.org/all/20260401120055.46498-1-mikhail.v.gavrilov@gmail.com/
v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
    amdgpu_pasid_free() instead of xa_erase_irq(). (Christian König)
    https://lore.kernel.org/all/20260401104859.36990-1-mikhail.v.gavrilov@gmail.com/
v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index a6ac3b4ce0df..684f40fce73f 100644
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
@@ -81,11 +81,18 @@ int amdgpu_pasid_alloc(unsigned int bits)
 /**
  * amdgpu_pasid_free - Free a PASID
  * @pasid: PASID to free
+ *
+ * Called in IRQ context.
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
-	xa_erase(&amdgpu_pasid_xa, pasid);
+
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
-- 
2.53.0

