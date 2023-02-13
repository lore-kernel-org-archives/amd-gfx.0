Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1DBC636CC
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 20:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D643E10E722;
	Mon, 13 Feb 2023 20:50:24 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B43010E71B;
 Mon, 13 Feb 2023 20:50:22 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4PFxLP50kRzDrt1;
 Mon, 13 Feb 2023 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1676321422; bh=0btOm75pfMRsfRtuuMoEzT9rn1LcMUFeV+WcQsEfl9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LFnw6kCc5swzEp/L79qqURN3Adgqx9mj+DYQh3E6zMbV6NqTM7h5L4ARHa6wSwX+t
 W7dnTboyv7SvNKC/fIds1ql3HytH+wjyI/tONBWvD2rU5HTWi0TREYEH9102toghqk
 4Z22JDyFHIGtCJbqR/Uyo9xY7FZdtffpaL1ItF/o=
X-Riseup-User-ID: 669E63AFCEAC0E29E2F42768667EA975B12C5800CBB7314253C8398FAECA2967
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4PFxLH53Bcz1y8Z;
 Mon, 13 Feb 2023 20:50:15 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 05/10] drm/amd/display: Fix excess arguments on kernel-doc
Date: Mon, 13 Feb 2023 17:49:18 -0300
Message-Id: <20230213204923.111948-6-arthurgrillo@riseup.net>
In-Reply-To: <20230213204923.111948-1-arthurgrillo@riseup.net>
References: <20230213204923.111948-1-arthurgrillo@riseup.net>
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
Cc: sunpeng.li@amd.com, tales.aparecida@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, Arthur Grillo <arthurgrillo@riseup.net>,
 mairacanal@riseup.net, daniel@ffwll.ch, harry.wentland@amd.com,
 alexander.deucher@amd.com, andrealmeid@riseup.net, airlied@gmail.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove arguments present on kernel-doc that are not present on the
function declaration and add the new ones if present.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            | 15 +++++++--------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c      |  2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3d36329be384..40e6b22daa22 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -273,8 +273,6 @@ static void sdma_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
  * sdma_v6_0_ring_emit_mem_sync - flush the IB by graphics cache rinse
  *
  * @ring: amdgpu ring pointer
- * @job: job to retrieve vmid from
- * @ib: IB object to schedule
  *
  * flush the IB by graphics cache rinse.
  */
@@ -326,7 +324,9 @@ static void sdma_v6_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
  * sdma_v6_0_ring_emit_fence - emit a fence on the DMA ring
  *
  * @ring: amdgpu ring pointer
- * @fence: amdgpu fence object
+ * @addr: address
+ * @seq: fence seq number
+ * @flags: fence flags
  *
  * Add a DMA fence packet to the ring to write
  * the fence seq number and DMA trap packet to generate
@@ -1060,10 +1060,9 @@ static void sdma_v6_0_vm_copy_pte(struct amdgpu_ib *ib,
  *
  * @ib: indirect buffer to fill with commands
  * @pe: addr of the page entry
- * @addr: dst addr to write into pe
+ * @value: dst addr to write into pe
  * @count: number of page entries to update
  * @incr: increase next addr by incr bytes
- * @flags: access flags
  *
  * Update PTEs by writing them manually using sDMA.
  */
@@ -1167,7 +1166,6 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
  * sdma_v6_0_ring_emit_vm_flush - vm flush using sDMA
  *
  * @ring: amdgpu_ring pointer
- * @vm: amdgpu_vm pointer
  *
  * Update the page table base and flush the VM TLB
  * using sDMA.
@@ -1591,10 +1589,11 @@ static void sdma_v6_0_set_irq_funcs(struct amdgpu_device *adev)
 /**
  * sdma_v6_0_emit_copy_buffer - copy buffer using the sDMA engine
  *
- * @ring: amdgpu_ring structure holding ring information
+ * @ib: indirect buffer to fill with commands
  * @src_offset: src GPU address
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
+ * @tmz: if a secure copy should be used
  *
  * Copy GPU buffers using the DMA engine.
  * Used by the amdgpu ttm implementation to move pages if
@@ -1620,7 +1619,7 @@ static void sdma_v6_0_emit_copy_buffer(struct amdgpu_ib *ib,
 /**
  * sdma_v6_0_emit_fill_buffer - fill buffer using the sDMA engine
  *
- * @ring: amdgpu_ring structure holding ring information
+ * @ib: indirect buffer to fill
  * @src_data: value to write to buffer
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6ccf477d1c4d..c2092775ca88 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -698,7 +698,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
  *
  * @dc: [in] current dc state
  * @context: [in] new dc state
- * @cmd: [in] DMUB cmd to be populated with SubVP info
+ * @enable: [in] if true enables the pipes population
  *
  * This function loops through each pipe and populates the DMUB SubVP CMD info
  * based on the pipe (e.g. SubVP, VBLANK).
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index f607a0e28f14..f62368da875d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -581,7 +581,7 @@ static void dpp1_dscl_set_manual_ratio_init(
  * dpp1_dscl_set_recout - Set the first pixel of RECOUT in the OTG active area
  *
  * @dpp: DPP data struct
- * @recount: Rectangle information
+ * @recout: Rectangle information
  *
  * This function sets the MPC RECOUT_START and RECOUT_SIZE registers based on
  * the values specified in the recount parameter.
-- 
2.39.1

