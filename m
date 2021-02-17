Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2396C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 22:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70A264DFF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 22:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70A264DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A9B6E804;
	Wed, 17 Feb 2021 22:20:32 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E544C6E804
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 22:20:30 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id gi9so4181qvb.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 14:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=omgO2A9/cfav0JLRtziAScXbtmxIeCZfJbetooLty+Q=;
 b=kK1XGI4lnCc+MFAnfDN0Mg8TgYb04LBP5UTX+/RoY+q3aCmTzOQ0SRy8Xhcd7zyLNE
 yjrA91JxxE6QJCv3kB13FKUA1cy7+5zxzVRv87B9oGrcErWmoXaBUkUwB+Gnw/Er0+z7
 0vF2abv802r2rQ7VWPrSLzEcPLccrIlDHFnFcc8sybYs0hUoj7whpObNbtqObb7V5XrZ
 25y21uFnXLwWnJHYe0a2w8lkwZJpytkP7gcJS/3zY7PzH3Gzremzu6h/B3w5GNkuUZDS
 PMvFuXzbXpVQ2kPVNrzLh0MLyKjjc/jMewR6ik4nTglYschmed+OOLnDtBDVM0h/bzID
 nR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=omgO2A9/cfav0JLRtziAScXbtmxIeCZfJbetooLty+Q=;
 b=OY96eubK7GLg0nqJA4ZZPlV9f5c50H0XhGtirnzBThLmX0C2/8FbdM0g5mtTCcusm/
 SdKnC4Zj2NyPdh+Ax8N1ef+VqH4lB7zlMpCWChC38J6kvKPNkK1a1MQCy+0UXaYPSXyb
 ZJIZFvhZD/y8JbA5w1CQUdbCSCUf+YkyTLfDRk2TCw2ivcALZsRdngisBe2s/y+TToFi
 kwiQh35Au6Ytx7zSKVEElhpniwL7kg/OL0qzO3jJa7LU7scxsskQtfxGSjo91wjkK2R5
 OdXihpN7icgFaYAjMbc5raKlfPtspWdTjcaV0kAVGKCU0xygaN2g64J9k1pRhPw+jvLM
 2v/w==
X-Gm-Message-State: AOAM5309S7dFOvJt4PGsYn2XxGNOB+gXrNjgB7PUzMw+uOHu7XK1S5qB
 iTd3yiYYT0+Bj4vfsOpR3tGPxMUnrF4=
X-Google-Smtp-Source: ABdhPJxeQUNwW0CVOMM40/6ZI/8mb4l//bMrUdYlmaqhX1HQHYouObJin+6V1Hi4kONUyFwRXszqqQ==
X-Received: by 2002:a05:6214:c8a:: with SMTP id
 r10mr1430044qvr.13.1613600429947; 
 Wed, 17 Feb 2021 14:20:29 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id l24sm2115350qtj.50.2021.02.17.14.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 14:20:29 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/admgpu: Set reference clock to 100Mhz on Renoir (v2)
Date: Wed, 17 Feb 2021 17:20:18 -0500
Message-Id: <20210217222018.2291196-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

Fixes the rlc reference clock used for GPU timestamps.
Value is 100Mhz.  Confirmed with hardware team.

v2: reword commit message.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1480
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c7d0e0e98391..230caaa3513f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -463,6 +463,8 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
 {
 	u32 reference_clock = adev->clock.spll.reference_freq;
 
+	if (adev->asic_type == CHIP_RENOIR)
+		return 10000;
 	if (adev->asic_type == CHIP_RAVEN)
 		return reference_clock / 4;
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
