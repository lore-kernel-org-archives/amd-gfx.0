Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912E5CAC58D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 11:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C54910EAD5;
	Thu, 11 Sep 2025 11:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LTtyz77N";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C97F10EAC7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RB9uwS8atVkYYHb33d9yaS1f9LZzwtUAXzXqEU31sX8=; b=LTtyz77NQ3pj6mnKc0I6ZS/1iZ
 kR3fSp6zHFdS8SsMtNYyNkAfRI4HttzWs28xAZONzOqg8mtX+Dl3G8oxhE1VEKXmY97wv1Sfu6x4h
 Xnzh7NI0smqdNWTNzSPdduT2i+/M/+97U34zlCVSsiLyPEtRZmilIh0BZCuwbGkXBF6IAk1vd9npz
 D+JxpW7AzPvuHkmOFRofPhAI0gpeIApaOVout1HN34kT+DATUXtdDi+nTJejlSSKAnb3cQpedUkzE
 Vng/d10qwpe8dpPpujEK3Z0BobjPHQRY1AB40Wve0t6ix/ygEU5Okvwle/7FMCCsmCXkd8qhr4G/C
 IfWNum7Q==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwfgs-009n2g-9k; Thu, 11 Sep 2025 13:42:14 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 03/16] drm/amdgpu: More compact VCN IB emission
Date: Thu, 11 Sep 2025 12:41:42 +0100
Message-ID: <20250911114155.24786-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
References: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 101 +++++++++++++-----------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 595f0df17bcc..3b30bdff76d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -762,16 +762,19 @@ static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
 						uint32_t ib_pack_in_dw, bool enc)
 {
 	uint32_t *ib_checksum;
+	u32 *ptr = &ib->ptr[ib->length_dw];
 
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
@@ -801,6 +804,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
+	u32 *ptr;
 	int i, r;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
@@ -813,7 +817,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	ib->length_dw = 0;
+	ptr = ib->ptr;
 
 	/* single queue headers */
 	if (adev->vcn.inst[ring->me].using_unified_queue) {
@@ -822,10 +826,11 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
 	}
 
-	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
-	ib->ptr[ib->length_dw++] = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
-	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib->ptr[ib->length_dw]);
-	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
+	*ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
+	*ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
+	decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
+	ib->length_dw = ptr - ib->ptr +
+			sizeof(struct amdgpu_vcn_decode_buffer) / 4;
 	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
 
 	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
@@ -833,7 +838,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
 
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+		*ptr++ = 0x0;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
@@ -931,6 +936,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
+	u32 *ptr;
 	int i, r;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
@@ -943,31 +949,32 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 		return r;
 
 	ib = &job->ibs[0];
+	ptr = ib->ptr;
 	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
-	ib->length_dw = 0;
-
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
-	ib->ptr[ib->length_dw++] = 0x00000018;
-	ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
-	ib->ptr[ib->length_dw++] = handle;
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000018;
+	*ptr++ = 0x00000001; /* session info */
+	*ptr++ = handle;
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = addr;
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000014;
-	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
-	ib->ptr[ib->length_dw++] = 0x0000001c;
-	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000014;
+	*ptr++ = 0x00000002; /* task info */
+	*ptr++ = 0x0000001c;
+	*ptr++ = 0x00000000;
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000008;
-	ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
+	*ptr++ = 0x00000008;
+	*ptr++ = 0x08000001; /* op initialize */
+
+	ib->length_dw = ptr - ib->ptr;
 
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+		*ptr++ = 0x0;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
@@ -998,6 +1005,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
+	u32 *ptr;
 	int i, r;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
@@ -1010,31 +1018,32 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 		return r;
 
 	ib = &job->ibs[0];
+	ptr = ib->ptr;
 	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
-	ib->length_dw = 0;
-
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
-	ib->ptr[ib->length_dw++] = 0x00000018;
-	ib->ptr[ib->length_dw++] = 0x00000001;
-	ib->ptr[ib->length_dw++] = handle;
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000018;
+	*ptr++ = 0x00000001;
+	*ptr++ = handle;
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = addr;
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000014;
-	ib->ptr[ib->length_dw++] = 0x00000002;
-	ib->ptr[ib->length_dw++] = 0x0000001c;
-	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000014;
+	*ptr++ = 0x00000002;
+	*ptr++ = 0x0000001c;
+	*ptr++ = 0x00000000;
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000008;
-	ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
+	*ptr++ = 0x00000008;
+	*ptr++ = 0x08000002; /* op close session */
+
+	ib->length_dw = ptr - ib->ptr;
 
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+		*ptr++ = 0x0;
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
-- 
2.48.0

