Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0259AC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 08:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FE310E4DD;
	Tue, 11 Apr 2023 08:13:16 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA6510E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 08:13:14 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id qa44so17890497ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681200792; x=1683792792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Enz/fVTmZ+9g3pWalBQhvr22dvEx8gH0YNIz8Fb77cg=;
 b=AgnH2p1lg0I3z8mmxdnjhQVns+3x7zFSfQbhJxoexTNs0yABFWKcwTBxOIm5kZf0BY
 c3FXP2es+LcMUgM9ZvtUzOiw3uVzRed8QwYKJvjEaQTtcwA/Y7rJbRkOmNnXRZAg/JDd
 yZgLoBJu5DzlqA2LMZPMV+rfvYkvrIr3/pvSbT9DrQL2Xv+3QA5fK02wDG31GXaANYGQ
 AB5VP7kuw1hSNEQseAd7qvbilzo5ZbESLlXziqYkS28wF8FdAL16lDLfF8ywIB+HO77a
 i0Hiy8xcJx4MlQqpJb2Ce/4puWtdJsgVy162UjpeDxGVumJ115s+lhgSlp9CO/Qx/Hyx
 4HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681200792; x=1683792792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Enz/fVTmZ+9g3pWalBQhvr22dvEx8gH0YNIz8Fb77cg=;
 b=jD+ilcSlPiat0HzAJ0kWCkKvhhsQa14rLn12kktGcH0LeULJefJ6gjKisL0HdlQCLB
 2EROm83CqaY+LgM+3EySWQYVeww5DfuuM866tV7Cwe63QEsZ5T8t3YTlHJkoR2hgk44M
 0HAAuLVPtFugTDyI0Hom9khaVVqRUmw7bC484VD5ZUmF4s6qgi0Bm5xHgS5wGdO9Pn5c
 ir4B/p3UYk0lTk+FjZDbigtVucdar18Qw2Up8At+oh2XuTcBbUT4hG5K4mUlV3cXj8OE
 wvfSjkThlCUfwrXIkvvkK8amtHsubpTCH8dSCtGItunGf+D6aozOzVDWNksp99qr6lPU
 NQ1A==
X-Gm-Message-State: AAQBX9fFKwLJKlg1/M+1M0+nbtUNjzPu9UZdA8n3gPCtn34g8LgMIeCy
 iMYoYXRImIHxgin72qumhSJOMJqmaI2Pag==
X-Google-Smtp-Source: AKy350acyDaGQBIN38OEzrycyRWfTlv5rozuvvsaZZTvcSk6AaC2UUn+1fQSBI5CHYCopFOy+nBrLQ==
X-Received: by 2002:a17:906:cc87:b0:948:d1af:3a11 with SMTP id
 oq7-20020a170906cc8700b00948d1af3a11mr1607896ejb.50.1681200792293; 
 Tue, 11 Apr 2023 01:13:12 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 ht18-20020a170907609200b0094a93f75e6esm1694268ejc.15.2023.04.11.01.13.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Apr 2023 01:13:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: use sdma_v6 single packet invalidation
Date: Tue, 11 Apr 2023 10:13:10 +0200
Message-Id: <20230411081310.133939-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

This achieves the same result as the sequence used in emit_flush_gpu_tlb
but the invalidation is now a single packet instead of the 3 packets
required to implement reg_write_reg_wait.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 40e6b22daa22..fdc6dfd60621 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1173,7 +1173,28 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 static void sdma_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					 unsigned vmid, uint64_t pd_addr)
 {
-	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+
+	/* Update the PD address for this VMID. */
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	/* Trigger invalidation. */
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->vm_inv_eng) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
+	amdgpu_ring_write(ring, req);
+	amdgpu_ring_write(ring, 0xFFFFFFFF);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
 }
 
 static void sdma_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
-- 
2.34.1

