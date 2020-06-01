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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17ED20825
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIViJ/L1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17ED20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2C56E284;
	Mon,  1 Jun 2020 18:03:40 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0533F6E27C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:40 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id j32so8406208qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f1a1hf+EyIMhM/UuL8wo9w45EVTeH6VTirLp1q7NN/0=;
 b=RIViJ/L1B4JroE6Lh+6e0PuetUVxDa2Ds7RReRL1ITf5nMbMdEG0LQlA0kIJ5BjgcE
 CRsRe26x4kXO5WL5RkCrf1TxBcCxEGhz4XA//Gkovn354EugkqEEUyjq4vO2STgBIIzC
 /lalVJMvAVt1Ayg3msN7qYusbS/MbUSQCBJ2Ockjwldr2sZ3vJhySsTXkCy8xGYAay3m
 +G1oQ0XLYgt+O1E6ZETItHfeu0An5UTn9wmozZmuBu5UAdu549GaJN94qR1a7JydwuUZ
 NoyuvFvSwYmHZuuja5xmzISkDeQf5NpXVeBnlzMk+9k9QP+Bc+T1jE8XYTWUR4zHyZl4
 pPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f1a1hf+EyIMhM/UuL8wo9w45EVTeH6VTirLp1q7NN/0=;
 b=Uax94ouB2cSMkKrKl1kCYzijidN7sKacfAedfzme0EJp2nhfA8P+QH6U5rVVdlZOXB
 00Frv4z5VZNc93TPj/8Mz/RLFKMUvxfZB0GVJseRdgun4UDM7gtOGHzWC5UaqL83MgHi
 rygSw1xDO65P6KU6b562mql0fAr7aWVC+4HfxLTxZ7kXEaindTB9r7Ev6hNGBm1EIXWy
 EClLI9vn17ip1v+22VMCTzW7+AbVWKuOJLOYmGkVCEpRld+l9QM7xj89B4EdT5LnjIDF
 9r1ybgQwZ5qwKXmczcZikQez+nRqa91e7Eqq8TAOuvVpWXprTckDOW+hu93yrOwbHTSv
 LEWQ==
X-Gm-Message-State: AOAM533VDKUQeyB4BMI7VoG6VD/KZot4RHfeM6rr70TEE7auoAy45Flr
 f186SDMHgwqHvomoAxqVYiLUAArb
X-Google-Smtp-Source: ABdhPJx7R/rDdObKiJupDZurxneKHM7LDjkld/N2/V43+OccLhOznLKAVMTHNKnSCNimzK6rJame1g==
X-Received: by 2002:aed:2d87:: with SMTP id i7mr10069894qtd.291.1591034619031; 
 Mon, 01 Jun 2020 11:03:39 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 036/207] drm/amd/powerplay: enable DCEFCLK DPM and DS for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:48 -0400
Message-Id: <20200601180239.1267430-33-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable Display Clocks Dynamic Power Management (DPM) for sienna_cichlid.
Enable Display Controller Engine Fabric Clock Deep Sleep for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index a91e6f753bea..852c364fd7a3 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -45,7 +45,8 @@
 	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
 	FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	 | \
 	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_FCLK_BIT))
+	FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	 | \
+	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
 
 #define MSG_MAP(msg, index) \
 	[SMU_MSG_##msg] = {1, (index)}
@@ -272,6 +273,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
 				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
+				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 				| FEATURE_MASK(FEATURE_THERMAL_BIT);
@@ -282,6 +284,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
 
+	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT);
+
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
