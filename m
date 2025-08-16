Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474BCCA0EE4
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 15:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1513910E18A;
	Sat, 16 Aug 2025 15:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kBUrn38r";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D3010E18A
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BLjqVY9XlIp+/phsirsJNkMfwJEYK6Rs5x4pvN3HcWs=; b=kBUrn38rYDy1NpQevgaY8gmOdL
 XOsNsm2dTJu5143XJaVrDWqn1/n65G0+OhPlXozCa5PqPq949/bWUSHxoI7t/LmqwXrI3ZSSbxwTt
 4NICQleqkSuTXDMtOXBlfd2leNK2lIhVEroghiIXOgih4G8DfrciGjvbbf7htASDo6f9W49sqHxrW
 Kr9QCOnGSd1CWj5omAdCByq4x8aI+9BF2RlCkWn/OyB8ZezOexzsqVuQuRLFYjuEQJUYoL/05jiSk
 i07EcvLZ8J0D7kK71Y3LCO5u9FkRnkP5xpmhAEdvDfdJFTeWZ0faVV5HsMtRaJ366zvQxz/fVbJj4
 3Q5a4oLw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1unIuw-00F9aY-C3; Sat, 16 Aug 2025 17:34:02 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
Date: Sat, 16 Aug 2025 09:31:38 -0600
Message-ID: <20250816153315.1285182-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816153315.1285182-1-siqueira@igalia.com>
References: <20250816153315.1285182-1-siqueira@igalia.com>
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

Expand the kernel-doc about amdgpu_ring and add some tiny improvements.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5c..78fd324c84e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -75,8 +75,16 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
  * @ring: amdgpu_ring structure holding ring information
  * @ndw: number of dwords to allocate in the ring buffer
  *
- * Allocate @ndw dwords in the ring buffer (all asics).
- * Returns 0 on success, error on failure.
+ * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
+ * inspecting the code, you may encounter places where this function is called
+ * amdgpu_ring_alloc(ring, X + Y + Z) where X, Y, and Z are integer numbers.
+ * This is a way to show how many dwords operations will be inserted in the
+ * ring. For example, if gfx_v9_0_wait_reg_mem(), amdgpu_ring_emit_reg_wait(),
+ * amdgpu_ring_emit_wreg(), and amdgpu_ring_emit_fence() will be called, before
+ * that you will see amdgpu_ring_alloc(ring, 7 + 7 + 5 + 8).
+ *
+ * Returns:
+ * 0 on success, error on failure.
  */
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 {
@@ -122,7 +130,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
 		ring->funcs->begin_use(ring);
 }
 
-/** amdgpu_ring_insert_nop - insert NOP packets
+/**
+ * amdgpu_ring_insert_nop - insert NOP packets
  *
  * @ring: amdgpu_ring structure holding ring information
  * @count: the number of NOP packets to insert
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e..d27dbb3c109f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
 #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
 #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
 #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
+
+/* Ensure the execution in case of preemption or reset */
 #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
 
 #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
-- 
2.47.2

