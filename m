Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F234AE77192
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C978110E3A5;
	Fri, 27 Dec 2024 11:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MbglZpPG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088DD10E3A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kP5WO0/RbkQ2nI4ngNGoe7JBbkxBjFmbxMIQHAadDwI=; b=MbglZpPG+l2JbAOYEF51U8vpGv
 U13YLRthBpGEyPqybl+VhPGv5ehgzupFEkPQfytsyjn1QYIUkbiWVqembM1sk8IUms4xCZ94C3C9W
 JImuQaRmkRSkN44gxMf9rQ43JNfSMUgeDptJSaU30jrEPGtaII+jxJE4GeSKYeSBeYdb4FwwuyaG8
 1E7PP6w1xNhQRZGB/7VxHKm7E+DMh1M6nYHCIjH+DJuAoUf02VtkfuHPWMzkvsrePeZfK6pk+pumx
 4Vm02gRdLngd/NqefcDTvkSWCxlz7i1farAOiVHAs5T4BPyO4TiRJB4dnmUTCR8Sn3dXSb3Ogv4rc
 lelKSFnQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nn-008EH5-9x; Fri, 27 Dec 2024 12:19:55 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 08/12] drm/amdgpu: Cache some values in ring emission helpers
Date: Fri, 27 Dec 2024 11:19:34 +0000
Message-ID: <20241227111938.22974-9-tursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227111938.22974-1-tursulin@igalia.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

     text	   data	    bss	     dec	    hex	filename
 10437711	 542597	 188232	11168540	 aa6b1c	amdgpu.ko.before
 10418181	 542597	 188232	11149010	 aa1ed2	amdgpu.ko.after

Main reason seems to be amdgpu_ring_write() can avoid re-loading
ring->wptr when called multiple times in sequence.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 158238f8c06a..b57951d8c997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -385,8 +385,10 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
 
 static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
 {
-	ring->ring[ring->wptr++ & ring->buf_mask] = v;
-	ring->wptr &= ring->ptr_mask;
+	u64 wptr = ring->wptr;
+
+	ring->ring[wptr++ & ring->buf_mask] = v;
+	ring->wptr = wptr & ring->ptr_mask;
 	ring->count_dw--;
 }
 
@@ -394,9 +396,11 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 					      void *src, int count_dw)
 {
 	unsigned occupied, chunk1, chunk2;
+	u32 buf_mask = ring->buf_mask;
+	u64 wptr = ring->wptr;
 
-	occupied = ring->wptr & ring->buf_mask;
-	chunk1 = ring->buf_mask + 1 - occupied;
+	occupied = wptr & buf_mask;
+	chunk1 = buf_mask + 1 - occupied;
 	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
 	chunk2 = count_dw - chunk1;
 	chunk1 <<= 2;
@@ -410,8 +414,8 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 		memcpy(ring->ring, src, chunk2);
 	}
 
-	ring->wptr += count_dw;
-	ring->wptr &= ring->ptr_mask;
+	wptr += count_dw;
+	ring->wptr = wptr & ring->ptr_mask;
 	ring->count_dw -= count_dw;
 }
 
-- 
2.47.1

