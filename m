Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837BC63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 18:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAAE206B5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 18:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwklN8ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAAE206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266BD6E7E6;
	Mon, 30 Nov 2020 18:58:50 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2020C6E7E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 18:58:49 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id p12so8981382qtp.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CycVe4R/2Z9TMU8MPs7n/W6xmzrcqftPFFMgWG8qz24=;
 b=GwklN8eftNoefTt+xeasWXT0mxQWfdLUjugu2GZIf8c0Zc4EMrCgFgdqgn+zqYk//q
 CevTpM5ZpCTOwWXkl76Sr5e7us0EmC7OYsB0t7zsmFH2w8NQkf10dvlVB07NCgbFvxe/
 wBqxMeg9D7cLq73q5UTmnd2e3XVKevgwz3BJoRfH4xYrONRorLE6h1JFVVVVmBihUzWI
 ixUXci0YKsQQm7/MYGJv9BIybK8XGAR8YhGP+KKh7IMN1DPryhSc9Dm364kMbhhNm3pT
 JKxQPe6P/nlFyhA7aXgmGqdBvrSsFKE9GNh66bXa8/NAlqANj8RP1w6OYNR5YroB0OUa
 m2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CycVe4R/2Z9TMU8MPs7n/W6xmzrcqftPFFMgWG8qz24=;
 b=WEBjbB93ymWauD9qM8EuJ/5WyIQtkzfAhak9Dyq2rQzRNLHoio4MPHMtUtS9Jdndwx
 un62Xv6G5AHskz3HpnOVPo1+8a9gUrCOn06QgNEeAxgVHwPFLOTDToOUxbcwWsum8mlq
 EYnFxEE71NVh8DtCaQBGSQ8/wgIf47vwKWEZQvJtsDdJKDeOFM9D52ZzCpFg6uu6wu1r
 Es9DYm3pHkIStFlN6LYFyhsgLKGKYcxny2C8QwvVfUx7zQ00Nb318gq1WXEw3f3MDgNi
 g8EtfYA1kdYX45mjJ1ILSMbbIa70f9ot1iY7ZqbpSgnQrkXy5FJlb6iBgJiPBsNSuRPl
 l2/g==
X-Gm-Message-State: AOAM530sgU7EBojoS6A3EHY0yZtNMToSu16gktWOIT17FibhZ6FKRW6v
 42rmjFqWp1vOPIlglMsHcU+NNEp2VYc=
X-Google-Smtp-Source: ABdhPJzi+F/WT4XLNg5M+KR+28BbWxhAluXU9FjwjpgpH3vuDiMEycdYtPqGvmRka1C1hvbe1jjHIQ==
X-Received: by 2002:ac8:c8c:: with SMTP id n12mr22403374qti.32.1606762728061; 
 Mon, 30 Nov 2020 10:58:48 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o9sm16528035qte.35.2020.11.30.10.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 10:58:47 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: default noretry=0 for navi1x and newer
Date: Mon, 30 Nov 2020 13:58:37 -0500
Message-Id: <20201130185837.291258-1-alexander.deucher@amd.com>
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

There are no performance advantages to setting it to 1 and
it causes stability issues in some cases.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1374
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index fede84509dbc..02b2ee9b8939 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -422,11 +422,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
@@ -437,6 +432,11 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 			gmc->noretry = amdgpu_noretry;
 		break;
 	case CHIP_RAVEN:
+	case CHIP_NAVI10:
+	case CHIP_NAVI14:
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 	default:
 		/* Raven currently has issues with noretry
 		 * regardless of what we decide for other
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
