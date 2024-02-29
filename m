Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A578C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 14:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C7410E3BF;
	Thu, 29 Feb 2024 14:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2qhhOgQ";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB39010E3B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 14:49:29 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-a3ee69976c9so180005966b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709218168; x=1709822968; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xiAOBgUliWftbRe4r8CNAunQHuxKOV+4krtQJriJTEI=;
 b=k2qhhOgQOxIAp2KjlXwcgiQRTzd2K5fDlwLpxlI6CAuniF3g4YeZ64s1NeCEnJ9QUN
 A4LmtuGODEaCANYLo8el8eo6zD4AA4Ko1Bwn8ZijqxCIe+T+07xs9t8fZYNMj6CxQdq0
 T2+8UxW0xaKeruA8nLMV1TOa3/W55qYiAjCtPfq3gXBVMkCZMVkUWbPryVusSL4GJzC2
 eSlgwTveyFGNqQt1bzRVS7J8YwDHEdAJiZe4XQir22LrN/TLId+u05bzUI2+FBdxH0/S
 AixuFhaNRdbjG8YiHRQndE5T7gAzx/FHjnAmEnM6R+q6pSG4sek2Drn5QqmKDTpT+LKI
 ejjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709218168; x=1709822968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiAOBgUliWftbRe4r8CNAunQHuxKOV+4krtQJriJTEI=;
 b=LNOi0dvOtlpbgPkGvYni2bVi+rIpaq50S2bi5rCVHwoxftJUCmdJke95U6ZahTlcIG
 FYmgl4yRz3sgDPyXnsC0LBCukyK0wUdB0E4WxmPjfcv/o3EZjuLT7JT95v+hBE7iXT7v
 PZBdoyBBuHMdg65UoAhBAnrwffQqN0SEjJYf+jOqqIA/8U6tmz1QVTiZa+cQPFuCAipe
 ooQCk0tmw7o3xzabLRFZpsPL4r+3oUkSkZ5BUaU/af12zVW6GqbwjPQmPInXslLhxdR2
 rBH0nETBZs1s90Z2tKC2/pnph7IgtwEgD/H9udEt0XZD+QEaKKImtImKTH1FBhpEHctx
 XroQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXomQ5Xyuy3tjF6P+KDMLQmXkLiterBxScqb73xW8B3g/uKf7+QFgwFIY+AlrJQ15KemZ76VYWFQODhAHEJTUtlvEqwTmXOQoyC2V0O+Q==
X-Gm-Message-State: AOJu0YxvAOVqdUfRXNo0gO6/4P8pGVg0SL+m6RKANs+tAhWiIrlsNY5w
 hqSY6j9ZHWb30PnhrCVrdwYjZKTIjMBz8HG2eMNFb/Y2eWVAWbzDmswrNlO2cq0=
X-Google-Smtp-Source: AGHT+IHnYVcB4IsuwdRKCe6Y/b48LF7TU1EMxD2BH/ABaM4/lINtduwZUD9RJRQcTdLjupzJzANpKA==
X-Received: by 2002:a17:906:3954:b0:a44:284a:597d with SMTP id
 g20-20020a170906395400b00a44284a597dmr1609189eje.11.1709218167674; 
 Thu, 29 Feb 2024 06:49:27 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15dd:1300:6947:88a8:d838:c55])
 by smtp.gmail.com with ESMTPSA id
 jg29-20020a170907971d00b00a4412406741sm749167ejc.131.2024.02.29.06.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:49:27 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: workaround to avoid SET_Q_MODE packets
Date: Thu, 29 Feb 2024 15:49:25 +0100
Message-Id: <20240229144925.97165-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229144925.97165-1-christian.koenig@amd.com>
References: <20240229144925.97165-1-christian.koenig@amd.com>
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

It turned out that executing the SET_Q_MODE packet on every submission
creates to much overhead.

Implement a workaround which allows skipping the SET_Q_MODE packet if
subsequent submissions all use the same parameters.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 104 +++++++++++++++++++----
 2 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 756330767909..582053f1cd56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -285,6 +285,9 @@ struct amdgpu_ring {
 	unsigned		cond_exe_offs;
 	u64			cond_exe_gpu_addr;
 	volatile u32		*cond_exe_cpu_addr;
+	unsigned int		set_q_mode_offs;
+	volatile u32		*set_q_mode_ptr;
+	u64			set_q_mode_token;
 	unsigned		vm_hub;
 	unsigned		vm_inv_eng;
 	struct dma_fence	*vmid_wait;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2ccbdee570cf..6e6b6eff48e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5461,6 +5461,11 @@ static void gfx_v11_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
 		amdgpu_ring_write(ring, 0x0);
 	}
+
+	/* Make sure that we can't skip the SET_Q_MODE packets when the VM
+	 * changed in any way.
+	 */
+	ring->set_q_mode_ptr = NULL;
 }
 
 static void gfx_v11_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
@@ -5510,16 +5515,81 @@ static void gfx_v11_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0);
 }
 
+static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						   uint64_t addr)
+{
+	unsigned ret;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	/* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, 0);
+	ret = ring->wptr & ring->buf_mask;
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
+
+	return ret;
+}
+
 static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 					   u64 shadow_va, u64 csa_va,
 					   u64 gds_va, bool init_shadow,
 					   int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int offs, end;
 
 	if (!adev->gfx.cp_gfx_shadow)
 		return;
 
+	/*
+	 * The logic here isn't easy to understand because we need to keep state
+	 * accross multiple executions of the function as well as between the
+	 * CPU and GPU. The general idea is that the newly written GPU command
+	 * has a condition on the previous one and only executed if really
+	 * necessary.
+	 */
+
+	/*
+	 * The dw in the NOP controls if the next SET_Q_MODE packet should be
+	 * executed or not. Reserve 64bits just to be on the save side.
+	 */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, 1));
+	offs = ring->wptr & ring->buf_mask;
+
+	/*
+	 * We start with skipping the prefix SET_Q_MODE and always executing
+	 * the postfix SET_Q_MODE packet. This is changed below with a
+	 * WRITE_DATA command when the postfix executed.
+	 */
+	amdgpu_ring_write(ring, shadow_va ? 1 : 0);
+	amdgpu_ring_write(ring, 0);
+
+	if (ring->set_q_mode_offs) {
+		uint64_t addr;
+
+		addr = amdgpu_bo_gpu_offset(ring->ring_obj);
+		addr += ring->set_q_mode_offs << 2;
+		end = gfx_v11_0_ring_emit_init_cond_exec(ring, addr);
+	}
+
+	/*
+	 * When the postfix SET_Q_MODE packet executes we need to make sure that the
+	 * next prefix SET_Q_MODE packet executes as well.
+	 */
+	if (!shadow_va) {
+		uint64_t addr;
+
+		addr = amdgpu_bo_gpu_offset(ring->ring_obj);
+		addr += offs << 2;
+		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
+		amdgpu_ring_write(ring, WRITE_DATA_DST_SEL(5) | WR_CONFIRM);
+		amdgpu_ring_write(ring, lower_32_bits(addr));
+		amdgpu_ring_write(ring, upper_32_bits(addr));
+		amdgpu_ring_write(ring, 0x1);
+	}
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
 	amdgpu_ring_write(ring, lower_32_bits(shadow_va));
 	amdgpu_ring_write(ring, upper_32_bits(shadow_va));
@@ -5531,23 +5601,26 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 			  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid) : 0);
 	amdgpu_ring_write(ring, init_shadow ?
 			  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
-}
 
-static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
-						   uint64_t addr)
-{
-	unsigned ret;
+	if (ring->set_q_mode_offs)
+		amdgpu_ring_patch_cond_exec(ring, end);
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	/* discard following DWs if *cond_exec_gpu_addr==0 */
-	amdgpu_ring_write(ring, 0);
-	ret = ring->wptr & ring->buf_mask;
-	/* patch dummy value later */
-	amdgpu_ring_write(ring, 0);
+	if (shadow_va) {
+		uint64_t token = shadow_va ^ csa_va ^ gds_va ^ vmid;
 
-	return ret;
+		/*
+		 * If the tokens match try to skip the last postfix SET_Q_MODE
+		 * packet to avoid saving/restoring the state all the time.
+		 */
+		if (ring->set_q_mode_ptr && ring->set_q_mode_token == token)
+			*ring->set_q_mode_ptr = 0;
+
+		ring->set_q_mode_token = token;
+	} else {
+		ring->set_q_mode_ptr = &ring->ring[ring->set_q_mode_offs];
+	}
+
+	ring->set_q_mode_offs = offs;
 }
 
 static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
@@ -6114,7 +6187,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_frame_size = /* totally 247 maximum if 16 IBs */
 		5 + /* update_spm_vmid */
 		5 + /* COND_EXEC */
-		9 + /* SET_Q_PREEMPTION_MODE */
+		22 + /* SET_Q_PREEMPTION_MODE */
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
@@ -6127,6 +6200,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 		31 + /*	DE_META */
 		3 + /* CNTX_CTRL */
 		5 + /* HDP_INVL */
+		22 + /* SET_Q_PREEMPTION_MODE */
 		8 + 8 + /* FENCE x2 */
 		8, /* gfx_v11_0_emit_mem_sync */
 	.emit_ib_size =	4, /* gfx_v11_0_ring_emit_ib_gfx */
-- 
2.34.1

