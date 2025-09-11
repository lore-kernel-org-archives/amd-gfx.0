Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2984CAC58D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 11:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B01410EAC7;
	Thu, 11 Sep 2025 11:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="svM+//j+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A670810EAC7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mluQma4b50wqe+h4yLyTsH666VV1YNtKjuQDEzK4Y1c=; b=svM+//j+Vgu2FCJpmSp8MYKgtJ
 NJjL39qA7Nl8j71dKd+Op+kDMdGHb3pFDvrndvojo30BOtjWYA6BhGTRhd9CKhwdNLRjR1mumxHDu
 EpNT0Yo5NMsuTJaqUiDCI6EO0N1sIf/lLOQZtqePJqhSQ1+C+78KT6Mq1pYpxVAP1f87GtqXtEYLK
 LOe7QGa3n2J2F/o4Arm+3Cd1B+6BaPgdy9zkrMoC+A1ZAlzjrqWHOkKpJih1+NKFR+ExyCRasbS3J
 0dYnt3+LMdaRmkMZroFc7Mq1E5kCkz/RX/nkPdu4ZvlBk6QK2xRyHIkQKu2w6W194daZCmrU20n7t
 xxyvZFoQ==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwfhC-009n4e-H5; Thu, 11 Sep 2025 13:42:34 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 13/16] drm/amdgpu: More compact SDMA 5.0 IB emission
Date: Thu, 11 Sep 2025 12:41:52 +0100
Message-ID: <20250911114155.24786-14-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 106 +++++++++++++++----------
 1 file changed, 64 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 7dc67a22a7a0..ab012592a276 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1155,16 +1155,19 @@ static void sdma_v5_0_vm_copy_pte(struct amdgpu_ib *ib,
 				  uint64_t pe, uint64_t src,
 				  unsigned count)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	unsigned bytes = count * 8;
 
-	ib->ptr[ib->length_dw++] = SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
-		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);
-	ib->ptr[ib->length_dw++] = bytes - 1;
-	ib->ptr[ib->length_dw++] = 0; /* src/dst endian swap */
-	ib->ptr[ib->length_dw++] = lower_32_bits(src);
-	ib->ptr[ib->length_dw++] = upper_32_bits(src);
-	ib->ptr[ib->length_dw++] = lower_32_bits(pe);
-	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
+	*ptr++ = SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
+		 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);
+	*ptr++ = bytes - 1;
+	*ptr++ = 0; /* src/dst endian swap */
+	*ptr++ = lower_32_bits(src);
+	*ptr++ = upper_32_bits(src);
+	*ptr++ = lower_32_bits(pe);
+	*ptr++ = upper_32_bits(pe);
+
+	ib->length_dw = ptr - ib->ptr;
 
 }
 
@@ -1183,18 +1186,21 @@ static void sdma_v5_0_vm_write_pte(struct amdgpu_ib *ib, uint64_t pe,
 				   uint64_t value, unsigned count,
 				   uint32_t incr)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	unsigned ndw = count * 2;
 
-	ib->ptr[ib->length_dw++] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
-		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib->ptr[ib->length_dw++] = lower_32_bits(pe);
-	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
-	ib->ptr[ib->length_dw++] = ndw - 1;
+	*ptr++ = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+		 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
+	*ptr++ = lower_32_bits(pe);
+	*ptr++ = upper_32_bits(pe);
+	*ptr++ = ndw - 1;
 	for (; ndw > 0; ndw -= 2) {
-		ib->ptr[ib->length_dw++] = lower_32_bits(value);
-		ib->ptr[ib->length_dw++] = upper_32_bits(value);
+		*ptr++ = lower_32_bits(value);
+		*ptr++ = upper_32_bits(value);
 		value += incr;
 	}
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -1214,17 +1220,21 @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 				     uint64_t addr, unsigned count,
 				     uint32_t incr, uint64_t flags)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
+
 	/* for physically contiguous pages (vram) */
-	ib->ptr[ib->length_dw++] = SDMA_PKT_HEADER_OP(SDMA_OP_PTEPDE);
-	ib->ptr[ib->length_dw++] = lower_32_bits(pe); /* dst addr */
-	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
-	ib->ptr[ib->length_dw++] = lower_32_bits(flags); /* mask */
-	ib->ptr[ib->length_dw++] = upper_32_bits(flags);
-	ib->ptr[ib->length_dw++] = lower_32_bits(addr); /* value */
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = incr; /* increment size */
-	ib->ptr[ib->length_dw++] = 0;
-	ib->ptr[ib->length_dw++] = count - 1; /* number of entries */
+	*ptr++ = SDMA_PKT_HEADER_OP(SDMA_OP_PTEPDE);
+	*ptr++ = lower_32_bits(pe); /* dst addr */
+	*ptr++ = upper_32_bits(pe);
+	*ptr++ = lower_32_bits(flags); /* mask */
+	*ptr++ = upper_32_bits(flags);
+	*ptr++ = lower_32_bits(addr); /* value */
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = incr; /* increment size */
+	*ptr++ = 0;
+	*ptr++ = count - 1; /* number of entries */
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -1237,18 +1247,22 @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 0x7;
+	if (!pad_count)
+		return;
+
 	for (i = 0; i < pad_count; i++)
 		if (sdma && sdma->burst_nop && (i == 0))
-			ib->ptr[ib->length_dw++] =
-				SDMA_PKT_HEADER_OP(SDMA_OP_NOP) |
-				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
+			*ptr++ = SDMA_PKT_HEADER_OP(SDMA_OP_NOP) |
+				 SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
 		else
-			ib->ptr[ib->length_dw++] =
-				SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+			*ptr++ = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+
+	ib->length_dw += pad_count;
 }
 
 
@@ -2021,15 +2035,19 @@ static void sdma_v5_0_emit_copy_buffer(struct amdgpu_ib *ib,
 				       uint32_t byte_count,
 				       uint32_t copy_flags)
 {
-	ib->ptr[ib->length_dw++] = SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
+	u32 *ptr = &ib->ptr[ib->length_dw];
+
+	*ptr++ = SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
 		SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_FLAGS_TMZ) ? 1 : 0);
-	ib->ptr[ib->length_dw++] = byte_count - 1;
-	ib->ptr[ib->length_dw++] = 0; /* src/dst endian swap */
-	ib->ptr[ib->length_dw++] = lower_32_bits(src_offset);
-	ib->ptr[ib->length_dw++] = upper_32_bits(src_offset);
-	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
-	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
+	*ptr++ = byte_count - 1;
+	*ptr++ = 0; /* src/dst endian swap */
+	*ptr++ = lower_32_bits(src_offset);
+	*ptr++ = upper_32_bits(src_offset);
+	*ptr++ = lower_32_bits(dst_offset);
+	*ptr++ = upper_32_bits(dst_offset);
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -2047,11 +2065,15 @@ static void sdma_v5_0_emit_fill_buffer(struct amdgpu_ib *ib,
 				       uint64_t dst_offset,
 				       uint32_t byte_count)
 {
-	ib->ptr[ib->length_dw++] = SDMA_PKT_HEADER_OP(SDMA_OP_CONST_FILL);
-	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
-	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
-	ib->ptr[ib->length_dw++] = src_data;
-	ib->ptr[ib->length_dw++] = byte_count - 1;
+	u32 *ptr = &ib->ptr[ib->length_dw];
+
+	*ptr++ = SDMA_PKT_HEADER_OP(SDMA_OP_CONST_FILL);
+	*ptr++ = lower_32_bits(dst_offset);
+	*ptr++ = upper_32_bits(dst_offset);
+	*ptr++ = src_data;
+	*ptr++ = byte_count - 1;
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
-- 
2.48.0

