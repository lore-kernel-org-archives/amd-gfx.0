Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FA606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=jvwGEmY3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290AE10F583;
	Tue, 20 Oct 2026 13:27:53 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C547D10E894
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=wAMSoBLpVC8MlpBZUhR+/ap1EQAkwafg4lblxWGThyo=; b=jvwGEmY32HQMGhYK7EFmV7yW86
 zBygY23NhzoV/gVzIdveAo0LaklAyIrtzMdu/yGxbsgJf4RqQVgslAQFMHdx+Wa9deHogsNbMgpbS
 b9KkJ+H3Of5aAkpYqWc7iHtkLO1fkxus2AUs1ewlRqOZjmRawu0zTQ2byQwal4xldltrBVvAHp9Uy
 IwUOJ5Vx3/B20dqKzWT+BoDZb4gStA9vBV2Rc7xX83QPMluO6XjH55aA2E3xEthzS1mfCzYVKfjxe
 yja5wuaXRh/kx4kt9RWBxr/rsGuvRiUvCb7vCZpqC8p0TCtoJ7ZvIl77YZTiIJDLfX2y1FcszyUeg
 bPihBp5w==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJ9sV-004c6Z-Ri; Tue, 20 Oct 2026 15:27:43 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amdgpu: Simplify amdgpu_ring_init
Date: Tue, 20 Oct 2026 14:27:39 +0100
Message-ID: <20261020132739.31852-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
References: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(Too) many times I grepped the codebase trying to figure out who sets
adev->gpu_sched[hw_ip][hw_prio].num_scheds and this time I decided to make
this greppable by avoding the fun pointer games.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 227734541316..7b67e8cecca2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -213,11 +213,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		     unsigned int irq_type, unsigned int hw_prio,
 		     atomic_t *sched_score)
 {
-	int r;
 	int sched_hw_submission = amdgpu_sched_hw_submission;
-	u32 *num_sched;
-	u32 hw_ip;
 	unsigned int max_ibs_dw;
+	int r;
 
 	/* Set the hw submission limit higher for KIQ because
 	 * it's used for a number of gfx/compute tasks by both
@@ -359,10 +357,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->vmid_wait = dma_fence_get_stub();
 
 	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
-		hw_ip = ring->funcs->type;
-		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
-		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-			&ring->sched;
+		struct amdgpu_sched *gpu_sched =
+			&adev->gpu_sched[ring->funcs->type][hw_prio];
+
+		gpu_sched->sched[gpu_sched->num_scheds++] = &ring->sched;
 	}
 
 	return 0;
-- 
2.56.0

