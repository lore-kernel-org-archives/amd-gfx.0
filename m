Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BEFC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC7810EA8E;
	Tue,  8 Sep 2026 18:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRsY8MXc";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D483010EA8E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:11 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49557167508so58744435e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891070; x=1789495870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q2geQMoc7lWVUFYPv1CxF+SCZ+CbgarVPHceBvzpWtE=;
 b=BRsY8MXcvapbDuWlOUuyHcK8ojjeJWPqY6NQ8/ketnJcKZQ0mUndwKTXx9nKvTM5eA
 rDL3lN3J68U32mAl7/26eAd8EB5PojtN8znxbmPtmTGUTDKWFFzANm0/87NvA5qm1kuW
 fyhVLj4K918+SvkMmAz+g+LvpJf34GselPKUl9MksDlEwgROvjtgC+aspP21wOojKcOa
 5JR06+VBwZJJAWwOrsAmmNFEMLn5YE5tcMZ9AC+Rh8GntU1gxwuvvw6Oz4hCLT5Bmdnc
 ptx02tJirZ16Dl2bzHd+Bc9p/TSbE1NThiS+4r02vb3YoU2egDBr9Tg9XA9+2pYD4FuH
 qdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891070; x=1789495870;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q2geQMoc7lWVUFYPv1CxF+SCZ+CbgarVPHceBvzpWtE=;
 b=kzyK6QD2DtSCLGGM7GnaL2btLiU01qn/AFfplrJ+LGX+6lcgPqgIb8IPAc0QzR4Jyv
 FtNq94ljFrgGFuHTKBLNXOgOzsrKlg2L4vpmDj5SbDFlbNy9iFugPvNpFt7mADZCQsZv
 RSHi4nY9dQIT/x2S7u8s/TethY1oTVl1H+qm7IgaUPvJRR1y0wwPpOO5bKBIinxzw43h
 44s/BGX62hoAmbj3XOmzrdgUBjkO+DdPWYAKwmcuUl/SNKws5WIwmKyafUQNV4vZOwAb
 0RDjJdo+dHpkBfAm1Xf63n3jLHMgcfg9d781zg4CZ+zb2hXXbraM++outImVP6WCTIE0
 2Q+Q==
X-Gm-Message-State: AFuF++n3Zc+NQHxVeBW4pWUQ8f8wxb34rpY42OjNWvrWRXSJ3W7r60fm
 MrUXd6ykwv2BRsjrMRqzSNmHfBqjzXJfJz8K6NXTaywQIzBsROtFT4Rhkqr/wbi4
X-Gm-Gg: AYBFou2XIRnp2WRt3tziA3pcpUNCAz4w+7/H+1xtLyy2PEg64obp3F7rb4lAJXMyKWm
 WlCXEClfwDWndOhGM7j/HjR1wFShUngPb7QFOgMjSChICdABDWC/K7oZEFhyd9pCbau4OWG2d5N
 Wnb50mRb3PN3/1bqno109wZw4ouAjJ4GBESdTGf65WPUBUQgzWdiMi8gIr0jRGB5A4exphWcxhI
 8ZOxk3tyb8MrnDrVTVVGj4CAVRAY0qeIXl2qVljeApwt23nQvbwZ9CUEujv9jORj6i9GcljqzwU
 4OgX7EEG5pyhyDtnRvUnasi7h8ul47LMjv+i3CuFtAXUwwnV3LmytRqAUEcQv2QAfPQLVob5llm
 gTzKRjYTmNHrk/OQxV3as/Hzi1jOlK1k6phMJbflVa51Y1xJA4wxHIZqI22Wt5NCH+rS8usYwvY
 qZBtP3fh16mGl0NvEOzSrqb3mW6StUJ7aN+iLgJTsddFtg5Ek46cYk5vdu4InLYx267wH9a3zeZ
 +Wp1amv7DisGePSDO3u
X-Received: by 2002:a05:600c:8b09:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49cf823f57fmr636699975e9.10.1788891070090; 
 Tue, 08 Sep 2026 11:11:10 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:09 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/9] drm/amdgpu/sdma: Remove unnecessary guilty tracking of
 SDMA queues
Date: Tue,  8 Sep 2026 20:10:47 +0200
Message-ID: <20260908181052.381126-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
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

amdgpu_sdma_reset_engine() saves and restores contents of
both the SDMA gfx queue and the paging queue, so it's
not necessary to track which queue was guilty anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2b4e51c33e6f..44ba997c8e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -79,9 +79,6 @@ struct amdgpu_sdma_instance {
 	uint64_t		sdma_fw_gpu_addr;
 	uint32_t		*sdma_fw_ptr;
 	struct mutex		engine_reset_mutex;
-	/* track guilty state of GFX and PAGE queues */
-	bool			gfx_guilty;
-	bool			page_guilty;
 	const struct amdgpu_sdma_funcs   *funcs;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 53c816043eb8..0ca774959401 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1409,9 +1409,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
-		/* Initialize guilty flags for GFX and PAGE queues */
-		adev->sdma.instance[i].gfx_guilty = false;
-		adev->sdma.instance[i].page_guilty = false;
 		adev->sdma.instance[i].funcs = &sdma_v4_4_2_sdma_funcs;
 
 		ring = &adev->sdma.instance[i].ring;
@@ -1582,15 +1579,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
-{
-	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
-	uint32_t context_status = RREG32(sdma_v4_4_2_get_reg_offset(adev, instance_id, reg_offset));
-
-	/* Check if the SELECTED bit is set */
-	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
-}
-
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *timedout_fence)
@@ -1608,19 +1596,11 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 instance_id = ring->me;
 	u32 inst_mask;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	/* Check if this queue is the guilty one */
-	adev->sdma.instance[instance_id].gfx_guilty =
-		sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
-	if (adev->sdma.has_page_queue)
-		adev->sdma.instance[instance_id].page_guilty =
-			sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
-
 	/* stop queue */
 	inst_mask = 1 << ring->me;
 	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
-- 
2.55.0

