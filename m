Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAE8CA0FE1
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Aug 2025 23:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A02710E2A8;
	Sun, 24 Aug 2025 23:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dSTU4KoH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B242710E224
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Aug 2025 23:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3Jp9ts4yBRWEZ0anX08DiSQakhNmKN7jZkPVys0ln9U=; b=dSTU4KoHaCAhM0fcq0rEXAshL+
 omF3aV/7K0WDfN0OG04Y3IIeN/jajVe+vHpZNnH6wovGny+rb4xJlB7j97ZVb2le2MWVn2pC8IejT
 BcoDotqHmZW5SPjqYlyPIdNTpXavyYxMAfJ8x/TziND8j25ljfBjNcZlWA3l0vRDOdmeuFAxKDVEj
 nUllbHmfUUsHiybreQXIWGz8SvaTcrT9NflnBism2T8gR1YRCejByO0E+BKn9/PSlcehks6Id5icw
 Z9L51n/9Mqg+ZY0Xdb3ZCnB1SrAQJG3Wn6EG+v/1H6f0ZbZcZfzNTbdMUxVIoNGJuTPjs6ZTxvxgT
 tgFyES8w==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uqKCc-00198j-J1; Mon, 25 Aug 2025 01:32:46 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
Date: Sun, 24 Aug 2025 17:29:41 -0600
Message-ID: <20250824233149.3780127-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250824233149.3780127-1-siqueira@igalia.com>
References: <20250824233149.3780127-1-siqueira@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5c..80dd6f58a53b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -75,8 +75,15 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
  * @ring: amdgpu_ring structure holding ring information
  * @ndw: number of dwords to allocate in the ring buffer
  *
- * Allocate @ndw dwords in the ring buffer (all asics).
- * Returns 0 on success, error on failure.
+ * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
+ * inspecting the code, you may encounter places where this function is called
+ * amdgpu_ring_alloc(ring, X + Y + Z), where X, Y, and Z are integer numbers.
+ * This indicates the number of dword operations to be inserted into the ring
+ * per operation.
+ *
+ * Returns:
+ * 0 on success, otherwise -ENOMEM if it tries to allocate more than the
+ * maximum dword allowed for one submission.
  */
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 {
@@ -122,7 +129,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
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

