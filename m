Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E247C64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 23:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0720E2220B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 23:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0720E2220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795416E95D;
	Tue,  1 Dec 2020 23:18:30 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8464C6E95B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 23:18:27 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id 7so2566608qtp.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 15:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FLMJoUIucx+Nk1yqu/OKDJuLM2kDjI4KVj0O1UZ0pcs=;
 b=mxFreQODxPSe5BGYvjUUoTW26SrDRMMSHdicuKg73+A7DNvGzE55qHvf1Ynj/Qah9r
 rzKFb/VWYq6y5Aed52heNQ6nJv9/DBHoax8o1rxbbrxw3dun5ponL525RHv89VnKr5Ei
 TIhkQiYvNeKBk9S2sCEheqJs1wkG1n5gzcZI0A5aTw+px6fNweNZk/a1whJ/kYyJSVBN
 9bgwg3j+HLKZOWNZOiPGPtpmodu1hXLdLE15Oje1C0v7XB0X+DenzJ3+VEZSjmbUpQHe
 Rie5wwyTvA34aVkHGvrwuYI7DgSYP2VeQobjcAPUFq8blqBW4IYqISVSQnQ7ji4PvGaj
 UZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FLMJoUIucx+Nk1yqu/OKDJuLM2kDjI4KVj0O1UZ0pcs=;
 b=GEal0/xUO24aWa/q+oE1Lc2EOX2KzlZiXec0p1qYx3GUq1uxN35VCXu4qimbYi+JoJ
 52zZ7qTV1FVz3hO9OuDlono2JibnD3HmZ9VKp9+ibace65rhRiovMlB/EiHmW02GkDF7
 FPtzWyPsGLSu5lJLx3QuEgrt5+pYIgml9fcqKpPvtzQRtTFHewcdF54ELywVaI5jua9N
 ufAuG3yjJNVfmpMoCwJuk0IxKoifrB3OVUhLei37j320Z/dVoJ/4H0m95bH99U/dHCTN
 EO/+iTI0Yc80M+Rs3Z+95FCHBecRCSSfoF3JWmYXmEWRu0OwuHvX73AbOVlbUsIGT2Sz
 661g==
X-Gm-Message-State: AOAM533uLV3s2kaXttz/fkdwUHA/DkzFbo8ZHGCnOuC69+Ea/Rf7C/mz
 ZDYOBEZPQPTi9ln3XGFssscJVfXPMKE=
X-Google-Smtp-Source: ABdhPJysyBKrTZQJk+R/3WYY3lTxpMZimrB7mm1Obqo/rcicIjQaGEULbCCtol9jM/gLwALsY3wCsQ==
X-Received: by 2002:ac8:4246:: with SMTP id r6mr5469556qtm.59.1606864706617;
 Tue, 01 Dec 2020 15:18:26 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id r8sm1294615qtj.94.2020.12.01.15.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 15:18:26 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/sdma5.2: enable ctxempty interrupt
Date: Tue,  1 Dec 2020 18:18:16 -0500
Message-Id: <20201201231816.1241159-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201201231816.1241159-1-alexander.deucher@amd.com>
References: <20201201231816.1241159-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is may be required for proper gfxoff operation with
SDMA workloads.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ca8d93ebd7f9..3043569665c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -760,6 +760,15 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
  */
 static int sdma_v5_2_rlc_resume(struct amdgpu_device *adev)
 {
+	int i;
+	u32 sdma_cntl;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		sdma_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, CTXEMPTY_INT_ENABLE, 1);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), sdma_cntl);
+	}
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
