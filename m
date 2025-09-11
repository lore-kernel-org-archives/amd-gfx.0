Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D069CA1016
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 11:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0C910EACD;
	Thu, 11 Sep 2025 11:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CsHeXnxE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3243D10EACD
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ntCsbSmYR2musiKBSZ7/O7L2KmNfZGY9eJYFgoyF0zs=; b=CsHeXnxEWx4GGYulfWFI07xUhf
 CAq++gbvZ2P/eQdmIdNtqAXfbOhZfzY3Ate7w0A7kQ/CfFCZ8YHJKLb1yRC0NZRrQcSFlAFTdwv+Y
 fzD9kTY+9bmEb74gA8n04cFkkoXV+EjZmGWZY4WXrpDs+xVvZ/cqC/3y/ndcefLURVQ+iy+OUQw6v
 wWv9ms8t7bm/FzXuM2PCYDQFB2jIb0O5bQ6xoxRxY+kKoVrFeqTx/Zgei0zPoGne7KgKvQP6aCg4v
 BEzmGUwLnpPM0FtRnDdgYoGhTC/z5R7SLafLhrv9iyqRvKzpwdsQFCUl7J8oHWkewBCmdAUFAvZEu
 mPX1rQTA==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwfgz-009n3F-1X; Thu, 11 Sep 2025 13:42:21 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 06/16] drm/amdgpu: More compact SI SDMA emission
Date: Thu, 11 Sep 2025 12:41:45 +0100
Message-ID: <20250911114155.24786-7-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 84 +++++++++++++++++------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 7f18e4875287..9e26c7598d74 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -323,14 +323,16 @@ static void si_dma_vm_copy_pte(struct amdgpu_ib *ib,
 			       uint64_t pe, uint64_t src,
 			       unsigned count)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	unsigned bytes = count * 8;
 
-	ib->ptr[ib->length_dw++] = DMA_PACKET(DMA_PACKET_COPY,
-					      1, 0, 0, bytes);
-	ib->ptr[ib->length_dw++] = lower_32_bits(pe);
-	ib->ptr[ib->length_dw++] = lower_32_bits(src);
-	ib->ptr[ib->length_dw++] = upper_32_bits(pe) & 0xff;
-	ib->ptr[ib->length_dw++] = upper_32_bits(src) & 0xff;
+	*ptr++ = DMA_PACKET(DMA_PACKET_COPY, 1, 0, 0, bytes);
+	*ptr++ = lower_32_bits(pe);
+	*ptr++ = lower_32_bits(src);
+	*ptr++ = upper_32_bits(pe) & 0xff;
+	*ptr++ = upper_32_bits(src) & 0xff;
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -348,16 +350,19 @@ static void si_dma_vm_write_pte(struct amdgpu_ib *ib, uint64_t pe,
 				uint64_t value, unsigned count,
 				uint32_t incr)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	unsigned ndw = count * 2;
 
-	ib->ptr[ib->length_dw++] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, ndw);
-	ib->ptr[ib->length_dw++] = lower_32_bits(pe);
-	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
+	*ptr++ = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, ndw);
+	*ptr++ = lower_32_bits(pe);
+	*ptr++ = upper_32_bits(pe);
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
@@ -377,6 +382,7 @@ static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,
 				     uint64_t addr, unsigned count,
 				     uint32_t incr, uint64_t flags)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	uint64_t value;
 	unsigned ndw;
 
@@ -391,19 +397,21 @@ static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,
 			value = 0;
 
 		/* for physically contiguous pages (vram) */
-		ib->ptr[ib->length_dw++] = DMA_PTE_PDE_PACKET(ndw);
-		ib->ptr[ib->length_dw++] = pe; /* dst addr */
-		ib->ptr[ib->length_dw++] = upper_32_bits(pe) & 0xff;
-		ib->ptr[ib->length_dw++] = lower_32_bits(flags); /* mask */
-		ib->ptr[ib->length_dw++] = upper_32_bits(flags);
-		ib->ptr[ib->length_dw++] = value; /* value */
-		ib->ptr[ib->length_dw++] = upper_32_bits(value);
-		ib->ptr[ib->length_dw++] = incr; /* increment size */
-		ib->ptr[ib->length_dw++] = 0;
+		*ptr++ = DMA_PTE_PDE_PACKET(ndw);
+		*ptr++ = pe; /* dst addr */
+		*ptr++ = upper_32_bits(pe) & 0xff;
+		*ptr++ = lower_32_bits(flags); /* mask */
+		*ptr++ = upper_32_bits(flags);
+		*ptr++ = value; /* value */
+		*ptr++ = upper_32_bits(value);
+		*ptr++ = incr; /* increment size */
+		*ptr++ = 0;
 		pe += ndw * 4;
 		addr += (ndw / 2) * incr;
 		count -= ndw / 2;
 	}
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -415,8 +423,12 @@ static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void si_dma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	while (ib->length_dw & 0x7)
-		ib->ptr[ib->length_dw++] = DMA_PACKET(DMA_PACKET_NOP, 0, 0, 0, 0);
+	int pad = 8 - (ib->length_dw & 0x7);
+
+	if (pad && pad < 8) {
+		memset32(ib->ptr, DMA_PACKET(DMA_PACKET_NOP, 0, 0, 0, 0), pad);
+		ib->length_dw += pad;
+	}
 }
 
 /**
@@ -783,12 +795,15 @@ static void si_dma_emit_copy_buffer(struct amdgpu_ib *ib,
 				       uint32_t byte_count,
 				       uint32_t copy_flags)
 {
-	ib->ptr[ib->length_dw++] = DMA_PACKET(DMA_PACKET_COPY,
-					      1, 0, 0, byte_count);
-	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
-	ib->ptr[ib->length_dw++] = lower_32_bits(src_offset);
-	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset) & 0xff;
-	ib->ptr[ib->length_dw++] = upper_32_bits(src_offset) & 0xff;
+	u32 *ptr = &ib->ptr[ib->length_dw];
+
+	*ptr++ = DMA_PACKET(DMA_PACKET_COPY, 1, 0, 0, byte_count);
+	*ptr++ = lower_32_bits(dst_offset);
+	*ptr++ = lower_32_bits(src_offset);
+	*ptr++ = upper_32_bits(dst_offset) & 0xff;
+	*ptr++ = upper_32_bits(src_offset) & 0xff;
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -806,11 +821,14 @@ static void si_dma_emit_fill_buffer(struct amdgpu_ib *ib,
 				       uint64_t dst_offset,
 				       uint32_t byte_count)
 {
-	ib->ptr[ib->length_dw++] = DMA_PACKET(DMA_PACKET_CONSTANT_FILL,
-					      0, 0, 0, byte_count / 4);
-	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
-	ib->ptr[ib->length_dw++] = src_data;
-	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset) << 16;
+	u32 *ptr = &ib->ptr[ib->length_dw];
+
+	*ptr++ = DMA_PACKET(DMA_PACKET_CONSTANT_FILL, 0, 0, 0, byte_count / 4);
+	*ptr++ = lower_32_bits(dst_offset);
+	*ptr++ = src_data;
+	*ptr++ = upper_32_bits(dst_offset) << 16;
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 
-- 
2.48.0

