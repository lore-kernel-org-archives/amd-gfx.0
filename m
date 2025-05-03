Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D17AC369C2
	for <amd-gfx@archiver.kernel.org>; Sat,  3 May 2025 20:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E625810E03C;
	Sat,  3 May 2025 20:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BUoRyiyA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D3F410E13E
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 May 2025 20:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mzdlBHEnXg9dUZXx6MukWY5CtWHB1w/kpM9g+ayIeAo=; b=BUoRyiyAk3kpgojuUuTpgDfRTx
 Ob43K2Mu0LQJU0VsVLNY5Ou3710LZ9KTdxqUE1m0DpQLfApcNg9KiqWytq9hfNID7pnUxbRuuxAIc
 qLkTqkGLLjxp0wt6NZhpBiGVvPBsjzp+BTHEidUUMklDTe4BYAja3cLAFYtkl0vqxiA9zjCcthM33
 gzGwFWggO20IXX3F1MzGXDseWBUI2Jxy/sB7Bz1o07nQ8lTO/aVTe1SKRhDmbUspkrTz5KIg/IAtq
 +lTO1xir+fQ+zn/MaCoSnOQEGPiXpCT/DRTtCx0+QAoGeKWJb+HtTo5OBYSS8xCp1psrxdZJwkUtA
 iUSSNQDw==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBJbS-002dFw-Ae; Sat, 03 May 2025 22:39:23 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 1/2] drm/amdgpu: Add documentation to some parts of the
 AMDGPU ring and wb
Date: Sat,  3 May 2025 14:38:42 -0600
Message-ID: <20250503203905.346049-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250503203905.346049-1-siqueira@igalia.com>
References: <20250503203905.346049-1-siqueira@igalia.com>
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

Add some random documentation associated with the ring buffer
manipulations and writeback.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 52 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 74 ++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843..ab9d1956ce28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -520,12 +520,62 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
  */
 #define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
 
+/**
+ * amdgpu_wb - This struct is used for small GPU memory allocation.
+ *
+ * This struct is used to allocate a small amount of GPU memory that can be
+ * used to shadow certain states into the memory. This is especially useful for
+ * providing easy CPU access to some states without requiring register access
+ * (e.g., if some block is power gated, reading register may be problematic).
+ *
+ * Note: the term writeback was initially used because many of the amdgpu
+ * components had some level of writeback memory, and this struct initially
+ * described those components.
+ */
 struct amdgpu_wb {
+
+	/**
+	 * @wb_obj:
+	 *
+	 * Buffer Object used for the writeback memory.
+	 */
 	struct amdgpu_bo	*wb_obj;
+
+	/**
+	 * @wb:
+	 *
+	 * Pointer to the first writeback slot. In terms of CPU address
+	 * this value can be accessed directly by using the offset as an index.
+	 * For the GPU address, it is necessary to use gpu_addr and the offset.
+	 */
 	volatile uint32_t	*wb;
+
+	/**
+	 * @gpu_addr:
+	 *
+	 * Writeback base address in the GPU.
+	 */
 	uint64_t		gpu_addr;
-	u32			num_wb;	/* Number of wb slots actually reserved for amdgpu. */
+
+	/**
+	 * @num_wb:
+	 *
+	 * Number of writeback slots reserved for amdgpu.
+	 */
+	u32			num_wb;
+
+	/**
+	 * @used:
+	 *
+	 * Track the writeback slot already used.
+	 */
 	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
+
+	/**
+	 * @lock:
+	 *
+	 * Protects read and write of the used field array.
+	 */
 	spinlock_t		lock;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ec4de8df34e7..b95b47110769 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -164,8 +164,24 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
 
 /* provided by hw blocks that expose a ring buffer for commands */
 struct amdgpu_ring_funcs {
+	/**
+	 * @type:
+	 *
+	 * GFX, Compute, SDMA, UVD, VCE, VCN, VPE, KIQ, MES, UMSCH, and CPER
+	 * use ring buffers. The type field just identifies which component the
+	 * ring buffer is associated with.
+	 */
 	enum amdgpu_ring_type	type;
 	uint32_t		align_mask;
+
+	/**
+	 * @nop:
+	 *
+	 * Every block in the amdgpu has no-op instructions (e.g., GFX 10
+	 * uses PACKET3(PACKET3_NOP, 0x3FFF), VCN 5 uses VCN_ENC_CMD_NO_OP,
+	 * etc). This field receives the specific no-op for the component
+	 * that initializes the ring.
+	 */
 	u32			nop;
 	bool			support_64bit_ptrs;
 	bool			no_user_fence;
@@ -241,6 +257,9 @@ struct amdgpu_ring_funcs {
 	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
 
+/**
+ * amdgpu_ring - Holds ring information
+ */
 struct amdgpu_ring {
 	struct amdgpu_device		*adev;
 	const struct amdgpu_ring_funcs	*funcs;
@@ -252,13 +271,61 @@ struct amdgpu_ring {
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
+
+	/**
+	 * @wptr:
+	 *
+	 * This is part of the Ring buffer implementation and represents the
+	 * write pointer. The wptr determines where the host has written.
+	 */
 	u64			wptr;
+
+	/**
+	 * @wptr_old:
+	 *
+	 * Before update wptr with the new value, usually the old value is
+	 * stored in the wptr_old.
+	 */
 	u64			wptr_old;
 	unsigned		ring_size;
+
+	/**
+	 * @max_dw:
+	 *
+	 * Maximum number of DWords for ring allocation. This information is
+	 * provided at the ring initialization time, and each IP block can
+	 * specify a specific value. Check places that invoke
+	 * amdgpu_ring_init() to see the maximum size per block.
+	 */
 	unsigned		max_dw;
+
+	/**
+	 * @count_dw:
+	 *
+	 * This value starts with the maximum amount of DWords supported by the
+	 * ring. This value is updated based on the ring manipulation.
+	 */
 	int			count_dw;
 	uint64_t		gpu_addr;
+
+	/**
+	 * @ptr_mask:
+	 *
+	 * Some IPs provide support for 64-bit pointers and others for 32-bit
+	 * only; this behavior is component-specific and defined by the field
+	 * support_64bit_ptr. If the IP block supports 64-bits, the mask
+	 * 0xffffffffffffffff is set; otherwise, this value assumes buf_mask.
+	 * Notice that this field is used to keep wptr under a valid range.
+	 */
 	uint64_t		ptr_mask;
+
+	/**
+	 * @buf_mask:
+	 *
+	 * Buffer mask is a value used to keep wptr count under its
+	 * thresholding. Buffer mask initialized during the ring buffer
+	 * initialization time, and it is defined as (ring_size / 4) -1.
+	 */
 	uint32_t		buf_mask;
 	u32			idx;
 	u32			xcc_id;
@@ -276,6 +343,13 @@ struct amdgpu_ring {
 	bool			use_pollmem;
 	unsigned		wptr_offs;
 	u64			wptr_gpu_addr;
+
+	/**
+	 * @wptr_cpu_addr:
+	 *
+	 * This is the CPU address pointer in the writeback slot. This is used
+	 * to commit changes to the GPU.
+	 */
 	volatile u32		*wptr_cpu_addr;
 	unsigned		fence_offs;
 	u64			fence_gpu_addr;
-- 
2.47.2

