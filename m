Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EA3CCD1BF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 22:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820EA10E96B;
	Thu, 23 Oct 2025 22:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XQn7mEEq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6368010E972
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 22:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z/brdQIfizy0sVC9adhnmlqSxWD1iH7KzCmgt6dLrmg=; b=XQn7mEEqFSP61ySsdFzWiRpHuJ
 +5m8fH4b4q/lssjQfvgU+0asWRU5/B/nFdLfRHOsYPkMjnr6QPZbLX+9xR1KMLvSMaUSAZxTh0duH
 G9+DChsXCiK64fGEmuRzR7hOF3TRMsjU5+1p3FB7dmAEcqZpXBASTeRbM6gXj5vSYi+Wkfj78XlsX
 VD8RMvdalrTsgZj9zfqAdMKF8yFGTAGFJLJXP/WVYFiW0IdikHbfc4+kJYm8YwD44QmRDNZCC9CjQ
 /r1XvtGrOQqB/4MO8B5evEHlnRFUzJ2+SoIDX9WPLShCtyJTQC5prJxAPbKJv2fcrvFsgJE/60GTO
 sY2Vd7Iw==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vC3y2-00DpJV-KQ; Fri, 24 Oct 2025 00:39:35 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v4 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
Date: Thu, 23 Oct 2025 16:38:44 -0600
Message-ID: <20251023223918.601594-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023223918.601594-1-siqueira@igalia.com>
References: <20251023223918.601594-1-siqueira@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 43f769fed810..60e3beac5496 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -75,8 +75,15 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
  * @ring: amdgpu_ring structure holding ring information
  * @ndw: number of dwords to allocate in the ring buffer
  *
- * Allocate @ndw dwords in the ring buffer (all asics).
- * Returns 0 on success, error on failure.
+ * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
+ * inspecting the code, you may encounter places where this function is invoked
+ * like this: amdgpu_ring_alloc(ring, X + Y + Z), where X, Y, and Z are integer
+ * numbers. The idea of using each integer addition instead of the final result
+ * is to explicitly indicate each packet that will be inserted into the ring.
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
index 87b962df5460..e83589619a92 100644
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

