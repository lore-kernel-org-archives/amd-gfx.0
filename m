Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4FFC982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B74110F300;
	Fri, 18 Sep 2026 12:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="a5Oasa2j";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BA710F2F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=if2eDIX3myPAYFa+M6q11Mt33U2WnHz7o3iVUYq3f3I=; b=a5Oasa2jDn8lK+ukZOV7qUwQ/C
 Q//DtwL/jk4FMU1Oomsyjm5kdIGJeFHzLKIHtXa2/kuVHUG+Jy1FBXH37waSgKNW9pSYXqkDrouHA
 ehJRrbS7G5ksPggodMOLA2eFDpxX6w8r4tl2yi5Z8gEFDAzH41iwbsJrGVYRG1wMQCGMP7HuwDuuK
 Yi6/D1nUWtC8CWBd0Q4So9BmNvcBwYq/gCCP/M/IHaTuqHULVk5t65HeC2DiCtpTrUjZiYSVqOV60
 1NJA/UwcwljQoEUOLI9D9h2c8/ePIX9DwDwevHS2OhL0OYg6r8bgGIxAuzoLDy69qVImxEElw0AlB
 O283zi7w==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x7XLN-003vNL-Oq; Fri, 18 Sep 2026 14:05:29 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/18] drm/amdgpu: More compact CIK SDMA IB emission
Date: Fri, 18 Sep 2026 13:05:06 +0100
Message-ID: <20260918120518.96922-7-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 105 +++++++++++++++-----------
 1 file changed, 63 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 8a09fa912931..4c4c8a8e3eb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -693,16 +693,18 @@ static void cik_sdma_vm_copy_pte(struct amdgpu_ib *ib,
 				 uint64_t pe, uint64_t src,
 				 unsigned count)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	unsigned bytes = count * 8;
 
-	ib->ptr[ib->length_dw++] = SDMA_PACKET(SDMA_OPCODE_COPY,
-		SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
-	ib->ptr[ib->length_dw++] = bytes;
-	ib->ptr[ib->length_dw++] = 0; /* src/dst endian swap */
-	ib->ptr[ib->length_dw++] = lower_32_bits(src);
-	ib->ptr[ib->length_dw++] = upper_32_bits(src);
-	ib->ptr[ib->length_dw++] = lower_32_bits(pe);
-	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
+	*ptr++ = SDMA_PACKET(SDMA_OPCODE_COPY, SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
+	*ptr++ = bytes;
+	*ptr++ = 0; /* src/dst endian swap */
+	*ptr++ = lower_32_bits(src);
+	*ptr++ = upper_32_bits(src);
+	*ptr++ = lower_32_bits(pe);
+	*ptr++ = upper_32_bits(pe);
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -720,18 +722,21 @@ static void cik_sdma_vm_write_pte(struct amdgpu_ib *ib, uint64_t pe,
 				  uint64_t value, unsigned count,
 				  uint32_t incr)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	unsigned ndw = count * 2;
 
-	ib->ptr[ib->length_dw++] = SDMA_PACKET(SDMA_OPCODE_WRITE,
-		SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
-	ib->ptr[ib->length_dw++] = lower_32_bits(pe);
-	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
-	ib->ptr[ib->length_dw++] = ndw;
+	*ptr++ = SDMA_PACKET(SDMA_OPCODE_WRITE,
+			     SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
+	*ptr++ = lower_32_bits(pe);
+	*ptr++ = upper_32_bits(pe);
+	*ptr++ = ndw;
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
@@ -750,17 +755,21 @@ static void cik_sdma_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
 				    uint64_t addr, unsigned count,
 				    uint32_t incr, uint64_t flags)
 {
+	u32 *ptr = &ib->ptr[ib->length_dw];
+
 	/* for physically contiguous pages (vram) */
-	ib->ptr[ib->length_dw++] = SDMA_PACKET(SDMA_OPCODE_GENERATE_PTE_PDE, 0, 0);
-	ib->ptr[ib->length_dw++] = lower_32_bits(pe); /* dst addr */
-	ib->ptr[ib->length_dw++] = upper_32_bits(pe);
-	ib->ptr[ib->length_dw++] = lower_32_bits(flags); /* mask */
-	ib->ptr[ib->length_dw++] = upper_32_bits(flags);
-	ib->ptr[ib->length_dw++] = lower_32_bits(addr); /* value */
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = incr; /* increment size */
-	ib->ptr[ib->length_dw++] = 0;
-	ib->ptr[ib->length_dw++] = count; /* number of entries */
+	*ptr++ = SDMA_PACKET(SDMA_OPCODE_GENERATE_PTE_PDE, 0, 0);
+	*ptr++ = lower_32_bits(pe); /* dst addr */
+	*ptr++ = upper_32_bits(pe);
+	*ptr++ = lower_32_bits(flags); /* mask */
+	*ptr++ = upper_32_bits(flags);
+	*ptr++ = lower_32_bits(addr); /* value */
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = incr; /* increment size */
+	*ptr++ = 0;
+	*ptr++ = count; /* number of entries */
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -773,18 +782,22 @@ static void cik_sdma_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
 static void cik_sdma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	u32 *ptr = &ib->ptr[ib->length_dw];
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 7;
+	if (!pad_count)
+		return;
+
 	for (i = 0; i < pad_count; i++)
 		if (sdma && sdma->burst_nop && (i == 0))
-			ib->ptr[ib->length_dw++] =
-					SDMA_PACKET(SDMA_OPCODE_NOP, 0, 0) |
-					SDMA_NOP_COUNT(pad_count - 1);
+			*ptr++ = SDMA_PACKET(SDMA_OPCODE_NOP, 0, 0) |
+				 SDMA_NOP_COUNT(pad_count - 1);
 		else
-			ib->ptr[ib->length_dw++] =
-					SDMA_PACKET(SDMA_OPCODE_NOP, 0, 0);
+			*ptr++ = SDMA_PACKET(SDMA_OPCODE_NOP, 0, 0);
+
+	ib->length_dw += pad_count;
 }
 
 /**
@@ -1278,13 +1291,17 @@ static void cik_sdma_emit_copy_buffer(struct amdgpu_ib *ib,
 				      uint32_t byte_count,
 				      uint32_t copy_flags)
 {
-	ib->ptr[ib->length_dw++] = SDMA_PACKET(SDMA_OPCODE_COPY, SDMA_COPY_SUB_OPCODE_LINEAR, 0);
-	ib->ptr[ib->length_dw++] = byte_count;
-	ib->ptr[ib->length_dw++] = 0; /* src/dst endian swap */
-	ib->ptr[ib->length_dw++] = lower_32_bits(src_offset);
-	ib->ptr[ib->length_dw++] = upper_32_bits(src_offset);
-	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
-	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
+	u32 *ptr = &ib->ptr[ib->length_dw];
+
+	*ptr++ = SDMA_PACKET(SDMA_OPCODE_COPY, SDMA_COPY_SUB_OPCODE_LINEAR, 0);
+	*ptr++ = byte_count;
+	*ptr++ = 0; /* src/dst endian swap */
+	*ptr++ = lower_32_bits(src_offset);
+	*ptr++ = upper_32_bits(src_offset);
+	*ptr++ = lower_32_bits(dst_offset);
+	*ptr++ = upper_32_bits(dst_offset);
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 /**
@@ -1302,11 +1319,15 @@ static void cik_sdma_emit_fill_buffer(struct amdgpu_ib *ib,
 				      uint64_t dst_offset,
 				      uint32_t byte_count)
 {
-	ib->ptr[ib->length_dw++] = SDMA_PACKET(SDMA_OPCODE_CONSTANT_FILL, 0, 0);
-	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
-	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
-	ib->ptr[ib->length_dw++] = src_data;
-	ib->ptr[ib->length_dw++] = byte_count;
+	u32 *ptr = &ib->ptr[ib->length_dw];
+
+	*ptr++ = SDMA_PACKET(SDMA_OPCODE_CONSTANT_FILL, 0, 0);
+	*ptr++ = lower_32_bits(dst_offset);
+	*ptr++ = upper_32_bits(dst_offset);
+	*ptr++ = src_data;
+	*ptr++ = byte_count;
+
+	ib->length_dw = ptr - ib->ptr;
 }
 
 static const struct amdgpu_buffer_funcs cik_sdma_buffer_funcs = {
-- 
2.55.0

