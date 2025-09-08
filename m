Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96828CAC587
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 23:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E3510E5F8;
	Mon,  8 Sep 2025 23:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Te1YYpSq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C3210E5F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 23:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U5njux5lZnDZ3SzU2fXB0FLE7fN2EPRxt9eSzAtaOBo=; b=Te1YYpSqGikBjrc71Hr7mHcTvG
 eCIL9yvMYEhtBktHulCONcSSVGvzLK9InyrB7krJITJmhJDy+ZM95cU3g4ec3zqxYh9LgD4InV9J2
 iNfDRkkOirlDE0EqC+7EoyE9bo+oY+/pAnUm5e1qRzsEydKU77WABINt/fOifvB1NKUPtt2q9vct4
 0efXH2zwKuokJp9+BejLwrH93s20h8Uf7Knv9J4VJ06jJVb+727JGwOBlPTj2fE1MuUGhU/Dt41HU
 v3gLS93xWNOZVGdqJcHZGjATJqVFOvkCXlLqhoND5Ao7azSEUkS5yQAIZHZvMjX9cmGiw8+DagTqn
 qShOqH7A==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uvlBf-008iqD-8o; Tue, 09 Sep 2025 01:22:15 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/5] drm/amdgpu: Remove volatile from ring manipulation
Date: Mon,  8 Sep 2025 17:15:38 -0600
Message-ID: <20250908232134.2223198-4-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908232134.2223198-1-siqueira@igalia.com>
References: <20250908232134.2223198-1-siqueira@igalia.com>
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

None of the pointer operations handled by the ring file requires
volatile, for this reason, this commit removes all occurrences of
volatile associated with rings.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 17848ce65d1f..6d123172bb0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -545,7 +545,7 @@ struct amdgpu_wb {
 	 * this value can be accessed directly by using the offset as an index.
 	 * For the GPU address, it is necessary to use gpu_addr and the offset.
 	 */
-	volatile uint32_t	*wb;
+	uint32_t		*wb;
 
 	/**
 	 * @gpu_addr:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e..80b85547c810 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -114,7 +114,7 @@ struct amdgpu_sched {
  */
 struct amdgpu_fence_driver {
 	uint64_t			gpu_addr;
-	volatile uint32_t		*cpu_addr;
+	uint32_t			*cpu_addr;
 	/* sync_seq is protected by ring emission lock */
 	uint32_t			sync_seq;
 	atomic_t			last_seq;
@@ -298,7 +298,7 @@ struct amdgpu_ring {
 	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
-	volatile u32		*rptr_cpu_addr;
+	u32			*rptr_cpu_addr;
 
 	/**
 	 * @wptr:
@@ -378,19 +378,19 @@ struct amdgpu_ring {
 	 * This is the CPU address pointer in the writeback slot. This is used
 	 * to commit changes to the GPU.
 	 */
-	volatile u32		*wptr_cpu_addr;
+	u32			*wptr_cpu_addr;
 	unsigned		fence_offs;
 	u64			fence_gpu_addr;
-	volatile u32		*fence_cpu_addr;
+	u32			*fence_cpu_addr;
 	uint64_t		current_ctx;
 	char			name[16];
 	u32                     trail_seq;
 	unsigned		trail_fence_offs;
 	u64			trail_fence_gpu_addr;
-	volatile u32		*trail_fence_cpu_addr;
+	u32			*trail_fence_cpu_addr;
 	unsigned		cond_exe_offs;
 	u64			cond_exe_gpu_addr;
-	volatile u32		*cond_exe_cpu_addr;
+	u32			*cond_exe_cpu_addr;
 	unsigned int		set_q_mode_offs;
 	u32			*set_q_mode_ptr;
 	u64			set_q_mode_token;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f6ac6a36bc44..8841d7213de4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4075,7 +4075,7 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *f = NULL;
 	unsigned int index;
 	uint64_t gpu_addr;
-	volatile uint32_t *cpu_ptr;
+	uint32_t *cpu_ptr;
 	long r;
 
 	memset(&ib, 0, sizeof(ib));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ff600a6c80ae..86b3fcab5772 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -603,7 +603,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
-	volatile uint32_t *cpu_ptr;
+	uint32_t *cpu_ptr;
 	long r;
 
 	/* MES KIQ fw hasn't indirect buffer support for now */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a14fd94af90d..710ec9c34e43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -497,7 +497,7 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
-	volatile uint32_t *cpu_ptr;
+	uint32_t *cpu_ptr;
 	long r;
 
 	/* MES KIQ fw hasn't indirect buffer support for now */
-- 
2.50.1

