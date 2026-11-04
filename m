Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B42606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cnkvLrHM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE6710E23A;
	Wed,  4 Nov 2026 12:16:59 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8C010FB9F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 12:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=demxrs4ln1K2GfYJKRx97YzegT3F2LuyInC/Rdd5JW8=; t=1793794613; x=2109154613; 
 b=cnkvLrHMIed7P+QNQipGk9eJDfR5G5fJyK5ljD43Oj1klff+MemYNGGO0M8dE6+zNLFmx0RDZ7I
 RTVh/V/KeFrrVcFbt7t0URw8/X2fMNzSuXnabT/lzCpUEd1j4UTV5CpQLoMcEJrk7zvDuesuBnQ7j
 GR1j6tIM7uN2rc6tCxV0S3QBlk2NEyQc8Ikw5IFJ/r6axy9SP/CjWd4DVRt93T0VVFu80vZo8Cmcg
 gNqBp/0eGzzosMmnoa2Ot91gi/HAArBJpqt7gfHPgI9u8RyvAIgRQJCLyKSHf6qkPocTgxcEq/jr3
 bbRT4Jo+LJRSb1IOwkQXZXPKKrWvne+ztDYw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOZv8-002Eq9-Es; Wed, 04 Nov 2026 13:16:50 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Track entity initialization status in the driver
Date: Wed,  4 Nov 2026 12:16:47 +0000
Message-ID: <20261104121647.34640-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
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

Instead of accessing the internals of the DRM scheduler data structures
directly and relying on the own entity backing store to be zeroed on
allocation, lets explicitly track whether we have called
drm_sched_entity_init() and base on that the decision on whether or not
to call drm_sched_entity_destroy().

Alternative could (in theory) be to re-order the driver init/fini flows,
but that is really complicated due inter-dependencies between different
stages.

Apart from being conceptually cleaner this also re-allows future DRM
scheduler work which will embed the run-queue in the scheduler.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
Considering how many hundreds of kilobytes I have saved so far I hope I
can get away with adding a couple of booleans. ;)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index cd35ff7ca864..8f69aa4597e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -377,7 +377,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 	void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
 	int i, j;
 
-	if (adev->uvd.entity.rq)
+	if (adev->uvd.entity_initialized)
 		drm_sched_entity_destroy(&adev->uvd.entity);
 
 	for (j = 0; j < adev->uvd.num_uvd_inst; ++j) {
@@ -420,6 +420,8 @@ int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 			DRM_ERROR("Failed setting up UVD kernel entity.\n");
 			return r;
 		}
+
+		adev->uvd.entity_initialized = true;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
index 9dfad2f48ef4..fcda8a6af839 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -62,6 +62,7 @@ struct amdgpu_uvd {
 	struct amdgpu_uvd_inst	inst[AMDGPU_MAX_UVD_INSTANCES];
 	struct drm_file		*filp[AMDGPU_MAX_UVD_HANDLES];
 	atomic_t		handles[AMDGPU_MAX_UVD_HANDLES];
+	bool			entity_initialized;
 	struct drm_sched_entity entity;
 	struct delayed_work	idle_work;
 	unsigned		harvest_config;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 3952af9ae115..eede5bb5e24b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -253,7 +253,7 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
 
-	if (adev->vce.entity.rq)
+	if (adev->vce.entity_initialized)
 		drm_sched_entity_destroy(&adev->vce.entity);
 
 	for (i = 0; i < adev->vce.num_rings; i++)
@@ -288,6 +288,8 @@ int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 			DRM_ERROR("Failed setting up VCE run queue.\n");
 			return r;
 		}
+
+		adev->vce.entity_initialized = true;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index 778c714c8385..f4eb9566a317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -48,6 +48,7 @@ struct amdgpu_vce {
 	struct amdgpu_ring	ring[AMDGPU_MAX_VCE_RINGS];
 	struct amdgpu_irq_src	irq;
 	unsigned		harvest_config;
+	bool			entity_initialized;
 	struct drm_sched_entity	entity;
 	uint32_t                srbm_soft_reset;
 	unsigned		num_rings;
-- 
2.56.0

