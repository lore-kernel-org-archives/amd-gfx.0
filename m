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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF65C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C102077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNS5pQ9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C102077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11366E2C4;
	Mon,  1 Jun 2020 18:04:31 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D2E6E2CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:30 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id n141so9982873qke.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lrfvfH75KMHW18azG2RIldiZQEFHT5kFetKl6G0Reyw=;
 b=rNS5pQ9VZDHsaRhlP/BgU8pxDIphRP4Po5DNpoz0rg7S/bdDtfynPPkfK5Sb9+DaqH
 3T/t5ere1cicMBCQf8dNI20UT+gLaMQ7N3ylVnoYmVLyf1jNhhyi6xbgOnVId8e1qKPy
 nisL43fIYOcHI6Ngv82hCdWXHfIWtqdbuU6Z5MVxn2jsTbkwfG023ez/ArNxTSYwIpci
 4GJnpvM9tca6mHMQbuZaZhSlNCabHWlWiJ+iB1dS6TG+rdXOORZCVu3xBEloH2UqbjBb
 DU5bLHt036yrUlYEqfQa/1HWANywN1NZ/JIK2meBquJfLYzKx703DZuLJkiuzekDDjh5
 /E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lrfvfH75KMHW18azG2RIldiZQEFHT5kFetKl6G0Reyw=;
 b=aiJUXSvVJ4HfW1rkyKEOJ0KKOKI4Gxsa+EF0k2EfMcsKNsfRTMqp53kA5PAOth4aqf
 sRGQmD2SdZSf88gsIxoVX3EcSYHkWGupQ0cM5dmqRgKW6hH/fpL45M9Dn0VOhK3K6VLp
 uPifSVjaZ8+cO4/bL4sdFYeZSa9GTgBE5bHiRdEDCq7ni2oDl4ma8sON+Cmzp8rsWlfn
 qM9UDAoagh6v9nPPx8ZQSYEE5NtMdX+V8Ci1qeKmolTGhGLZe3bBpNhqmRC58Cb3trpl
 rx8wcBCNMQzZq6G8TrasTd1Wv92V7xUA/QP2uC0fATRbI1smjKcSYeGlYqMb3/zIyZE3
 K/nw==
X-Gm-Message-State: AOAM530f0x29wKdMrSQfxR2QBrgiJjlq7g2fG+IQMMCvUNZ80ol27aeO
 cotA8yT4690WLVorg8SxskD0fjCt
X-Google-Smtp-Source: ABdhPJwSGTW3I3IgGCjJwmuMtWwpbAPby64Wid7x2UvGiC7NE2KKOjHiohODAOELgnJXpUH9D6oUcg==
X-Received: by 2002:a05:620a:49c:: with SMTP id
 28mr14898602qkr.168.1591034669790; 
 Mon, 01 Jun 2020 11:04:29 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:29 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 072/207] drm/amdgpu/mes10.1: implement setting hardware
 resources
Date: Mon,  1 Jun 2020 14:00:24 -0400
Message-Id: <20200601180239.1267430-69-alexander.deucher@amd.com>
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

The routine is implemented to generate mes command to
assign the hardware resources which can be scheduled
to mes.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 27374561ff4d..8102ffcf949c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -216,6 +216,47 @@ static int mes_v10_1_query_sched_status(struct amdgpu_mes *mes)
 			&mes_status_pkt, sizeof(mes_status_pkt));
 }
 
+static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
+{
+	int i;
+	struct amdgpu_device *adev = mes->adev;
+	union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
+
+	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
+
+	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
+	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
+	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
+	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
+	mes_set_hw_res_pkt.paging_vmid = 0;
+	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr;
+
+	for (i = 0; i < MAX_COMPUTE_PIPES; i++)
+		mes_set_hw_res_pkt.compute_hqd_mask[i] =
+			mes->compute_hqd_mask[i];
+
+	for (i = 0; i < MAX_GFX_PIPES; i++)
+		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
+
+	for (i = 0; i < MAX_SDMA_PIPES; i++)
+		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
+
+	for (i = 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
+		mes_set_hw_res_pkt.agreegated_doorbells[i] =
+			mes->agreegated_doorbells[i];
+
+	mes_set_hw_res_pkt.api_status.api_completion_fence_addr =
+		mes->ring.fence_drv.gpu_addr;
+	mes_set_hw_res_pkt.api_status.api_completion_fence_value =
+		++mes->ring.fence_drv.sync_seq;
+
+	return mes_v10_1_submit_pkt_and_poll_completion(mes,
+			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt));
+}
+
 static const struct amdgpu_mes_funcs mes_v10_1_funcs = {
 	.add_hw_queue = mes_v10_1_add_hw_queue,
 	.remove_hw_queue = mes_v10_1_remove_hw_queue,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
