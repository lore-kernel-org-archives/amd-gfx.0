Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D59AC433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229FF20878
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwlSNupj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229FF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CE96E2B4;
	Mon,  1 Jun 2020 18:04:17 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C756E2B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:17 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id u17so7318443qtq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YKJdeJ+d/88JOxwuWxrICNBbLJ5TlJ+izJ/vzTbdVHc=;
 b=TwlSNupjFEmjoE7WfCsTHzWuQ2wy98kqX86bvPBCI4l45am+1QQjFiPGOjOEVubXoV
 IsXpN7f8FPojgijdwLErFc3CZMASrv557IxUtZ+ehiOIBQA8Q36BMkAIK1quMtRfj6by
 A2oDqNn1JyGD9JYkVydK17CFrNoNTqN+yMsg3+mWROvTvNWhXwl3/acT8SVk/42ckkLu
 CKezUog/5xiSJmHpxxfkEUhQfzGIES1AuRkepRyV+QmDwOitVmQb2l7rrv2eWuYfzrnQ
 w3PUZrN6voTDYn/o0NABvU5wuP02UxUKJosWvzqPH83EAwoLiAUetT7osnRZCxIahe1Q
 tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YKJdeJ+d/88JOxwuWxrICNBbLJ5TlJ+izJ/vzTbdVHc=;
 b=SFDVbI3lTuuQFiKmSYTs+49FGu3X5IzcceYI6WOcBe83KtkL7pe9K/PEEiACWAgQ/X
 MOSpTcqgjMaBtbiAgB4WJPW6jNX6PCay8orofRopXaPNEDkNwZREGR8gOoxc79rA4nXV
 eG3aMM0Oi2u0sfgKzRa8VpHdiv9U+1QbNKS7i3WfYhLfuk4DN0DuLEH6P+ax831stRJ4
 wy1e/01pdsTdGtKrJEGfG6ST40N9DyJh0aFrO+kUU1tE7p2ihiEtDZ1RfKCecGUDJCif
 ZyVSRXHHqDa9/AhP/SwOOdJ/QPj4M9a6E1soQ+YHJrLxsydtYzrjccIOmnR4sMfiwPxQ
 PdLg==
X-Gm-Message-State: AOAM533gg6QdjMFhW7YjlAZaPPGclrytAKtu7AIi5CtBlx4iu7QCoU4W
 3RjEv1HuGVo4nXLd4K6SeiwbLOC6
X-Google-Smtp-Source: ABdhPJynIdlJhdc6JFM27GEJ9BRMUCcGAXaTCvtkrgnfaK8o6a+6WDu8lW1FeFFFfsq60idpbeXXuw==
X-Received: by 2002:aed:3b56:: with SMTP id q22mr22967424qte.345.1591034656130; 
 Mon, 01 Jun 2020 11:04:16 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:15 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 063/207] drm/amdgpu/mes10.1: initialize the mqd
Date: Mon,  1 Jun 2020 14:00:15 -0400
Message-Id: <20200601180239.1267430-60-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Initialize the mqd according to mes ring setup.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 130 +++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index ace82c477f01..36d8314b8d39 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -350,6 +350,136 @@ static int mes_v10_1_allocate_eop_buf(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct v10_compute_mqd *mqd = ring->mqd_ptr;
+	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
+	uint32_t tmp;
+
+	mqd->header = 0xC0310800;
+	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se3 = 0xffffffff;
+	mqd->compute_misc_reserved = 0x00000003;
+
+	eop_base_addr = ring->eop_gpu_addr >> 8;
+	mqd->cp_hqd_eop_base_addr_lo = eop_base_addr;
+	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
+
+	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
+	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_EOP_CONTROL);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
+			(order_base_2(MES_EOP_SIZE / 4) - 1));
+
+	mqd->cp_hqd_eop_control = tmp;
+
+	/* enable doorbell? */
+	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
+
+	if (ring->use_doorbell) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_OFFSET, ring->doorbell_index);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_EN, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_SOURCE, 0);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_HIT, 0);
+	}
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_EN, 0);
+
+	mqd->cp_hqd_pq_doorbell_control = tmp;
+
+	/* disable the queue if it's active */
+	ring->wptr = 0;
+	mqd->cp_hqd_dequeue_request = 0;
+	mqd->cp_hqd_pq_rptr = 0;
+	mqd->cp_hqd_pq_wptr_lo = 0;
+	mqd->cp_hqd_pq_wptr_hi = 0;
+
+	/* set the pointer to the MQD */
+	mqd->cp_mqd_base_addr_lo = ring->mqd_gpu_addr & 0xfffffffc;
+	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
+
+	/* set MQD vmid to 0 */
+	tmp = RREG32_SOC15(GC, 0, mmCP_MQD_CONTROL);
+	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
+	mqd->cp_mqd_control = tmp;
+
+	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
+	hqd_gpu_addr = ring->gpu_addr >> 8;
+	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
+	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
+
+	/* set up the HQD, this is similar to CP_RB0_CNTL */
+	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
+			    (order_base_2(ring->ring_size / 4) - 1));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
+			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
+#ifdef __BIG_ENDIAN
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
+#endif
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	mqd->cp_hqd_pq_control = tmp;
+
+	/* set the wb address whether it's enabled or not */
+	wb_gpu_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
+	mqd->cp_hqd_pq_rptr_report_addr_hi =
+		upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
+	wb_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffff8;
+	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	tmp = 0;
+	/* enable the doorbell if requested */
+	if (ring->use_doorbell) {
+		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_OFFSET, ring->doorbell_index);
+
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_EN, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_SOURCE, 0);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_HIT, 0);
+	}
+
+	mqd->cp_hqd_pq_doorbell_control = tmp;
+
+	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
+	ring->wptr = 0;
+	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR);
+
+	/* set the vmid for the queue */
+	mqd->cp_hqd_vmid = 0;
+
+	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x53);
+	mqd->cp_hqd_persistent_state = tmp;
+
+	/* set MIN_IB_AVAIL_SIZE */
+	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_IB_CONTROL);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
+	mqd->cp_hqd_ib_control = tmp;
+
+	/* activate the queue */
+	mqd->cp_hqd_active = 1;
+	return 0;
+}
+
 static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
