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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA7C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20C920897
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqLVBxq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20C920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1616E2B0;
	Mon,  1 Jun 2020 18:04:16 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CFF6E2B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:14 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id w1so9955947qkw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hnH2zBkkIyw0t6hS8yyGnumRQPCc3Y9EyklqTbHhNGk=;
 b=mqLVBxq8LeRUT4yadNLh61PlEGDbrVF04mSg7UtzGe/IdnYndkR7MOK3ZpJ3k7498d
 aA82QwBYR6C/cLW/m/jrTUmUEmtDzB+E8apIaYohVWsH4iNfaShmA5D7pWN3HHzeJZGz
 I0ZKyRrWILOxEaGIiWzLspTHAKj1h1tUMSnZnETvEvGqiMoEru/73JkXrvMd0ri95sAE
 /4AwwjcD0nbpYDl9SRxVTBB3tyDWfTFpwyw+WRH6ZN4/mscNCXVi9/ZfTZRwkl3K9aAe
 BsAQpZXcVmD6LWRWL5cVBQjQw2Hs66qxLIH9RJeqiJaRtQaS7qFL7UNuTOQ/TkzuzCGh
 PmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hnH2zBkkIyw0t6hS8yyGnumRQPCc3Y9EyklqTbHhNGk=;
 b=bxCIvO4BdEHiBc6NCKTRk36OpsFT+Ke9F95sRM00VdzWvUMrD6VVPsv+50S9KV5JAQ
 ywvx0d2IJGqNH5Rta+OR7lRg49ru5I7blpEeJb/8dvx+OJeW37vRY/btZVjJ5/TyDyuI
 QVP813xzg6g9g0ewiNxmIKlEYoySHm96Ig7NJPSwCTScYXnuIxUeP5CjKl0Vyr07e3nO
 yzRGDtv4ANEuNCPUZD9wC99F2AAFVuSbXERgauFtEYoT27MyhKnbVnfY1OWJinLbPglh
 v3kWNGKNYnkplvb9sZfjFOVHjkMt+4yRjjpQwNvA4onrh7dwxn32FyfXwdDeVNCK1n4Q
 4n3Q==
X-Gm-Message-State: AOAM5312sQ4d4zi2a0PI+SpEpgYsv2T/4yzBQsAPJLrVpgfkdP4Y4MoC
 36dfVb21wl+gyXJBZNLVtoUbQEk4
X-Google-Smtp-Source: ABdhPJwqKBWzycJAsjdewhDqFJp/YvUk90ZB54/7vHtsti4OYjaYu1yA/M0ZJAaK6ZkABY/za1Bjvg==
X-Received: by 2002:a37:bc07:: with SMTP id m7mr7786783qkf.93.1591034653609;
 Mon, 01 Jun 2020 11:04:13 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:12 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 061/207] drm/amdgpu/mes10.1: implement the ring functions of
 mes specific
Date: Mon,  1 Jun 2020 14:00:13 -0400
Message-Id: <20200601180239.1267430-58-alexander.deucher@amd.com>
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

Implement mes ring functions and set up them.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 4f7e345673ca..80f6812d8ecf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -33,6 +33,47 @@ MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
 
 #define MES_EOP_SIZE   2048
 
+static void mes_v10_1_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		atomic64_set((atomic64_t*)&adev->wb.wb[ring->wptr_offs],
+			     ring->wptr);
+		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	} else {
+		BUG();
+	}
+}
+
+static u64 mes_v10_1_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	return ring->adev->wb.wb[ring->rptr_offs];
+}
+
+static u64 mes_v10_1_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	u64 wptr;
+
+	if (ring->use_doorbell)
+		wptr = atomic64_read((atomic64_t *)
+				     &ring->adev->wb.wb[ring->wptr_offs]);
+	else
+		BUG();
+	return wptr;
+}
+
+static const struct amdgpu_ring_funcs mes_v10_1_ring_funcs = {
+	.type = AMDGPU_RING_TYPE_MES,
+	.align_mask = 1,
+	.nop = 0,
+	.support_64bit_ptrs = true,
+	.get_rptr = mes_v10_1_ring_get_rptr,
+	.get_wptr = mes_v10_1_ring_get_wptr,
+	.set_wptr = mes_v10_1_ring_set_wptr,
+	.insert_nop = amdgpu_ring_insert_nop,
+};
+
 static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
 				  struct mes_add_queue_input *input)
 {
@@ -315,6 +356,8 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 
 	ring = &adev->mes.ring;
 
+	ring->funcs = &mes_v10_1_ring_funcs;
+
 	ring->me = 3;
 	ring->pipe = 0;
 	ring->queue = 0;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
