Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8343BC7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 08:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E22010E664;
	Fri,  9 Jun 2023 08:18:28 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC0510E66E;
 Fri,  9 Jun 2023 08:18:23 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E68C9654B0;
 Fri,  9 Jun 2023 08:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C945C433D2;
 Fri,  9 Jun 2023 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686298702;
 bh=bV0AjXaMBOwcPgHZlva/QwT1Ny6xhO6iUTwyI835e2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cVmvOWAKHoSKy8W4/gtTWa2vmeBm71dB7jn1ZBGFZkt9iV5nxTuJ1hFNnfsYsiS/g
 oD9ijSARaf23ncovhmQiYacLkhDfx/veUHaqtLYH0J705hOluSpXHCySiObjtwS5eX
 9bMgQlCjF2E3Ejj6z8N/TtXoZ94MAJxZjXdBkMDjkXJSWTaJfX0k4JlXsDymLUn996
 foYeDcypwz1yMgB3H0zt/Ku0Avq17EhTia6d/IMzByP+GP1JCe5xE9uumkIMkHpWUm
 yTOT6xnI6YKKtz0H8QEan94neI4B736hA/SE97cMpEDLXyUSzChc9X4qPLE1AYj/ly
 1rGC7mqgyIB9g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Subject: [RESEND 15/15] drm/amd/amdgpu/sdma_v6_0: Demote a bunch of
 half-completed function headers
Date: Fri,  9 Jun 2023 09:17:18 +0100
Message-ID: <20230609081732.3842341-16-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609081732.3842341-1-lee@kernel.org>
References: <20230609081732.3842341-1-lee@kernel.org>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linaro-mm-sig@lists.linaro.org, Stanley Yang <Stanley.Yang@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter or member 'job' not described in 'sdma_v6_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:248: warning: Function parameter or member 'flags' not described in 'sdma_v6_0_ring_emit_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:945: warning: Function parameter or member 'timeout' not described in 'sdma_v6_0_ring_test_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1124: warning: Function parameter or member 'ring' not described in 'sdma_v6_0_ring_pad_ib'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1175: warning: Function parameter or member 'vmid' not described in 'sdma_v6_0_ring_emit_vm_flush'
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1175: warning: Function parameter or member 'pd_addr' not described in 'sdma_v6_0_ring_emit_vm_flush'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3b03dda854fdc..8cd7abe74e6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -233,7 +233,7 @@ static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 			amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
-/**
+/*
  * sdma_v6_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
  * @ring: amdgpu ring pointer
@@ -936,7 +936,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	return r;
 }
 
-/**
+/*
  * sdma_v6_0_ring_test_ib - test an IB on the DMA engine
  *
  * @ring: amdgpu_ring structure holding ring information
@@ -1118,7 +1118,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = count - 1; /* number of entries */
 }
 
-/**
+/*
  * sdma_v6_0_ring_pad_ib - pad the IB
  * @ib: indirect buffer to fill with padding
  * @ring: amdgpu ring pointer
@@ -1167,7 +1167,7 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
 
-/**
+/*
  * sdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
-- 
2.41.0.162.gfafddb0af9-goog

