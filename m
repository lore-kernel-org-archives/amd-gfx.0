Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CA5C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 15:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026922074B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 15:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vedr0j82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026922074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C2B6E2DA;
	Mon, 14 Sep 2020 15:43:14 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E436E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 15:43:13 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id o20so12941995pfp.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AjXopPrhrS1Cjtif/iMQzIW8Yh5ZoFOBDSXyPGnd4LA=;
 b=Vedr0j82XBrbVaSGyzk00gPhhOa2sYebbsJxxRLhRvRAKEk1NfsxqGRco+cLeKaAtW
 Bd2AHhKcuEU57HDkzUPKkFUzjx5kzY1ZXOara8Nrmy6Mt9pQRgIR5m2BDHCfVwlZdpoA
 Bmv7fB/3TmQFfaYX/2GT/wYtGbgpCkWGnhM/yNTfOxfBwF5AI8Ec73X+PY7GA0FuC6aW
 M83deDzLMk6J/V4HNmaDptLVW4igqY6dj/QqZrSR4PE6zJN0h+8MKvyi5N0T6LM8z0vI
 sCDhU7BO0XvxJxOL8aTgOrR31lmUXCCPDiaz8qRgWCFEiCovzkdkpIdl6FurrFLM0cyi
 hchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AjXopPrhrS1Cjtif/iMQzIW8Yh5ZoFOBDSXyPGnd4LA=;
 b=US8tEeDHyEs8Ys53Ajz3wxs+2xMtGdotdv4+P2zeqjWCvWBiw8WLWraDlhcbq+m0jD
 Rp+3tQsrI8k90oTcwP7FbHgLDd2wbEKVK8HUGrUcwlWA1fg9KJ67D/aCQlEPAqrbBdli
 CYsnlkwguLktV+N0AH8v139+ERtDVT7Q4NzXEeRtrmsZ0+uez9qNJRV9kT8Aby7pMnA3
 KFqUDoisLRqnhNgvOON8VRAaOazKPFL66oMzbTqldRhO/KHxeOooGvLb6l1udEH6izoD
 GjyEWI8qWmtFgqgoCD5RF/FFJoro4qhWTEeh2VxqKmsVPxbEHRWm8U3okCpaX068xiAb
 hVgA==
X-Gm-Message-State: AOAM533fPSI1gibOcu0McUJjjaUPG8rUo9EIRcXQhenY283D97Jp07SM
 bZPLVPiEhgBpjoI9Wx3UziScKo+yWgo=
X-Google-Smtp-Source: ABdhPJxWcyRRBWvHf4io5gZAZ041Z4jJ9apUgeh31rsDZ7gDWy5ReC5hGGq4cChIst673GTR28+9nQ==
X-Received: by 2002:a65:6449:: with SMTP id s9mr3540896pgv.388.1600098192735; 
 Mon, 14 Sep 2020 08:43:12 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id t15sm10955562pfl.175.2020.09.14.08.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:43:12 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gmc9: remove mmhub client duplicated case
Date: Mon, 14 Sep 2020 11:42:50 -0400
Message-Id: <20200914154250.17345-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Copy paste typo.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d0645ad3446e..2bdfc861028a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -269,7 +269,6 @@ static const char *mmhub_client_ids_arcturus[][2] = {
 	[14][1] = "HDP",
 	[15][1] = "SDMA0",
 	[32+15][1] = "SDMA1",
-	[32+15][1] = "SDMA1",
 	[64+15][1] = "SDMA2",
 	[96+15][1] = "SDMA3",
 	[128+15][1] = "SDMA4",
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
