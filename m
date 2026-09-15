Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DEEC88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E29610E20E;
	Tue, 15 Sep 2026 13:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J6nk+sAW";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0980A10F493
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 12:55:57 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so213014f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 05:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476955; cv=none;
 d=google.com; s=arc-20260327;
 b=BzbHg4ggq6e1QNazqkNs6FsgeoGF68x6tkniq+UN1rdcEwN+l6oX8NVAnrxIomo4qw
 +qB4kGvwu3eDaR55ARZh3kSBwCWc8pl7bV7YMGRf/w7Khv+jgDcERLMez4twcsMWDqFS
 BN1qdTF/blXQjt+J4kVMCwRPvlec8c/Xy4gp2jPrbQvQ8i2Gecyi8YZ2eJ0UGmYbz7T5
 DtZQ2OMzb5FQa6eR/x3pOijBe1vVnsHLlz11PN11swWGhPTQclr3lPsflxf51SdMBRE6
 aci/m+tg2g5C3ZdMepErOmeOQRPIp7dVl9X4pPwyO30Az9b5zdnOyCgYfmTUkQkKE2fu
 DrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=/B1MYgcCdpxQ2wVxHtxJnBZbXHbJE7oYIKPzuvd9CN8=;
 fh=w08ZKERbdjyCX85JeqQhK5jfp3tR8zQ36EXp+OyErLI=;
 b=mnR9IQvLlMA6DFPBEwf4+Gj0vqmJ56Kg4TD9Dc9YhsmJ+aAreiJd5ogyEz2aGDGv3W
 pCHjyQ00OrqxtDft62EddVE3Md3r05tpu3hgooGfNWdiGU90O8xkuCmjv895ORHlKWyU
 oree4JWnFKDNybyBDjilETMK3x4cJN6K+qJiEqLJqfDCtcon2/o9dx6UOlZTsexXZYLc
 /nJEB78gy41PY7QjD7ZSHyubT3vhZ1bQ5D7/ZMWxQkJvJbTmklORammbQUuanBQfrYSL
 VUREKjYFR+6MnkS9Fnoz6WT/tYV2dLIaZwzH4K3l1R/6I2JyZ12dbTdHb25hrThhpSg9
 P0Qw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789476955; x=1790081755; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/B1MYgcCdpxQ2wVxHtxJnBZbXHbJE7oYIKPzuvd9CN8=;
 b=J6nk+sAW2SjByYkkM0vS3fL5QFtOfo3chomOcYDDHG8wzl3SKraUWgn3VxKYhD9iPG
 Jvcaa37D1zyIzQpu5nWYbpb2bS7dXdVboKaI75LlkgGn228FozzDOcAZFfIFxjQh193p
 5rCf702e1oMNOayMYRBy103WZNJDwXTHq8s99eOXtepr4KYRh4jW0RXn1gWSWKxz3I/p
 pIiCc9yoSk6qacyn+lKo2IF5UyWePnF/BIxFREe8wTE0tJn9MrSzYuTp+12qAAEC5KVt
 l2HNmclLTsLkXZd7tEclfc4gOOE7ZiSVqLUGnJOglHhIzhipVFAHYbZSTjTerDAGSNYo
 u4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476955; x=1790081755;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/B1MYgcCdpxQ2wVxHtxJnBZbXHbJE7oYIKPzuvd9CN8=;
 b=odVEySdKNUsS3wgsFsNNPx78pgStRzqPmuWoAH3M1W5YG8mj0QSKiZIjArVAxskQsM
 96tt/J9BdF87wNqmFSLBx9rVWoIHnACTgtKuCNTtDmU4zmuPZK+/RfYZ7P/TofFvJHIe
 Us6JztouAhe0tjOR/JIzA0vlyrJC7JdLeUG9vaQDwmP/+PDZlflcRMpqHw5+JiDVNORf
 IuGghF0CIz/j7789oAnyNPWGy1LwyYk7cDxlGJGaoxXpeuKPlHx8u5bd3o8JO6rlwaii
 iA1cqFlkUMGXevseXYFC4Il9ZfSKZJa9KCJDN/hwXMd4ceeWj5F6/8oTRWo7VznxQv7L
 BBxg==
X-Gm-Message-State: AFuF++l+dBz/LbeOhskVrwoKr8f6q20siOP0VgQZivaxXLj6MecML9CO
 7fh48SSRVe/qTlzixkkqgYs0L81x6I3aw4gaSB6grQa18mrSL808FM5HafCtDUkLdPfT9S9Tb7e
 Zsk63RJf2vFVcdO/7uvu3lTN7eMYmTUFxux6W48ksbGNq
X-Gm-Gg: AYBFou1w3Comq3imeM2kbaymwUJrVd3+xNGiHInzHYMJ5z/hw82243/cLQ2ZB133KVl
 U+5ZR7vFFpgDmf4NrdwKadK9jZGh6o8UMg0+CA1QbODiHs8+hvRCllBEu3kisoM7GNDq2GpgiOj
 ST+aOlSh6w4iiWd79LkWFHzAB4MaTfm6kovrok+x4KnbUJbHp636hZ2tVXTIhs/69bfyThi8HHd
 x45sZg4TCKRN+xUqBMwdVA4t4gcPBYQcFiRlj6A4BOP8JHe/QEeTQdXlPaCivOs8X3FYY/YWxab
 elEoNhbuSxatkoCKumtCfZqCy3cZvFFYDR0GsA6NeX9+9ZY+6hdXiUTXRo5uNtYl
X-Received: by 2002:a05:6000:491e:b0:486:eec7:3c1e with SMTP id
 ffacd0b85a97d-4870a9e3c16mr878285f8f.37.1789476955104; Tue, 15 Sep 2026
 05:55:55 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:55:54 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:55:54 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:55:54 -0700
X-Gm-Features: AcwNN1VxYORm61RoCLtU1XGB6Dmj5FD_IHOznCRTWGQK6fb4ApUn_RCxBLRI-tU
Message-ID: <CAF9RqJ7gJuo7NqR5HW3Z6_xQ29B8hq3Gvn8bLyLfFVD3Bvo4Mw@mail.gmail.com>
Subject: [PATCH] drm/amd: fix comment typos in amdgpu and radeon
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Sep 2026 13:14:42 +0000
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

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h                       | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c             | 2 +-
 .../amd/display/dc/dml2_0/dml21/dml21_translation_helper.c    | 2 +-
 drivers/gpu/drm/radeon/radeon_fence.c                         | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d53259a5b82f..acafa8c59cc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -532,7 +532,7 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 	out->state.flags = 0x0;
 	out->state.hangs = 0x0;

-	/* determine if a GPU reset has occured since the last call */
+	/* determine if a GPU reset has occurred since the last call */
 	reset_counter = atomic_read(&adev->gpu_reset_counter);
 	/* TODO: this should ideally return NO, GUILTY, or INNOCENT. */
 	if (ctx->reset_counter_query == reset_counter)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 8a2d64f0ebc3..f8be73e5fec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -228,12 +228,12 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
  */

 /**
- * amdgpu_vmid_had_gpu_reset - check if reset occured since last use
+ * amdgpu_vmid_had_gpu_reset - check if reset occurred since last use
  *
  * @adev: amdgpu_device pointer
  * @id: VMID structure
  *
- * Check if GPU reset occured since last use of the VMID.
+ * Check if GPU reset occurred since last use of the VMID.
  */
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 44fe40f9e8df..57bd34981be0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -31,7 +31,7 @@
 #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
 /* bit set means preamble IB is first presented in belonging context */
 #define AMDGPU_PREAMBLE_IB_PRESENT_FIRST    (1 << 1)
-/* bit set means context switch occured */
+/* bit set means context switch occurred */
 #define AMDGPU_HAVE_CTX_SWITCH              (1 << 2)
 /* bit set means IB is preempted */
 #define AMDGPU_IB_PREEMPTED                 (1 << 3)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
index 5bc3bc60a2ac..ebbe7900205e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
@@ -46,7 +46,7 @@ static void dcn20_wait_for_vmid_ready(struct dcn20_vmid *vmid)
 	/* According the hardware spec, we need to poll for the lowest
 	 * bit of PAGE_TABLE_BASE_ADDR_LO32 = 1 any time a GPUVM
 	 * context is updated. We can't use REG_WAIT here since we
-	 * don't have a seperate field to wait on.
+	 * don't have a separate field to wait on.
 	 *
 	 * TODO: Confirm timeout / poll interval with hardware team
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 1b0d55e2d7b0..1c9a3fe0f64c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -977,7 +977,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const
struct dc *in_dc, struct dc_s

 void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx,
struct dc_state *context)
 {
-	/* TODO these should be the max of active, svp prefetch and idle
should be tracked seperately */
+	/* TODO these should be the max of active, svp prefetch and idle
should be tracked separately */
 	context->bw_ctx.bw.dcn.clk.dispclk_khz =
in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.dispclk_khz;
 	context->bw_ctx.bw.dcn.clk.dcfclk_khz =
in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.active.dcfclk_khz;
 	context->bw_ctx.bw.dcn.clk.dramclk_khz =
in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.active.uclk_khz;
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c
b/drivers/gpu/drm/radeon/radeon_fence.c
index 299865569252..8e9402b8811b 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -191,7 +191,7 @@ static int
radeon_fence_check_signaled(wait_queue_entry_t *wait,
  * @ring: ring index the fence is associated with
  *
  * Checks the current fence value and calculates the last
- * signalled fence value. Returns true if activity occured
+ * signalled fence value. Returns true if activity occurred
  * on the ring, and the fence_queue should be waken up.
  */
 static bool radeon_fence_activity(struct radeon_device *rdev, int ring)
@@ -262,7 +262,7 @@ static bool radeon_fence_activity(struct
radeon_device *rdev, int ring)
  * @work: delayed work item
  *
  * Checks for fence activity and if there is none probe
- * the hardware if a lockup occured.
+ * the hardware if a lockup occurred.
  */
 static void radeon_fence_check_lockup(struct work_struct *work)
 {
-- 
2.54.0.windows.1
