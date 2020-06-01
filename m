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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AEBC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99D02073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib/6PzVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99D02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6266E2EC;
	Mon,  1 Jun 2020 18:21:15 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE576E2EC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:14 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id q14so8220945qtr.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KePInzW0+Sq6wa19EIQHTeAzFIIyJ4m7XGc1eU+PHIs=;
 b=ib/6PzVn6oJhWQB5HyRwffiLNQp1gY7oT+mSTLgNz7CKAXwi08j8g8HSkY0E7ADhd1
 WxJIgsas+gtK7C2DyIFOiM/H2F0xtxjpwrpBv+RQOthWJuHaBLZP9Ht3KrL2xS05RflM
 1Krfze4aknK8hhQEpqpEKk94j4jyPQcaP0syjSTdOco7tQFX4iuvL7TE2AnFem9jYCev
 9yFXjf16DjEYQh/lhKYWvtmgmqEriJGylKM0RQ1OjL/4mhuIRKXN73mUOlnn6Buh7UNC
 dxVrxNMdeIr5s51mcMfyZvV+Tx15ppvU3t1hSF4HP/D2MaW6vChASZLFmz7mlP/Bd/tP
 53Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KePInzW0+Sq6wa19EIQHTeAzFIIyJ4m7XGc1eU+PHIs=;
 b=OkBhl5oahGncGeDgGaUXUy9KXTHrXnuIIN/h/qlQt0Ig+B07DJ/4S2BK1lPqWs2F6c
 wpGOSzLKKX8BvQRrjyxUJdXLKT5sZvYxWbxR5Uv4xx5F+T0b9ia/2gesCVgxRJX6+iXW
 Gr3+An4gSjhoHtxdOfkxz0n9dG04wvbaSrnroulPakYTzKOV+8OXuTo3pqVfBe2PNrPl
 U9S4ni2TQP+y1qZLyrxOMf8M3pL+Rl1WUluZd+Rys8yCCz4QpIUTeHmmC2sWOt6ehcGT
 0gFF4u972ct315hQ/uHFI7TzY31E4Pi4VDm0N8d2F20AHvIBSaE1soWe9k+uxCIgEYZr
 Ymyw==
X-Gm-Message-State: AOAM531JkjrCzwFa539FvUtlKgBS/V2g5HFE7v+mm/SPHMZXPZfmk6Mw
 U6f4LVvARZozbyYUUm5GX2JRSBhK
X-Google-Smtp-Source: ABdhPJyxL0op2+/ljSvPOO/TFNchUSTVbQnA0uhnc8XZeSMa47bBJGjf1ksCkiFE9PrK1k7dJ7ZHlQ==
X-Received: by 2002:ac8:67d7:: with SMTP id r23mr24101726qtp.110.1591035673751; 
 Mon, 01 Jun 2020 11:21:13 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 097/207] drm/amdgpu: drop gfx_v10_0_tiling_mode_table_init
Date: Mon,  1 Jun 2020 14:19:04 -0400
Message-Id: <20200601182054.1267858-8-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

tiling mode table is not used anymore for gfx10

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 940b4563312b..ce6ba3ba9223 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4401,12 +4401,6 @@ static int gfx_v10_0_sw_fini(void *handle)
 	return 0;
 }
 
-
-static void gfx_v10_0_tiling_mode_table_init(struct amdgpu_device *adev)
-{
-	/* TODO */
-}
-
 static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance)
 {
@@ -4656,8 +4650,6 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 
 	WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
 
-	gfx_v10_0_tiling_mode_table_init(adev);
-
 	gfx_v10_0_setup_rb(adev);
 	gfx_v10_0_get_cu_info(adev, &adev->gfx.cu_info);
 	gfx_v10_0_get_tcc_info(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
