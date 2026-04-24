Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0161AFF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE0910E633;
	Mon, 27 Apr 2026 08:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a7dCTalx";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBE310F5AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 14:08:19 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7dbd23bc684so4435144a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777039699; x=1777644499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCyLy6DDJKSoLzccYLKiC2rCMua8OU8Lv96sFiOKNFg=;
 b=a7dCTalxbGgbrx5tJuoRarIHQe7SES//NfHJiV12MmUEXeCWflq9gNGYqnvLrCLpQI
 ro9lGmIcqQilKbEgzYv0UOnz0J+EDsYoyzL1LsshqUAo/Q4Wa9LezJ4zO++RQ554uqWn
 6ZiwbXPKiHw/guy71t0zs7Exaq6CRtWf9tzEoewB1DxJvR+bWzPJTKphKEy8gZetLy1o
 8nLpvd58NgUrKwx94uYDo3w92ehmeDtBj2pI6vQZ3FrLdMARCPuXE3+gTXrUAMss7TFH
 omX9d+jPpGbMDNnNo/XcDCDBaTqvNpFDq9s7+fF8L65z8vpytYuFlVrdScSDa2CYWSZ8
 FMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039699; x=1777644499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QCyLy6DDJKSoLzccYLKiC2rCMua8OU8Lv96sFiOKNFg=;
 b=MjSxgJ22QCQn/UHjV5reiVdwJdmnVs8K/38zmPvTHXHFHevSVMmDps0dAAgW2xM2jb
 yxfKnebAwl2Wbn+YiidXVZUcHZEZ2JqV0uXemL0kfczHNLq3L1JiTmbyneeg66LtrhJn
 YvAvXIOLTIZmrvBaWvdpxch3qD6ktxWO+Okb9I9SQJHGfFLX4/KAbeTGI3eeUHsRtq5y
 wGlneqFee7KOCq45RoMohBAvIFKBQRVFvfZz4+t5MwYdTr8XZF3LnlvaRH/74+wdnSBZ
 taTcOp/JSe5L9VsGpo21ZKdPDYhDu3bVqfT3kRo/LBP/ZQhDZGgQ8DYjutHNM99irJNh
 Jq8g==
X-Gm-Message-State: AOJu0Yx9YzpP9nZ/J+YwNE/7iREa1N0gRgso4rA6mD5B07fARJPg7qvR
 Nsrt6BmP6JaWm3MbZ1l5rC1xG0O7Sod9kVC7JJjfJYQ1t+I4kD6HRnCNziEnGIs=
X-Gm-Gg: AeBDietsBUUF+R0qMBhBUMjwVEk8yqJtAH0OFnE0r1XkrL1sWb9HyjcpvaPhLYdMKYB
 V2eYPUQmtoNj2sTa0vKr9D+O7Z6mYV0J164QN+DUve3x9vfRa8hPyovj+U1eJ1EXwMDGxAomx6m
 D67O/ntWcBjdHJvmMjBugWd420VhpXLq/QQkCsF9YV47j48VixCTX7Xp5pyNBEhbPF/SxELa+ZI
 BUIcD3fd2omEVZtn/EfO6ZWXV9A0ztsDt6em7L2YpVuNW0xqypyAsxhT1+Qynp3MUEbhWyQ4E6M
 VnFjjTUYJ9hWPR4qMtyNv32kFD6148ddsTi6Nnh4+E8RUYZJNEsHErtOd9LvRPNS6yHb0aanaKY
 CqL9/F/jKIBF2y5ATM4GC5VG5SCjpQan4a6OjrhP5p5533oxUHeDpXk3IaXi5CbuPKSmDcGzAz6
 iU9b6YzbBEdLwJrooVBoG3yWaUzdJE/YEE9A8nkeOf9pGUuuBe9/f9MvoTcuqvUg1Gur2odHicg
 feIxFZNu0DSfrPeL8ddK+2CtnGIevz78xM=
X-Received: by 2002:a05:6830:490e:b0:7dc:dd19:7f69 with SMTP id
 46e09a7af769-7dcdd198242mr9266087a34.17.1777039699009; 
 Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, stable@vger.kernel.org,
 "John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 1/2] drm/amdgpu: reject IB addresses with reserved
 byte-swap bits
Date: Fri, 24 Apr 2026 09:08:15 -0500
Message-ID: <20260424140816.43766-2-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424140816.43766-1-jbmoore61@gmail.com>
References: <20260424140816.43766-1-jbmoore61@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:37:19 +0000
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

Reject IB GPU addresses with bits [1:0] set early in the CS parser,
before they reach ring emission callbacks. On legacy AMD hardware
(pre-amdgpu era), these two bits encoded byte-swap mode for IB memory
fetches. That feature was dropped on all hardware that amdgpu supports,
but the ring emission paths still contain BUG_ON(addr & 0x3) assertions
that crash the kernel if userspace submits a misaligned IB address.

Add an early check in amdgpu_cs_p2_ib() to reject such submissions
with -EINVAL before the IB is allocated, and a defense-in-depth
WARN_ON_ONCE in amdgpu_ib_schedule() to catch any that slip through
from other code paths.

Fixes: b0635e808290 ("drm/amdgpu: implement GFX 9.0 support (v2)")
Cc: stable@vger.kernel.org
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 10d8dcc3a..53f537f3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -379,6 +379,14 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
 		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
+	/* Reject IB addresses with reserved byte-swap bits set.
+	 * On legacy HW (pre-amdgpu), bits [1:0] encoded byte-swap mode
+	 * for IB fetches. That feature is deprecated on all HW that
+	 * amdgpu supports, so these bits must be zero.
+	 */
+	if (chunk_ib->va_start & 0x3)
+		return -EINVAL;
+
 	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
 			   chunk_ib->ib_bytes : 0,
 			   AMDGPU_IB_POOL_DELAYED, ib);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f1ed4a436..3111d2c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -272,6 +272,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
+		/* Defense-in-depth: the CS parser rejects misaligned IB
+		 * addresses, but catch any that slip through before they
+		 * hit BUG_ON(addr & 0x3) in ring emission callbacks.
+		 */
+		if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) {
+			r = -EINVAL;
+			amdgpu_ring_undo(ring);
+			goto free_fence;
+		}
+
 		if (job && ring->funcs->emit_frame_cntl) {
 			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
 				amdgpu_ring_emit_frame_cntl(ring, false, secure);
-- 
2.43.0

