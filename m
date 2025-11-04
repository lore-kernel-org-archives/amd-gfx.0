Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC773CCFA10
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6097110E5F8;
	Tue,  4 Nov 2025 14:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="q/Q8wqDb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C97F10E5F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7+kuv5p/mRWan3ed8Ey+FWeztusqvKqPiBj/eUjPOtE=; b=q/Q8wqDbu1c5n3iayiciq6U8WA
 svfmaWKcNyGp0XsUekM9iLvERAHBckf5NywnT7jZgAKAVhUT/JM2jsnQCHnttbA80Wdoz4tRnX3vY
 Dio2cjFqDpaeAqJgbk8G/E4heg/jf8lgTZkvTLngcVt+/QO+us/agHGRViU0+2pUj+SapDrcFNwnT
 V0XqS27aI4nVPSqaQVFkMkq94pOBRyunQxp2ef/hmp0s7Q9fvuguEjO7+J5oTGrnwzwVIjvx+N7xa
 FNgXXlfo0FkVmG8+XvSX555eGchWeP3uKLMp8/+doePtbI6jof6xeChUTdy1tu6+sUE1jXq5L3YXd
 WuqWdm7w==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHgB-001OEz-Rm; Tue, 04 Nov 2025 15:06:35 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 08/25] drm/amdgpu/vcn2.0: Use local variables more
Date: Tue,  4 Nov 2025 14:04:04 +0000
Message-ID: <20251104140421.88520-9-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
References: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
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

Compact some very long and repetitive lines of code by caching the
respective object in local variables. This is a concept which is already
used at places, but not consistently so.

add/remove: 0/0 grow/shrink: 0/7 up/down: 0/-246 (-246)
Function                                     old     new   delta
vcn_v2_0_dec_ring_insert_nop                 200     198      -2
vcn_v2_0_dec_ring_insert_start               272     257     -15
vcn_v2_0_dec_ring_emit_wreg                  402     373     -29
vcn_v2_0_dec_ring_test_ring                  457     422     -35
vcn_v2_0_dec_ring_emit_ib                    571     530     -41
vcn_v2_0_dec_ring_emit_reg_wait              536     492     -44
vcn_v2_0_dec_ring_emit_fence                 938     858     -80
Total: Before=8977605, After=8977359, chg -0.00%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 71 +++++++++++++++------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 850aa5fb4e13..eca5e25093db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1479,11 +1479,12 @@ static void vcn_v2_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
  */
 void vcn_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_reg *internal =
+		&ring->adev->vcn.inst[ring->me].internal;
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data0, 0));
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->cmd, 0));
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_START << 1));
 }
 
@@ -1512,13 +1513,14 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
  */
 void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_reg *internal =
+		&ring->adev->vcn.inst[ring->me].internal;
 	int i;
 
 	WARN_ON(ring->wptr % 2 || count % 2);
 
 	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.nop, 0));
+		amdgpu_ring_write(ring, PACKET0(internal->nop, 0));
 		amdgpu_ring_write(ring, 0);
 	}
 }
@@ -1536,28 +1538,30 @@ void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 				unsigned flags)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_reg *internal =
+		&ring->adev->vcn.inst[ring->me].internal;
 
 	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.context_id, 0));
+
+	amdgpu_ring_write(ring, PACKET0(internal->context_id, 0));
 	amdgpu_ring_write(ring, seq);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data0, 0));
 	amdgpu_ring_write(ring, addr & 0xffffffff);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data1, 0));
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xff);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->cmd, 0));
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_FENCE << 1));
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data0, 0));
 	amdgpu_ring_write(ring, 0);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data1, 0));
 	amdgpu_ring_write(ring, 0);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->cmd, 0));
 
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_TRAP << 1));
 }
@@ -1577,35 +1581,37 @@ void vcn_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 			       struct amdgpu_ib *ib,
 			       uint32_t flags)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_reg *internal =
+		&ring->adev->vcn.inst[ring->me].internal;
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.ib_vmid, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->ib_vmid, 0));
 	amdgpu_ring_write(ring, vmid);
 
-	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_bar_low, 0));
+	amdgpu_ring_write(ring,	PACKET0(internal->ib_bar_low, 0));
 	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_bar_high, 0));
+	amdgpu_ring_write(ring,	PACKET0(internal->ib_bar_high, 0));
 	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_size, 0));
+	amdgpu_ring_write(ring,	PACKET0(internal->ib_size, 0));
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
 void vcn_v2_0_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 				uint32_t val, uint32_t mask)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_reg *internal =
+		&ring->adev->vcn.inst[ring->me].internal;
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data0, 0));
 	amdgpu_ring_write(ring, reg << 2);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data1, 0));
 	amdgpu_ring_write(ring, val);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.gp_scratch8, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->gp_scratch8, 0));
 	amdgpu_ring_write(ring, mask);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->cmd, 0));
 
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_REG_READ_COND_WAIT << 1));
 }
@@ -1628,15 +1634,16 @@ void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 void vcn_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring,
 				uint32_t reg, uint32_t val)
 {
-	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_reg *internal =
+		&ring->adev->vcn.inst[ring->me].internal;
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data0, 0));
 	amdgpu_ring_write(ring, reg << 2);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->data1, 0));
 	amdgpu_ring_write(ring, val);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->cmd, 0));
 
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_WRITE_REG << 1));
 }
@@ -1826,6 +1833,8 @@ static int vcn_v2_0_process_interrupt(struct amdgpu_device *adev,
 int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_reg *internal = &adev->vcn.inst[ring->me].internal;
+	struct amdgpu_vcn_reg *external = &adev->vcn.inst[ring->me].external;
 	uint32_t tmp = 0;
 	unsigned i;
 	int r;
@@ -1833,17 +1842,17 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
+	WREG32(external->scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 4);
 	if (r)
 		return r;
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->cmd, 0));
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_START << 1));
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.scratch9, 0));
+	amdgpu_ring_write(ring, PACKET0(internal->scratch9, 0));
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32(adev->vcn.inst[ring->me].external.scratch9);
+		tmp = RREG32(external->scratch9);
 		if (tmp == 0xDEADBEEF)
 			break;
 		udelay(1);
-- 
2.48.0

