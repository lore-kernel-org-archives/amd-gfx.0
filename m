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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42157C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9F8207D0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpVqr7fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9F8207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D656E6E2B8;
	Mon,  1 Jun 2020 18:04:20 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695116E2B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:19 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id k22so8419934qtm.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JSE7nWXUpMkrov3wVIgUVDUZvtIHyH5iEJmGCf9ltAE=;
 b=XpVqr7fJSCc4ArhBC04tqyjMer9e8qP3yn6ORYhC/3afxDB01GXGq6Ged/2aTHNv1f
 EoaZQChKTria+Cko2k8n4kx/jnjvPOMTNG/bpCwu8YhK/ge4+nhh4D98Db66rZkh5edv
 JFJrns3F+Panp9vJPn0IJHF5b/eFfBAJGJ5rHXRrZyk+DqdXEC6v6IlaaFRnJMzZ8bgR
 5hHpV1JUhza+X8/CbRldW/Sq34j+nSmEKT9W96oDT4QZDfjuv9Uvzt7SMbyi4+oz2X3y
 zV39UyozVYBFgwjGPFvw4dAsR4wmEieusOUdcwXiAgSQEqnzVXdwb03ic6BXQ4TcTpIn
 yTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JSE7nWXUpMkrov3wVIgUVDUZvtIHyH5iEJmGCf9ltAE=;
 b=jjQxIPTcYlfBpwZT3yxYFXRpA2YxJceePn4IVRt5zHg+PHboP3U1KH4gA+x+5Xvk3+
 iA5Fu7EiRHm+7lNqChp+E8+wKWSNRcOf6ElE72aGr6Bpx55JGZ9itPUMwN76bPfCuWNY
 uP6r75QeSd/15P0eA0A+Hgp8U+fqUm8SwnctxNiQOYWqsfVyZVcgP27SFMLHj5KUxi8O
 3qX8gvwQjMH8Pkbjga95GLhZLPil3eklFEBDltVIR4GIJ1C5NBueg8HyDCztc7diiSxE
 hEtA0UAzUmxkDLF9IVY75hUz0tfVZA6dh5zakLNutYDMG6VbJp1cyL65JNh0UFW48EE8
 ghYA==
X-Gm-Message-State: AOAM533uqXRdl+/4H95dbrzvVi/pZ6ROMUx9hmpGqLgxoQYlX6WKigGK
 6NgSRx0wRR7dQpdd7VYYTkUJgQFu
X-Google-Smtp-Source: ABdhPJwTgLZKDcKk6jOjVvKgIcH991NnyjxWdM9fgHGRUg4K5qXT91mjaq5DnIfN+O745iFZcIcUXw==
X-Received: by 2002:ac8:1b99:: with SMTP id z25mr23073688qtj.209.1591034658347; 
 Mon, 01 Jun 2020 11:04:18 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 064/207] drm/amdgpu/mes10.1: install mes queue by register
 programming
Date: Mon,  1 Jun 2020 14:00:16 -0400
Message-Id: <20200601180239.1267430-61-alexander.deucher@amd.com>
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

Directly writing mes queue registers to set up it.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 36d8314b8d39..02c7e4807a3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -480,6 +480,68 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 	return 0;
 }
 
+static void mes_v10_1_queue_init_register(struct amdgpu_ring *ring)
+{
+	struct v10_compute_mqd *mqd = ring->mqd_ptr;
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t data = 0;
+
+	mutex_lock(&adev->srbm_mutex);
+	nv_grbm_select(adev, 3, 0, 0, 0);
+
+	/* set CP_HQD_VMID.VMID = 0. */
+	data = RREG32_SOC15(GC, 0, mmCP_HQD_VMID);
+	data = REG_SET_FIELD(data, CP_HQD_VMID, VMID, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_VMID, data);
+
+	/* set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_EN=0 */
+	data = RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+			     DOORBELL_EN, 0);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, data);
+
+	/* set CP_MQD_BASE_ADDR/HI with the MQD base address */
+	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr_lo);
+	WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi);
+
+	/* set CP_MQD_CONTROL.VMID=0 */
+	data = RREG32_SOC15(GC, 0, mmCP_MQD_CONTROL);
+	data = REG_SET_FIELD(data, CP_MQD_CONTROL, VMID, 0);
+	WREG32_SOC15(GC, 0, mmCP_MQD_CONTROL, 0);
+
+	/* set CP_HQD_PQ_BASE/HI with the ring buffer base address */
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE, mqd->cp_hqd_pq_base_lo);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI, mqd->cp_hqd_pq_base_hi);
+
+	/* set CP_HQD_PQ_RPTR_REPORT_ADDR/HI */
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
+		     mqd->cp_hqd_pq_rptr_report_addr_lo);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
+		     mqd->cp_hqd_pq_rptr_report_addr_hi);
+
+	/* set CP_HQD_PQ_CONTROL */
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL, mqd->cp_hqd_pq_control);
+
+	/* set CP_HQD_PQ_WPTR_POLL_ADDR/HI */
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
+		     mqd->cp_hqd_pq_wptr_poll_addr_lo);
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+		     mqd->cp_hqd_pq_wptr_poll_addr_hi);
+
+	/* set CP_HQD_PQ_DOORBELL_CONTROL */
+	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
+		     mqd->cp_hqd_pq_doorbell_control);
+
+	/* set CP_HQD_PERSISTENT_STATE.PRELOAD_SIZE=0x53 */
+	WREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE, mqd->cp_hqd_persistent_state);
+
+	/* set CP_HQD_ACTIVE.ACTIVE=1 */
+	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, mqd->cp_hqd_active);
+
+	nv_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
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
