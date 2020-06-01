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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5782C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3072073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2JHPiU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3072073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770606E311;
	Mon,  1 Jun 2020 18:21:35 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9446E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:34 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id i68so8490582qtb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8SfamSL95J2bd8Jf5/IcVfkBqCDneJo/pxt8Tjh772M=;
 b=D2JHPiU3gFOU+iP3Nq1Nj5grZZXWIg32ZsIcmi0Ab1BeRjtesk6q0ut2rpOVo+2gDM
 e+GrzCAPSq9PN2AW9muV+mPWKLVxIHOBtYuiMVtU8x2xwSB2cn9cDuz4CFwdc8NMFETj
 6Cg9zl+vCCdG5e860lWTe1S786Zmcg4EIORsLYgG5FQBfyjfPUXLfR1VBIG3nwkTmzJu
 cSz1ZdsoZk3JajxAxRpfpya5jwPFMoH9vdb6zMqGy0o77nIjZZEpWuwf9+u2ZMtB+tNu
 GiaewXeh4wHSbT5PlamXQrC6noTZfZ+TnBd88jv+ivgA01HxQQg0y7vKMNPdAMLcAKPP
 DPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8SfamSL95J2bd8Jf5/IcVfkBqCDneJo/pxt8Tjh772M=;
 b=i60fCWR8DWFQLajzyZv1d5Ux7SuZLIbgOTpWAgyvvMD/nhb13jHAGoXhBTa5qLm0Wj
 EDjMFcjJconXRLQiBeJb5G/CHpmsnvBvfcJIibgHEqbuHJ/0u/bXEurG39foLUK7fQHD
 xuK6VbyzuG68gxJGsROOfRAJ/58O+iB5ghxwSkqL0wSjU/Q74oYEicRVjPs51NO46Bc6
 eu45fQg7GyHrdIj0y9I8Kg4jNOx4pv5ZQ1X9ivdBmKY2343iM2F0geZ8Zqru48mAB4+O
 i+iYU9Tp2ssB30JjUmwzn6wiKxyciY/xaZ6Jv0b69oRQ/ywnSQLJkMs6OoBtbOAmwg/B
 zHBg==
X-Gm-Message-State: AOAM533KWpq8lCUepcvhFZnWLuAtjvOJSR76cwonc4ssL3qhH7zBUbAd
 2gUhcvpubHzUxyN3Pt2lM2BnhQzd
X-Google-Smtp-Source: ABdhPJyLBVYYD9r+9rcC21KDdxfXKTp+xbKa4SkhVOam30zz61VtGv0zeDz1xTc0YAJwjAJiKp+snQ==
X-Received: by 2002:ac8:3779:: with SMTP id p54mr23774939qtb.156.1591035693375; 
 Mon, 01 Jun 2020 11:21:33 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:32 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 112/207] drm/amdgpu: fix SDMA hdp flush engine conflict
Date: Mon,  1 Jun 2020 14:19:19 -0400
Message-Id: <20200601182054.1267858-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Each of HDP flush engine should be used by one ring, correct allocate of
hdp flush engine to SDMA ring.
Correct me value of each SDMA ring, as it was cleared when init microcode.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 52206050adb9..f072cef28b60 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -391,10 +391,7 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask = 0;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->me == 0)
-		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0;
-	else
-		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma1;
+	ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
@@ -1224,6 +1221,7 @@ static int sdma_v5_2_sw_init(void *handle)
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
+		ring->me = i;
 
 		DRM_INFO("use_doorbell being set to: [%s]\n",
 				ring->use_doorbell?"true":"false");
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
