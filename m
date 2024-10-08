Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB7BCEFC22
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 15:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509BE10E578;
	Tue,  8 Oct 2024 15:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NRblHjoz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC3510E57A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c+Sv8tISLEJhBNHFjMPy2kymXbcRFlLWdVdDIFUK18c=; b=NRblHjozWr8BcR+0QWDyAa89ju
 05HY1Tw+yqNrSTRwiQfSHseMXAGHd9jT3ZADehCU34BmA+8ZfiLzIuT2erHPFeQbacAUqawMUup8Y
 K+fEvKNiFj5cuBx5iKvvfIOAoTY/TytUL1fu/AW/Pq67MM2pWfaQ8JYK7MmOUg7s56En97CnAAXIR
 b59ugVELe3bFVO4eQSna9INu3qh8cRftfpiK5ThIxfv+OBzche9GhBOYHFje9qKo2n2Kz8QOLX8NL
 gyXIzvjvlYgK7HNqGYHxClh7EHaFO/7Jn5Imb8ROJYpX4GoJPW67pYso4glBw+jJBavlc6wqA7fo3
 wJXZz7VA==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1syBmX-006bl3-9A; Tue, 08 Oct 2024 17:05:49 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [RFC 4/4] drm/amdgpu: Document the magic big endian bit
Date: Tue,  8 Oct 2024 16:05:32 +0100
Message-ID: <20241008150532.23661-5-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008150532.23661-1-tursulin@igalia.com>
References: <20241008150532.23661-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Similar to the previous patch but with the addition of a magic bit1 set on
big endian platforms. No idea what it is but maybe adding a helper and
giving both it and the magic bit a proper name would be worth it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 14 ++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index aeab6fe21db6..68f3799f173c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -503,6 +503,19 @@ static inline void amdgpu_ring_write_addr(struct amdgpu_ring *ring, u64 addr)
 	amdgpu_ring_write64(ring, v);
 }
 
+static inline void
+amdgpu_ring_write_addr_xbe(struct amdgpu_ring *ring, u64 addr)
+{
+	u64 v;
+
+#ifdef __BIG_ENDIAN
+	v = (u64)lower_32_bits(addr) << 32 | upper_32_bits(addr) | (2 << 0); /* Magic bit name? */
+#else
+	v = addr;
+#endif
+	amdgpu_ring_write64(ring, v);
+}
+
 /**
  * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
  * @ring: amdgpu_ring structure
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 24fb58543041..de1909c1de49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8549,12 +8549,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, header);
 	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
-	amdgpu_ring_write(ring,
-#ifdef __BIG_ENDIAN
-		(2 << 0) |
-#endif
-		lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write_addr_xbe(ring, ib->gpu_addr);
 	amdgpu_ring_write(ring, control);
 }
 
@@ -8584,12 +8579,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
 	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
-	amdgpu_ring_write(ring,
-#ifdef __BIG_ENDIAN
-				(2 << 0) |
-#endif
-				lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write_addr_xbe(ring, ib->gpu_addr);
 	amdgpu_ring_write(ring, control);
 }
 
-- 
2.46.0

