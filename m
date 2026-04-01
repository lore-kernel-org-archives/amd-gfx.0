Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF31D35177
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 11:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7909710E402;
	Wed,  1 Apr 2026 11:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VZHDWHEg";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE71210E402
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 11:25:48 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5a0faa0d15cso7209549e87.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775042747; x=1775647547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8xyKCWGX2L2w0vRQ4XMQooKM1IF5VXY9md7usUI5pIA=;
 b=VZHDWHEgXszYdPqqA4vxoHNMLd+6IG+Y4RlnU/TN8XhnmuEgZW5+0dHmtH4hnUrRQG
 8FQl2BltLdMPxR/tsaOs7IuQGqv90mjU2V7/6gHcgWME+a41iuCpvWsTa3U0V1laEIN3
 OzC27GRIzm4t4F2bT8tO/XCjcZIkVWfqspM+NXnyqSdW+8UvcZmx+gL6L+MJFXxAZ4Om
 MC2kgbL6FRmrbmXRVedTXysY9PtUsRfAUpD58aVDiQpp5rCB6G6PqFbsHE2tJZd27nf9
 jwUVNZgp2sV3ai/oDANktjUinOfTHMHpvQWsVewJXhWBZYZPQ+kQj+I/9Z7cZb210KcI
 TQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775042747; x=1775647547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xyKCWGX2L2w0vRQ4XMQooKM1IF5VXY9md7usUI5pIA=;
 b=LCxG8Wj+GHxsOv71+Jt4zTA397JjxDtpCW3TUI3qWxRHVceLInP7+5RIsWPsp7zD5a
 jlT86KGzcpZEklUzApMD/TA5xioHJuw+KfXD6RT0Mka9wJMfli7qA9wcm3RF8Mda83J1
 Z3ybW8UAzKlPTytMZfTVXNYaaC4hsbTnnxYpivveG8jz+dNP53I1SoAzL2IgnU77x5qm
 kptgLxeN3trU0ab/9GX5EdktSfgdYT28YmMkRlAkNxt4rhwY8y/tdrKp1IrgvCgN+02y
 2tmJjrbwVpz5waTxzWvLF14t5u2Gfvfenpgip2qhgpWnVnyZpfAShyhKA98HouZnG4e8
 Ff0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOi4CJDGdBALcntdkMe9SwyD8o7A1GDCbg9unTY+iFuzCUVsxJFzEtDhFWukNPraOTmi7ucJ+3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWdcWMC5hRI0159b2o2IZ9UfJB2hxPJ4bP3X1XgFwxS/v28QFT
 c8i0c++rcJSTVfhcEF7ccLjujzdkx6SkOOsmo7eHebM4bnYX60GuMkHL
X-Gm-Gg: ATEYQzxLNgLQU1oZhHNQpzwXSWO8xhT/BIO1Y5ZY85QtqsYBYCqs+4+z0/MJpw11tzG
 GQeI3OBDTV9PWMymZ9/urZHyLXIlJZaJgkROt5npA33ojOt2GtdpfFJMEbfZmB+OD9bzHrSbeNy
 3xfWCh1H7JSJ6UdKMdeA0I1nykaLAt9O9/Za9gAQ1ik3JSScH91UW5ixC2homLWvgddTYQgIwPs
 psEJ5rZ6BsLksa09/Y3DPXLD+8CORUIAZ6Ad5FuanYcww2JJ+Uy92fmcqUYP6UhPuV1JzHGhl7O
 3yIQ/6rmGe48m4/gPEUJxKRBLHo/4eGIpr+Dz/f8gU3zlsdG9MQVBZ/S+rcdJCwsOi3nY/ZxkPr
 i9IshtuOvTMXRApJtQPPugh2hK1nOtwEj7UzlmsUYO+rLGIluytAXWAc62Akbx0NvWkdjEUluqQ
 5JEwC2rS6Oc0OleNYEhXxvd9x/OQfipu6avQ==
X-Received: by 2002:a05:6512:3049:b0:5a2:b884:153f with SMTP id
 2adb3069b0e04-5a2c1ee87f3mr1190860e87.1.1775042746683; 
 Wed, 01 Apr 2026 04:25:46 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13b13bbsm3256191e87.0.2026.04.01.04.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 04:25:45 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3] drm/amdgpu: use IRQ-safe xarray API for PASID management
Date: Wed,  1 Apr 2026 16:25:40 +0500
Message-ID: <20260401112540.451773-1-mikhail.v.gavrilov@gmail.com>
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

v3: Shortened comment per Christian König.
v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
    amdgpu_pasid_free() instead of xa_erase_irq(). (Christian König)
    https://lore.kernel.org/all/20260401104859.36990-1-mikhail.v.gavrilov@gmail.com/
v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index a6ac3b4ce0df..a1f72f5d31d6 100644
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
@@ -84,8 +84,14 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
-	xa_erase(&amdgpu_pasid_xa, pasid);
+
+	/* Called from IRQ via amdgpu_pasid_free_cb, needs irqsave */
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
-- 
2.53.0

