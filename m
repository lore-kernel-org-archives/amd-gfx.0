Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8F4CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 12:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A7D10E673;
	Mon, 22 Jun 2026 12:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IRFccw3T";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E527F10E66B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 12:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NaKtP86E+RyYzDvWnQwYbAxfa1OTbVnQZ+9vpMeVmYc=; b=IRFccw3Tx/hPOwaF3Fw0KZIuxI
 Gka/UHJtSsY4WGufe9669zI/XFivVanXlFltybbvFuuP+9BHA2JXlNT4yIaMeXl3AoKoLTNNbOPDA
 9rimR4Hf1SULdPrgzDV1kSMHRKhWiXZLdYOCVAlJq7DZCPSV5iOBIDhEXr+jgGtkdG4yYd6MySbku
 L3LSlGPTcl9HM5L6LpijuGfWlKbz+lgvADvjeooJ0fD88N0TFvnPJdILywWtsn3L8Ve3HLRXn9krC
 XRzQQ4gWgFA9Ex/jQNwlFK5hQGHZTy73eymcTWGJUj72q2BI8YDdfxX52XynfaCA4mUsDbnbIylvq
 P1PGHwfQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbdSP-003iyw-16; Mon, 22 Jun 2026 14:08:53 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 02/16] drm/amdgpu: More compact VCN IB emission
Date: Mon, 22 Jun 2026 13:08:21 +0100
Message-ID: <20260622120835.52473-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622120835.52473-1-tvrtko.ursulin@igalia.com>
References: <20260622120835.52473-1-tvrtko.ursulin@igalia.com>
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

Avoid constant register reloads while emitting IBs by using a local write
pointer and only updating the size at the end of each helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 134 +++++++++++++-----------
 1 file changed, 75 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e4d435d4a629..04ebbda51214 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -624,9 +624,12 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 {
 	u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_reg *internal = &adev->vcn.inst[ring->me].internal;
+	uint32_t nop = PACKET0(internal->nop, 0);
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	uint32_t *ptr;
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -636,15 +639,16 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	ib->ptr[0] = PACKET0(adev->vcn.inst[ring->me].internal.data0, 0);
-	ib->ptr[1] = addr;
-	ib->ptr[2] = PACKET0(adev->vcn.inst[ring->me].internal.data1, 0);
-	ib->ptr[3] = addr >> 32;
-	ib->ptr[4] = PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0);
-	ib->ptr[5] = 0;
+	ptr = ib->ptr;
+	*ptr++ = PACKET0(internal->data0, 0);
+	*ptr++ = addr;
+	*ptr++ = PACKET0(internal->data1, 0);
+	*ptr++ = addr >> 32;
+	*ptr++ = PACKET0(internal->cmd, 0);
+	*ptr++ = 0;
 	for (i = 6; i < 16; i += 2) {
-		ib->ptr[i] = PACKET0(adev->vcn.inst[ring->me].internal.nop, 0);
-		ib->ptr[i+1] = 0;
+		*ptr++ = nop;
+		*ptr++ = 0;
 	}
 	ib->length_dw = 16;
 
@@ -764,17 +768,20 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
 						uint32_t ib_pack_in_dw, bool enc)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	uint32_t *ib_checksum;
 
-	ib->ptr[ib->length_dw++] = 0x00000010; /* single queue checksum */
-	ib->ptr[ib->length_dw++] = 0x30000002;
-	ib_checksum = &ib->ptr[ib->length_dw++];
-	ib->ptr[ib->length_dw++] = ib_pack_in_dw;
+	*ptr++ = 0x00000010; /* single queue checksum */
+	*ptr++ = 0x30000002;
+	ib_checksum = ptr++;
+	*ptr++ = ib_pack_in_dw;
 
-	ib->ptr[ib->length_dw++] = 0x00000010; /* engine info */
-	ib->ptr[ib->length_dw++] = 0x30000001;
-	ib->ptr[ib->length_dw++] = enc ? 0x2 : 0x3;
-	ib->ptr[ib->length_dw++] = ib_pack_in_dw * sizeof(uint32_t);
+	*ptr++ = 0x00000010; /* engine info */
+	*ptr++ = 0x30000001;
+	*ptr++ = enc ? 0x2 : 0x3;
+	*ptr++ = ib_pack_in_dw * sizeof(uint32_t);
+
+	ib->length_dw = ptr - ib->ptr;
 
 	return ib_checksum;
 }
@@ -804,7 +811,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
-	int i, r;
+	u32 *ptr;
+	int r;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_size_dw += 8;
@@ -825,18 +833,20 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
 	}
 
-	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
-	ib->ptr[ib->length_dw++] = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
-	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib->ptr[ib->length_dw]);
-	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
+	ptr = &ib->ptr[ib->length_dw];
+
+	*ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
+	*ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
+	decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
+	ib->length_dw = ptr - ib->ptr +
+			sizeof(struct amdgpu_vcn_decode_buffer) / 4;
 	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
 
 	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
 	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
 	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
 
-	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+	memset32(ptr, 0, ib_size_dw - ib->length_dw);
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
@@ -934,7 +944,8 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	int i, r;
+	u32 *ptr;
+	int r;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_size_dw += 8;
@@ -946,31 +957,33 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 		return r;
 
 	ib = &job->ibs[0];
-	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-
 	ib->length_dw = 0;
+	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
-	ib->ptr[ib->length_dw++] = 0x00000018;
-	ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
-	ib->ptr[ib->length_dw++] = handle;
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	ptr = &ib->ptr[ib->length_dw];
 
-	ib->ptr[ib->length_dw++] = 0x00000014;
-	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
-	ib->ptr[ib->length_dw++] = 0x0000001c;
-	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000018;
+	*ptr++ = 0x00000001; /* session info */
+	*ptr++ = handle;
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = addr;
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000008;
-	ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
+	*ptr++ = 0x00000014;
+	*ptr++ = 0x00000002; /* task info */
+	*ptr++ = 0x0000001c;
+	*ptr++ = 0x00000000;
+	*ptr++ = 0x00000000;
 
-	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+	*ptr++ = 0x00000008;
+	*ptr++ = 0x08000001; /* op initialize */
+
+	ib->length_dw = ptr - ib->ptr;
+
+	memset32(ptr, 0, ib_size_dw - ib->length_dw);
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
@@ -1001,7 +1014,8 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	int i, r;
+	u32 *ptr;
+	int r;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_size_dw += 8;
@@ -1013,31 +1027,33 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 		return r;
 
 	ib = &job->ibs[0];
-	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-
 	ib->length_dw = 0;
+	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
-	ib->ptr[ib->length_dw++] = 0x00000018;
-	ib->ptr[ib->length_dw++] = 0x00000001;
-	ib->ptr[ib->length_dw++] = handle;
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	ptr = &ib->ptr[ib->length_dw];
 
-	ib->ptr[ib->length_dw++] = 0x00000014;
-	ib->ptr[ib->length_dw++] = 0x00000002;
-	ib->ptr[ib->length_dw++] = 0x0000001c;
-	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000018;
+	*ptr++ = 0x00000001;
+	*ptr++ = handle;
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = addr;
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000008;
-	ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
+	*ptr++ = 0x00000014;
+	*ptr++ = 0x00000002;
+	*ptr++ = 0x0000001c;
+	*ptr++ = 0x00000000;
+	*ptr++ = 0x00000000;
 
-	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+	*ptr++ = 0x00000008;
+	*ptr++ = 0x08000002; /* op close session */
+
+	ib->length_dw = ptr - ib->ptr;
+
+	memset32(ptr, 0, ib_size_dw - ib->length_dw);
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
-- 
2.54.0

