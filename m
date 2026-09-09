Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBBBC79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 10:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF66610E84C;
	Wed,  9 Sep 2026 10:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="F0s9f+mb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C2510EE4D
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=E4cS8FS8GXc/c2R2tj9rLQMNrL69B63WLkuLkgdlr+k=; b=F0s9f+mbi9UCL0zA5o8ON8eTF2
 3+XRh3Tab/TpaKdkaGz6Nc94cuGx1iXUyTg1U9IWomccUjywEdGEhd7Qc+jrvB5mQHZqQGIwzwzGD
 28fDe7YYHrFyEy2c0lPBUj8/AZb29/EIETL3oNaf2he+x2u6m8AJrUtfWKg4apf29RMPeFV+eL7gv
 l1KQgQ9ytBxjgz4fNTSsyJFIo2McEq3YAHGQlIP8C5woCdtOxlZt5aIAOQNgN7eNQqEOuMvgDyMLJ
 8gIrGaei0hXXOcKonx+UlF8Z1+Nyn+nvhXIqiqV9dUq/vFXa19xj62GUwfgPbNZGXYoASaDu+On6d
 WapoHhVw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x4Fue-00Gyjq-JL; Wed, 09 Sep 2026 12:52:20 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/6] drm/amdgpu: Add SDMA ring init helper
Date: Wed,  9 Sep 2026 11:52:10 +0100
Message-ID: <20260909105215.88242-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
References: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
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

Consolidate one part of the SDMA ring initialization with a new
amdgpu_sdma_ring_init() helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 13 ++-----------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 19 ++++++-------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 +-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  8 ++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 13 +++++--------
 11 files changed, 42 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fbac732f3e01..cca8b3a98f6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -37,6 +37,25 @@
  * GPU SDMA IP block helpers function.
  */
 
+int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
+			  const char *prefix, unsigned int index)
+{
+	int r;
+
+	ring->ring_obj = NULL;
+
+	if (prefix)
+		sprintf(ring->name, "sdma%u", index);
+
+	r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
+			     AMDGPU_SDMA_IRQ_INSTANCE0 + index,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 struct amdgpu_sdma_instance *amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 671cfbb67b7a..2f1edef97c2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -158,6 +158,9 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
+int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
+			  const char *prefix, unsigned int index);
+
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 657ef6c93c61..fb2047d8e25a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -865,13 +865,8 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = false;
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     (i == 0) ? AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 9478dd034aff..656f66527999 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1146,7 +1146,6 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		if (!amdgpu_sriov_vf(adev)) {
 			ring->use_doorbell = true;
 			ring->doorbell_index = adev->doorbell_index.sdma_engine[i];
@@ -1154,11 +1153,7 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 			ring->use_pollmem = true;
 		}
 
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     (i == 0) ? AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 9d7d919a5aa1..e135dfb1c3e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1858,7 +1858,6 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
@@ -1878,16 +1877,12 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		else
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 
 		if (adev->sdma.has_page_queue) {
 			ring = &adev->sdma.instance[i].page;
-			ring->ring_obj = NULL;
 			ring->use_doorbell = true;
 
 			/* paging queue use same doorbell index/routing as gfx queue
@@ -1915,11 +1910,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 			else
 				ring->vm_hub = AMDGPU_MMHUB0(0);
 
-			sprintf(ring->name, "page%d", i);
-			r = amdgpu_ring_init(adev, ring, 1024,
-					     &adev->sdma.trap_irq,
-					     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-					     AMDGPU_RING_PRIO_DEFAULT, NULL);
+			r = amdgpu_sdma_ring_init(adev, ring, "page", i);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 461f8b220a3e..2e46e63a6dbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1484,7 +1484,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->sdma.instance[i].funcs = &sdma_v4_4_2_sdma_funcs;
 
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		aid_id = adev->sdma.instance[i].aid_id;
 
@@ -1495,18 +1494,15 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
 		ring->vm_hub = AMDGPU_MMHUB0(aid_id);
 		ring->no_user_submission = adev->sdma.no_user_submission;
+		r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
+		if (r)
+			return r;
 
 		sprintf(ring->name, "sdma%d.%d", aid_id,
 				i % adev->sdma.num_inst_per_aid);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
-		if (r)
-			return r;
 
 		if (adev->sdma.has_page_queue) {
 			ring = &adev->sdma.instance[i].page;
-			ring->ring_obj = NULL;
 			ring->use_doorbell = true;
 
 			/* doorbell index of page queue is assigned right after
@@ -1515,15 +1511,12 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 			ring->doorbell_index =
 				(adev->doorbell_index.sdma_engine[i] + 1) << 1;
 			ring->vm_hub = AMDGPU_MMHUB0(aid_id);
+			r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
+			if (r)
+				return r;
 
 			sprintf(ring->name, "page%d.%d", aid_id,
 					i % adev->sdma.num_inst_per_aid);
-			r = amdgpu_ring_init(adev, ring, 1024,
-					     &adev->sdma.trap_irq,
-					     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-					     AMDGPU_RING_PRIO_DEFAULT, NULL);
-			if (r)
-				return r;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 97fee70dc2f6..a0614fa9ffa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1411,7 +1411,6 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
 		adev->sdma.instance[i].funcs = &sdma_v5_0_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
@@ -1422,11 +1421,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 			: (adev->doorbell_index.sdma_engine[1] << 1); // get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(0);
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     (i == 0) ? AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 35cdf6c149f8..5b3dafc194d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1331,7 +1331,6 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
 		adev->sdma.instance[i].funcs = &sdma_v5_2_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
 
@@ -1342,10 +1341,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.sdma_engine[i] << 1); //get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(0);
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 303fd7d1b7c8..845e622d3c1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1335,7 +1335,6 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
 		ring->no_user_submission = adev->sdma.no_user_submission;
@@ -1347,11 +1346,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(0);
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index d5552f206e4d..ea460a19b89d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1319,7 +1319,6 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
 		ring->no_user_submission = adev->sdma.no_user_submission;
@@ -1331,11 +1330,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(0);
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 0f30eb503c2a..1704d406c34a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1305,7 +1305,6 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
 		ring->no_user_submission = adev->sdma.no_user_submission;
@@ -1323,14 +1322,12 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
+		r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
+		if (r)
+			return r;
+
 		sprintf(ring->name, "sdma%d.%d", xcc_id,
-				GET_INST(SDMA0, i) % adev->sdma.num_inst_per_xcc);
-		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
-		if (r)
-			return r;
+			GET_INST(SDMA0, i) % adev->sdma.num_inst_per_xcc);
 	}
 
 	adev->sdma.supported_reset =
-- 
2.55.0

