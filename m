Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017C3CF2564
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 00:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0EF10E217;
	Wed, 19 Nov 2025 00:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cl/4fN6u";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB7210E217
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 00:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3psW620OxcpT1i3DgFNo6nGD/MqHV0VQq03CWlKvZ1k=; b=cl/4fN6uUD/swTmHOOm2SUqBqi
 3Gnt7bx7HLgcTH/cHAa2XlwmyBx6OteOaP3UsxdW57jKWqQmnb8XvP4ojGKehViQT4CmqhPCVjeQ1
 6RHn5wGfO4AwyxbRKkciHImXxjVh03iiHExJfvTXXQKXDXbO5fELFuj+sZYHnSNYO9cFPC83T/7Mu
 qsHa3lnWDx9/L8vhusdeIlRi46D2eTT10ltCt/XkbvxqPAQzUszyvPua2ge8vHa3eP4MzFTUo0gT1
 zn6r2dQThZt1vY7Vpykq8Ymz0UtDFxVYazSnBEgdTJhsS+qnYAHF074zqeuKa2sC3U8b0Lm+SSl0v
 5g8ySv8w==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vLWNI-002Mxr-Ry; Wed, 19 Nov 2025 01:48:44 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v5 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
Date: Tue, 18 Nov 2025 17:45:50 -0700
Message-ID: <20251119004818.4126460-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119004818.4126460-1-siqueira@igalia.com>
References: <20251119004818.4126460-1-siqueira@igalia.com>
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index cd8873c6931a..4336862c9d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -76,8 +76,12 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
  * @ring: amdgpu_ring structure holding ring information
  * @ndw: number of dwords to allocate in the ring buffer
  *
- * Allocate @ndw dwords in the ring buffer (all asics).
- * Returns 0 on success, error on failure.
+ * Allocate @ndw dwords in the ring buffer. The number of dwords should be the
+ * sum of all commands written to the ring.
+ *
+ * Returns:
+ * 0 on success, otherwise -ENOMEM if it tries to allocate more than the
+ * maximum dword allowed for one submission.
  */
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 {
@@ -123,7 +127,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
 		ring->funcs->begin_use(ring);
 }
 
-/** amdgpu_ring_insert_nop - insert NOP packets
+/**
+ * amdgpu_ring_insert_nop - insert NOP packets
  *
  * @ring: amdgpu_ring structure holding ring information
  * @count: the number of NOP packets to insert
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7a27c6c4bb44..a1fb0fadb6ea 100644
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
2.51.0

