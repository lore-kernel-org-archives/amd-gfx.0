Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0984C982DD
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E9510F311;
	Fri, 18 Sep 2026 12:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ce0XxqEL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEA610F30D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=nL5nUcaBqS7hivhTURYJGMNQAgK+Z4ZQSoLM8RYueF4=; b=Ce0XxqEL2oOL2MaRTRDx3oYIIc
 CMJxpCfW4vpLyt/lXd/XCkWLyAqm9e0FyH5dxYllDdKVFm+gAGFijeK01WKgyYT4VAYdQzc1pd3XA
 HyTpoGrgLZnQMwOZP/j4vj4g5eQFtS9S/09uAQtfATLsSv8NpefCZ7toVnygOdwB78uCzx3vNW3CU
 iEs4Z/4UjduZtvmi3e/gVJQRTQM281Ru/yrRxH6pY29QRUhS8Ytda3M7MInoVdhslj7BKUcalVlWD
 0h4ANGr2PoCxmO3t9Nl7jAJz1i0ShGLHes9krx5ZCKQII3kIFuyQNLlJuwqEHhJ1lOAgpO2lhCsFl
 tIjgYKrg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x7XLM-003vND-W2; Fri, 18 Sep 2026 14:05:28 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/18] drm/amdgpu: More compact SI SDMA emission
Date: Fri, 18 Sep 2026 13:05:05 +0100
Message-ID: <20260918120518.96922-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
References: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
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

Avoid constant register reloads while emitting IBs by using a local write
pointer and only updating the size at the end of each helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 84 +++++++++++++++++------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 31ab701d45d3..333861204546 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -328,14 +328,16 @@ static void si_dma_vm_copy_pte(struct amdgpu_ib *ib,
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
@@ -353,16 +355,19 @@ static void si_dma_vm_write_pte(struct amdgpu_ib *ib, uint64_t pe,
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
@@ -382,6 +387,7 @@ static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,
 				     uint64_t addr, unsigned count,
 				     uint32_t incr, uint64_t flags)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	uint64_t value;
 	unsigned ndw;
 
@@ -396,19 +402,21 @@ static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,
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
@@ -420,8 +428,12 @@ static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,
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
@@ -793,12 +805,15 @@ static void si_dma_emit_copy_buffer(struct amdgpu_ib *ib,
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
@@ -816,11 +831,14 @@ static void si_dma_emit_fill_buffer(struct amdgpu_ib *ib,
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
2.55.0

