Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A08E77192
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2B710E3AE;
	Fri, 27 Dec 2024 11:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qjPzKN8m";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5DC10E3A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jutmnwLZxXogzsTDXKEl/VJvRTL/wrQccy/lHR/DzPY=; b=qjPzKN8mIi6qyIYf8f4BfJINP5
 DnZtp7Ed0ZrbPlqrAbqOhmVSX7g8lEwpE4msqzB3JB+ap+81ucmHpnBfP52KfIrHw05kFMMiFvBGe
 ZaMxOnYvkexCTy54In3jpUEqo/XYDW0yl/1pZpSkBSi7neZ1vbN8Leqy/U5RylBzpfqtYGKTQkLnh
 nSmkMJehvSeyaU0T18MJLgJEqglElDhy4wLjhCRdrPl3Pbr+yZngPa+h5WGXnwoY3qUe1QowXabyo
 WiN1KfTCYH46QTBxALhu28gP5hxF1gvDH8XR+LSXB5WE8kPj4QRo6dJoZ8csZRfa0jpb2TeK/TNl9
 5W+6iatg==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8No-008EHM-LP; Fri, 27 Dec 2024 12:19:56 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 10/12] drm/amdgpu: Convert VCE to variadic amdgpu_ring_write()
Date: Fri, 27 Dec 2024 11:19:36 +0000
Message-ID: <20241227111938.22974-11-tursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227111938.22974-1-tursulin@igalia.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
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

Just a small example how the conversion works.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b9060bcd4806..3fa0b0824836 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1069,10 +1069,11 @@ void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring,
 				struct amdgpu_ib *ib,
 				uint32_t flags)
 {
-	amdgpu_ring_write(ring, VCE_CMD_IB);
-	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, ib->length_dw);
+	amdgpu_ring_write(ring,
+			  VCE_CMD_IB,
+			  lower_32_bits(ib->gpu_addr),
+			  upper_32_bits(ib->gpu_addr),
+			  ib->length_dw);
 }
 
 /**
@@ -1089,12 +1090,13 @@ void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 {
 	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
 
-	amdgpu_ring_write(ring, VCE_CMD_FENCE);
-	amdgpu_ring_write(ring, addr);
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, seq);
-	amdgpu_ring_write(ring, VCE_CMD_TRAP);
-	amdgpu_ring_write(ring, VCE_CMD_END);
+	amdgpu_ring_write(ring,
+			  VCE_CMD_FENCE,
+			  addr,
+			  upper_32_bits(addr),
+			  seq,
+			  VCE_CMD_TRAP,
+			  VCE_CMD_END);
 }
 
 /**
-- 
2.47.1

