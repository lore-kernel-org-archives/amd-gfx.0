Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD89C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 18:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282BC2074F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 18:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FySxjV5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282BC2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE2789F45;
	Mon, 28 Sep 2020 18:19:04 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073C389F45
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 18:19:02 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id x201so1494182qkb.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CgIydQexoSMF3mjCpaKHV/foHInzvc8nsq+h2cZ4bps=;
 b=FySxjV5PdGqLAyBPnPnXx5nKjUvAVStIwRnwDVQ8j3PQKXgFiDpYnq/PbGDFa16C43
 6/KSZ44ivM5LJH8DNnxjaqA1VvGt4f5JoHp4qnxodPfYjmGF9crsdMnCUH1rRCm8+AHo
 92T0wb6gi50NZ6+IDkNgkVhmdFC3kPCE7qMALBc90HOl0zPYM7bQNMVA0AtiuBe07s0M
 ffge8Z+lqlR2A2R+t6CqCO9NMhMyJMY/FqfSRGD+u/FMb1/A6YEoSn8+V2C2GsfVIVMY
 HlCAF9OajC5fHrM5PjBzKcq1+2C7RpEFRxVac5QxrgZzZR9rzk0b1c6zJY+g0SkguOz1
 0DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CgIydQexoSMF3mjCpaKHV/foHInzvc8nsq+h2cZ4bps=;
 b=GmCD1gf9haTxhHYB5ZKthCV2ocbvPq4Oi5HliSeBWDxEkrrTnWXJK+GlUd1RvMIPFq
 O1oVo3wNZdlLghzaQS0Ha+VqCk6ZGc/e/ddICE7vxpdmDPDeb/8sUFMvmgec2awIAQUx
 /UtrJ5JUyDdWYrHx81Z4/CGYg40c1eM+VQi+v5+OvKuLEvFdP9z+zTidphu/H05IWTrQ
 TBdbBL39VL2sZxSFJarpktvdLpXxCDfpazi66EXE+IJvkGsRZTYcKqk3q3/zGm3f/367
 bW8t6TC8UEslwxq6rJ5mloX2ip4sTWQbETxlFtNKNSIWpCA3QQwN5m0D7IslZlstLOzG
 D0ow==
X-Gm-Message-State: AOAM530h/UgFiPYfsK0XnbGExMJtUnd7rz/YybX1Ovww1vn6TfvjJUot
 woW4hMdNZ9SOR/BGTfYN336c2Cj98fA=
X-Google-Smtp-Source: ABdhPJw5b1JDxi+ovLRC4X+qwHUXsjezY5+5JNlZVrczQnnAhyDY6fIjSGJBP4+unhGQ04BNVZlZBg==
X-Received: by 2002:ae9:e30f:: with SMTP id v15mr733163qkf.132.1601317141882; 
 Mon, 28 Sep 2020 11:19:01 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id r5sm2130702qtd.87.2020.09.28.11.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 11:19:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu/smu12: fix force clock handling for mclk
Date: Mon, 28 Sep 2020 14:18:54 -0400
Message-Id: <20200928181854.2053782-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

The state array is in the reverse order compared to other asics
(high to low rather than low to high).

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1313
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 55a254be5ac2..66c1026489be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -222,14 +222,16 @@ static int renoir_get_profiling_clk_mask(struct smu_context *smu,
 			*sclk_mask = 0;
 	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
 		if (mclk_mask)
-			*mclk_mask = 0;
+			/* mclk levels are in reverse order */
+			*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
 	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
 		if(sclk_mask)
 			/* The sclk as gfxclk and has three level about max/min/current */
 			*sclk_mask = 3 - 1;
 
 		if(mclk_mask)
-			*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
+			/* mclk levels are in reverse order */
+			*mclk_mask = 0;
 
 		if(soc_mask)
 			*soc_mask = NUM_SOCCLK_DPM_LEVELS - 1;
@@ -323,7 +325,7 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
 		case SMU_UCLK:
 		case SMU_FCLK:
 		case SMU_MCLK:
-			ret = renoir_get_dpm_clk_limited(smu, clk_type, 0, min);
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, NUM_MEMCLK_DPM_LEVELS - 1, min);
 			if (ret)
 				goto failed;
 			break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
