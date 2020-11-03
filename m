Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20C4C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F29C21556
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 23:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3ZtA8cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F29C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B0A6E909;
	Tue,  3 Nov 2020 23:24:46 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2726E909
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 23:24:44 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id x20so17110858qkn.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 15:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Oo5f49W3kKPGtXhg3RXv2/td/zDdrtwr+ov1uBur964=;
 b=a3ZtA8cdClnv9SREdmBVy/GncoLR7MoGlRnQpt9WyXVGFDR+CKdyhYhSQmfenYxsdK
 qNpsstAZm/nHf00SSxn2SyYXz0QyMr/hGgoNxDduRgSX3GBpqAkuoWdFsxEOJCwTiVH7
 zeuqintgXv0Fyn3Y7cYkEoEG10d7jhTdYdNag9lW7v7tMbNiND6prFCZ6+18cbYmsFwE
 oF4VJamN67Ate2tTAVkOzGQMRYOZ+sInbFf4ctGAo67D/ET8Mlj0XTc/Uz6L4T9G0rF2
 3fktFT6ELrtY/4KZC364OolmqdPg1Vmd8z/ofQYfvinv0qnZMLY3tQWAk07M6lociuRR
 ykfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Oo5f49W3kKPGtXhg3RXv2/td/zDdrtwr+ov1uBur964=;
 b=stmcmGFR8C6ZOqlD40fWT95wA38q4pH5tVHkLbmaehxtZmHG1xzApvgLQ+Eyoh6aqg
 ZjMMY75ck/i3yUvvH69OTfKb7XkVIZHLQleFVCcCWIHrULTt9fFuGVd0y0YOigTdxRRA
 t2RJh8AThHRGHgLjv+EM+gpM2OAVEKHOG8lQ9JZY5kKuip66ebq5xIlmYxoc4RFPq8c4
 ZRH2eUJeO6wVv9M9ojmAAvKmaMnbSrohRP02KWm3ITY50DuhNUuN0Y0UECzgKOViG7qb
 POTYXwXPuCmx27NGKPtwI0Boqr/h6xXYXk8o69DAfUwGbj7EdCaFVnak5hkuTU91/j97
 Qu2g==
X-Gm-Message-State: AOAM5330ZnZ1DP6HehDxYk8TvFNeOg2Ammu5S2EIgWD7n9AeBYiMAIrm
 CpHwUa5sYdu5uhvJh69ImuHRbMufbWg=
X-Google-Smtp-Source: ABdhPJwug14gWfpSQudOqNsECHGAOt+l+9Op72TG7pbjFSuJsKuTau/aBGFS1R5d5CUA8c7LikdsWg==
X-Received: by 2002:a37:2712:: with SMTP id n18mr21557887qkn.405.1604445883205; 
 Tue, 03 Nov 2020 15:24:43 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e28sm377684qka.73.2020.11.03.15.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 15:24:42 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu: remove duplicate call to
 smu_set_default_dpm_table
Date: Tue,  3 Nov 2020 18:24:34 -0500
Message-Id: <20201103232434.832933-1-alexander.deucher@amd.com>
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

For kernel 5.10, this function was called twice due to what looks
like a mis-merge.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fc4f95fa87cf..b1e5ec01527b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1029,17 +1029,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	/*
-	 * Set initialized values (get from vbios) to dpm tables context such as
-	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
-	 * type of clks.
-	 */
-	ret = smu_set_default_dpm_table(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
-		return ret;
-	}
-
 	ret = smu_notify_display_change(smu);
 	if (ret)
 		return ret;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
